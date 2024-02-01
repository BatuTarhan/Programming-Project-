class LineDot
  {
    // A nested class for the dots seen on the line chart
    private float x;
    private float y;
    private int data;
    private int day;
    private boolean right;
    private int width;
    private int height;
    
    LineDot(float x, float y, int data, int day)
    {
      this.x = x;
      this.y = y;
      this.data = data;
      this.day = day;
      // Render info card to the right of the mouse if there's not enough space to the left
      if (x < 160) this.right = true;
      else this.right = false;
      this.width = 150;
      this.height = 60;
    }
    
    void draw()
    {
      if (this.hovered()) 
      {
        fill(255);
        rect(this.x+(this.right ? 10 : -160), this.y, this.width, this.height, 5, 5, 5, 5);
        fill(0);
        textAlign(CENTER, CENTER);
        text((this.day < 10 ? "0" : "") + this.day + "/01/2022", this.x+(this.right ? 10 : -160), this.y, this.width, 30);
        line(this.x+(this.right ? 10 : -160)+5, this.y+25, this.x+(this.right ? 10 : -160)+this.width-5, this.y+25);
        textAlign(LEFT,CENTER);
        text("Flights: " + this.data, this.x+(this.right ? 20 : -150), this.y+10, this.width-10, this.height);
        circle(this.x, this.y, 10);
      }
      else circle(this.x, this.y, 5);
      
    }
    
    public boolean hovered()
    {
      if (mouseX >= this.x-5 && mouseX <= this.x+5 && mouseY >= this.y-5 && mouseY <= this.y+5) return true;
      return false;
    }
  }
