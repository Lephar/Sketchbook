EApplet applet;
PImage image[];
int index, count;

void settings()
{
  size(1120,630);
}

void setup()
{
  frameRate(24);
  
  index = 0;
  count = 5;
  
  image = new PImage[count];
  
  for(int i=0; i<count; i++)
  {
    image[i] = loadImage("("+(i+1)+").jpg");
    image[i].resize(width,height);
    image[i].loadPixels();
  }
  
  applet = new EApplet(this);
  runSketch(new String[]{"Histogram"},applet);
}

void draw()
{
  image(image[index],0,0);
}


PImage threshold(PImage image)
{
  PImage temp = image.copy();
  float avg = 0;
  
  temp.loadPixels(); //<>//
  for(int i=0; i<temp.pixels.length; i++) avg += (fRed(temp.pixels[i])+fGreen(temp.pixels[i])+fBlue(temp.pixels[i]))/3;
  avg = avg / temp.pixels.length;
  
  for(int i=0; i<temp.pixels.length; i++) //<>//
  {
    if(avg > (fRed(temp.pixels[i])+fGreen(temp.pixels[i])+fBlue(temp.pixels[i]))/3) temp.pixels[i] = color(0);
    else temp.pixels[i] = color(255); //<>//
  }
  
  temp.updatePixels();
  
  return temp;
}

int fRed(color c)
{
  return (c&0x00FF0000)>>16;
}

int fGreen(color c)
{
  return (c&0x0000FF00)>>8;
}

int fBlue(color c)
{
  return c&0x000000FF;
}
  
void update(int button)
{
  if(button == LEFT) index--;
  else if(button == RIGHT) index++;
  index = (count + index) % count;
}

void keyPressed()
{
  update(keyCode);
  applet.calculate();
}