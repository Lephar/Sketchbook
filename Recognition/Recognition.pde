import java.awt.*;
import gab.opencv.*;
import processing.video.*;

OpenCV cv;
Capture cam;
PGraphics west,east;
Rectangle faces[];

void settings()
{
  size(640,480);
  noSmooth();
}

void setup()
{
  frameRate(30);
  (cam=new Capture(this,640,480,30)).start();
  (cv=new OpenCV(this,320,240)).loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void draw()
{
  background(0);
  surface.setTitle(""+frameRate);
  
  if(cam.available())
  {
    cam.read();
    cv.loadImage(cam);
  }
  
  image(cam,0,0);
  
  /*noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  faces = cv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++)
  {
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }*/
}