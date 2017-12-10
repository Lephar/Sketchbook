class Planet
{
  color col;
  float size, minr, maxr, vel, thet;
  PVector pos, org, ang;
  
  Planet(float rad, float vel, float min, float max, float red, float grn, float blu)
  {
    this(rad, new PVector(0,0,0), new PVector(vel,min,max), new PVector(0,0,0), color(red, grn, blu));
  }
  
  Planet(float rad, PVector org, PVector orb, PVector ang, color col)
  {
    thet = 0;
    size = rad;
    this.org = org;
    vel = orb.x;
    minr = orb.y;
    maxr = orb.z;
    this.ang = ang;
    this.col = col;
    pos = new PVector();
  }
  
  void draw()
  {
    pushMatrix();
    translate(org.x,org.y,org.z);
    //drawPath();
    rotateX(ang.x);
    rotateY(ang.y);
    rotateZ(ang.z);
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
    rotateX(PI/2);
    noFill();
    stroke(127);
    ellipse(0,0,maxr*2,minr*2);
    noStroke();
    rotateX(-PI/2);
  }
}