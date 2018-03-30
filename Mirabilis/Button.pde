class Button
{
  int margin, range, value;
  boolean clicked;
  
  Button(int margin, int range)
  {
    this.margin = margin;
    this.range = range;
    value = margin;
  }
  
  void draw()
  {
    stroke(#FFF59D);
    strokeWeight(12);
    line(margin,margin,margin,margin+range);
    noStroke();
    fill(#FFB300);
    ellipse(margin,value,40,40);
    
    if(clicked)
    {
      value += mouseY-pmouseY;
      if(value < margin) value = margin;
      else if(value > height-margin) value = height-margin;
    }
  }
  
  boolean pressed()
  {
    if(mousePressed && mouseX<margin+20 && mouseX>margin-20 && mouseY<value+20 && mouseY>value-20) return true;
    else return false;
  }
}