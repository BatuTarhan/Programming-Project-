/**
 * Class to implement searchbars with sorting functionality.
 *
 * @author  Justin Ikechukwu Cunningham
 */

import java.util.Arrays;

public class Search extends Widget
{
  private boolean isFocused;
  private String queryString;
  private String lastSearch;
  private String filter;
  private String order;
  private int event;
  private int event2;
  private SQLWrapper db;
  private int start;
  private int end;
  private Dropdown sortDrop;
  private Dropdown dropdown;
  private char[] acceptableList = new char[]{',', '.', ':', '!', '@', '%', '*', '(', ')', ' '};
  private PFont font;
  private color fontColor;
  private Slider slider;
  
  Search(int x, int y, int event, int event2, SQLWrapper db, int end, PFont font, color fontColor)
  {
    super(x, y, 600, 50, 0);
    this.isFocused = false;
    this.queryString = "JFK";
    this.lastSearch = "NY";
    this.filter = "origin";
    this.event = event;
    this.event2 = event2;
    this.db = db;
    this.start = 0;
    this.end = end;
    this.font = font;
    this.fontColor = fontColor;
    this.order = "all";
  }
  
  Search(int x, int y, int event, int event2, SQLWrapper db, Dropdown dropdown)
  {
    super(x, y, 600, 50, 0);
    this.isFocused = false;
    this.queryString = "";
    this.lastSearch = "NY";
    this.filter = "originState";
    this.event = event;
    this.event2 = event2;
    this.db = db;
    this.start = 0;
    this.end = 5;
    this.order = "all";
    this.dropdown = dropdown;
    this.fontColor = 0;
  }
  
  Search(int x, int y, int event, int event2, SQLWrapper db, Dropdown dropdown, Dropdown sortDrop, boolean slider)
  {
    super(x, y, 600, 50, 0);
    this.isFocused = false;
    this.queryString = "";
    this.lastSearch = "NY";
    this.filter = "originState";
    this.event = event;
    this.event2 = event2;
    this.db = db;
    this.start = 0;
    this.end = 5;
    this.order = "all";
    this.sortDrop = sortDrop;
    this.dropdown = dropdown;
    this.fontColor = 0;
    if (slider) this.slider = new Slider(80, 130, 840, BLUE, 50);
  }
  
  @Override
  void draw()
  {
    color strokeCol = this.isFocused ? color(66, 135, 245) : color(0);
    if (this.font != null) textFont(this.font);
    stroke(strokeCol);
    fill(255);
    line(this.x(), this.y()+40, this.x()+this.width(), this.y()+40);
    if (this.queryString == "")
    {
      fill(100);
      text("Search", this.x()+210, this.y()+33);
    }
    else
    {
      if (this.isFocused) line(this.x()+210+textWidth(this.queryString), this.y()+15, this.x()+210+textWidth(this.queryString), this.y()+this.height()-10);
      fill(this.fontColor);
      text(this.queryString, this.x()+210, this.y()+33);
    }
    text("Search", this.x()+700, this.y()+33);
    fill(0);
    
    // Draw the dort dropdown if it exists
    if (this.sortDrop != null) 
    {
      text("Sort by", this.x(), this.y()+90);
      this.sortDrop.draw();
    }
    if (this.dropdown != null) this.dropdown.draw();
    if (this.slider != null) this.slider.draw();
  }
  
  public int start()
  {
    return this.start;
  }
  
  public int end()
  {
    return this.end;
  }
  
  public String filter()
  {
    return this.filter;
  }
  
  public String queryString()
  {
    return this.queryString;
  }
  
  public String getDisplayValue()
  {
    return dropdown.displayValue();
  }
  
  public void incrementSearch(int increment)
  {
    this.start += increment;
  }
  
  public void decrementSearch(int decrement)
  {
    if (this.start - decrement < 0) this.start = 0;
    else this.start -= decrement;
  }
  
  public int getEvent()
  {
    int e = 0;
    String s = "";
    if (this.dropdown != null)
    {
      e = this.dropdown.getEvent();
      if (e == EVENT_BUTTON4) this.dropdown.toggleFocus();
      s = this.dropdown.getValueOnPress();
      if (s != "") this.filter = s;
    }
    if (sortDrop != null)
    {
      e = this.sortDrop.getEvent();
      if (e == EVENT_SORT) this.sortDrop.toggleFocus();
      s = this.sortDrop.getValueOnPress();
      if (s != "") this.order = s;
    }
    if(mouseX > this.x()+210 && mouseX < this.x()+610 && mouseY > this.y() && mouseY < this.y()+50) return this.event;
    if (mouseX > this.x()+700 && mouseX < this.x()+800 && mouseY > this.y() && mouseY < this.y()+50) return this.event2;
    return 0;
  }
  
  public void toggleFocus()
  {
    this.isFocused = !this.isFocused;
  }
  
  public void setFilter(String filter)
  {
    this.filter = filter;
  }
  
  public ArrayList<DataPoint> search(boolean reset)
  {
    if (reset) this.start = 0;
    this.lastSearch = this.queryString;
    ArrayList<DataPoint> tmpArr = this.applyAppropriateSearch(this.start);
    return tmpArr;
    //if (this.order == "all") return db.getWithFilter(this.filter, this.queryString, this.start, this.end);
    //if (this.order == "lateness") return db.getByLatenessWithFilter(false, this.filter, this.queryString, this.start, this.end);
    //return db.getWithFilter(this.filter, this.queryString, this.start, this.end, this.order);
  }
  
  public void incrementSearchAndSetTable(int increment, Table table)
  {
    ArrayList<DataPoint> tmpArr = this.applyAppropriateSearch(this.start+increment);
    //if (this.slider != null)
    //{
    //  if (this.order == "all") tmpArr = db.getWithFilter(this.filter, this.lastSearch, this.start+increment, this.end, this.slider.startValue()-1, this.slider.endValue()-1);
    //  else if (this.order == "lateness") tmpArr = db.getByLatenessWithFilter(false, this.filter, this.queryString, this.start+increment, this.end);
    //  else tmpArr = db.getWithFilter(this.filter, this.lastSearch, this.start+increment, this.end, this.order);
    //}
    //else
    //{
    //  if (this.order == "all") tmpArr = db.getWithFilter(this.filter, this.lastSearch, this.start+increment, this.end);
    //  else if (this.order == "lateness") tmpArr = db.getByLatenessWithFilter(false, this.filter, this.queryString, this.start+increment, this.end);
    //  else tmpArr = db.getWithFilter(this.filter, this.lastSearch, this.start+increment, this.end, this.order);
    //}
    //if (this.order == "all") tmpArr = db.getWithFilter(this.filter, this.lastSearch, this.start+increment, this.end);
    //else if (this.order == "lateness") tmpArr = db.getByLatenessWithFilter(false, this.filter, this.queryString, this.start+increment, this.end);
    //else tmpArr = db.getWithFilter(this.filter, this.lastSearch, this.start+increment, this.end, this.order);
    if (tmpArr.size() != 0)
    {
      this.start += increment;
      table.setRows(tmpArr);
    }
  }
  
  public void decrementSearchAndSetTable(int decrement, Table table)
  {
    ArrayList<DataPoint> tmpArr = this.applyAppropriateSearch(this.start-decrement);
    //if (this.order == "all") tmpArr = db.getWithFilter(this.filter, this.lastSearch, this.start-decrement, this.end);
    //else if (this.order == "lateness") tmpArr = db.getByLatenessWithFilter(false, this.filter, this.queryString, this.start-decrement, this.end);
    //else tmpArr = db.getWithFilter(this.filter, this.lastSearch, this.start-decrement, this.end, this.order);
    if (tmpArr.size() != 0)
    {
      this.start -= decrement;
      table.setRows(tmpArr);
    }
  }
  
  private ArrayList<DataPoint> applyAppropriateSearch(int startNum)
  {
    ArrayList<DataPoint> tmpArr;
    if (this.slider != null)
    {
      if (this.order == "all") tmpArr = db.getWithFilter(this.filter, this.lastSearch, startNum, this.end, this.slider.startValue()-1, this.slider.endValue()+1);
      else if (this.order == "lateness") tmpArr = db.getByLatenessWithFilter(false, this.filter, this.queryString, startNum, this.end);
      else tmpArr = db.getWithFilter(this.filter, this.lastSearch, startNum, this.end, this.order, this.slider.startValue()-1, this.slider.endValue()+1);
    }
    else
    {
      if (this.order == "all") tmpArr = db.getWithFilter(this.filter, this.lastSearch, startNum, this.end);
      else if (this.order == "lateness") tmpArr = db.getByLatenessWithFilter(false, this.filter, this.queryString, startNum, this.end);
      else tmpArr = db.getWithFilter(this.filter, this.lastSearch, startNum, this.end, this.order);
    }
    
    return tmpArr;
  }
  
  public void keyPressed()
  {
    if (this.isFocused && this.filter != "all")
    {
      if (key == BACKSPACE && this.queryString.length() > 0)
      {
        this.queryString = this.queryString.substring(0, this.queryString.length() - 1);
      }
      else if (Character.isLetterOrDigit(key) || this.isCharInArray(key)) 
        this.queryString = this.queryString + key;
    }
  }
  
  @Override
  public void mouseDragged()
  {
    if (this.slider != null) this.slider.mouseDragged();
  }
  
  private boolean isCharInArray(char character)
  {
    for (char c : acceptableList)
    {
      if (c == character) return true;
    }
    return false;
  }
}
