class Item
{
  int id;
  float x,y,w,h;
  PImage image;
  
  Item(int id, int x, int y)
  {
    this.id = id;
    
    if(id==0) (image = loadImage("images/bin.png")).resize(0,int(unit*52));
    else if(id==1) (image = loadImage("images/hidrant.png")).resize(0,int(unit*42));
    else if(id==2) (image = loadImage("images/bank.png")).resize(0,int(unit*48));
    else if(id==3) (image = loadImage("images/cubuk.png")).resize(0,int(unit*54));
    else if(id==4) (image = loadImage("images/bariyer.png")).resize(0,int(unit*54));
    else if(id==5) (image = loadImage("images/araba0.png")).resize(0,int(unit*43));
    else if(id==6) (image = loadImage("images/araba1.png")).resize(0,int(unit*64));
    else if(id==7) (image = loadImage("images/araba2.png")).resize(0,int(unit*42));
    //else if(id==8) (image = loadImage("images/taxi0.png")).resize(0,int(unit*64));
    //else if(id==9) (image = loadImage("images/taxi1.png")).resize(0,int(unit*64));
    //else if(id==10) (image = loadImage("images/taxi2.png")).resize(0,int(unit*64));
    
    w = image.width;
    h = image.height;
    
    this.x = x*unit;
    this.y = (y+318)*unit-h;
  }
  
  void draw()
  {
    image(image,x,y);
  }
}

class Gold
{
  int id, frame;
  float x, y, w, h;
  boolean collected;
  PImage gold[];
  
  Gold(int id, int x, int y)
  {
    this.id = id;
    w = unit*24;
    if(id==1) w *= 1.4;
    h = w;
    this.x = x*unit;
    this.y = (y+300)*unit-h;
    collected = false;
    
    frame=0;
    gold = new PImage[GOLD];
    for(int i=0; i<GOLD; i++) (gold[i] = loadImage("images/g"+i+".png")).resize(0,int(h));
  }
  
  void draw()
  { 
    if(!collected)
    {
      checkCollected();
      imageMode(CENTER);
      image(gold[(frame/2)%GOLD],x+w/2,y+h/2);
      imageMode(CORNER);
      frame++;
    }
  }
  
  void checkCollected()
  {
    if((((player.x<=x+w && player.x>=x) || (player.x+player.w>=x && player.x+player.w<=x+w))
    && ((player.y<=y+h && player.y>=y) || (player.y+player.h>=y && player.y+player.h<=y+h)))
    || (((x<player.x+player.w && x>player.x) || (x+w<player.x+player.w && x+w>player.x))
    && ((y<player.y+player.h && y>player.y) || (y+h<player.y+player.h && y+h>player.y))))
    {
      score+=id*10+10;
      collected=true;
    }
  }
}

class Bird
{
  int frame;
  float x, y, w, h;
  PImage bird[];
  ArrayList<Bomb> bombs;
  
  Bird(int x, int y)
  {
    w = unit*42;
    h = unit*42;
    this.x = x*unit;
    this.y = (y+108)*unit-h;
    
    frame=0;
    bird = new PImage[BIRD];
    for(int i=0; i<BIRD; i++) (bird[i] = loadImage("images/b"+i+".png")).resize(int(w),int(h));
    bombs = new ArrayList<Bomb>();
  }
  
  void draw()
  {
    image(mirror(bird[(frame/24)%BIRD]),x,y);
    if(frame%360==0) bombs.add(new Bomb(int(x+w/2),int(y+h)));
    for(int i=0; i<bombs.size(); i++) bombs.get(i).draw();
    x-=unit;
    frame++;
  }
}

class Bomb
{
  float x,y;
  PImage bomb;
  boolean done;
  
  Bomb(int x, int y)
  {
    this.x=x;
    this.y=y;
    done=false;
    (bomb=loadImage("images/bomb.png")).resize(int(5*unit),int(9*unit));
  }
  
  void draw()
  {
    if(!done)
    {
      image(bomb,x,y);
      y+=3*unit;
      if(y>=310*unit) done=true;
      
      if(x<player.x+player.w && x>player.x && y<player.y+player.h && y>player.y)
      {
        done=true;
        score-=5;
      }
    }
  }
}