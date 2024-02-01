/**
 * A generic class to implement widgets.
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class Widget {
  private int x;
  private int y;
  private int origY;
  private int width;
  private int height;
  private int extraHeight;
  private int event;
  private boolean hovered;
  
  private final static int GAP = 10;
  
  // Default constructor - a fallback
  Widget()
  {
    this.x = 0;
    this.y = 0;
    this.width = 0;
    this.height = 0;
    this.hovered = false;
    this.event = 0;
    this.extraHeight = 0;
    this.origY = 0;
  }
  
  Widget(int x,int y, int width, int height, int event)
  {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height = height; 
    this.event = event; 
    this.hovered = false;
    
    this.extraHeight = 0;
    this.origY = y;
  }
  
  // Constructor if you have no event/plan to overwrite getEvent()
  Widget(int x,int y, int width, int height)
  {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height = height; 
    this.event = 0; 
    this.hovered = false;
    
    this.extraHeight = 0;
    this.origY = y;
  }
  
  public int x()
  {
    return this.x;
  }
  
  public int y()
  {
    return this.y;
  }
  
  public int origY()
  {
    return this.origY;
  }
  
  public void setX(int x)
  {
    this.x = x;
  }
  
  public void setY(int y)
  {
    this.y = y;
  }
  
  public int height()
  {
    return this.height;
  }
  
  public int width()
  {
    return this.width;
  }
  
  public boolean hovered()
  {
    return this.hovered;
  }
  
  public void setExtraHeight(int extraHeight)
  {
    this.extraHeight = extraHeight;
  }
  
  public void callHelperFunctions()
  {
    this.isHovered();
  }
  
  public void mouseMoved()
  {
    this.isHovered();
  }
  
  public void mousePressed()
  {
    this.isHovered();
  }
  
  public void mouseDragged()
  {
    
  }
  
  void draw()
  {
    // Overwrite this method in your own Widget implementation
    // This is just a fallback
    fill(0);
    text("Widget", 0, 0);
  }
  
  
  public void isHovered()
  {
    if (mouseX > this.x && mouseX < this.x+this.width && mouseY > this.y && mouseY < this.y+this.height+this.extraHeight) this.hovered = true;
    else this.hovered = false;
  }
  
  public int getEvent()
  {
    if (mouseX > x && mouseX < x+this.width && mouseY > y && mouseY < y+this.height+this.extraHeight) return event;
    return 0;
  }
}
