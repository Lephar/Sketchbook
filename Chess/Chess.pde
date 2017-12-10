int size, depth;
boolean turn, think, done, queued;
Square clicked, square[][];
Piece piece[][];
Window applet;

void settings()
{
  int width = 3*displayWidth/4;
  int height = 3*displayHeight/4;
  size(width,height);
  smooth(64);
}

void setup()
{
  frameRate(60);
  noStroke();
  imageMode(CENTER);
  
  initialize();
  depth = 5;
}

void initialize()
{
  size = min(width,height)/8;
  surface.setSize(size*8,size*8);
  
  square = new Square[8][8];
  for(int i=0; i<8; i++) square[i] = new Square[8];
  for(int i=0; i<8; i++) for(int j=0; j<8; j++) square[i][j] = new Square(i,j);
  
  piece = new Piece[2][];
  for(int i=0; i<2; i++) piece[i] = new Piece[16];
  
  for(int i=0; i<8; i++) piece[0][i] = new Pawn(i,6,true);
  piece[0][8] = new Bishop(2,7,true);
  piece[0][9] = new Bishop(5,7,true);
  piece[0][10] = new Knight(1,7,true);
  piece[0][11] = new Knight(6,7,true);
  piece[0][12] = new Rook(0,7,true);
  piece[0][13] = new Rook(7,7,true);
  piece[0][14] = new Queen(3,7,true);
  piece[0][15] = new King(4,7,true);
  
  for(int i=0; i<8; i++) piece[1][i] = new Pawn(i,1,false);
  piece[1][8] = new Bishop(2,0,false);
  piece[1][9] = new Bishop(5,0,false);
  piece[1][10] = new Knight(1,0,false);
  piece[1][11] = new Knight(6,0,false);
  piece[1][12] = new Rook(0,0,false);
  piece[1][13] = new Rook(7,0,false);
  piece[1][14] = new Queen(3,0,false);
  piece[1][15] = new King(4,0,false);
  
  clicked = null;
  queued = false;
  think = false;
  done = false;
  turn = true;
  
  applet = new Window(this);
  runSketch(new String[]{"Turn"},applet);
}

void draw()
{
  for(int i=0; i<8; i++) for(int j=0; j<8; j++) square[i][j].draw();
  for(int i=0; i<2; i++) for(int j=0; j<16; j++) piece[i][j].draw();
  
  if(!done && !turn && !think && !queued) play();
  if(!piece[0][15].exists || !piece[1][15].exists) done = true;
  
  if(done)
  {
    fill(127,127);
    if(piece[1][15].exists) rect(piece[0][15].x*size,piece[0][15].y*size,size,size);
    else if(piece[0][15].exists) rect(piece[1][15].x*size,piece[1][15].y*size,size,size);
  }
}

void play()
{
  think = true;
  Move optimal = null, temp;
  
  for(int i=0; i<16; i++) for(int j=0; j<8; j++) for(int k=0; k<8; k++) if(piece[1][i].exists && piece[1][i].possible(j,k))
  {
    if(optimal == null) optimal = alphac(piece[1][i].x,piece[1][i].y,j,k,piece[1][i].x,piece[1][i].y,j,k,depth-1,null);
    else
    {
      temp = alphac(piece[1][i].x,piece[1][i].y,j,k,piece[1][i].x,piece[1][i].y,j,k,depth-1,optimal);
      if(temp.score == optimal.score && random(8) < 1) optimal = temp;
      if(temp.score > optimal.score) optimal = temp;
    }
  }
  
  if(optimal != null) square[optimal.sx][optimal.sy].piece.move(optimal.tx,optimal.ty);
  think = false;
}

Move alphac(int sx, int sy, int tx, int ty, int osx, int osy, int otx, int oty, int d, Move min)
{
  Move worst=null,temp;
  Piece destroyed = square[tx][ty].piece;
  square[sx][sy].piece.move(tx,ty);
  
  if(d == 0) worst = new Move(osx,osy,otx,oty,evaluate());
  
  else
  {
    for(int i=0; i<16; i++) for(int j=0; j<8; j++) for(int k=0; k<8; k++) if(piece[0][i].exists && piece[0][i].possible(j,k))
    {
      if(worst == null) worst = betac(piece[0][i].x,piece[0][i].y,j,k,osx,osy,otx,oty,d-1,null);
      else
      {
        temp = betac(piece[0][i].x,piece[0][i].y,j,k,osx,osy,otx,oty,d-1,worst);
        if(temp.score == worst.score && random(8) < 1) worst = temp;
        else if(temp.score < worst.score) worst = temp;
      }
      
      if(min != null && worst.score < min.score)
      {
        square[tx][ty].piece.move(sx,sy);
        if(sy == 1) square[sx][sy].piece.moved = false;
        if(destroyed != null) destroyed.revive();
        return worst;
      }
    }
  }
  
  square[tx][ty].piece.move(sx,sy);
  if(sy == 1) square[sx][sy].piece.moved = false;
  if(destroyed != null) destroyed.revive();
  
  return worst;
}

Move betac(int sx, int sy, int tx, int ty, int osx, int osy, int otx, int oty, int d, Move max)
{
  Move best=null,temp;
  Piece destroyed = square[tx][ty].piece;
  square[sx][sy].piece.move(tx,ty);
  
  if(d == 0) best = new Move(osx,osy,otx,oty,evaluate());
  
  else
  {
    for(int i=0; i<16; i++) for(int j=0; j<8; j++) for(int k=0; k<8; k++) if(piece[1][i].exists && piece[1][i].possible(j,k))
    {
      if(best == null) best = alphac(piece[1][i].x,piece[1][i].y,j,k,osx,osy,otx,oty,d-1,null);
      else
      {
        temp = alphac(piece[1][i].x,piece[1][i].y,j,k,osx,osy,otx,oty,d-1,best);
        if(temp.score == best.score && random(8) < 1) best = temp;
        else if(temp.score > best.score) best = temp;
      }
      
      if(max != null && best.score > max.score)
      {
        square[tx][ty].piece.move(sx,sy);
        if(sy == 6) square[sx][sy].piece.moved = false;
        if(destroyed != null) destroyed.revive();
        return best;
      }
    }
  }
  
  square[tx][ty].piece.move(sx,sy);
  if(sy == 6) square[sx][sy].piece.moved = false;
  if(destroyed != null) destroyed.revive();
  
  return best;
}

int evaluate()
{
  int value = 0;
  for(int i=0; i<2; i++) for(int j=0; j<16; j++) value += piece[i][j].value();
  return value;
}

void mouseClicked()
{
  queued = true;
  if(turn && !think && !done) for(int i=0; i<8; i++) for(int j=0; j<8; j++) if(square[i][j].touched()) square[i][j].click();
  draw();
  queued = false;
}