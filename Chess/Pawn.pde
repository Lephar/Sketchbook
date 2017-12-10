class Pawn extends Piece
{
  Pawn(int i, int j, boolean t)
  {
    super(i,j,t);
    if(t) icon = loadImage("pawn1.png");
    else icon = loadImage("pawn0.png");
    icon.resize(size,size);
  }
  
  boolean possible(int u, int w)
  {
    if(!exists) return false;
    
    else if(team)
    {
      if((u==x && w==y-1 && !square[u][w].ocp) || (!moved && u==x && w==y-2 && !square[u][w].ocp && !square[x][y-1].ocp)) return true;
      else if((u==x-1 && w==y-1 && square[u][w].ocp && !square[u][w].piece.team) || (u==x+1 && w==y-1 && square[u][w].ocp && !square[u][w].piece.team)) return true;
      else return false;
    }
    
    else
    {
      if((u==x && w==y+1 && !square[u][w].ocp) || (!moved && u==x && w==y+2 && !square[u][w].ocp && !square[x][y+1].ocp)) return true;
      else if((u==x-1 && w==y+1 && square[u][w].ocp && square[u][w].piece.team) || (u==x+1 && w==y+1 && square[u][w].ocp && square[u][w].piece.team)) return true;
      else return false;
    }
  }
}