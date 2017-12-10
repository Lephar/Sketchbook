Sun sun;
Star star[];
Planet planet[];
Satellite moon;

int count;

void setup()
{
  fullScreen(P3D);
  frameRate(24);
  smooth(8);
  
  count = 2048;
  sun = new Sun(96,255,127,0,64,255,255,255);
  star = new Star[count];
  for(int i=0; i<count; i++) star[i] = new Star();
  planet = new Planet[9];
  planet[0] = new Planet(6,0.02,120,160,255,127,127);
  planet[1] = new Planet(8,0.016,160,200,255,95,63);
  planet[2] = new Planet(12,0.013,220,240,0,95,255);
  planet[3] = new Planet(14,0.01,260,280,191,127,0);
  planet[4] = new Planet(28,0.008,320,360,191,127,95);
  planet[5] = new Planet(26,0.006,440,460,191,127,63);
  planet[6] = new Planet(23,0.004,560,580,127,191,255);
  planet[7] = new Planet(22,0.002,660,680,63,127,255);
  planet[8] = new Planet(25,0.0018,700,740,255,127,255);
  moon = new Satellite(planet[2],3,0.1,20,30,191,191,191);
}

void draw()
{
  background(0);
  translate(width/2, 60+height/2, -420);
  rotateX(-PI/12);
  sun.draw();
  sun.glow();
  stroke(255);
  for(int i=0; i<count; i++) star[i].draw();
  noStroke();
  star[(int)random(count)].reset();
  ambientLight(15,15,15);
  for(int i=0; i<9; i++) planet[i].draw();
  moon.draw();
}