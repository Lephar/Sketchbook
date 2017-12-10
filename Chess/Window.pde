class Window extends PApplet
{
  int size;
  PApplet parent;
  
  Window(PApplet applet)
  {
    super();
    parent = applet;
  }
  
  void settings()
  {
    int width = parent.width/3;
    int height = parent.height/3;
    size(width,height);
    smooth(64);
  }
  
  void setup()
  {
    surface.setTitle("AI");
    frameRate(60);
    noStroke();
  
    imageMode(CENTER);
    textAlign(CENTER,CENTER);
    textSize(20);
    
    size = min(width,height)/8;
    surface.setSize(size*8,size*8);
  }
  
  void draw()
  {
    if(done && piece[0][15].exists)
    {
      background(255);
      fill(0);
      text("White team won!",width/2,height/2-10);
    }
    
    else if(done && piece[1][15].exists)
    {
      background(0);
      fill(255);
      text("Black team won!",width/2,height/2-10);
    }
    
    else
    {
      for(int i=0; i<8; i++) for(int j=0; j<8; j++) square[i][j].draw(this);
      for(int i=0; i<2; i++) for(int j=0; j<16; j++) piece[i][j].draw(this);
    }
  }
}