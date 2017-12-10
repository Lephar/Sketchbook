class Bishop extends Piece
{
  Bishop(int i, int j, boolean t)
  {
    super(i,j,t);
    if(t) icon = loadImage("bishop1.png");
    else icon = loadImage("bishop0.png");
    icon.resize(size,size);
  }
  
  int value(){return 3 * super.value();}
  
  boolean possible(int u, int w)
  {
    int dx=u-x,dy=w-y,s;
    
    if(exists && abs(dx) != 0 && abs(dx) == abs(dy))
    {
      s = abs(dx);
      dx /= s;
      dy /= s;
      
      if(square[u][w].ocp && team==square[u][w].piece.team) return false;
      for(int i=1; i<s; i++) if(square[x+i*dx][y+i*dy].ocp) return false;
      
      return true;
    }
    
    else return false;
  }
}