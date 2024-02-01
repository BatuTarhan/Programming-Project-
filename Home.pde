/**
 * Class for the home button which routes back to the main screen.
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class Home extends Widget
{
  private color fill;
  private boolean hovered;
  
  Home(int x, int y, int width, int height, int event, int fill)
  {
    super(x, y, width, height, event);
    this.fill = fill;
  }
  
  @Override
  public void draw()
  {
    this.hovered = this.hovered();
    if (this.hovered) 
    {
      stroke(this.fill);
      fill(255);
    }
    else 
    {
      noStroke();
      fill(this.fill);
    }
    rect(this.x(), this.y(), this.width(), this.height(), 5, 5, 5, 5);
    noStroke();
    if (this.hovered) fill(this.fill);
    else fill(255);
    triangle(this.x()+10, this.y()+this.height()/2, this.x()+25, this.y()+10, this.x()+25, this.y()+this.height()-10);
    if (this.hovered) fill(255);
    else fill(this.fill);
    triangle(this.x()+15, this.y()+this.height()/2, this.x()+30, this.y()+10, this.x()+30, this.y()+this.height()-10);
    if (this.hovered) fill(this.fill);
    else fill(255);
    textFont(avenir15);
    textAlign(CENTER, CENTER);
    text("Home", this.x()+10, this.y(), this.width()-10, this.height());
    textAlign(CORNER);
    stroke(0);
  }
}
