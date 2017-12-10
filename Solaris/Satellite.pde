class Satellite extends Planet
{
  Planet planet;
  
  Satellite(Planet planet, float rad, float vel, float min, float max, float red, float grn, float blu)
  {
    super(rad, new PVector(0,0,0), new PVector(vel,min,max), new PVector(0,0,0), color(red, grn, blu));
    this.planet = planet;
  }
  
  void draw()
  {
    pushMatrix();
    translate(planet.pos.x,planet.pos.y,planet.pos.z);
    super.draw();
    popMatrix();
  }
}