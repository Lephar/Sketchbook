void drawMenu()
{
  image(background,0,0);
  
  pushMatrix();
  resetMatrix();
  rectMode(CORNER);
  textAlign(CENTER,CENTER);
  textSize(32*unit);
  camera(width/2,height/2,(height/2.0)/tan(PI*30.0/180.0),width/2,height/2,0,0,1,0);
  fill(255,127,0,127);
  strokeWeight(4);
  
  stroke(255,255,0);
  if(left)
  {
    score--;
    fill(255,127,0);
  }
  else if(!right) score=0;
  rect(8*unit,height/2+unit*8,width/3-unit*16,height/2-unit*16);
  
  fill(0,255,127,127);
  stroke(255,255,0);
  if(right)
  {
    score++;
    fill(0,255,127);
  }
  else if(!left) score=0;
  rect(2*width/3+8*unit,height/2+unit*8,width/3-unit*16,height/2-unit*16);
  
  fill(127,0,255);
  text("Exit",width/6,3*height/4);
  text("Start",5*width/6,3*height/4);
  
  fill(0);
  text("TIN-H by Lotus",3*width/4,height/8);
  
  textSize(16*unit);
  text("Ali Emre Gulcu     Alpay Kuru\nBerk Aydin     Salih Samet Akar",3*width/4,2*height/8);
  
  popMatrix();
  
  if(player!=null) player.draw();
  if(score==60)
  {
    score=0;
    state=GAME;
  }
  else if(score==-60) exit();
}

void drawBackground()
{
  camera(player.x+player.w,height/2,(height/2.0)/tan(PI*30.0/180.0),player.x+player.w,height/2,0,0,1,0);
  
  for(int i=-1; i<6; i++) image(background,i*background.width,0);
  image(bus,width/3-bus.width,310*unit-bus.height);
  image(flag,4250*unit,310*unit-flag.height);
  fill(255,0,0);
  text("Time: "+time,player.x+player.w-width/2+9*width/10,height/10);
  text("Score: "+score,player.x+player.w-width/2+9*width/10,2*height/10);
  if(time==0)
  {
    state=FAIL;
    time=180;
  }
  if(frameCount%60==0) time--;
}

void drawObjects()
{
  for(int i=0; i<items.size(); i++) items.get(i).draw();
  for(int i=0; i<birds.size(); i++) birds.get(i).draw();
  for(int i=0; i<gold.size(); i++) gold.get(i).draw();
}

void drawPlayer()
{
  if(left)
  {
    player.setStatus(WALK);
    player.setDirection(BACKWARD);
    if(!leftCollision()) player.moveLeft();
    //if(shift && !leftCollision()) player.moveLeft();
  }
    
  else if(right)
  {
    player.setStatus(WALK);
    player.setDirection(FORWARD);
    if(!rightCollision()) player.moveRight();
    //if(shift && !rightCollision()) player.moveRight();
  }
  
  if((left && right)||(!left && !right)) player.setStatus(IDLE);
  
  if(space) player.setStatus(JUMP);
  
  player.draw();
}

void drawSuccess()
{
  fill(0,127,0);
  textSize(36*unit);
  text("You Win!",player.x+player.w/2,2*height/5);
  textSize(24*unit);
  text("You have collected " + score + " score in " + (180-temp) + " seconds!",player.x+player.w/2,3*height/5);
  if(time==0)
  {
    initialized=false;
    state=MENU;
  }
  time--;
}

void drawFailure()
{
  fill(0,127,0);
  textSize(36*unit);
  text("You Lost :(",player.x+player.w/2,2*height/5);
  textSize(24*unit);
  text("You have collected " + score + " score in " + 180 + " seconds.",player.x+player.w/2,3*height/5);
  if(time==0)
  {
    initialized=false;
    state=MENU;
  }
  time--;
}