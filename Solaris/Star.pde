class Star
{
  int border;
  PVector pos;
  
  Star()
  {
    border = max(width,height);
    pos = new PVector(random(-2*border,3*border),random(-2*border,3*border),-1024);
  }
  
  void reset()
  {
    pos.set(random(-2*border,3*border),random(-2*border,3*border),-1024);
  }
  
  void draw()
  {
    point(pos.x,pos.y,pos.z);
  }
}