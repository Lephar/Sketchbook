class Planet
{
  color col;
  float size, minr, maxr, vel, thet;
  PVector pos, org, ang;
  
  Planet(float rad, float vel, float min, float max, float hor, float ver, float red, float grn, float blu)
  {
    this(rad, new PVector(0,0,0), new PVector(vel,min,max), new PVector(hor,0,ver), color(red, grn, blu));
  }
  
  Planet(float rad, PVector org, PVector orb, PVector ang, color col)
  {
    thet = 0;
    size = rad;
    this.org = org;
    vel = orb.x;
    minr = orb.y * (height / 768.0);
    maxr = orb.z * (width / 1366.0);
    this.ang = ang;
    this.col = col;
    pos = new PVector();
  }
  
  void draw()
  {
    pushMatrix();
    translate(org.x,org.y,org.z);
    rotateX(ang.x);
    rotateY(ang.y);
    rotateZ(ang.z);
    if(mousePressed) drawPath();
    pos.x = cos(thet) * maxr;
    pos.z = sin(thet) * minr;
    translate(pos.x,0,pos.z);
    fill(col);
    sphere(size);
    thet += vel;
    popMatrix();
  }
  
  void drawPath()
  {
    pushMatrix();
    rotateX(PI/2);
    noFill();
    stroke(127);
    ellipse(0,0,maxr*2,minr*2);
    noStroke();
    popMatrix();
  }
}
