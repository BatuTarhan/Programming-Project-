/**
 * Class for clock widget. Allows users to search flights by time
 * and origin airport
 *
 * @author  Hanna Gorynska
 */

class Clock extends Widget {

  Clock() {
    super();
  }
  Table tableClock;
  int hours = 12;
  int minutes = 0;
  int chosenHour = 0;
  int chosenMin = 0;
  boolean editingHour = true;
  boolean isPM = false;
  boolean isAM = false;
  boolean searchBox = false;
  boolean searchButton = false;
  boolean forward = false;
  boolean backward = false;
  String userInput = "";
  String time = "";
  int x = 200;
  int y = 180;
  int counter = 0;


  void draw() {
    background(250);
    
     if (searchButton) {
      // draw the table//
      time = nf(chosenHour, 2) + nf(chosenMin, 2);
      tableClock = new Table(50, SCREENY/2);

      tableClock.setRows(sql.getWithTwoFilters("scheduleDep", time, "origin", userInput, 0 ,3));
      //dataTable.setRows(sql.getWithTwoFilters("scheduleDep", time, "origin", userInput, 4, 7));

      tableClock.draw();
    }

    //clock face
    stroke(0);
    fill(BLUE);
    ellipse(x, y, 250, 250);
    fill(30);
    ellipse(x, y, 230, 230);

    //points
    strokeWeight(4);
    stroke(255);
    for (int i = 0; i < 12; i++) {
      float angle = map(i, 0, 12, 0, TWO_PI);
      float px = x + cos(angle) * 100;
      float py = y + sin(angle) * 100;
      point(px, py);
    }

    //hands
    strokeWeight(6);
    stroke(255);
    float hoursAngle = map(hours % 12, 0, 12, 0, TWO_PI) - HALF_PI;
    float minutesAngle = map(minutes, 0, 60, 0, TWO_PI) - HALF_PI;
    line(x, y, x + cos(hoursAngle) * 70, y + sin(hoursAngle) * 70);
    stroke(BLUE);
    strokeWeight(4);
    line(x, y, x + cos(minutesAngle) * 90, y + sin(minutesAngle) * 90);

    //AM
    if (isAM) {
      noStroke();
      fill(255);
      rect(340, 110, 70, 40, 10);
      fill(30);
      rect(342.5, 112.5, 65, 35, 10);
      fill(255);
      textFont(font);
      text("A.M.", 358, 135);
    } else {
      noStroke();
      fill(30);
      rect(340, 110, 70, 40, 10);
      fill(255);
      rect(342.5, 112.5, 65, 35, 10);
      fill(0);
      textFont(font);
      text("A.M.", 358, 135);
    }

    //PM
    if (isPM) {
      noStroke();
      fill(255);
      rect(340, 160, 70, 40, 10);
      fill(30);
      rect(342.5, 162.5, 65, 35, 10);
      fill(255);
      textFont(font);
      text("P.M.", 358, 185);
    } else {
      noStroke();
      fill(30);
      rect(340, 160, 70, 40, 10);
      fill(255);
      rect(342.5, 162.5, 65, 35, 10);
      fill(0);
      textFont(font);
      text("P.M.", 358, 185);
    }
    // searchBox
    textFont(font);
    fill(0);
    text("Please enter the origin airport", 510, 70);
    fill(0);
    rect(497.5, 77.5, 305, 60, 10);
    fill(255);
    rect(500, 80, 300, 55, 10);
    fill(0);
    textFont(font);
    text(userInput, 510, 115);

    //searchButton
    fill(BLUE);
    rect(550, 170, 200, 60, 10);
    fill(255);
    textFont(basic);
    text("SEARCH", 590, 210);

  /*
    //Arrows//
    fill(0);
    triangle(940, 660, 940, 670, 950, 665);
    triangle(930, 660, 930, 670, 920, 665);
*/

  }

  void mouseDragged() {
    float dx = mouseX - width/2;
    float dy = mouseY - height/2;
    float angle = atan2(dy, dx);
    if (angle < 0) {
      angle += TWO_PI;
    }
    float minuteValue = map(angle, 0, TWO_PI, 0, 60);

    if (editingHour) { // Editing hour hand
      if (mouseButton == LEFT) {
        hours = round(minuteValue/5)*1 + 1;
      }
    } else { // Editing minute hand
      if (mouseButton == LEFT) {
        minutes = round(minuteValue);
      }
    }
  }



  void keyPressed() {
    if (keyCode == ENTER) {
      editingHour = false; // Toggle editing mode
    } else if (keyCode == BACKSPACE) {
      editingHour = true;
    }
    if (key == BACKSPACE && searchBox) {
      if (userInput.length() > 0) {
        userInput = userInput.substring(0, userInput.length() -1);
      }
    } else if (searchBox && key != ENTER ) {
      if ( key >= 'A' && key <= 'Z') {
        userInput += key;
      }
    }
  }

  void mousePressed() {
    // Check if the a.m. button was clicked
    if (mouseX >= 340 && mouseX <= 410 && mouseY >= 110 && mouseY <= 150) {
      isAM = true;
      isPM = false;
    }
    if (mouseX >= 340 && mouseX <= 410 && mouseY >= 160 && mouseY <= 200) {
      isPM = true;
      isAM = false;
    }
    if (mouseX >= 500 && mouseX <= 800 && mouseY >= 80 && mouseY <= 135) {
      searchBox = true;
    } else {
      searchBox = false;
    }
    if (mouseX >= 550 && mouseX <= 750 && mouseY >= 170 && mouseY <= 230) {
      searchButton = true;
      chosenHour = hours;
      chosenMin = minutes;
      if (isAM && chosenHour > 12) {
        chosenHour -= 12;
      }
      if (isPM && chosenHour < 12) {
        chosenHour += 12;
      }
      println(chosenHour, chosenMin);
    }
  }
}
