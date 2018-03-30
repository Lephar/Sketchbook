#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
 
#define PROCESSING_TEXTURE_SHADER
 
uniform sampler2D texture;

uniform vec2 texOffset;
 
varying vec4 vertColor;
varying vec4 vertTexCoord;
 
uniform int blurSize;       
uniform int horizontalPass; 
uniform float sigma;        
 
const float pi = 3.14159265;
 
void main() {  
  float numBlurPixelsPerSide = float(blurSize / 2); 
 
  vec2 blurMultiplyVec = 0 < horizontalPass ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
 
  vec3 incrementalGaussian;
  incrementalGaussian.x = 1.0 / (sqrt(2.0 * pi) * sigma);
  incrementalGaussian.y = exp(-0.5 / (sigma * sigma));
  incrementalGaussian.z = incrementalGaussian.y * incrementalGaussian.y;
 
  vec4 avgValue = vec4(0.0, 0.0, 0.0, 0.0);
  float coefficientSum = 0.0;
 
  avgValue += texture2D(texture, vertTexCoord.st) * incrementalGaussian.x;
  coefficientSum += incrementalGaussian.x;
  incrementalGaussian.xy *= incrementalGaussian.yz;
 
  for (float i = 1.0; i <= numBlurPixelsPerSide; i++) { 
    avgValue += texture2D(texture, vertTexCoord.st - i * texOffset * 
                          blurMultiplyVec) * incrementalGaussian.x;         
    avgValue += texture2D(texture, vertTexCoord.st + i * texOffset * 
                          blurMultiplyVec) * incrementalGaussian.x;         
    coefficientSum += 2.0 * incrementalGaussian.x;
    incrementalGaussian.xy *= incrementalGaussian.yz;
  }
 
  gl_FragColor = avgValue / coefficientSum;
}
