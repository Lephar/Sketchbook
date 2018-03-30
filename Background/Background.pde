import processing.video.*;

int x;
Capture camera;
int status,frame;
PImage city,background,difference,foreground;
PImage[] buffer;
boolean mode;

void setup()
{
  size(320,240);
  frameRate(15);
  background(0);
  imageMode(CENTER);
  noSmooth();
  noStroke();
  noFill();
  
  frame=0;
  status=0;
  mode=false;
  (camera=new Capture(this,width,height,30)).start();
  (city=loadImage("bg1.png")).resize(0,height);
  x=city.width/2-width/2;
  buffer=new PImage[60];
}

void draw()
{
  if(status==0)
  {
    background(31);
    
    if(camera.available()) frame++;
    
    if(frame==buffer.length-1)
    {
      frame=-1;
      status=1;
    }
  }
  
  else if(status==1)
  {
    background(63);
    
    if(camera.available())
    {
      camera.read();
      frame++;
    }
    
    buffer[frame]=camera.copy();
    
    if(frame==buffer.length-1)
    {
      background=average(buffer);
      //difference=difference(background,buffer);
      buffer=new PImage[buffer.length];
      status=2;
      frame=-1;
    }
  }
  
  else if(status==2)
  {
    if(camera.available()) camera.read();
    foreground=difference(camera.get(),difference,background);
    image(city,width/2+x--,height/2);
    if(mode) image(camera,width/2,height/2);
    else image(foreground,width/2,3*height/4);
    saveFrame("frames/######.tif");
  }
}

void mousePressed()
{
  //status=1;
  mode=!mode;
}

void keyPressed()
{
  //status=1;
  mode=!mode;
}