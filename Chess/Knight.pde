class Knight extends Piece
{
  Knight(int i, int j, boolean t)
  {
    super(i,j,t);
    if(t) icon = loadImage("knight1.png");
    else icon = loadImage("knight0.png");
    icon.resize(size,size);
  }
  
  int value(){return 5 * super.value();}
  
  boolean possible(int u, int w)
  {
    int dx=abs(u-x),dy=abs(w-y);
    
    if(exists && ((dx==1 && dy==2) || (dx==2 && dy==1)) && (!square[u][w].ocp || (square[u][w].ocp && team!=square[u][w].piece.team))) return true;
    else return false;
  }
}