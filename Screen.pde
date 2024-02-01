/**
 * A generic class to draw screens.
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class Screen
{
  private ArrayList widgetList;
  private color backgroundColor;
  private int height;
  private int y;
  private int originalY;
  private boolean draggable;
  
  Screen(color backgroundColor)
  {
    this.widgetList = new ArrayList();
    this.backgroundColor = backgroundColor;
    this.height = 0;
    this.y = 0;
    this.originalY = 0;
    this.draggable = false;
  }
  
  Screen(color backgroundColor, int height, int y)
  {
    this.widgetList = new ArrayList();
    this.backgroundColor = backgroundColor;
    this.height = height;
    this.y = y;
    this.originalY = y;
    this.draggable = false;
  }
  
  public void addWidget(Widget widget)
  {
    this.widgetList.add(widget);
  }
  
  public void draw()
  {
    background(this.backgroundColor);
    if (mousePressed)
    {
      if (mouseX >= width-15 && 
          mouseX <= width-5 && 
          mouseY >= this.y+5 && 
          mouseY <= this.y+45)
        this.draggable = true;
        
      if ((this.draggable || (mouseX >= width-15 && 
          mouseX <= width-5 && 
          mouseY >= this.y+5 && 
          mouseY <= this.y+45)) &&
          mouseY >= this.originalY + 25 &&
          mouseY <= SCREENY - 30)
      {
         this.y = mouseY - 20;
         for (int i=0; i < this.widgetList.size(); i++)
         {
           Widget tmpWidget = (Widget) this.widgetList.get(i);
           tmpWidget.setY(Math.round(tmpWidget.origY() - ((float) (this.y-this.originalY-5))/(SCREENY-25-this.originalY-5)*this.height));
         }
      }
    } else this.draggable = false;
    if (this.height != 0)
    {
      fill(BLUE);
      noStroke();
      rect(width-15, this.y+5, 10, 40, 100, 100, 100, 100);
    }
    for (int i=0; i < this.widgetList.size(); i++)
    {
      Widget tmpWidget = (Widget) this.widgetList.get(i);
      tmpWidget.callHelperFunctions();
      tmpWidget.draw();
    }
  }
  
  public int getEvent()
  {
    for (int i=0; i < widgetList.size(); i++)
    {
      Widget tmpWidget = (Widget) widgetList.get(i);
      tmpWidget.mousePressed();
      int event = tmpWidget.getEvent();
      if (event != 0) return event;
    }
    return 0;
  }
  
  public void mouseMoved()
  {
    for (int i=0; i < widgetList.size(); i++)
    {
      Widget tmpWidget = (Widget) widgetList.get(i);
      tmpWidget.mouseMoved();
    }
  }
  
  public void mouseDragged()
  {
    for (int i=0; i < widgetList.size(); i++)
    {
      Widget tmpWidget = (Widget) widgetList.get(i);
      tmpWidget.mouseDragged();
    }
  }
}
