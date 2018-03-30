class Satellite extends Planet
{
  Planet planet;
  
  Satellite(Planet planet, float rad, float vel, float min, float max, float hor, float ver, float red, float grn, float blu)
  {
    super(rad, new PVector(0,0,0), new PVector(vel,min,max), new PVector(hor,0,ver), color(red, grn, blu));
    this.planet = planet;
  }
  
  void draw()
  {
    pushMatrix();
    translate(planet.org.x,planet.org.y,planet.org.z);
    rotateX(planet.ang.x);
    rotateY(planet.ang.y);
    rotateZ(planet.ang.z);
    translate(planet.pos.x,planet.pos.y,planet.pos.z);
    super.draw();
    popMatrix();
  }
}
