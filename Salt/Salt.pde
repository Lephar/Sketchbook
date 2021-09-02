import processing.sound.*;
import processing.video.*;

FFT fft;
SoundFile track;
Capture frame;

PImage buffer[];
float amplitude, innerAmplitude, temp;
int bands, cycle, innerCycle, shadeCount, shadeInterval;
boolean cameraReady, fileLoaded;

public void setup()
{
  size(640, 480);
  frameRate(30);
  noSmooth();
  
  background(0);
  colorMode(HSB);
  imageMode(CENTER);
  
  amplitude = 0;
  cycle = -1;
  bands = 16;
  shadeCount = 5;
  shadeInterval = 6;
  
  cameraReady = false;
  fileLoaded = false;
  
  thread("initCam");
  thread("initTrack");
}

void initCam()
{
  frame = new Capture(this, width, height, 30);
  frame.start();
  buffer = new PImage[shadeCount * shadeInterval];
  for(int i=1; i<buffer.length; i++)
    buffer[i] = createImage(frame.width, frame.height, ARGB);
  cameraReady = true;
}

void initTrack()
{
  track = new SoundFile(this, "salt.mp3");
  track.loop();
  fft = new FFT(this, bands);
  fft.input(track);
  fileLoaded = true;
}

public void draw()
{
  if(fileLoaded && cameraReady && frame.available())
  {
    translate(width/2, height/2);
    cycle = (cycle + 1) % buffer.length;
    
    fft.analyze();
    amplitude = (amplitude + fft.spectrum[0]) / 2;
    
    frame.read();
    buffer[cycle] = frame.copy();
    buffer[cycle].loadPixels();
    frame.loadPixels();
    
    for(int i=0; i<frame.pixels.length; i++)
    {
      temp = 0;
      innerAmplitude = 0.5;
      
      for(int j=0; j<shadeCount; j++)
      {
        innerAmplitude *= 2;
        innerCycle = (buffer.length + cycle - shadeInterval * j) % buffer.length;
        temp += brightness(buffer[innerCycle].pixels[i]) / innerAmplitude;
      }
      
      frame.pixels[i] = color(150, 120, temp * amplitude / 2);
    }
    
    frame.updatePixels();
    image(frame, 0, 0);
  }
}
