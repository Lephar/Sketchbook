class Queen extends Piece
{
  Queen(int i, int j, boolean t)
  {
    super(i,j,t);
    if(t) icon = loadImage("queen1.png");
    else icon = loadImage("queen0.png");
    icon.resize(size,size);
  }
  
  int value(){return 13 * super.value();}
  
  boolean possible(int u, int w)
  {
    int dx=u-x,dy=w-y,s;
    
    if(exists && (dx==0 && dy!=0) || (dx!=0 && dy==0) || (dx!=0 && abs(dx)==abs(dy)))
    {
      s = max(abs(dx),abs(dy));
      dx /= s;
      dy /= s;
      
      if(square[u][w].ocp && team==square[u][w].piece.team) return false;
      for(int i=1; i<s; i++) if(square[x+i*dx][y+i*dy].ocp) return false;
      
      return true;
    }
    
    else return false;
  }
}