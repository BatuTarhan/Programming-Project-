/**
 * Class for implementing the US map with flight data
 *
 * @author  Hanna Gorynska
 */

class Map extends Widget {
  int radius = 15;
  int radius2 = 10;

  //states//
  boolean washington = false;
  boolean oregon= false;
  boolean idaho = false;
  boolean montana = false;
  boolean wyoming = false;
  boolean northDakota = false;
  boolean southDakota = false;
  boolean nebraska = false;
  boolean minnesota = false;
  boolean iowa = false;
  boolean california= false;
  boolean nevada = false;
  boolean utah = false;
  boolean colorado = false;
  boolean kansas = false;
  boolean missouri = false;
  boolean arizona = false;
  boolean newMexico = false;
  boolean texas = false;
  boolean oklahoma = false;
  boolean arkansas = false;
  boolean louisiana = false;
  boolean wisconsin = false;
  boolean illinois = false;
  boolean michigan = false;
  boolean indiana = false;
  boolean ohio = false;
  boolean kentucky = false;
  boolean tennessee = false;
  boolean mississippi = false;
  boolean alabama = false;
  boolean georgia = false;
  boolean florida = false;
  boolean northCarolina = false;
  boolean southCarolina = false;
  boolean virginia = false;
  boolean westVirginia = false;
  boolean pennsylvania = false;
  boolean newYork = false;
  boolean maine = false;
  boolean newHampshire = false;
  boolean vermont = false;
  boolean massachussetts = false;
  boolean rhodeIsland = false;
  boolean conneticut = false;
  boolean newJersey = false;
  boolean delaware = false;
  boolean maryland = false;
  boolean alaska = false;
  boolean hawaii = false;
  
  Map () {
   super(); 
  }

  void draw() {
    background(10);
    map.resize(1000, 680);
    image(map, 0, 20);

    //Buttons//
    fill(255, 0, 0);
    ellipse(115, 70, radius, radius); //washington
    ellipse(90, 160, radius, radius); //oregon
    ellipse(200, 200, radius, radius); //idaho
    ellipse(290, 120, radius, radius); //montana
    ellipse(310, 230, radius, radius); //wyoming
    ellipse(440, 120, radius, radius); //northDakota
    ellipse(440, 200, radius, radius); //southDakota
    ellipse(440, 280, radius, radius); //nebraska
    ellipse(530, 160, radius, radius); //minnesota
    ellipse(550, 260, radius, radius); //iowa
    ellipse(70, 350, radius, radius);  //california
    ellipse(130, 290, radius, radius); //nevada
    ellipse(220, 310, radius, radius); //utah
    ellipse(330, 330, radius, radius); //colorado
    ellipse(460, 360, radius, radius); //kansas
    ellipse(580, 360, radius, radius); //missouri
    ellipse(200, 440, radius, radius); //arizona
    ellipse(310, 450, radius, radius); //newMexico
    ellipse(450, 550, radius, radius); //texas
    ellipse(490, 430, radius, radius); //oklahoma
    ellipse(580, 450, radius, radius); //arkansas
    ellipse(580, 550, radius, radius); //louisiana
    ellipse(620, 200, radius, radius); //wisconsin
    ellipse(640, 300, radius, radius); //illinois
    ellipse(710, 230, radius, radius); //michigan
    ellipse(690, 300, radius, radius); //indiana
    ellipse(750, 290, radius, radius); //ohio
    ellipse(730, 360, radius, radius); //kentucky
    ellipse(690, 420, radius, radius); //tennessee
    ellipse(640, 490, radius, radius); //mississippi
    ellipse(700, 490, radius, radius); //alabama
    ellipse(760, 490, radius, radius); //georgia
    ellipse(820, 610, radius, radius); //florida
    ellipse(840, 400, radius, radius); //northCarolina
    ellipse(810, 450, radius, radius); //southCarolina
    ellipse(850, 340, radius, radius); //virginia
    ellipse(790, 330, radius, radius); //westVirginia
    ellipse(830, 260, radius, radius); //pennsylvania
    ellipse(870, 200, radius, radius); //newYork
    ellipse(960, 110, radius, radius); //maine
    ellipse(930, 170, radius2, radius2); //newHampshire
    ellipse(910, 150, radius2, radius2); //vermont
    ellipse(930, 200, radius2, radius2); //massachussetts
    ellipse(945, 210, radius2, radius2); //rhodeIsland
    ellipse(925, 220, radius2, radius2); //conneticut
    ellipse(900, 275, radius2, radius2); //newJersey
    ellipse(892, 305, radius2, radius2); //delaware
    ellipse(863, 296, radius2, radius2); //maryland
    ellipse(110, 590, radius, radius); //alaska
    ellipse(350, 675, radius2, radius2); //hawaii

    //boxes
    if (washington) {
      fill(255);
      rect(50, 100, 250, 120, 10);
      fill(50);
      text("Washington", 125, 130);
      text("Flights in:", 60, 160);
      text("Flights out:", 60, 190);
      text("15,745", 150, 160);
      text("15,742", 150, 190);
    }
    if (oregon) {
      fill(255);
      rect(50, 150, 250, 120, 10);
      fill(50);
      text("Oregon", 135, 180);
      text("Flights in:", 60, 210);
      text("Flights out:", 60, 240);
      text("6,509", 150, 210);
      text("6,512", 150, 240);
    }
    if (idaho) {
      fill(255);
      rect(100, 50, 250, 120, 10);
      fill(50);
      text("Idaho", 200, 80);
      text("Flights in:", 110, 110);
      text("Flights out:", 110, 140);
      text("2,753", 200, 110);
      text("2,750", 200, 140);
    }
    if (montana) {
      fill(255);
      rect(280, 100, 250, 120, 10);
      fill(50);
      text("Montana", 360, 130);
      text("Flights in:", 290, 160);
      text("Flights out:", 290, 190);
      text("13,859", 380, 160);
      text("13,842", 380, 190);
    }
    if (wyoming) {
      fill(255);
      rect(280, 130, 250, 120, 10);
      fill(50);
      text("Wyoming", 360, 160);
      text("Flights in:", 290, 190);
      text("Flights out:", 290, 220);
      text("13,859", 380, 190);
      text("13,842", 380, 220);
    }
    if (northDakota) {
      fill(255);
      rect(280, 130, 250, 120, 10);
      fill(50);
      text("North Dakota", 350, 160);
      text("Flights in:", 290, 190);
      text("Flights out:", 290, 220);
      text("1,467", 380, 190);
      text("1,470", 380, 220);
    }
    if (southDakota) {
      fill(255);
      rect(280, 160, 250, 120, 10);
      fill(50);
      text("South Dakota", 350, 190);
      text("Flights in:", 290, 220);
      text("Flights out:", 290, 250);
      text("1,004", 380, 220);
      text("1,005", 380, 250);
    }
    if (nebraska) {
      fill(255);
      rect(280, 190, 250, 120, 10);
      fill(50);
      text("Nebraska", 360, 220);
      text("Flights in:", 290, 250);
      text("Flights out:", 290, 280);
      text("2,228", 380, 250);
      text("2,229", 380, 280);
    }
    if (minnesota) {
      fill(255);
      rect(400, 190, 250, 120, 10);
      fill(50);
      text("Minnesota", 480, 220);
      text("Flights in:", 410, 250);
      text("Flights out:", 410, 280);
      text("13,859", 500, 250);
      text("13,824", 500, 280);
    }
    if (iowa) {
      fill(255);
      rect(400, 270, 250, 120, 10);
      fill(50);
      text("Iowa", 500, 300);
      text("Flights in:", 410, 330);
      text("Flights out:", 410, 360);
      text("2,232", 500, 330);
      text("2,233", 500, 360);
    }
    if (california) {
      fill(255);
      rect(100, 380, 250, 120, 10);
      fill(50);
      text("California", 180, 410);
      text("Flights in:", 110, 440);
      text("Flights out:", 110, 470);
      text("55,750", 200, 440);
      text("55,746", 200, 470);
    }
    if (nevada) {
      fill(255);
      rect(140, 310, 250, 120, 10);
      fill(50);
      text("Nevada", 220, 340);
      text("Flights in:", 150, 370);
      text("Flights out:", 150, 400);
      text("14,600", 240, 370);
      text("14,597", 240, 400);
    }
    if (utah) {
      fill(255);
      rect(100, 350, 250, 120, 10);
      fill(50);
      text("Utah", 150, 380);
      text("Flights in:", 110, 410);
      text("Flights out:", 110, 440);
      text("9,565", 200, 410);
      text("9,558", 200, 440);
    }
    if (colorado) {
      fill(255);
      rect(330, 360, 250, 120, 10);
      fill(50);
      text("Colorado", 410, 390);
      text("Flights in:", 340, 410);
      text("Flights out:", 340, 440);
      text("25,921", 430, 410);
      text("25,919", 430, 440);
    }
    if (kansas) {
      fill(255);
      rect(460, 380, 250, 120, 10);
      fill(50);
      text("Kansas", 560, 410);
      text("Flights in:", 470, 440);
      text("Flights out:", 470, 470);
      text("1,234", 560, 440);
      text("1,237", 560, 470);
    }
    if (missouri) {
      fill(255);
      rect(580, 380, 250, 120, 10);
      fill(50);
      text("Missouri", 660, 410);
      text("Flights in:", 590, 440);
      text("Flights out:", 590, 470);
      text("9,200", 680, 440);
      text("9,199", 680, 470);
    }
    if (arizona) {
      fill(255);
      rect(200, 469, 250, 120, 10);
      fill(50);
      text("Arizona", 290, 490);
      text("Flights in:", 210, 520);
      text("Flights out:", 210, 550);
      text("15,883", 300, 520);
      text("15,900", 300, 550);
    }
    if (newMexico) {
      fill(255);
      rect(310, 480, 250, 120, 10);
      fill(50);
      text("New Mexico", 380, 510);
      text("Flights in:", 320, 540);
      text("Flights out:", 320, 570);
      text("1,917", 410, 540);
      text("1,916", 410, 570);
    }
    if (texas) {
      fill(255);
      rect(450, 570, 250, 120, 10);
      fill(50);
      text("Texas", 550, 600);
      text("Flights in:", 460, 630);
      text("Flights out:", 460, 660);
      text("59,129", 550, 630);
      text("59,127", 550, 660);
    }
    if (oklahoma) {
      fill(255);
      rect(490, 470, 250, 120, 10);
      fill(50);
      text("Oklahoma", 550, 500);
      text("Flights in:", 500, 530);
      text("Flights out:", 500, 560);
      text("3,010", 590, 530);
      text("3,010", 590, 560);
    }
    if (arkansas) {
      fill(255);
      rect(580, 420, 250, 120, 10);
      fill(50);
      text("Arkansas", 660, 450);
      text("Flights in:", 590, 480);
      text("Flights out:", 590, 510);
      text("2,270", 680, 480);
      text("2,271", 680, 510);
    }
    if (louisiana) {
      fill(255);
      rect(600, 570, 250, 120, 10);
      fill(50);
      text("Louisiana", 680, 600);
      text("Flights in:", 610, 630);
      text("Flights out:", 610, 660);
      text("5,588", 700, 630);
      text("5,589", 700, 660);
    }
    if (wisconsin) {
      fill(255);
      rect(580, 220, 250, 120, 10);
      fill(50);
      text("Wisconsin", 660, 250);
      text("Flights in:", 590, 280);
      text("Flights out:", 590, 310);
      text("4,782", 680, 280);
      text("4,790", 680, 310);
    }
    if (illinois) {
      fill(255);
      rect(640, 320, 250, 120, 10);
      fill(50);
      text("Illinois", 740, 350);
      text("Flights in:", 650, 380);
      text("Flights out:", 650, 410);
      text("30,255", 740, 380);
      text("30,264", 740, 410);
    }
    if (michigan) {
      fill(255);
      rect(710, 250, 250, 120, 10);
      fill(50);
      text("Michigan", 800, 280);
      text("Flights in:", 720, 310);
      text("Flights out:", 720, 340);
      text("13,859", 810, 310);
      text("13,842", 810, 340);
    }
    if (indiana) {
      fill(255);
      rect(690, 320, 250, 120, 10);
      fill(50);
      text("Indiana", 780, 350);
      text("Flights in:", 700, 380);
      text("Flights out:", 700, 410);
      text("4,747", 790, 380);
      text("4,744", 790, 410);
    }
    if (ohio) {
      fill(255);
      rect(750, 320, 250, 120, 10);
      fill(50);
      text("Ohio", 840, 350);
      text("Flights in:", 760, 380);
      text("Flights out:", 760, 410);
      text("8,002", 850, 380);
      text("7,995", 850, 410);
    }
    if (kentucky) {
      fill(255);
      rect(730, 380, 250, 120, 10);
      fill(50);
      text("Kentucky", 820, 410);
      text("Flights in:", 740, 440);
      text("Flights out:", 740, 470);
      text("5,836", 840, 440);
      text("5,836", 840, 470);
    }
    if (tennessee) {
      fill(255);
      rect(690, 450, 250, 120, 10);
      fill(50);
      text("Tennessee", 770, 480);
      text("Flights in:", 700, 510);
      text("Flights out:", 700, 540);
      text("10,430", 790, 510);
      text("10,430", 790, 540);
    }
    if (mississippi) {
      fill(255);
      rect(640, 510, 250, 120, 10);
      fill(50);
      text("Mississippi", 710, 540);
      text("Flights in:", 650, 570);
      text("Flights out:", 650, 600);
      text("1,254", 740, 570);
      text("1,255", 740, 600);
    }
    if (alabama) {
      fill(255);
      rect(700, 510, 250, 120, 10);
      fill(50);
      text("Alabama", 790, 530);
      text("Flights in:", 710, 560);
      text("Flights out:", 710, 590);
      text("2,627", 800, 560);
      text("2,638", 800, 590);
    }
    if (georgia) {
      fill(255);
      rect(740, 510, 250, 120, 10);
      fill(50);
      text("Georgia", 830, 530);
      text("Flights in:", 750, 560);
      text("Flights out:", 750, 590);
      text("27,648", 840, 560);
      text("27,633", 840, 590);
    }
    if (florida) {
      fill(255);
      rect(540, 490, 250, 120, 10);
      fill(50);
      text("Florida", 630, 520);
      text("Flights in:", 550, 550);
      text("Flights out:", 550, 580);
      text("52,913", 640, 550);
      text("52,893", 640, 580);
    }
    if (northCarolina) {
      fill(255);
      rect(710, 250, 250, 120, 10);
      fill(50);
      text("North Carolina", 780, 280);
      text("Flights in:", 720, 310);
      text("Flights out:", 720, 340);
      text("25,701", 810, 310);
      text("25,691", 810, 340);
    }
    if (southCarolina) {
      fill(255);
      rect(710, 300, 250, 120, 10);
      fill(50);
      text("South Carolina", 780, 330);
      text("Flights in:", 720, 360);
      text("Flights out:", 720, 390);
      text("4,834", 810, 360);
      text("4,837", 810, 390);
    }
    if (virginia) {
      fill(255);
      rect(710, 360, 250, 120, 10);
      fill(50);
      text("Virginia", 800, 390);
      text("Flights in:", 720, 420);
      text("Flights out:", 720, 450);
      text("23,568", 810, 420);
      text("23,588", 810, 450);
    }
    if (westVirginia) {
      fill(255);
      rect(650, 360, 250, 120, 10);
      fill(50);
      text("West Virginia", 720, 390);
      text("Flights in:", 660, 420);
      text("Flights out:", 660, 450);
      text("472", 750, 420);
      text("472", 750, 450);
    }
    if (pennsylvania) {
      fill(255);
      rect(700, 260, 250, 120, 10);
      fill(50);
      text("Pennsylvania", 770, 290);
      text("Flights in:", 710, 320);
      text("Flights out:", 710, 350);
      text("13,219", 800, 320);
      text("13,219", 800, 350);
    }
    if (newYork) {
      fill(255);
      rect(710, 230, 250, 120, 10);
      fill(50);
      text("New York", 800, 260);
      text("Flights in:", 720, 290);
      text("Flights out:", 720, 320);
      text("32,858", 810, 290);
      text("32,863", 810, 320);
    }
    if (maine) {
      fill(255);
      rect(670, 110, 250, 120, 10);
      fill(50);
      text("Maine", 770, 140);
      text("Flights in:", 680, 170);
      text("Flights out:", 680, 210);
      text("1,155", 770, 170);
      text("1,157", 770, 210);
    }
    if (newHampshire) {
      fill(255);
      rect(640, 50, 250, 120, 10);
      fill(50);
      text("New Hampshire", 710, 80);
      text("Flights in:", 650, 120);
      text("Flights out:", 650, 150);
      text("633", 740, 120);
      text("633", 740, 150);
    }
    if (vermont) {
      fill(255);
      rect(640, 50, 250, 120, 10);
      fill(50);
      text("Vermont", 730, 80);
      text("Flights in:", 650, 120);
      text("Flights out:", 650, 150);
      text("716", 740, 120);
      text("715", 740, 150);
    }
    if (massachussetts) {
      fill(255);
      rect(640, 100, 250, 120, 10);
      fill(50);
      text("Massachussetts", 710, 130);
      text("Flights in:", 650, 160);
      text("Flights out:", 650, 190);
      text("10,191", 740, 160);
      text("10,190", 740, 190);
    }
    if (rhodeIsland) {
      fill(255);
      rect(640, 100, 250, 120, 10);
      fill(50);
      text("Rhode Island", 710, 130);
      text("Flights in:", 650, 160);
      text("Flights out:", 650, 190);
      text("1,259", 740, 160);
      text("1,258", 740, 190);
    }
    if (conneticut) {
      fill(255);
      rect(640, 150, 250, 120, 10);
      fill(50);
      text("Connecticut", 710, 180);
      text("Flights in:", 650, 210);
      text("Flights out:", 650, 240);
      text("1,855", 740, 210);
      text("1,585", 740, 240);
    }
    if (newJersey) {
      fill(255);
      rect(640, 250, 250, 120, 10);
      fill(50);
      text("New Jersey", 720, 280);
      text("Flights in:", 650, 310);
      text("Flights out:", 650, 340);
      text("12,674", 740, 310);
      text("12,677", 740, 340);
    }
    if (delaware) {
      fill(255);
      rect(620, 250, 250, 120, 10);
      fill(50);
      text("Delaware", 700, 280);
      text("Flights in:", 630, 310);
      text("Flights out:", 630, 340);
      text("9", 720, 310);
      text("9", 720, 340);
    }
    if (maryland) {
      fill(255);
      rect(600, 250, 250, 120, 10);
      fill(50);
      text("Maryland", 690, 280);
      text("Flights in:", 610, 310);
      text("Flights out:", 610, 340);
      text("6,667", 700, 310);
      text("6,671", 700, 340);
    }
    if (alaska) {
      fill(255);
      rect(200, 550, 250, 120, 10);
      fill(50);
      text("Alaksa", 300, 580);
      text("Flights in:", 210, 610);
      text("Flights out:", 210, 640);
      text("2,871", 300, 610);
      text("2,875", 300, 640);
    }
    if (hawaii) {
      fill(255);
      rect(200, 520, 250, 120, 10);
      fill(50);
      text("Hawaii", 300, 550);
      text("Flights in:", 210, 580);
      text("Flights out:", 210, 610);
      text("9,681", 300, 580);
      text("9,684", 300, 610);
    }
  }

  void mousePressed() {
    if (dist(mouseX, mouseY, 115, 70) < 7.5) {
      washington= true;
    } else {
      washington = false;
    }
    if (dist(mouseX, mouseY, 90, 160) < 7.5) {
      oregon= true;
    } else {
      oregon = false;
    }
    if (dist(mouseX, mouseY, 200, 200) < 7.5) {
      idaho= true;
    } else {
      idaho = false;
    }
    if (dist(mouseX, mouseY, 290, 120) < 7.5) {
      montana= true;
    } else {
      montana = false;
    }
    if (dist(mouseX, mouseY, 310, 230) < 7.5) {
      wyoming= true;
    } else {
      wyoming = false;
    }
    if (dist(mouseX, mouseY, 440, 120) < 7.5) {
      northDakota= true;
    } else {
      northDakota = false;
    }
    if (dist(mouseX, mouseY, 440, 200) < 7.5) {
      southDakota= true;
    } else {
      southDakota = false;
    }
    if (dist(mouseX, mouseY, 440, 280) < 7.5) {
      nebraska= true;
    } else {
      nebraska = false;
    }
    if (dist(mouseX, mouseY, 530, 160) < 7.5) {
      minnesota= true;
    } else {
      minnesota = false;
    }
    if (dist(mouseX, mouseY, 550, 260) < 7.5) {
      iowa = true;
    } else {
      iowa = false;
    }
    if (dist(mouseX, mouseY, 70, 350) < 7.5) {
      california = true;
    } else {
      california = false;
    }
    if (dist(mouseX, mouseY, 130, 290) < 7.5) {
      nevada = true;
    } else {
      nevada = false;
    }
    if (dist(mouseX, mouseY, 220, 310) < 7.5) {
      utah = true;
    } else {
      utah = false;
    }
    if (dist(mouseX, mouseY, 330, 330) < 7.5) {
      colorado = true;
    } else {
      colorado = false;
    }
    if (dist(mouseX, mouseY, 460, 360) < 7.5) {
      kansas = true;
    } else {
      kansas = false;
    }
    if (dist(mouseX, mouseY, 580, 360) < 7.5) {
      missouri = true;
    } else {
      missouri = false;
    }
    if (dist(mouseX, mouseY, 200, 440) < 7.5) {
      arizona = true;
    } else {
      arizona = false;
    }
    if (dist(mouseX, mouseY, 310, 450) < 7.5) {
      newMexico = true;
    } else {
      newMexico = false;
    }
    if (dist(mouseX, mouseY, 450, 550) < 7.5) {
      texas = true;
    } else {
      texas = false;
    }
    if (dist(mouseX, mouseY, 490, 430) < 7.5) {
      oklahoma = true;
    } else {
      oklahoma = false;
    }
    if (dist(mouseX, mouseY, 580, 450) < 7.5) {
      arkansas = true;
    } else {
      arkansas = false;
    }
    if (dist(mouseX, mouseY, 580, 550) < 7.5) {
      louisiana = true;
    } else {
      louisiana = false;
    }
    //
    if (dist(mouseX, mouseY, 620, 200) < 7.5) {
      wisconsin= true;
    } else {
      wisconsin = false;
    }
    if (dist(mouseX, mouseY, 640, 300) < 7.5) {
      illinois= true;
    } else {
      illinois = false;
    }
    if (dist(mouseX, mouseY, 710, 230) < 7.5) {
      michigan= true;
    } else {
      michigan = false;
    }
    if (dist(mouseX, mouseY, 690, 300) < 7.5) {
      indiana = true;
    } else {
      indiana = false;
    }
    if (dist(mouseX, mouseY, 750, 290) < 7.5) {
      ohio = true;
    } else {
      ohio = false;
    }
    if (dist(mouseX, mouseY, 730, 360) < 7.5) {
      kentucky = true;
    } else {
      kentucky = false;
    }
    if (dist(mouseX, mouseY, 690, 420) < 7.5) {
      tennessee = true;
    } else {
      tennessee = false;
    }
    if (dist(mouseX, mouseY, 640, 490) < 7.5) {
      mississippi = true;
    } else {
      mississippi = false;
    }
    if (dist(mouseX, mouseY, 700, 490) < 7.5) {
      alabama = true;
    } else {
      alabama = false;
    }
    if (dist(mouseX, mouseY, 760, 490) < 7.5) {
      georgia = true;
    } else {
      georgia = false;
    }
    if (dist(mouseX, mouseY, 820, 610) < 7.5) {
      florida = true;
    } else {
      florida = false;
    }
    if (dist(mouseX, mouseY, 840, 400) < 7.5) {
      northCarolina = true;
    } else {
      northCarolina = false;
    }
    if (dist(mouseX, mouseY, 810, 450) < 7.5) {
      southCarolina = true;
    } else {
      southCarolina = false;
    }
    if (dist(mouseX, mouseY, 850, 340) < 7.5) {
      virginia = true;
    } else {
      virginia = false;
    }
    if (dist(mouseX, mouseY, 790, 330) < 7.5) {
      westVirginia = true;
    } else {
      westVirginia = false;
    }
    if (dist(mouseX, mouseY, 830, 260) < 7.5) {
      pennsylvania = true;
    } else {
      pennsylvania = false;
    }
    if (dist(mouseX, mouseY, 870, 200) < 7.5) {
      newYork = true;
    } else {
      newYork = false;
    }
    if (dist(mouseX, mouseY, 960, 110) < 7.5) {
      maine = true;
    } else {
      maine = false;
    }
    //
    if (dist(mouseX, mouseY, 930, 170) < 7.5) {
      newHampshire = true;
    } else {
      newHampshire = false;
    }
    if (dist(mouseX, mouseY, 910, 150) < 7.5) {
      vermont = true;
    } else {
      vermont = false;
    }
    if (dist(mouseX, mouseY, 930, 200) < 7.5) {
      massachussetts = true;
    } else {
      massachussetts = false;
    }
    if (dist(mouseX, mouseY, 945, 210) < 7.5) {
      rhodeIsland = true;
    } else {
      rhodeIsland = false;
    }
    if (dist(mouseX, mouseY, 925, 220) < 7.5) {
      conneticut = true;
    } else {
      conneticut = false;
    }
    if (dist(mouseX, mouseY, 900, 275) < 7.5) {
      newJersey = true;
    } else {
      newJersey = false;
    }
    if (dist(mouseX, mouseY, 892, 305) < 7.5) {
      delaware = true;
    } else {
      delaware = false;
    }
    if (dist(mouseX, mouseY, 863, 296) < 7.5) {
      maryland = true;
    } else {
      maryland = false;
    }
    if (dist(mouseX, mouseY, 110, 590) < 7.5) {
      alaska = true;
    } else {
      alaska = false;
    }
    if (dist(mouseX, mouseY, 350, 670) < 7.5) {
      hawaii = true;
    } else {
      hawaii = false;
    }
  }
}
