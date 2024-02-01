/**
 * Class for implementing the table rows of the Table class.
 * Separating these allow for easier modularity with regards to the
 * amount of rows shown and allows us to store information specific
 * to the row. The latter enables the modal functionality.
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class TableRow
{
  private DataPoint data;
  private int x;
  private int y;
  private int width;
  private int height;
  private int paddingTop;
  private int paddingLeft;
  private String schDepTime;
  private String actDepTime;
  private String schArrTime;
  private String actArrTime;
  private color fill;
  private color textColor;
  private boolean displayModal;
  private int x1;
  private int y1;
  private int x2; //<>//
  private int y2;

  TableRow(DataPoint data, int x, int y, int width, int height, color fill, color textColor)
  {
    this.data = data; //<>//
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height; //<>//
    this.paddingTop = 10;
    this.paddingLeft = 10;
    this.fill = fill;
    this.textColor = textColor;
    this.schDepTime = this.timeToString(this.data.scheduledDepTime); //<>//
    this.schArrTime = this.timeToString(this.data.scheduledArrTime);
    if (this.data.actualDepTime == 0) this.actDepTime = "N/A";
    else this.actDepTime = this.timeToString(this.data.actualDepTime);
    if (this.data.actualArrTime == 0) this.actArrTime = "N/A";
    else this.actArrTime = this.timeToString(this.data.actualArrTime);
    this.displayModal = false;
    try
    {
      String xy1 = locs.get(data.originStateAbr.toLowerCase());
      this.x1 = Integer.valueOf(xy1.split("/")[0]);
      this.y1 = Integer.valueOf(xy1.split("/")[1]);
      String xy2 = locs.get(data.destStateAbr.toLowerCase());
      this.x2 = Integer.valueOf(xy2.split("/")[0]);
      this.y2 = Integer.valueOf(xy2.split("/")[1]);
    } catch (NullPointerException exception)
    {
      this.x2 = 0;
      this.y2 = 0;
    }
  }

  private String timeToString(int time)
  {
    String timeString = Integer.toString(time);
    String formattedTimeString = ((time < 100) ? "00" :
      (time < 100) ? "0" + timeString.charAt(0) : timeString.substring(0, timeString.length()-2))
      + ":" + ((time < 10) ? "0" + timeString :
      timeString.substring(timeString.length()-2, timeString.length()));
    return formattedTimeString;
  }

  public boolean displayModal()
  {
    return this.displayModal;
  }

  public void draw()
  {
    noStroke();
    fill(fill);
    rect(this.x, this.y, this.width, this.height);
    fill(this.textColor);
    stroke(0);
    strokeWeight(1);
    strokeCap(SQUARE);
    text(this.data.date, this.x+this.paddingLeft, this.y+this.paddingTop, 110, this.height-this.paddingTop);
    line(this.x+this.paddingLeft+110, this.y, this.x+this.paddingLeft+110, this.y+this.height);
    text(this.data.carrier+this.data.flightNum, this.x+115+this.paddingLeft, this.y+this.paddingTop, 55, this.height-this.paddingTop);
    line(this.x+this.paddingLeft+170, this.y, this.x+this.paddingLeft+170, this.y+this.height);
    text(this.data.origin, this.x+175+this.paddingLeft, this.y+this.paddingTop, 65, this.height-this.paddingTop);
    line(this.x+this.paddingLeft+240, this.y, this.x+this.paddingLeft+240, this.y+this.height);
    text(this.data.originCityName, this.x+245+this.paddingLeft, this.y+this.paddingTop, 100, this.height-this.paddingTop);
    line(this.x+this.paddingLeft+345, this.y, this.x+this.paddingLeft+345, this.y+this.height);
    text(this.data.dest, this.x+350+this.paddingLeft, this.y+this.paddingTop, 65, this.height-this.paddingTop);
    line(this.x+this.paddingLeft+415, this.y, this.x+this.paddingLeft+415, this.y+this.height);
    text(this.data.destCityName, this.x+420+this.paddingLeft, this.y+this.paddingTop, 100, this.height-this.paddingTop);
    line(this.x+this.paddingLeft+520, this.y, this.x+this.paddingLeft+520, this.y+this.height);
    text(this.schDepTime, this.x+525+this.paddingLeft, this.y+this.paddingTop, 65, this.height-this.paddingTop);
    line(this.x+this.paddingLeft+590, this.y, this.x+this.paddingLeft+590, this.y+this.height);
    text(this.actDepTime, this.x+595+this.paddingLeft, this.y+this.paddingTop, 65, this.height-this.paddingTop);
    line(this.x+this.paddingLeft+660, this.y, this.x+this.paddingLeft+660, this.y+this.height);
    text(this.schArrTime, this.x+665+this.paddingLeft, this.y+this.paddingTop, 65, this.height-this.paddingTop);
    line(this.x+this.paddingLeft+730, this.y, this.x+this.paddingLeft+730, this.y+this.height);
    text(this.actArrTime, this.x+735+this.paddingLeft, this.y+this.paddingTop, 65, this.height-this.paddingTop);
    line(this.x+this.paddingLeft+800, this.y, this.x+this.paddingLeft+800, this.y+this.height);
    text(this.data.distance + "mi", this.x+805+this.paddingLeft, this.y+this.paddingTop, 85, this.height-this.paddingTop);
    strokeWeight(1);
    noStroke();
  }

  public void drawModal()
  {
    fill(BLUE);
    rect(40, 160, this.width+20, 465, 10, 10, 10, 10);
    textFont(avenir40);
    fill(255);
    text(this.data.carrier+this.data.flightNum, 50, 200);
    text(airlines.get(this.data.carrier), textWidth(this.data.carrier+this.data.flightNum) + 80, 200);
    textAlign(CENTER, CENTER);
    text(this.data.origin, 40+(this.width+20)/2-textWidth(this.data.origin)-50, 250);
    rectMode(CENTER);
    rect(20+(this.width+20)/2, 250, 100, 7);
    triangle(70+(this.width+20)/2, 235, 70+(this.width+20)/2, 265, 100+(this.width+20)/2, 250);
    text(this.data.dest, 40+(this.width+20)/2+textWidth(this.data.dest)+50, 250);
    textFont(avenir15);
    text(this.data.distance + "mi", 40+(this.width+20)/2, 280);
    rectMode(CORNER);
    textAlign(CORNER);
    text("Date: " + this.data.date, 50, 300);
    text("Scheduled Departure: " + this.schDepTime, 50, 320);
    text("Actual Departure: " + this.actDepTime, 50, 340);
    text("Scheduled Arrival: " + this.schArrTime, 50, 360);
    text("Actual Arrival: " + this.actArrTime, 50, 380);
    text("Origin City: " + this.data.originCityName + ", " + this.data.originStateAbr, 50, 400);
    text("Destination City: " + this.data.destCityName + ", " + this.data.destStateAbr, 50, 420);
    if (this.data.cancelled) text("This flight was cancelled", 50, 440);
    else if (this.data.diverted) text("This flight was diverted", 50, 440);
    else text("This flight flew out as planned", 50, 440);
    rect(40+this.width, 170, 10, 10);
    image(usatran, 400, 300, usa.width*0.7, usa.height*0.7);
    ellipseMode(CENTER);
    if (this.x2 != 0)
    {
      circle(this.x2, this.y2, 10);
      stroke(255);
      strokeWeight(1.5);
      if (!this.data.destStateAbr.equals("HI") && !this.data.originStateAbr.equals("HI") &&
          !this.data.destStateAbr.equals("AK") && !this.data.originStateAbr.equals("AK"))
          line(this.x1, this.y1, this.x2, this.y2);
      strokeWeight(1);
      fill(BLUE);
      circle(this.x1, this.y1, 10);
      fill(255);
    }
  }

  public boolean mousePressed()
  {
    if (this.displayModal &&
      mouseX >= 40+this.width && mouseX <= 50+this.width && mouseY >= 170 && mouseY <= 180)
    {
      this.displayModal = false;
      return false;
    }
    if (mouseX >= this.x && mouseX <= this.x+this.width && mouseY >= this.y && mouseY <= this.y+this.height)
    {
      this.displayModal = true;
      return true;
    }
    return false;
  }
}
