/**
 * Class for quickly implementing dropdowns. 
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class Dropdown extends Widget
{
  private boolean focused;
  private String displayValue;
  private int event;
  private ArrayList<DropdownItem> itemList;
  
  Dropdown(int x, int y, int width, int height, int event)
  {
    super(x, y, width, height, 20);
    this.event = event;
    this.itemList = new ArrayList();
    this.displayValue = "";
  }
  
  /**
  * Adds a DropdownItem to the dropdown
  *
  * @param  displayValue the text to be displayed in the dropdown ui
  * @param  value        the value of the item
  */
  public void addItem(String displayValue, String value)
  {
    String type;
    if (itemList.size() == 0) type = "first";
    else if (itemList.size() == 1) type = "last";
    else
    {
      type = "last";
      DropdownItem lastItem = itemList.get(itemList.size()-1);
      String tmpDN = lastItem.getDisplayValue();
      String tmpN = lastItem.getValue();
      itemList.remove(itemList.size()-1);
      itemList.add(new DropdownItem(this.x()-10, this.y()+15+50*(itemList.size()), this.width(), 50, tmpDN, tmpN, "normal"));
    }
    DropdownItem newItem = new DropdownItem(this.x()-10, this.y()+15+50*(itemList.size()), this.width(), 50, displayValue, value, type);
    itemList.add(newItem);
    if (this.displayValue == "") this.displayValue = newItem.getDisplayValue();
  }
  
  @Override
  void draw()
  {
    fill(0);
    noStroke();
    text(this.displayValue, this.x(), this.y());
    if (this.focused) triangle(this.x()+this.width()-20, this.y()-3, this.x()+this.width(), this.y()-3, this.x()+this.width()-10, this.y()-12);
    else triangle(this.x()+this.width()-20, this.y()-12, this.x()+this.width(), this.y()-12, this.x()+this.width()-10, this.y()-3);
    if (this.focused)
    {
      for (int i=0; i < itemList.size(); i++)
      {
        itemList.get(i).draw();
      }
    }
  }
  
  public boolean focused()
  {
    return this.focused;
  }
  
  public String displayValue()
  {
    return this.displayValue;
  }
  
  /**
  * Returns the value of the dropdown row that was just pressed
  * <p>
  * Returns an empty string if there was no selected row
  *
  * @return              the value of the selected row
  */
  public String getValueOnPress()
  {
    if (this.focused)
    {
      for (int i=0; i < itemList.size(); i++)
      {
        DropdownItem tmp = itemList.get(i);
        if (tmp.isPressed() == 1)
        {
          this.displayValue = tmp.getDisplayValue();
          //this.search.setFilter(tmp.getValue());
          this.focused = false;
          return tmp.getValue();
        }
      }
    }
    return "";
  }
  
  @Override
  public int getEvent()
  {
    // Check if the dropdown itself has been pressed
    if(mouseX > this.x() && mouseX < this.x()+300 && mouseY > this.y()-50 && mouseY < this.y()) return this.event;
    return 0;
  }
  
  public void toggleFocus()
  {
    this.focused  = !this.focused;
  }
}
