
class Distance extends Widget {

  String userInput1 = "" ;
  String userInput2 = "";
  boolean box1 = false;
  boolean box2 = false;
  boolean counterStart = false;
  boolean buttonPressed = false;
  int boxWidth = 300;
  int boxHeight = 75;
  float angle = 0;
  float radius = 300;
  float speed = 0.03;
  float x = 750;
  float y = 450;
  int dist;
  color background = BLUE;
  color boxOutline = color(77, 78, 79);
  color button = color(32, 96, 161);
  
  Distance() {
   super(); 
  }
  
  void draw() {
    noStroke();
    background(255);
    fill(background);
    rect(25, 25, 950, 650, 10);
    fill(255);
    rect(50, 250, 900, 400, 10);
    fill(50);
    textFont(basic);
    text("Enter State Codes to calculate distance", 250, 75);
    
    //Box1
    fill(boxOutline);
    rect(width/4 - boxWidth/2 - 2, 130 - boxHeight/2 - 2, boxWidth + 4, boxHeight + 4, 10);
    fill(255);
    rect(width/4 - boxWidth/2, 130 - boxHeight/2, boxWidth, boxHeight, 10);
    fill(0);
    textFont(basic);
    text(userInput1, width/4 - boxWidth/2 + 80, 130 + 10);
    takeOff.resize(80, 80);
    image(takeOff, width/4 - boxWidth/2, 130 - boxHeight/2 - 5);

    //Box2
    fill(boxOutline);
    rect(width -250 - boxWidth/2 - 2, 130 - boxHeight/2 - 2, boxWidth + 4, boxHeight + 4, 10);
    fill(255);
    rect(width - 250 - boxWidth/2, 130 - boxHeight/2, boxWidth, boxHeight, 10);
    fill(0);
    //textSize(30);
    text(userInput2, width - boxWidth/2 - 170, 130 + 10);
    landing.resize(85, 75);
    image(landing, width - 250 - boxWidth/2, 130 - boxHeight/2);

    //Calculate Button
    fill(button);
    rect(width/2 - 100, 180, 200, 60, 10);
    textFont(basic);
    fill(255);
    text("Calculate", width/2 -68, 220);


    //Moving Airplane
    airplane.resize(100, 100);
    image(airplane, x, y);
    if (buttonPressed) {
      dist = sql.getDistance(userInput1, userInput2);
      x = 450 + radius*cos(angle);
      y = 440 - radius/2*sin(angle);
      angle += 0.02;
    }
    if ( x <= 160 && y >= 450) {
      angle = 0;
      buttonPressed = false;
    }

      fill(30);
      textFont(basic);
      text("Distance travelled is:", 350, 400);
      text(dist, 410, 450);
      text("miles", 490, 450);


    //Images
    airport.resize(200, 200);
    image(airport, 750, 450);

    island.resize(200, 180);
    image(island, 70, 460);
    
  }


  void keyPressed() {
    if (key == BACKSPACE && box1) {
      if (userInput1.length() > 0) {
        userInput1 = userInput1.substring(0, userInput1.length() -1);
      }
    } else if (box1 && key != ENTER ) {
      if ( key >= 'A' && key <= 'Z') {
        userInput1 += key;
      }
    }
    if (key == BACKSPACE && box2) {
      if (userInput2.length() > 0) {
        userInput2 = userInput2.substring(0, userInput2.length() -1);
      }
    } else if (box2 && key != ENTER) {
      if (key >= 'A' && key <= 'Z') {
        userInput2 += key;
      }
    }
  }

  void mousePressed() {
    //Box1
    if (mouseX > width/4 - boxWidth/2 && mouseX < width/4 + boxWidth/2 &&
      mouseY > 130 - boxHeight/2 && mouseY < 130 + boxHeight/2) {
      box1 = true;
    } else {
      box1 = false;
    }
    //Box2
    if (mouseX > width -250 - boxWidth/2 && mouseX < width - 100 + boxWidth/2 &&
      mouseY > 130 - boxHeight/2 && mouseY < 130 + boxHeight/2) {
      box2 = true;
    } else {
      box2 = false;
    }
    //button
    if (mouseX > 400 && mouseX < 600 && mouseY >
      200 && mouseY < 260) {
      buttonPressed = true;
      counterStart = true;
    } else {
      buttonPressed = false;
      counterStart = false;
    }
  }
}
