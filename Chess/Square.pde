class Square
{
  int x, y;
  boolean slc, ocp, col;
  Piece piece;
  
  Square(int i, int j)
  {
    x = i;
    y = j;
    slc = false;
    ocp = false;
    col = (x+y)%2 == 0 ? true : false;
    piece = null;
  }
  
  void draw()
  {
    if(this == clicked) fill(#9e9e9e);
    else if(col && touched()) fill(#bdbdbd);
    else if(touched()) fill(#757575);
    else if(col) fill(#f5f5f5);
    else fill(#424242);
    
    rect(x*size,y*size,size,size);
  }
  
  void draw(Window applet)
  {
    if(col) applet.fill(#f5f5f5);
    else applet.fill(#424242);
    
    applet.rect(x*applet.size,y*applet.size,applet.size,applet.size);
  }
  
  boolean touched(){return mouseX>=x*size && mouseY>=y*size & mouseX<(x+1)*size && mouseY<(y+1)*size;}
  
  void click()
  {
    if(clicked == null)
    {
      if(piece != null && piece.team == turn) clicked = this;
    }
    
    else
    {
      if(clicked == this) clicked = null;
      else if(this.piece != null && this.piece.team == clicked.piece.team) clicked = this;
      else if(clicked.piece.possible(x,y))
      {
        clicked.piece.move(x,y);
        clicked = null;
      }
    }
  }
}