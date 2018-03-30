class Frame
{
  PVector a, b, c;
  
  Frame(float x1, float x2, float x3, float a1, float a2)
  {
    a = new PVector(0,-x1);
    b = new PVector(0,-x2);
    b.rotate(a1);
    c = new PVector(0,-x3);
    c.rotate(-a2);
  }
  
  void draw()
  {
    fill(127,127,127);
    triangle(a.x, a.y, b.x, b.y, c.x, c.y);
  }
}
