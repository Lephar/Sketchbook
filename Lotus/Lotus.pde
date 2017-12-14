import java.awt.*;
import java.io.*;
import gab.opencv.*;
import processing.sound.*;
import processing.video.*;

float unit;
int time, score, state, temp;
boolean up, down, left, right, space, shift, initialized, loaded;
boolean neg, neu, pos;
String feature[], goldlines[], datalines[];
final int IDLE=4, WALK=12, FALL=13, JUMP=14, BACKWARD=-1, FORWARD=1, LIMIT=6, GOLD=26, BIRD=2;
final int MENU=0, GAME=1, SUCC=2, FAIL=3;
ArrayList<Item> items;
ArrayList<Bird> birds;
ArrayList<Gold> gold;
Rectangle face, faces[];
PImage bus, flag, background;
PGraphics east, west, north;
PVector vector;
SoundFile music;
Player player;
Capture cam;
OpenCV cv;

void settings()
{
  fullScreen(P3D);
  //size(640,480,P3D);
  noSmooth();
}

void setup()
{
  frameRate(60);
  
  unit = height/360.0;
  state = MENU;
  loaded = false;
  initialized = false;
  
  (background = loadImage("images/bg1.png")).resize(0,height);
  image(background,0,0);
  
  fill(0);
  textAlign(CENTER,CENTER);
  textSize(36*unit);
  text("Welcome to TIN-H!\n The Game is Loading...",width/2,height/2);
}

void draw()
{
  if(!loaded) loadObjects();
  if(!initialized) initSketch();
  
  else if(state==MENU)
  {
    drawMenu();
    controlHead();
  }
  
  else if(state==GAME)
  {
    drawBackground();
    drawObjects();
    drawPlayer();
    controlHead();
    //controlFlag();
  }
  
  else if(state==SUCC)
  {
    drawSuccess();
    controlHead();
    left=right=space=false;
  }
  
  else if(state==FAIL)
  {
    drawFailure();
    controlHead();
    left=right=space=false;
  }
}

void loadObjects()
{
  (cam=new Capture(this,320,240,15)).start();
  //(cam=new Capture(this,640,480,30)).start();
  (cv=new OpenCV(this,cam.width,cam.height)).loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  west=createGraphics(cam.width,cam.height);
  north=createGraphics(cam.width,cam.height);
  east=createGraphics(cam.width,cam.height);
  
  west.imageMode(CENTER);
  north.imageMode(CENTER);
  east.imageMode(CENTER);
  
  (bus = loadImage("images/otobus.png")).resize(0,int(112*unit));
  (flag = loadImage("images/bayrak1.png")).resize(int(60*unit),int(120*unit));
  
  datalines = loadStrings("data/GameData.txt");
  goldlines = loadStrings("data/GoldData.txt");
  
  music=new SoundFile(this,"music/fon.mp3");
  music.play();
  music.loop();
  
  loaded = true;
}

void initSketch()
{
  score = 0;
  time = 180;
  up = down = left = right = space = false;
  neu = neg = pos = false;
  
  textSize(16*unit);
  textAlign(CENTER);
  
  player = new Player();
  gold = new ArrayList<Gold>();
  items = new ArrayList<Item>();
  birds = new ArrayList<Bird>();
  
  for(int i=0; i<6; i++) birds.add(new Bird(i*1200,0));
  
  for (int i=0; i<datalines.length; i++)
  {
    feature = datalines[i].split(" ");
    items.add(new Item(Integer.parseInt(feature[0]), Integer.parseInt(feature[1]), Integer.parseInt(feature[2])));
  }
  
  for (int i=0; i<goldlines.length; i++)
  {
    feature = goldlines[i].split(" ");
    gold.add(new Gold(Integer.parseInt(feature[0]), Integer.parseInt(feature[1]), Integer.parseInt(feature[2])));
  }
  
  initialized = true;
}
/*
void keyPressed()
{
  if(key==' ') space=true;
  else if(keyCode==UP) up=true;
  else if(keyCode==DOWN) down=true;
  else if(keyCode==LEFT) left=true;
  else if(keyCode==RIGHT) right=true;
  else if(keyCode==SHIFT) shift=true;
}
 
void keyReleased()
{
  if(key==' ') space=false;
  else if(keyCode==UP) up=false;
  else if(keyCode==DOWN) down=false;
  else if(keyCode==LEFT) left=false;
  else if(keyCode==RIGHT) right=false;
  else if(keyCode==SHIFT) shift=false;
  
}
*/