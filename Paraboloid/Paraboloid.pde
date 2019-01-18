import controlP5.*;
ControlP5 controlP5;

public int X1 = 0;
public int Y1 = 0;
public int Z1 = 0;
public int RotX = 0;
public int RotY = 0;
public int RotZ = 0;
public int A1 = 20;
public int B1 = 20;
public int T1 = 0;
public int xyz1 = 1;
public int xyz2 = 1;
public int xyz3 = 1;
public int xyz4 = 1;
public int vb1 = 150;
public int hb1 = 150;
public int vb2 = 150;
public int hb2 = 150;
public int X2 = 0;
public int Y2 = 0;
public int Z2 = 0;
public int A2 = 20;
public int B2 = 20;
public int T2 = 0;
public int T3 = 0;
public int T4 = 0;
public int i2 = 1;
public int P1 = 0;
public int P2 = 0;
public float C1 = 1;
public float C2 = 1;
public int BG = 200;

void setup()
{
  //size(1360,800,P3D);
  fullScreen(P3D);
  
  smooth();
  frameRate(24);

  controlP5 = new ControlP5(this);
  controlP5.setAutoDraw(false);
  
  Controller n1 = controlP5.addSlider("X2",-400,400,0,1040,390,10,100);
  Controller n2 = controlP5.addSlider("Y2",-300,300,0,1070,390,10,100);
  Controller n3 = controlP5.addSlider("Z2",-500,500,0,1100,390,10,100);
  Controller n4 = controlP5.addSlider("A2",1,100,20,1130,390,10,100);
  Controller n5 = controlP5.addSlider("B2",1,100,20,1160,390,10,100);
  Controller n6 = controlP5.addSlider("T2",0,1,0,1190,390,10,100);
  Controller n7 = controlP5.addSlider("T4",0,1,0,1220,390,10,100);
  Controller ii2 = controlP5.addSlider("vb2",0,400,150,1250,390,10,100);
  Controller nn2 = controlP5.addSlider("hb2",0,300,150,1280,390,10,100);

  Controller o = controlP5.addSlider("X1",-400,400,0,1040,200,10,100);
  Controller z = controlP5.addSlider("Y1",-300,300,0,1070,200,10,100);
  Controller a = controlP5.addSlider("Z1",-500,500,0,1100,200,10,100);
  Controller t = controlP5.addSlider("A1",1,100,20,1130,200,10,100);
  Controller e = controlP5.addSlider("B1",1,100,20,1160,200,10,100);
  Controller k = controlP5.addSlider("T1",0,1,0,1190,200,10,100);
  Controller k2 = controlP5.addSlider("T3",0,1,0,1220,200,10,100);
  Controller ii1 = controlP5.addSlider("vb1",0,400,150,1250,200,10,100);
  Controller nn1 = controlP5.addSlider("hb1",0,300,150,1280,200,10,100);
  
  Controller N = controlP5.addSlider("RotX",0,720,0,1130,30,10,100);
  Controller E = controlP5.addSlider("RotY",0,720,0,1160,30,10,100);
  Controller r = controlP5.addSlider("RotZ",0,720,0,1190,30,10,100);
  Controller P1 = controlP5.addSlider("P1",0,1,0,1100,30,10,10);
  Controller P2 = controlP5.addSlider("P2",0,1,0,1100,60,10,10);
  Controller gg1 = controlP5.addSlider("C1",0.1,3,1,1220,30,10,100);
  Controller gg2 = controlP5.addSlider("C2",0.1,3,1,1250,30,10,100);
  Controller BG = controlP5.addSlider("BG",25,255,200,1280,30,10,100);
}

void draw()
{
  background(BG);
  controlP5.draw();
  
  xyz1 = T1==1 ? -1 : 1;
  xyz2 = T2==1 ? -1 : 1;
  xyz3 = T3==1 ? -1 : 1;
  xyz4 = T4==1 ? -1 : 1;
  
  float p = 1;
  float r = 1;
  
  pushMatrix();
  translate(480,360);
  rotateX(radians(RotX));
  rotateY(radians(RotY));
  rotateZ(radians(RotZ));
  
  strokeWeight(5);
  stroke(0,255,0);
  point(0,-300,0);
  point(0,300,0);
  strokeWeight(2);
  stroke(255,0,0);
  line(-300,0,0,300,0,0);
  stroke(0,0,255);
  line(0,0,-300,0,0,300);
  strokeWeight(3);
  stroke(0,255,0);
  line(0,-300,0,0,300,0);
  strokeWeight(1);
  stroke(0);

  for(p=-300; p<=300; p+=50)
  {
    line(p,0,-300,p,0,300);
    line(-300,0,p,300,0,p);
  }
  
  for(p=-vb1; p<=vb1; p+=C1)
  {
    for(r=-hb1; r<=hb1; r+=C1)
    {
      if(P1==1)
      {
        stroke(0,0,255);
        point(p+X1,(sq(p)/sq(A1)*xyz1+(sq(r)/sq(B1))*xyz3)+Y1,r+Z1);
      }
    }
  }
  
  for(p=-vb2; p<=vb2; p=p+C2)
  {
    for(r=-hb2; r<=hb2; r=r+C2)
    {
      {
        if(P2==1)
        {
          stroke(255,0,0);
          point(p+X2,(sq(p)/sq(A2)*xyz2+(sq(r)/sq(B2))*xyz4)+Y2,r+Z2);
        }
      }
    }
  }
  
  popMatrix();
}