/*

Created on 9/13/2023 (11:20 PM) by Sebastian Dowell for Mr. Chan's APCSA Scales Assignment.

*/

// Initial Declarations

float rotX = 0;
float rotY = 0;
float deltaX = 0;
float deltaZ = 0;
double t = 0;
double tref = 0;
double v = 0;
double a = 30;
double vlim = 10;

boolean isKeyPressed = false;
boolean[] keysPressed = new boolean[128];

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
  
  textSize(128);
  fill(200);
  text("SCALES", -200, -100);
  
  for (int i = 0; i <= height; i += 45) {
     for (int j = 0; j <= width; j += 45) {
       if ((((int)deltaX/45) != 0) & (((int)deltaX/45) != 0)) {
         
       } else if ((((int)deltaX/45) == 0) & (((int)deltaX/45) != 0)) {
         
       } else if ((((int)deltaX/45) != 0) & (((int)deltaX/45) == 0)) {
         
       } else {
         drawScale(j - (width / 2) - deltaX, 100, i - (height / 2) + deltaZ, 
                (int)((colorData[i][j][1] * 144/6) + ((144*5)/6)), 
                (int)((colorData[i][j][2] * 238/6) + ((238*5)/6)), 
                (int)((colorData[i][j][3] * 144/6) + ((144*5)/6)), 60);
       }
     }
  }
  
  if (isKeyPressed) {
    t = (millis() - tref) / 1000.0;
    if (v > vlim) {
      v = vlim;
    } else if (vlim > v) {
      v = a * t;
    }

    System.out.println("Speed: " + v); // debug
    
    if (keysPressed['w'] || keysPressed['W']) {
      deltaZ += v; // Move forward
    }
    if (keysPressed['s'] || keysPressed['S']) {
      deltaZ -= v; // Move backward
    }
    if (keysPressed['a'] || keysPressed['A']) {
      deltaX -= v; // Move left
    }
    if (keysPressed['d'] || keysPressed['D']) {
      deltaX += v; // Move right
    }
  }
}

// Important Functions

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

void keyPressed() {
  isKeyPressed = true;
  keysPressed[key] = true;
  tref = millis();
}

void keyReleased() {
  isKeyPressed = false;
  keysPressed[key] = false;
  v = 0;
  t = 0;
  tref = 0;
  a = 30;
}

int[][][] initializeColorData() {
  int colorData[][][] = new int[height * 2 + 1][width * 2 + 1][4];
    for (int i = 0; i <= height * 2; i += 45) {
     for (int j = 0; j <= width * 2; j += 45) {
       for (int k = 1; k <= 3; k++) {
         colorData[i][j][k] = (int)(Math.floor(Math.random() * 4));
       }
     }
  }
  return colorData;
}
