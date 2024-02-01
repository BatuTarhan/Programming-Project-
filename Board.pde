/**
 * Class for Airport Board widget. Displays departure information like
 * a traditional departure board
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class Board extends Widget
{
  private ArrayList<BoardLine> b;
  private int start;
  private int end;
  
  Board()
  {
    super(0, 0, SCREENX, SCREENY);
    this.start = 0;
    this.end = 12;
    ArrayList<DataPoint> a = sql.getWithFilter("origin", "JFK", this.start, this.end);
    this.b = new ArrayList();
    for (int i=0; i < a.size(); i++)
    {
      DataPoint tmp = a.get(i);
      String r = "Arrived";
      if (tmp.cancelled) r = "Cancelled";
      else if (tmp.diverted) r = "Diverted";
      this.b.add(new BoardLine(150+i*40, 30, "00:00", tmp.destCityName, tmp.carrier+tmp.flightNum, r));
    }
  }
  
  @Override
  public void draw()
  {
    fill(10);
    noStroke();
    rect(0, 0, this.width(), this.height());
    for (int i=0; i < b.size(); i++)
    {
     b.get(i).draw(); 
    }
    textFont(avenir40);
    fill(255);
    textAlign(CORNER);
    text("Departures from ", 20, 100);
    textFont(avenir15);
    text("Time", 20, 135);
    text("Destination", 960*7/40, 135);
    text("Flight", 960*25/40, 135);
    text("Remarks", 960*32/40, 135);
  }
  
  public void updateBoard(ArrayList<DataPoint> tgtList)
  {
    for (int i=0; i < tgtList.size() || i < 12; i++)
    {
      DataPoint tmp = tgtList.get(i);
      String r = "Arrived";
      if (tmp.cancelled) r = "Cancelled";
      else if (tmp.diverted) r = "Diverted";
      this.b.get(i).changeInfo("00:00", tmp.destCityName, tmp.carrier+tmp.flightNum, r);
      
    }
  }
  
//  public int getEvent()
//  {
//    this.start += 12;
//    //this.end += 12;
//    if (mouseY > 500)
//    {
//      ArrayList<DataPoint> a = sql.getWithFilter("originState", "NY", this.start, this.end);
//      for (int i=0; i < a.size(); i++)
//      {
//        DataPoint tmp = a.get(i);
//        String r = "Arrived";
//        if (tmp.cancelled) r = "Cancelled";
//        else if (tmp.diverted) r = "Diverted";
//        this.b.get(i).changeInfo("00:00", tmp.destCityName, tmp.carrier+tmp.flightNum, r);
//      }
//    }
//    //this.b.changeInfo("07:16", "Shanghai", "AA1234", "Cancelled");
//    return 0;
//  }
}

public class BoardLine extends Widget
{
  private String time;
  private String city;
  private String flight;
  private String remarks;
  private String tmpTime;
  private String tmpCity;
  private String tmpFlight;
  private String tmpRemarks;
  private boolean change;
  private ArrayList<Integer> tmpCityCount;
  private ArrayList<Integer> tmpTimeCount;
  private ArrayList<Integer> tmpFlightCount;
  private ArrayList<Integer> tmpRemarksCount;
  private int currentCount;
  private int countFrom;
  private int lastUpdate;
  
  BoardLine(int y, int height, String time, String city, String flight, String remarks)
  {
    super(20, y, SCREENX-40, height);
    this.time = time;
    this.city = city;
    this.flight = flight;
    this.remarks = remarks;
    this.change = false;
    this.tmpCityCount = null;
    this.currentCount = 0;
    this.lastUpdate = 0;
  }
  
  public void changeInfo(String time, String city, String flight, String remarks)
  {
    this.tmpCity = city;
    this.tmpTime = time;
    this.tmpFlight = flight;
    this.tmpRemarks = remarks;
    this.tmpCityCount = new ArrayList();
    this.tmpTimeCount = new ArrayList();
    this.tmpFlightCount = new ArrayList();
    this.tmpRemarksCount = new ArrayList();
    this.lastUpdate = frameCount;
    
    for (int i=0; i < this.tmpCity.length(); i++)
    {
      this.tmpCityCount.add(0);
    }
    
    for (int i=0; i < this.tmpTime.length(); i++)
    {
      this.tmpTimeCount.add(0);
    }
    
    for (int i=0; i < this.tmpFlight.length(); i++)
    {
      this.tmpFlightCount.add(0);
    }
    
    for (int i=0; i < this.tmpRemarks.length(); i++)
    {
      this.tmpRemarksCount.add(0);
    }
    
    this.change = true;
  }
  
  private int startCountFrom(char srcChar, char tgtChar)
  {
    if (srcChar == '/') return 65;
    if (tgtChar == '/') return '/';
    if (tgtChar == ' ') 
    {
      //println("SPACE");
      return ' ';
    }
    if (srcChar == ' ')
    {
      if (tgtChar >= 'A' && tgtChar <= 'Z') return 65;
      if (tgtChar >= 'a' && tgtChar <= 'z') return 97;
      if (tgtChar >= 48 && tgtChar <= 57) return 48;
    }
    if (srcChar >= 48 && srcChar <= 57 && tgtChar >= 48 && tgtChar <= 57) return srcChar;
    if (srcChar >= 48 && srcChar <= 57)
    {
      if (tgtChar >= 'A' && tgtChar <= 'Z') return 65;
      return 97;
    }
    if (tgtChar >= 48 && tgtChar <= 57) return 48;
    if (srcChar >= 'A' && srcChar <= 'Z' && tgtChar >= 'A' && tgtChar <= 'Z') return srcChar;
    if (srcChar >= 'a' && srcChar <= 'z' && tgtChar >= 'a' && tgtChar <= 'z') return srcChar;
    if (tgtChar >= 'A' && tgtChar <= 'Z') return 65;
    if (srcChar >= 'A' && srcChar <= 'Z') return 97;
    return 0;
  }
  
  private char transformChar(String src, String tgt, int idx, ArrayList<Integer> countArr)
  {
    char tgtChar = ' ';
    int increment = 1;
    if (idx >= src.length() && idx <= tgt.length()-1)
    {
      // Handle src shorter than tgt
      tgtChar = tgt.charAt(idx);
      this.currentCount = countArr.get(idx);
      if (tgtChar == ' ')
      {
        this.countFrom = ' ';
        this.currentCount = 0;
        //tgtChar = ' ';
      }
      else
      {
        if (tgtChar >= 48 && tgtChar <= 57) this.countFrom = 48;
        else if (tgt.charAt(idx) >= 'a' && tgt.charAt(idx) <= 'z') this.countFrom = 97;
        else this.countFrom = 65;
      }
      increment = 1;
    }
    else if (idx >= tgt.length() && idx <= src.length()-1)
    {
      // Handle src longer than tgt
      this.currentCount = 0;
      this.countFrom = ' ';
      tgtChar = ' ';
      increment = 1;
    }
    else
    {
      // Handle rest
      tgtChar = tgt.charAt(idx);
      this.countFrom = this.startCountFrom(src.charAt(idx), tgt.charAt(idx));
      this.currentCount = Math.abs(countArr.get(idx)) * (tgtChar < this.countFrom ? -1 : 1);
      //if (tgtChar == 'J') println("SRC: " + this.currentCount + " CURRENT: " + char(this.countFrom+this.currentCount));
      increment = tgtChar < this.countFrom ? -1 : 1;
    }
    //if (tgtChar == ' ') println(tgt + ": " + (char(this.countFrom+this.currentCount) != char(tgtChar)));
    if (char(this.countFrom+this.currentCount) != char(tgtChar))
    {
      countArr.set(idx, this.currentCount+increment);
      return char(this.countFrom+this.currentCount);
    }
    return tgtChar;
  }
  
  @Override
  public void draw()
  {
    if (this.change && frameCount - this.lastUpdate >= 90)
    {
      this.change = false;
      this.time = this.tmpTime;
      this.city = this.tmpCity;
      this.flight = this.tmpFlight;
      this.remarks = this.tmpRemarks;
    }
    fill(46, 46, 32);
    noStroke();
    rectMode(CORNER);
    rect(this.x(), this.y(), this.width(), this.height());
    stroke(0);
    fill(237, 241, 123);
    textFont(font);
    textAlign(CENTER, CENTER);
    for (int i=0; i < 40; i++)
    {
      float tmpX = this.x()+float(this.width())*float(i)/40;
      line(tmpX, this.y(), tmpX, this.y()+this.height());
      // Handle time
      if (i < 5)
      {
        if (this.change && i != 2)
        {
          char c = this.transformChar(this.time, this.tmpTime, i, this.tmpTimeCount);
          text(String.valueOf(c), tmpX, this.y(), this.width()/40, this.height());
        }
        else text(String.valueOf(this.time.charAt(i)), tmpX, this.y(), this.width()/40, this.height());
      }
      // Handle city
      else if (i > 5 && i < 23)
      {
        if (this.change && this.tmpCity != null && (i-6 < this.city.length() || i-6 < this.tmpCity.length()))
        { 
          char c = this.transformChar(this.city, this.tmpCity, i-6, this.tmpCityCount);
          text(String.valueOf(c), tmpX, this.y(), this.width()/40, this.height());
        }
        else if (i - 6 <= this.city.length()-1)
        {
          text(String.valueOf(this.city.charAt(i - 6)), tmpX, this.y(), this.width()/40, this.height());
        }
      }
      // Handle Flight Number
      if (i > 23 && i < 30)
      {
        if (this.change && this.tmpFlight != null && (i-24 < this.flight.length() || i-24 < this.tmpFlight.length()))
        {
          char c = this.transformChar(this.flight, this.tmpFlight, i-24, this.tmpFlightCount);
          text(String.valueOf(c), tmpX, this.y(), this.width()/40, this.height());
        }
        else if (i - 24 <= this.flight.length()-1)
          text(String.valueOf(this.flight.charAt(i - 24)), tmpX, this.y(), this.width()/40, this.height());
      }
      else if (i > 30)
      {
        // Handle Extra Remarks
        if (this.change && this.tmpRemarks != null && (i-31 < this.remarks.length() || i-31 < this.tmpRemarks.length()))
        {
          char c = this.transformChar(this.remarks, this.tmpRemarks, i-31, this.tmpRemarksCount);
          text(String.valueOf(c), tmpX, this.y(), this.width()/40, this.height());
        }
        else if (i - 31 <= this.remarks.length()-1)
          text(String.valueOf(this.remarks.charAt(i - 31)), tmpX, this.y(), this.width()/40, this.height());
      }
    }
  }
}
