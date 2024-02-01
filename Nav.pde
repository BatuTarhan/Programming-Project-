/**
 * Class for navigation buttons. Their primary purpose is to
 * enable routing functionality.
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class Nav extends Widget
{
  private int borderRadius;
  private color fillColor;
  private color textColor;
  private String text;
  private PImage img;
  private boolean animate;
  private int origX;
  
  Nav(int x, int y, String text, int width, int height, int event, color fillColor, color textColor, int borderRadius, PImage img)
  {
    super(x, y, width, height, event);
    this.borderRadius = borderRadius;
    this.fillColor = fillColor;
    this.textColor = textColor;
    this.text = text;
    this.img = img;
    this.animate = false;
    this.origX = x;
  }
  
  @Override
  public void draw()
  {
    strokeWeight(1);
    noFill();
    if (this.hovered()) 
    {
      this.animate = true;
      stroke(this.fillColor);
      fill(255);
    }
    else
    {
      this.animate = false;
      noStroke();
      fill(this.fillColor);
    }
    this.animate();
    textFont(avenir);
    rect(this.x(), this.y(), this.width(), this.height(), this.borderRadius, this.borderRadius, this.borderRadius, this.borderRadius);
    if (this.hovered()) tint(255, 255);
    else tint(255, 120);
    rectMode(CORNER);
    image(this.img, 
          this.x()+this.width()-((float(this.height())/float(this.img.height)) * this.img.width), 
          this.y(), 
          (float(this.height())/float(this.img.height)) * this.img.width, 
          this.height());
    fill(0);
    tint(255, 255);
    if (this.hovered()) fill(this.fillColor);
    else fill(this.textColor);
    textAlign(LEFT, CENTER);
    text(this.text, this.x()+20, this.y(), this.width(), this.height());
    textAlign(CORNER);
    textFont(font);
  }
  
  private void animate()
  {
    if (this.animate && this.x() < this.origX + 30)
    {
      this.setX(this.x() + 4);
    }
    else if (!this.animate && this.x() > this.origX)
    {
      this.setX(this.x() - 4);
    }
  }
}
