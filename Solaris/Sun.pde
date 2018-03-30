class Sun extends Planet
{
  color lclr;
  PShader blur;
  
  Sun(float rad, float red, float grn, float blu, int glow, float lrd, float lgr, float lbl)
  {
    super(rad, new PVector(0,0,0), new PVector(0,0,0), new PVector(0,0,0), color(red, grn, blu));
    blur = loadShader("blur.glsl");
    blur.set("blurSize",glow);
    blur.set("sigma",glow/2.0);
    lclr = color(lrd, lgr, lbl);
  }
  
  Sun(float rad, PVector org, PVector orb, PVector ang, color col, int glow, color light)
  {
    super(rad, org, orb, ang, col);
    blur.set("blurSize",glow*2);
    blur.set("sigma",glow/2.0);
    lclr = light;
  }
  
  void draw()
  {
    lights();
    super.draw();
    noLights();
  }
  
  void glow()
  {
    blur.set("horizontalPass",0);
    filter(blur);
    blur.set("horizontalPass",1);
    filter(blur);
    draw();
    pointLight(red(lclr),green(lclr),blue(lclr),pos.x,pos.y,pos.z);
  }
}
