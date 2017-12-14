class Player
{
  float x,y,w,h,v,ground;
  int status,direction,frame;
  PImage current,idlel[],idler[],walkl[],walkr[],jumpl[],jumpr[];
  
  Player()
  {
    frame=0;
    status=IDLE;
    direction=FORWARD;
    
    idlel=new PImage[IDLE];
    idler=new PImage[IDLE];
    walkl=new PImage[WALK];
    walkr=new PImage[WALK];
    jumpl=new PImage[JUMP];
    jumpr=new PImage[JUMP];
    for(int i=0;i<IDLE;i++) (idlel[i]=loadImage("images/il"+i+".png")).resize(0,int(unit*idlel[i].height/3.4));
    for(int i=0;i<IDLE;i++) (idler[i]=loadImage("images/ir"+i+".png")).resize(0,int(unit*idler[i].height/3.4));
    for(int i=0;i<WALK;i++) (walkl[i]=loadImage("images/wl"+i+".png")).resize(0,int(unit*walkl[i].height/3.4));
    for(int i=0;i<WALK;i++) (walkr[i]=loadImage("images/wr"+i+".png")).resize(0,int(unit*walkr[i].height/3.4));
    for(int i=0;i<JUMP;i++) (jumpl[i]=loadImage("images/jl"+i+".png")).resize(0,int(unit*jumpl[i].height/3.4));
    for(int i=0;i<JUMP;i++) (jumpr[i]=loadImage("images/jr"+i+".png")).resize(0,int(unit*jumpr[i].height/3.4));
    current=idler[0];
    
    v=0;
    w=idler[0].width;
    h=idler[0].height;
    x=width/2-w;
    y=310*unit-h;
    ground=310*unit;
  }
  
  void draw()
  {
    updateGround();
    
    if(status==IDLE)
      if(direction==BACKWARD) current=idlel[frame/30%IDLE];
      else current=idler[frame/30%IDLE];
    
    else if(status==WALK)
    {
      if(direction==BACKWARD) current=walkl[frame/4%WALK];
      else current=walkr[frame/4%WALK];
      if(y+h<ground) status=JUMP;
    }
    
    else if(status==JUMP)
    {
      if(direction==BACKWARD) current=jumpl[frame/4%JUMP];
      else current=jumpr[frame/4%JUMP];
      jump();
    }
    
    if(status==JUMP && v>0 && y+h==ground)
    {
      status=IDLE;
      frame=0;
    }
    
    frame++;
    
    imageMode(CENTER);
    image(current,x+idler[0].width/2,y+idler[0].height/2);
    imageMode(CORNER);
  }
  
  void updateGround()
  {
    int index = -1;
    
    for(int i=0; i<items.size(); i++) 
      if(y+h<=items.get(i).y && x+w>=items.get(i).x && x<=items.get(i).x+items.get(i).w)
        index = i;
    
    if(index==-1) ground=310*unit;
    else ground=items.get(index).y;
  }
  
  void setStatus(int status)
  {
    if(this.status!=status&&this.status!=JUMP)
    {
      this.status=status;
      if(status==JUMP) v=-LIMIT;
      frame=0;
    }
  }
  
  void jump()
  {
    y+=v*unit;
    if(v<LIMIT) v+=0.25;
    if(y+h>ground) y=ground-h;
  }
  
  void moveLeft(){x-=unit;}
  void moveRight(){x+=unit;}
void setDirection(int direction){this.direction=direction;}
}