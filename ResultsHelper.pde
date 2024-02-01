/**
 * A helper class to implement pagination.
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class ResultsHelper extends Widget
{
  private Search search;
  private int eventForward;
  private int eventBack;
  private color textColor;
  
  ResultsHelper(int x, int y, int width, int height, Search search, int eventForward, int eventBack, color textColor)
  {
    super(x, y, width, height);
    this.search = search;
    this.eventForward = eventForward;
    this.eventBack = eventBack;
    this.textColor = textColor;
  }
  
  ResultsHelper(int x, int y, int width, int height, Search search, int eventForward, int eventBack)
  {
    super(x, y, width, height);
    this.search = search;
    this.eventForward = eventForward;
    this.eventBack = eventBack;
    this.textColor = 0;
  }
  
  public void draw()
  {
    textFont(avenir15);
    fill(this.textColor);
    text("Showing results " + int(this.search.start()+1) + " - " + int(this.search.start()+this.search.end()), this.x(), this.y());
    triangle(this.x()+this.width()-10, this.y(), this.x()+this.width()-10, this.y()-15, this.x()+this.width(), this.y()-7);
    triangle(this.x()+this.width()-30, this.y()-7, this.x()+this.width()-20, this.y(), this.x()+this.width()-20, this.y()-15);
  }
  
  public void increaseSearch(Table table)
  {
    this.search.incrementSearchAndSetTable(5, table);
  }
  
  public void decreaseSearch(Table table)
  {
    this.search.decrementSearchAndSetTable(5, table);
  }
  
  public int getEvent()
  {
    if (mouseX > this.x()+this.width()-10 && mouseX < this.x()+this.width() &&
        mouseY > this.y()-15 && mouseY < this.y())
        return this.eventForward;
    if (mouseX > this.x()+this.width()-30 && mouseX < this.x()+this.width()-20 &&
        mouseY > this.y()-15 && mouseY < this.y())
        return this.eventBack;
    return 0;
  }
}
