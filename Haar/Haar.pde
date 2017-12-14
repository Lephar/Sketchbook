import processing.video.*;

long haar[][];
Capture camera;
int x1,y1,x2,y2;

void settings()
{
  size(1280,480,P3D);
  noSmooth();
}

void setup()
{
  frameRate(30);
  noStroke();
  noFill();
  
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER,CENTER);
  
  (camera=new Capture(this,width/2,height,30)).start();
}

void draw()
{
  background(255);
  if(camera.available()) camera.read();
  //haar=haar(mirror(edge(blur(camera))));
  //image(lhaar(mirror(edge(blur(camera)))),camera.width/2,height/2);
  //image(lhaar(mirror(camera)),camera.width+camera.width/2,height/2);
  image(mirror(camera),camera.width/2,height/2);
  image(edgep(blur(camera)),camera.width+camera.width/2,height/2);
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
  println(light(haar,x1,y1,x2-x1,y2-y1));
}