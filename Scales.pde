// Necessary Import(s)
import java.util.ArrayList;

void setup() {
  size(500, 500);
  noLoop();
}

void draw() {
  scale(100, 100, 200, Math.random());
}

void scale (int x, int y, int c, double rand) {
  // Initiate randomness
  rand = rand * Math.sqrt(Math.random());
  fill((int)(c * ((Math.random()) / rand)));
  
  beginShape();
  vertex(x-10, y);
  bezierVertex((float)(x-10 + rand), (float)(y-10), (float)(x-5 + rand), (float)y-10, x, y-20);
  vertex(x, y-20);
  bezierVertex((float)(x+5 - rand), y-10, (float)(x+10 - rand), y-10, x+10, y);
  endShape(CLOSE);
  
}
