Button button;
Plane plane[];
Frame frame;
PImage image;
PVector position;
float r, g, b;
final color LIGHT=#90CAF9, DARK=#0C1169;

void setup()
{
  fullScreen(P2D);
  frameRate(60);
  smooth(128);
  rectMode(CENTER);
  imageMode(CENTER);
  
  button = new Button(120, height-240);
  image = loadImage("spp.png");
  
  frame = new Frame(360,360,360,2*PI/3,2*PI/3);
  
  position = new PVector(0,91);
  plane = new Plane[5];
  
  for(int i=0; i<plane.length; i++)
  {
    plane[i] = new Plane((int)position.x,(int)position.y,i*2*PI/plane.length);
    position.rotate(2*PI/5);
  }
}

void draw()
{
  r = map(button.value,button.margin,height-button.margin,red(LIGHT),red(DARK));
  g = map(button.value,button.margin,height-button.margin,green(LIGHT),green(DARK));
  b = map(button.value,button.margin,height-button.margin,blue(LIGHT),blue(DARK));
  background(r,g,b);
  button.draw();
  
  translate(17*width/32,5*height/8);
  frame.draw();
  fill(r,g,b);
  ellipse(0,0,172,172);
  for(int i=0; i<plane.length; i++) plane[i].draw();
}

void mousePressed()
{
  if(button.pressed()) button.clicked = true;
  else if(mouseX < button.margin+20 && mouseX > button.margin-20 && mouseY > button.margin && mouseY < height-button.margin) button.value = mouseY;
}

void mouseReleased()
{
  button.clicked = false;
}
