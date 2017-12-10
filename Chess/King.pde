class King extends Piece
{
  King(int i, int j, boolean t)
  {
    super(i,j,t);
    if(t) icon = loadImage("king1.png");
    else icon = loadImage("king0.png");
    icon.resize(size,size);
  }
  
  int value(){return 87 * super.value();}
  
  boolean possible(int u, int w)
  {
    int dx=abs(u-x),dy=abs(w-y);
    
    if(exists && dx<=1 && dy<=1 && (!square[u][w].ocp || (square[u][w].ocp && team!=square[u][w].piece.team))) return true;
    else return false;
  }
  
  void destroy()
  {
    super.destroy();
    if(!think) done = true;
  }
}