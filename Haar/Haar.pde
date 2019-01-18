import processing.video.*;

long haar[][];
Capture camera;
int x1,y1,x2,y2;

void settings()
{
  size(1280,960,P3D);
  noSmooth();
}

void setup()
{
  frameRate(30);
  noStroke();
  noFill();
  
  rectMode(CENTER);
  //imageMode(CENTER);
  textAlign(CENTER,CENTER);
  
  (camera=new Capture(this,width/2,height/2,30)).start();
}

void draw()
{
  background(255);
  if(camera.available()) camera.read();
  //haar=haar(mirror(edge(blur(camera))));
  image(lhaar(camera),0,0);
  image(blur(camera),camera.width,0);
  image(edge(blur(camera)),0,camera.height);
  image(threshold(camera),camera.width,camera.height);
  surface.setTitle(""+frameRate);
}

void mouseClicked()
{
  println(rval(get(mouseX,mouseY))+" "+gval(get(mouseX,mouseY))+" "+bval(get(mouseX,mouseY)));
}

void mousePressed()
{
  x1=mouseX;
  y1=mouseY;
}

void mouseReleased()
{
  x2=mouseX;
  y2=mouseY;
  //println(light(haar,x1,y1,x2-x1,y2-y1));
}
