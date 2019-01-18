class EApplet extends PApplet
{
  PApplet parent;
  int count, weight;
  float max, vRed[], vGreen[], vBlue[];
  
  EApplet(PApplet applet)
  {
    super();
    parent = applet;
  }
  
  void settings()
  {
    size(480,270);
    smooth(32);
  }
  
  void setup()
  {
    surface.setTitle("Graphic");
    frameRate(24);
    
    weight = 1;
    count = width/weight+1;
    
    strokeWeight(weight);
    
    max = 0;
    vRed = new float[count];
    vGreen = new float[count];
    vBlue = new float[count];
    for(int i=0; i<count; i++) vRed[i] = 0;
    for(int i=0; i<count; i++) vGreen[i] = 0;
    for(int i=0; i<count; i++) vBlue[i] = 0;
    calculate();
  }
  
  void draw()
  {
    background(0);
    loadPixels();
    for(int i=0; i<width; i++)
    {
      for(int j=0; j<height; j++)
      {
        if(j > height-vRed[int(i/weight)]*height/max) pixels[i+j*width] = color(255, fGreen(pixels[i+j*width]), fBlue(pixels[i+j*width]));
        if(j > height-vGreen[i/weight]*height/max) pixels[i+j*width] = color(fRed(pixels[i+j*width]), 255, fBlue(pixels[i+j*width]));
        if(j > height-vBlue[i/weight]*height/max) pixels[i+j*width] = color(fRed(pixels[i+j*width]), fGreen(pixels[i+j*width]), 255);
      }
    }
    /*
    for(int i=0; i<count; i++) line(i*weight+weight/2,height-vRed[i]*height/max,i*weight+weight/2,height);
    stroke(0,255,0,85);
    for(int i=0; i<count; i++) line(i*weight+weight/2,height-vGreen[i]*height/max,i*weight+weight/2,height);
    stroke(0,0,255,85);
    for(int i=0; i<count; i++) line(i*weight+weight/2,height-vBlue[i]*height/max,i*weight+weight/2,height);
    */
    updatePixels();
  }
  
  void calculate()
  {
    float rTone, gTone, bTone;
    color pixel;
    
    max = 0;
    
    for(int i=0; i<count; i++)
    {
      vRed[i] = 0;
      vGreen[i] = 0;
      vBlue[i] = 0;
    }
    
    for(int i=0; i<image[index].pixels.length; i++)
    {
      pixel = image[index].pixels[i];
      rTone = count * fRed(pixel) / 256.0;
      gTone = count * fGreen(pixel) / 256.0;
      bTone = count * fBlue(pixel) / 256.0;
      for(int j=int(rTone); j<int(rTone+count/256.0); j++) vRed[int(j)]++;
      for(int j=int(gTone); j<int(gTone+count/256.0); j++) vGreen[int(j)]++;
      for(int j=int(bTone); j<int(bTone+count/256.0); j++) vBlue[int(j)]++;
    }
    
    for(int i=0; i<count; i++) if(max < max(vRed[i], vGreen[i], vBlue[i])) max = max(vRed[i], vGreen[i], vBlue[i]);
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
  
  void keyPressed()
  {
    update(keyCode);
    calculate();
  }
}