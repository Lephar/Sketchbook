void controlHead()
{
  int index, value;
  
  if(cam.available()) cam.read();
  
  west.beginDraw();
  west.translate(west.width/2,west.height/2);
  west.rotate(-PI/6);
  west.image(cam.get(),0,0);
  west.endDraw();
  
  north.beginDraw();
  north.translate(north.width/2,north.height/2);
  north.image(cam.get(),0,0);
  north.endDraw();
  
  east.beginDraw();
  east.translate(west.width/2,west.height/2);
  east.rotate(PI/6);
  east.image(cam.get(),0,0);
  east.endDraw();
  
  if(frameCount%10==0)
  {
    neu = neg = pos = false;
    
    cv.loadImage(north.get());
    faces=cv.detect();
    
    if(faces.length>0) neu=true;
    else
    {
      cv.loadImage(east.get());
      faces=cv.detect();
    }
    
    if(!neu && faces.length>0) pos=true;
    else if(!neu)
    {
      cv.loadImage(west.get());
      faces=cv.detect();
    }
    
    if(!neu && !pos && faces.length>0) neg=true;
    
    if(neu||neg||pos)
    {
      value=0;
      index=-1;
      
      for(int i=0; i<faces.length; i++) if(value<faces[i].height)
      {
        value=faces[i].height;
        index=i;
      }
      
      face=faces[index];
    }
  }
  
  pushMatrix();
  rectMode(CENTER);
  noFill();
  translate(player.x+player.w-width/2+cam.width,0);
  scale(-1,1);
  image(cam.get(),0,0);
  
  if(face!=null && faces.length!=0)
  {
    vector=new PVector(face.x+face.width/2-cam.width/2,face.y+face.height/2-cam.height/2);
    if(neg) vector.rotate(PI/6);
    else if(pos) vector.rotate(-PI/6);
    
    strokeWeight(8);
    stroke(255,0,0);
    point(cam.width/2+vector.x,cam.height/2+vector.y);
    
    strokeWeight(2);
    stroke(255,255,0);
    rect(cam.width/2+vector.x,cam.height/2+vector.y,face.width,face.height);
    
    if(cam.width/2+vector.x<2*cam.width/5) right=true;
    else right=false;
    if(cam.width/2+vector.x>3*cam.width/5) left=true;
    else left=false;
    if(cam.height/2+vector.y<2*cam.height/5) space=true;
    else space=false;
  }
  
  if(space) stroke(0,255,0);
  else stroke(0,0,255);
  line(0,2*cam.height/5,cam.width,2*cam.height/5);
  
  if(right) stroke(0,255,0);
  else stroke(0,0,255);
  line(2*cam.width/5,0,2*cam.width/5,cam.height);
  
  if(left) stroke(0,255,0);
  else stroke(0,0,255);
  line(3*cam.width/5,0,3*cam.width/5,cam.height);
  popMatrix();
}

boolean leftCollision()
{
  if(player.x<=width/3) return true;
  
  boolean collision=false;
  
  for(int i=0; i<items.size(); i++)
  {
    Item item = items.get(i);
    
    if(player.x<item.x+item.w && player.x>item.x && player.y+player.h>item.y)
    {
      collision=true;
      break;
    }
  }
  
  return collision;
}

boolean rightCollision()
{
  boolean collision=false;
  
  for(int i=0; i<items.size(); i++)
  {
    Item item = items.get(i);
    
    if(player.x+player.w>item.x && player.x+player.w<item.x+item.w && player.y+player.h>item.y)
    {
      collision=true;
      break;
    }
  }
  
  if(player.x+player.w>4250*unit)
  {
    state=SUCC;
    PrintWriter writer=null;
    try 
    {
      writer=new PrintWriter(new BufferedWriter(new FileWriter("data/HighScores.txt",true)));
      writer.println("Time:"+time+" Score:"+score);
    } 
    catch (IOException e){}
    finally{if(writer!=null) writer.close();}
    temp=time;
    time=180; 
  }
  
  return collision;
}

PImage mirror(PImage raw)
{
  raw.loadPixels();
  PImage mirror=createImage(raw.width,raw.height,ARGB);
  for(int i=0;i<mirror.width;i++) for(int j=0;j<mirror.height;j++) mirror.pixels[i+j*mirror.width]=raw.pixels[raw.width-i-1+j*raw.width];
  mirror.updatePixels();
  return mirror;
}