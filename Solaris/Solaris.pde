Sun sun;
Star star[];
Planet planet[];
Satellite satellite[];

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
  
  planet = new Planet[8];
  planet[0] = new Planet(6,0.02,120,160,0,PI/24,255,127,127);
  planet[1] = new Planet(8,-0.016,160,200,0,-PI/24,255,95,63);
  planet[2] = new Planet(12,0.013,220,240,0,PI/48,0,95,255);
  planet[3] = new Planet(14,0.01,260,280,0,-PI/48,191,127,0);
  planet[4] = new Planet(28,0.008,320,360,0,PI/24,191,127,95);
  planet[5] = new Planet(26,0.006,440,460,0,-PI/48,191,127,63);
  planet[6] = new Planet(23,0.004,560,580,0,PI/12,127,191,255);
  planet[7] = new Planet(22,-0.002,620,680,PI/48,-PI/36,63,127,255);
  
  satellite = new Satellite[7];
  satellite[0] = new Satellite(planet[2],3,0.1,20,30,0,PI/6,191,191,191);
  satellite[1] = new Satellite(planet[4],3,-0.048,50,65,0,-PI/6,95,191,95);
  satellite[2] = new Satellite(planet[4],3,0.036,50,65,0,PI/12,95,0,95);
  satellite[3] = new Satellite(planet[4],4,-0.032,55,60,0,PI/3,191,95,0);
  satellite[4] = new Satellite(planet[5],5,-0.032,50,65,0,-PI/6,95,191,95);
  satellite[5] = new Satellite(planet[5],4,0.036,50,65,0,PI/12,95,0,95);
  satellite[6] = new Satellite(planet[6],4,-0.024,55,60,PI/6,PI/3,0,95,127);
}

void draw()
{
  background(0);
  translate(width/2, 9*height/16, -height/2);
  rotateX(-PI/12);
  sun.draw();
  sun.glow();
  stroke(255);
  for(int i=0; i<count; i++) star[i].draw();
  noStroke();
  star[(int)random(count)].reset();
  ambientLight(15,15,15);
  for(int i=0; i<planet.length; i++) planet[i].draw();
  for(int i=0; i<satellite.length; i++) satellite[i].draw();
}
