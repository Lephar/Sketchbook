long light(long haar[][], int x, int y, int w, int h)
{
  if(x<0||y<0||w<0||h<0||x+w>=haar.length||y+h>=haar[0].length) return -1;
  else return haar[x+w][y+h]-haar[x+w][y]-haar[x][y+h]+haar[x][y];
}

long[][] haar(PImage raw)
{
  raw.loadPixels();
  long buffer[][]=new long[raw.width][raw.height];
  
  for(int i=0;i<raw.width;i++) for(int j=0;j<raw.height;j++)
    if(i==0&&j==0) buffer[i][j]=lval(raw.pixels[i+j*raw.width]);
    else if(i==0) buffer[i][j]=lval(raw.pixels[i+j*raw.width])+buffer[i][j-1];
    else if(j==0) buffer[i][j]=lval(raw.pixels[i+j*raw.width])+buffer[i-1][j];
    else buffer[i][j]=lval(raw.pixels[i+j*raw.width])+buffer[i-1][j]+buffer[i][j-1]-buffer[i-1][j-1];
    
  return buffer;
}

PImage edge(PImage raw){return edge(raw,8);}
PImage threshold(PImage raw){return threshold(raw,128);}

PImage equate(PImage raw)
{
  raw.loadPixels();
  double average=0;
  PImage image=createImage(raw.width,raw.height,ARGB);
  
  for(int i=0;i<raw.pixels.length;i++) average+=lval(raw.pixels[i]);
  average/=raw.pixels.length;
  average++;
  
  for(int i=0;i<image.pixels.length;i++)
  {
    double l=imax(1,lval(raw.pixels[i]));
    double r=average*imax(1,rval(raw.pixels[i]))/l;
    double g=average*imax(1,gval(raw.pixels[i]))/l;
    double b=average*imax(1,bval(raw.pixels[i]))/l;
    image.pixels[i]=color((int)r,(int)g,(int)b,255);
  }
  
  image.updatePixels();
  return image;
}

PImage lhaar(PImage raw)
{
  raw.loadPixels();
  long buffer[]=new long[raw.pixels.length];
  PImage image=createImage(raw.width,raw.height,RGB);
  
  for(int i=0; i<raw.pixels.length; i++)
    if(i==0) buffer[i]=lval(raw.pixels[i]);
    else if(i<raw.width) buffer[i]=lval(raw.pixels[i])+buffer[i-1];
    else if(i%raw.width==0) buffer[i]=lval(raw.pixels[i])+buffer[i-raw.width];
    else buffer[i]=lval(raw.pixels[i])+buffer[i-1]+buffer[i-raw.width]-buffer[i-raw.width-1];
  
  for(int i=0; i<raw.pixels.length; i++)
    if(buffer[buffer.length-1]==0) image.pixels[i]=color(0);
    else image.pixels[i]=color(255*buffer[i]/buffer[buffer.length-1]);
  image.updatePixels();
  
  return image;
}

PImage chaar(PImage raw)
{
  raw.loadPixels();
  long rbuffer[]=new long[raw.pixels.length],gbuffer[]=new long[raw.pixels.length],bbuffer[]=new long[raw.pixels.length];
  PImage image=createImage(raw.width,raw.height,RGB);
  
  for(int i=0; i<raw.pixels.length; i++)
    if(i==0)
    {
      rbuffer[i]=rval(raw.pixels[i]);
      gbuffer[i]=gval(raw.pixels[i]);
      bbuffer[i]=bval(raw.pixels[i]);
    }
    
    else if(i<raw.width)
    {
      rbuffer[i]=rval(raw.pixels[i])+rbuffer[i-1];
      gbuffer[i]=gval(raw.pixels[i])+gbuffer[i-1];
      bbuffer[i]=bval(raw.pixels[i])+bbuffer[i-1];
    }
    
    else if(i%raw.width==0)
    {
      rbuffer[i]=rval(raw.pixels[i])+rbuffer[i-raw.width];
      gbuffer[i]=gval(raw.pixels[i])+gbuffer[i-raw.width];
      bbuffer[i]=bval(raw.pixels[i])+bbuffer[i-raw.width];
    }
    
    else
    {
      rbuffer[i]=rval(raw.pixels[i])+rbuffer[i-1]+rbuffer[i-raw.width]-rbuffer[i-raw.width-1];
      gbuffer[i]=gval(raw.pixels[i])+gbuffer[i-1]+gbuffer[i-raw.width]-gbuffer[i-raw.width-1];
      bbuffer[i]=bval(raw.pixels[i])+bbuffer[i-1]+bbuffer[i-raw.width]-bbuffer[i-raw.width-1];
    }
    
  for(int i=0; i<raw.pixels.length; i++)
    if(rbuffer[rbuffer.length-1]==0||gbuffer[gbuffer.length-1]==0||bbuffer[bbuffer.length-1]==0) image.pixels[i]=color(0);
    else image.pixels[i]=color(255*rbuffer[i]/rbuffer[rbuffer.length-1],255*gbuffer[i]/gbuffer[gbuffer.length-1],255*bbuffer[i]/bbuffer[bbuffer.length-1]);
  image.updatePixels();
  
  return image;
}

PImage edge(PImage raw, int dlim)
{
  raw.loadPixels();
  PImage edge=createImage(raw.width,raw.height,ARGB);
  for(int i=0;i<edge.pixels.length;i++) edge.pixels[i]=color(255,0);
  for(int i=1;i<edge.width;i++) for(int j=1;j<edge.height;j++)
  {
    int hdif=cdif(raw.pixels[i+j*raw.width],raw.pixels[(i-1)+j*raw.width]);
    int vdif=cdif(raw.pixels[i+j*raw.width],raw.pixels[i+(j-1)*raw.width]);
    int ddif=cdif(raw.pixels[i+j*raw.width],raw.pixels[(i-1)+(j-1)*raw.width]);
    if(dlim<imax(hdif,vdif,ddif)) edge.pixels[i+j*edge.width]=color(0,255);
    //if(dlim<hdif&&dlim<vdif) edge.pixels[i+j*edge.width]=color(63,0,63,255);
    //else if(dlim<hdif) edge.pixels[i+j*edge.width]=color(127,0,0,255);
    //else if(dlim<vdif) edge.pixels[i+j*edge.width]=color(0,0,127,255);
  }
  edge.updatePixels();
  return edge;
}

PImage blur(PImage raw)
{
  raw.loadPixels();
  PImage blur=createImage(raw.width,raw.height,ARGB);
  for(int i=0;i<raw.pixels.length;i++) blur.pixels[i]=raw.pixels[i];
  for(int i=1;i<blur.width-1;i++) for(int j=1;j<blur.height-1;j++)
  {
    color c=raw.pixels[i+j*raw.width];
    color tl=raw.pixels[(i-1)+(j-1)*raw.width];
    color tr=raw.pixels[(i+1)+(j-1)*raw.width];
    color bl=raw.pixels[(i-1)+(j+1)*raw.width];
    color br=raw.pixels[(i+1)+(j+1)*raw.width];
    int ravg=(rval(c)+rval(tl)+rval(tr)+rval(bl)+rval(br))/5;
    int gavg=(gval(c)+gval(tl)+gval(tr)+gval(bl)+gval(br))/5;
    int bavg=(bval(c)+bval(tl)+bval(tr)+bval(bl)+bval(br))/5;
    //int ravg=(rval(raw.pixels[i+j*raw.width])+rval(raw.pixels[i+(j-1)*raw.width])+rval(raw.pixels[(i-1)+j*raw.width]))/3;
    //int gavg=(gval(raw.pixels[i+j*raw.width])+gval(raw.pixels[i+(j-1)*raw.width])+gval(raw.pixels[(i-1)+j*raw.width]))/3;
    //int bavg=(bval(raw.pixels[i+j*raw.width])+bval(raw.pixels[i+(j-1)*raw.width])+bval(raw.pixels[(i-1)+j*raw.width]))/3;
    blur.pixels[i+j*blur.width]=color(ravg,gavg,bavg,255);
  }
  blur.updatePixels();
  return blur;
}

PImage threshold(PImage raw, int clim)
{
  raw.loadPixels();
  PImage binary=createImage(raw.width,raw.height,ARGB);
  for(int i=0;i<binary.pixels.length;i++)
    if(clim<lval(raw.pixels[i])) binary.pixels[i]=color(255,255);
    else binary.pixels[i]=color(0,255);
  binary.updatePixels();
  return binary;
}

PImage mirror(PImage raw)
{
  raw.loadPixels();
  PImage mirror=createImage(raw.width,raw.height,ARGB);
  for(int i=0;i<mirror.width;i++) for(int j=0;j<mirror.height;j++) mirror.pixels[i+j*mirror.width]=raw.pixels[raw.width-i-1+j*raw.width];
  mirror.updatePixels();
  return mirror;
}

PImage edgep(PImage raw)
{
  int dlim=4;
  raw.loadPixels();
  PImage edge=createImage(raw.width,raw.height,ARGB);
  for(int i=0;i<edge.pixels.length;i++) edge.pixels[i]=color(255,0);
  for(int i=1;i<edge.width;i++) for(int j=1;j<edge.height;j++)
  {
    int hdif=cdif(raw.pixels[i+j*raw.width],raw.pixels[(i-1)+j*raw.width]);
    int vdif=cdif(raw.pixels[i+j*raw.width],raw.pixels[i+(j-1)*raw.width]);
    //int ddif=cdif(raw.pixels[i+j*raw.width],raw.pixels[(i-1)+(j-1)*raw.width]);
    //if(dlim<imax(hdif,vdif,ddif)) edge.pixels[i+j*edge.width]=color(0,255);
    if(dlim<hdif&&dlim<vdif) edge.pixels[i+j*edge.width]=color(63,0,63,255);
    else if(dlim<hdif) edge.pixels[i+j*edge.width]=color(127,0,0,255);
    else if(dlim<vdif) edge.pixels[i+j*edge.width]=color(0,0,127,255);
  }
  edge.updatePixels();
  return edge;
}

PImage blurp(PImage raw)
{
  raw.loadPixels();
  PImage blur=createImage(raw.width,raw.height,ARGB);
  for(int i=0;i<raw.pixels.length;i++) blur.pixels[i]=raw.pixels[i];
  for(int i=1;i<blur.width-1;i++) for(int j=1;j<blur.height-1;j++)
  {
    color c=raw.pixels[i+j*raw.width];
    color tl=raw.pixels[(i-1)+(j-1)*raw.width];
    //color tr=raw.pixels[(i+1)+(j-1)*raw.width];
    //color bl=raw.pixels[(i-1)+(j+1)*raw.width];
    //color br=raw.pixels[(i+1)+(j+1)*raw.width];
    int ravg=(rval(c)+rval(tl))/2;
    int gavg=(gval(c)+gval(tl))/2;
    int bavg=(bval(c)+bval(tl))/2;
    //int ravg=(rval(c)+rval(tl)+rval(tr)+rval(bl)+rval(br))/5;
    //int gavg=(gval(c)+gval(tl)+gval(tr)+gval(bl)+gval(br))/5;
    //int bavg=(bval(c)+bval(tl)+bval(tr)+bval(bl)+bval(br))/5;
    //int ravg=(rval(raw.pixels[i+j*raw.width])+rval(raw.pixels[i+(j-1)*raw.width])+rval(raw.pixels[(i-1)+j*raw.width]))/3;
    //int gavg=(gval(raw.pixels[i+j*raw.width])+gval(raw.pixels[i+(j-1)*raw.width])+gval(raw.pixels[(i-1)+j*raw.width]))/3;
    //int bavg=(bval(raw.pixels[i+j*raw.width])+bval(raw.pixels[i+(j-1)*raw.width])+bval(raw.pixels[(i-1)+j*raw.width]))/3;
    blur.pixels[i+j*blur.width]=color(ravg,gavg,bavg,255);
  }
  blur.updatePixels();
  return blur;
}