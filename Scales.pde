// Necessary Import(s)
import java.util.ArrayList;

void setup() {
  size(500, 500, P3D);
  strokeWeight(5);
  noLoop();
}

void draw() {
  scale(100, 100, 100);
}

void scale (int x, int y, int c) {
  // Initiate randomness
  fill((int)(Math.random() * 250), (float)(Math.random() * 100), 0);
  
  beginShape();
  vertex(x, y);
  vertex(x, y);
  endShape(CLOSE);
  
}
