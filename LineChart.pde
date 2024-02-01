/**
 * Class for implementing line charts.
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class LineChart extends Widget
{ 
  private int total;
  private String filter;
  private String displayFilter;
  private String query;
  private ArrayList<Float> heights;
  private ArrayList<Integer> values;
  private ArrayList<LineDot> dotList;
  LineChart(int x, int y, int width, int height, int event)
  {
    super(x, y, width, height, event);
    this.total = 30000;
    this.heights = new ArrayList();
    this.values = new ArrayList();
    this.dotList = new ArrayList();
    this.filter = "origin";
    this.displayFilter = "Origin Airport";
    this.query = "SMF";
  }
  
  public void settingUp(String filter, String query, String displayFilter)
  {
    this.values = new ArrayList();
    this.heights = new ArrayList();
    this.dotList = new ArrayList();
    this.filter = filter;
    this.query = query;
    this.displayFilter = displayFilter;
    if (this.filter == "all")
    {
      // No filter
      for (int i=1; i <= 31; i++)
      {
        this.values.add(sql.countWithFilter("date", "1/"+i+"/2022 12:00:00 AM"));
                this.values.add(sql.countWithFilter("date", "2022-01-" + (i < 10 ? "0" : "") + i));
      }
    }
    else
    {
      for (int i=1; i <= 31; i++)
      {
        //this.values.add(sql.countWithFilter("date", "1/"+i+"/2022 12:00:00 AM", filter, query));
                this.values.add(sql.countWithFilter("date", "2022-01-" + (i < 10 ? "0" : "") + i, filter, query));

        println("done");
      }
    }
    this.total = Collections.max(this.values);
    
    int r = this.total % 10;
    if (r != 0) this.total += 10 - r;
    
    for (int i=0; i < this.values.size(); i++)
    {
      float h = this.y() - ((float) this.values.get(i) / (float) this.total) * this.height();
      this.heights.add(h);
      this.dotList.add(new LineDot(this.x()+this.width()*((float)(i+1)/31), h, this.values.get(i), i+1));
    }
  }

  public void draw()
  {
    textFont(avenir15);
    fill(0);
    stroke(0);
    textAlign(CENTER, CENTER);
    text("Number of flights" + (this.filter == "all" ? "" : " where " + this.displayFilter + " is " + this.query), this.x(), this.y()-this.height()-50, this.width(), 30);
    textAlign(CORNER);
    
    line(this.x(), this.y(), this.x()+this.width(), this.y());
    line(this.x(), this.y(), this.x(), this.y()-this.height());
    
    for (int i=0; i < 11; i++)
    {
      line(this.x(), this.y()-this.height()*((float) i/10), this.x()-10, this.y()-this.height()*((float) i/10));
      text((this.total/10)*i, this.x()-70, this.y()+6-this.height()*((float) i/10));
    }
    
    ellipseMode(CENTER);
    for (int i=0; i < 31; i++)
    {
      fill(0);
      line(this.x()+this.width()*((float)(i+1)/31), this.y(), this.x()+this.width()*((float)(i+1)/31), this.y()+10);
      if (i % 2 == 0)
      {
        textAlign(CENTER,CENTER);
        text(Integer.toString(i), (int) this.x()+this.width()*((float)(i)/31)-25, this.y()+20, 50, 20);
        textAlign(CORNER);
      }
      if (i == 0)
      {
        line(this.x(), this.y(), this.x()+((this.width()*((float)(i+1)/31))), this.heights.get(i));
      } else
      {
        line(this.x()+this.width()*((float)(i)/31), this.heights.get(i-1),
          this.x()+this.width()*((float)(i+1)/31), this.heights.get(i));
      }
    }
    
    for (int i=0; i < 31; i++)
    {
      this.dotList.get(i).draw();
    }
    ellipseMode(CORNER);
  }
}
