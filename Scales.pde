/*

Created on 9/13/2023 (11:20 PM) by Sebastian Dowell for Mr. Chan's APCSA Scales Assignment.

*/

float rotX = 0;
float rotY = 0;

int colorData[][][] = new int[height * 2 + 1][width * 2 + 1][4];

void setup() {
  size(500, 500, P3D);
  strokeWeight(1);
  lights();
  ambientLight(100, 100, 100);
  colorData = initializeColorData();
}

void draw() {
  background(0);
  translate(width/2, height/2);
  rotateX(rotX);
  rotateY(rotY);
  lights();
  
  for (int i = 0; i <= height * 2; i += 15) {
     for (int j = 0; j <= width * 2; j += 15) {
       drawScale(j - (width / 2), 100, i - (height / 2), 
                (int)((colorData[i][j][1] * 144/4) + ((144*3)/4)), 
                (int)((colorData[i][j][2] * 238/4) + ((238*3)/4)), 
                (int)((colorData[i][j][3] * 144/4) + ((144*3)/4)), 60);
     }
  }
}

void drawScale(float x, float y, float z, int r, int g, int b, int s) {
  noStroke();
  float baseSize = s;
  
  fill(r, g, b);
  drawEllipsoid(x, y, z, baseSize, baseSize);
}

void drawSide(float x1, float y1, float z1, float x2, float y2, float z2, float r1, float r2) {
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= 25; i++) {
    float angle = TWO_PI / 25 * i;
    float xx1 = x1 + cos(angle) * r1;
    float yy1 = y1 + sin(angle) * r1;
    float xx2 = x2 + cos(angle) * r2;
    float yy2 = y2 + sin(angle) * r2;
    vertex(xx1, yy1, z1);
    vertex(xx2, yy2, z2);
  }
  
  float angle = TWO_PI / 25 * 0;
  float xx1 = x1 + cos(angle) * r1;
  float yy1 = y1 + sin(angle) * r1;
  float xx2 = x2 + cos(angle) * r2;
  float yy2 = y2 + sin(angle) * r2;
  vertex(xx1, yy1, z1);
  vertex(xx2, yy2, z2);

  endShape(CLOSE);
}

void drawEllipsoid(float x, float y, float z, float rx, float ry) {
  int detail = 25;
  for (int i = 0; i <= detail; i++) {
    float lat0 = PI * (-0.5 + (float) (i-1) / detail);
    float lat1 = PI * (-0.5 + (float) i / detail);
    float z0  = z + ry * cos(lat0);
    float z1  = z + ry * cos(lat1);
    float r0  = 0.5 * rx * sin(lat0);
    float r1  = 0.5 * rx * sin(lat1);
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j <= detail; j++) {
      float lon = 2 * PI * (float) j / detail;
      float x0 = x + cos(lon) * r0;
      float y0 = y + sin(lon) * r0;
      float x1 = x + cos(lon) * r1;
      float y1 = y + sin(lon) * r1;
      vertex(x0, y0, z0);
      vertex(x1, y1, z1);
    }
    endShape();
  }
}

void mouseDragged() {
  float dX = radians(mouseX - pmouseX);
  float dY = radians(mouseY - pmouseY);

  rotX += dY;
  rotY += dX;
}

int[][][] initializeColorData() {
  int colorData[][][] = new int[height * 2 + 1][width * 2 + 1][4];
    for (int i = 0; i <= height * 2; i += 15) {
     for (int j = 0; j <= width * 2; j += 15) {
       for (int k = 1; k <= 3; k++) {
         colorData[i][j][k] = (int)(Math.floor(Math.random() * 4));
       }
     }
  }
  return colorData;
}
