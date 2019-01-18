PImage average(PImage array[])
{
  int rval,gval,bval;
  PImage average=createImage(array[0].width,array[0].height,ARGB);
  
  average.loadPixels();
  for(int i=0; i<array.length; i++) array[i].loadPixels();
  
  for(int i=0; i<average.pixels.length; i++)
  {
    rval=gval=bval=0;
    
    for(int j=0; j<array.length; j++)
    {
      rval+=rval(array[j].pixels[i]);
      gval+=gval(array[j].pixels[i]);
      bval+=bval(array[j].pixels[i]);
    }
    
    average.pixels[i]=color(rval/array.length,gval/array.length,bval/array.length);
  }
  
  average.updatePixels();
  return average;
}

PImage difference(PImage image, PImage array[])
{
  int dif,val;
  PImage difference=createImage(image.width,image.height,ARGB);
  
  for(int i=0; i<difference.pixels.length; i++)
  {
    dif=0;
    
    for(int j=0; j<array.length; j++)
    {
      val=ldif(image.pixels[i],array[j].pixels[i]);
      if(dif<val) dif=val;
    }
    
    difference.pixels[i]=color(dif);
  }

  difference.updatePixels();
  return difference;
}

PImage difference(PImage image, PImage difference, PImage background)
{
  int dif,lim;
  PImage foreground=createImage(image.width,image.height,ARGB);
  
  foreground.loadPixels();
  image.loadPixels();
  
  for(int i=0; i<image.pixels.length; i++)
  {
    //lim=lval(difference.pixels[i]);
    dif=ldif(image.pixels[i],background.pixels[i]);
    
    if(dif<=48) foreground.pixels[i]=color(0,255,0,0);
    else foreground.pixels[i]=image.pixels[i];
  }
  
  foreground.updatePixels();
  //foreground.resize(0,height/2);
  return foreground;
}
