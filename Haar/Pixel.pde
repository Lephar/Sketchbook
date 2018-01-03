int iabs(int x){return x<0?-x:x;}
int imin(int x, int y){return x<y?x:y;}
int imax(int x, int y){return x<y?y:x;}
int imin(int x, int y, int z){return x<y?(x<z?x:z):(y<z?y:z);}
int imax(int x, int y, int z){return x<y?(y<z?z:y):(x<z?z:x);}

float fabs(float x){return x<0?-x:x;}
float fmin(float x, float y){return x<y?x:y;}
float fmax(float x, float y){return x<y?y:x;}
float fmin(float x, float y, float z){return x<y?(x<z?x:z):(y<z?y:z);}
float fmax(float x, float y, float z){return x<y?(y<z?z:y):(x<z?z:x);}

int aval(color col){return (col&0xFF000000)>>24;}
int rval(color col){return (col&0x00FF0000)>>16;}
int gval(color col){return (col&0x0000FF00)>>8;}
int bval(color col){return col&0x000000FF;}
int lval(color col){return (rval(col)+gval(col)+bval(col))/3;}
int cval(color col){return (int)hue(col);}
int sval(color col){return (int)saturation(col);}

int rdif(color col1, color col2){return iabs(rval(col1)-rval(col2));}
int gdif(color col1, color col2){return iabs(gval(col1)-gval(col2));}
int bdif(color col1, color col2){return iabs(bval(col1)-bval(col2));}
int adif(color col1, color col2){return iabs(aval(col1)-aval(col2));}
int ldif(color col1, color col2){return iabs(lval(col1)-lval(col2));}
int cdif(color col1, color col2){return (rdif(col1,col2)+gdif(col1,col2)+bdif(col1,col2))/3;}
int sdif(color col1, color col2){return iabs(sval(col1)-sval(col2));}

int aval(PImage image, int x, int y){return aval(image.pixels[x+y*image.width]);}
int rval(PImage image, int x, int y){return rval(image.pixels[x+y*image.width]);}
int gval(PImage image, int x, int y){return gval(image.pixels[x+y*image.width]);}
int bval(PImage image, int x, int y){return bval(image.pixels[x+y*image.width]);}
int lval(PImage image, int x, int y){return lval(image.pixels[x+y*image.width]);}
int cval(PImage image, int x, int y){return cval(image.pixels[x+y*image.width]);}