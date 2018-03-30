class Plane
{
  int x, y;
  float a, r, t, s;
  
  Plane(int x, int y, float a)
  {
    this.x = x;
    this.y = y;
    this.a = a;
    r=17*PI/10;
    s=PI/480;
  }
  
  void draw()
  {
    pushMatrix();
    translate(x,y);
    rotate(a+r);
    t = map(button.value,button.margin,height-button.margin,17*PI/10,2*PI);
    if(r<t) r+=s;
    else r-=s;
    image(image,0,0,200,200);
    popMatrix();
  }
}
