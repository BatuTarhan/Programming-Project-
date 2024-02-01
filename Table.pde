/**
 * Class for creating tables for the flight data.
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class Table extends Widget
{
  private ArrayList<TableRow> rowList;
  private int paddingTop;
  private int paddingLeft;
  private boolean visible;
  
  Table(int x, int y)
  {
    super(x, y, 900, 450, 0);
    this.paddingTop = 10;
    this.paddingLeft = 10;
    this.rowList = new ArrayList();
    this.visible = true;
  }
  
  public void setRows(ArrayList<DataPoint> data)
  {
    rowList.removeAll(rowList);
    for (int i=0; i < data.size(); i++)
    {
      DataPoint tmp = data.get(i);
      rowList.add(new TableRow(tmp, this.x(), this.y()+75+75*i, this.width(), 75, (i % 2 == 1) ? color(BLUE) : color(255), (i % 2 == 1) ? color(255) : color(BLUE)));
    }
  }
  
  public void draw()
  {
    textFont(avenir15);
    fill(255);
    stroke(0);
    rect(this.x(), this.y(), this.width(), 75);
    fill(0);
    line(this.x(), this.y()+74, this.x()+this.width(), this.y()+74);
    text("Date", this.x()+this.paddingLeft, this.y()+this.paddingTop, 110, 65);
    line(this.x()+this.paddingLeft+110, this.y(), this.x()+this.paddingLeft+110, this.y()+75);
    text("Flight Num", this.x()+115+this.paddingLeft, this.y()+this.paddingTop, 65, 65);
    line(this.x()+this.paddingLeft+170, this.y(), this.x()+this.paddingLeft+170, this.y()+75);
    text("Origin", this.x()+175+this.paddingLeft, this.y()+this.paddingTop, 65, 65);
    line(this.x()+this.paddingLeft+240, this.y(), this.x()+this.paddingLeft+240, this.y()+75);
    text("Origin City", this.x()+245+this.paddingLeft, this.y()+this.paddingTop, 100, 65);
    line(this.x()+this.paddingLeft+345, this.y(), this.x()+this.paddingLeft+345, this.y()+75);
    text("Dest", this.x()+350+this.paddingLeft, this.y()+this.paddingTop, 65, 65);
    line(this.x()+this.paddingLeft+415, this.y(), this.x()+this.paddingLeft+415, this.y()+75);
    text("Dest City", this.x()+420+this.paddingLeft, this.y()+this.paddingTop, 100, 65);
    line(this.x()+this.paddingLeft+520, this.y(), this.x()+this.paddingLeft+520, this.y()+75);
    text("Sch. Dep.", this.x()+525+this.paddingLeft, this.y()+this.paddingTop, 65, 65);
    line(this.x()+this.paddingLeft+590, this.y(), this.x()+this.paddingLeft+590, this.y()+75);
    text("Act. Dep.", this.x()+595+this.paddingLeft, this.y()+this.paddingTop, 65, 65);
    line(this.x()+this.paddingLeft+660, this.y(), this.x()+this.paddingLeft+660, this.y()+75);
    text("Sch. Arr.", this.x()+665+this.paddingLeft, this.y()+this.paddingTop, 65, 65);
    line(this.x()+this.paddingLeft+730, this.y(), this.x()+this.paddingLeft+730, this.y()+75);
    text("Act. Arr", this.x()+735+this.paddingLeft, this.y()+this.paddingTop, 65, 65);
    line(this.x()+this.paddingLeft+800, this.y(), this.x()+this.paddingLeft+800, this.y()+75);
    text("Distance", this.x()+805+this.paddingLeft, this.y()+this.paddingTop, 85, 65);
    if (rowList.size() > 0)
    {
      for (int i=0; i < rowList.size(); i++)
      {
        rowList.get(i).draw();
      }
      for (int i=0; i < rowList.size(); i++)
      {
        TableRow tmp = rowList.get(i);
        if (tmp.displayModal()) tmp.drawModal();
      }
    }
  }
  
  public void mousePressed()
  {
    if (rowList.size() > 0)
    {
      for (int i=0; i < rowList.size(); i++)
      {
        if (rowList.get(i).mousePressed()) this.visible = false;
      }
    }
  }
}
