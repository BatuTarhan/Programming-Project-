/**
 * Class for implementing the dropdown rows of the Dropdown class.
 * Separating these allow for easier modularity with regards to the
 * amount of rows shown.
 *
 * @author  Justin Ikechukwu Cunningham
 */

// @todo: move isHovered() out of draw()
public class DropdownItem
{
  private int x;
  private int y;
  private int width;
  private int height;
  private String displayValue;
  private String value;
  private String type;
  private color fill;
  private color textCol;
  
  DropdownItem(int x, int y, int width, int height, String displayValue, String value, String type)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.displayValue = displayValue;
    this.value = value;
    this.type = type;
  }
  
  public void draw()
  {
    if (this.isHovered()) 
    {
      this.fill = color(BLUE);
      this.textCol = color(255);
    }
    else 
    {
      this.fill = color(255);
      this.textCol = color(0);
    }
    fill(this.fill);
    stroke(0);
    if (this.type == "first") rect(this.x, this.y, this.width, this.height, 10, 10, 0, 0);
    else if (this.type == "last") rect(this.x, this.y, this.width, this.height, 0, 0, 10, 10);
    else rect(this.x, this.y, this.width, this.height);
    fill(this.textCol);
    text(this.displayValue, this.x+10, this.y+30);
  }
  
  private boolean isHovered()
  {
    if (mouseX > this.x && mouseX < this.x+this.width && mouseY > y && mouseY < y+this.height) return true;
    else return false;
  }
  
  public int isPressed()
  {
    // Returns 1 if pressed
    // Returns 0 otherwise
    if (mouseX > this.x && mouseX < this.x+this.width && mouseY > this.y && mouseY < this.y+this.height) return 1;
    return 0;
  }
  
  public String getDisplayValue()
  {
    return this.displayValue;
  }
  
  public String getValue()
  {
    return this.value;
  }
}
