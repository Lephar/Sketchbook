class Piece
{
  int x, y;
  PImage icon;
  boolean team, exists, moved;
  
  Piece(int i, int j, boolean t)
  {
    x = i;
    y = j;
    team = t;
    exists = true;
    moved = false;
    square[i][j].ocp = true;
    square[i][j].piece = this;
  }
  
  void draw()
  {
    if(exists) image(icon,x*size+size/2,y*size+size/2);
  }
  
  void draw(Window applet)
  {
    if(exists) applet.image(icon,x*applet.size+applet.size/2,y*applet.size+applet.size/2,applet.size,applet.size);
  }
  
  int value(){return exists ? (team ? -1 : 1) : 0;}
  
  boolean possible(int x, int y){return exists && !square[x][y].ocp;}
  
  void move(int u, int w)
  {
    if(square[u][w].piece != null) square[u][w].piece.destroy();
    square[x][y].ocp = false;
    square[x][y].piece = null;
    square[u][w].ocp = true;
    square[u][w].piece = this;
    moved = true;
    x = u;
    y = w;
    turn = !turn;
  }
  
  void revive()
  {
    square[x][y].piece = this;
    square[x][y].ocp = true;
    exists = true;
  }
  
  void destroy()
  {
    square[x][y].piece = null;
    square[x][y].ocp = false;
    exists = false;
  }
}