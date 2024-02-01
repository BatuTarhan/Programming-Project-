/**
 * Class to implement two button sliders.
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class Slider extends Widget
{
  private int circleAX;
  private int circleBX;
  private int value;
  private int valueEnd;
  private color fill;
  private int event;

  Slider(int x, int y, int width, color fill, int event)
  {
    super(x, y, width, 8, event);
    this.circleAX = this.x() + 10;
    this.circleBX = this.x()+this.width() - 10;
    this.value = 1;
    this.valueEnd = 31;
    this.fill = fill;
    this.event = event;
  }
  
  public int startValue()
  {
    return this.value;
  }
  
  public int endValue()
  {
    return this.valueEnd;
  }

  @Override
    public void draw()
  {
    stroke(0);
    fill(100);
    rect(this.x(), this.y(), this.circleAX-this.x(), 8, 1e6, 1e6, 1e6, 1e6);
    fill(this.fill);
    rect(this.circleAX, this.y(), this.width()-this.circleAX+this.x(), 8, 1e6, 1e6, 1e6, 1e6);
    fill(100);
    rect(this.circleBX, this.y(), this.width()-this.circleBX+this.x(), 8, 1e6, 1e6, 1e6, 1e6);
    fill(0);
    text(this.value+"/01/22", this.x()-70, this.y()+this.height()+2);
    text(this.valueEnd+"/01/22", this.x()+this.width()+10, this.y()+this.height()+2);
    fill(255);
    ellipseMode(CENTER);
    circle(this.circleAX, this.y()+4, 20);
    circle(this.circleBX, this.y()+4, 20);
  }

  /**
  * Sets the position of the left slider grab handle
  */
  public void setCircleAPosition()
  {
    if (mouseX >= this.circleAX - 10 && mouseX <= this.circleAX + 10 && mouseY >= this.y()-6 && mouseY <= this.y() + 14)
    {
      if (mouseX < this.x()) this.circleAX = this.x();
      else if (mouseX > this.x()+this.width()) this.circleAX = this.x() + this.width();
      else this.circleAX = mouseX;
      this.value = round((float) (this.circleAX-this.x())/this.width() * 30)+1;
    }
  }

  /**
  * Sets the position of the right slider grab handle
  */
  public void setCircleBPosition()
  {
    if (mouseX >= this.circleBX - 10 && mouseX <= this.circleBX + 10 && mouseY >= this.y()-6 && mouseY <= this.y() + 14)
    {
      if (mouseX < this.x()) this.circleBX = this.x();
      else if (mouseX > this.x()+this.width()) this.circleBX = this.x() + this.width();
      else this.circleBX = mouseX;
      this.valueEnd = round((float) (this.circleBX-this.x())/this.width() * 30)+1;
    }
  }
  
  @Override
  public void mouseDragged()
  {
      this.setCircleAPosition();
      this.setCircleBPosition();
  }
  
  
}
