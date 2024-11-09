int stage = 0;  // Stage

// Variables for Stage 2 (Lines)
static final int NUM_LINES = 10;
float t;

// Variables for Stage 3 (Arcs)
float sw, alpha;
float yStep = 10;
float arcSize = 200;

// Variables for Stage 4 (Cube)
float r, g, b;

void setup() {
  size(600, 600, P3D);  
  textAlign(CENTER, CENTER);
  t = 0;  
  
  randomizeColor();
}

void draw() {
  background(255);
  
  if (stage == 0) {
    fill(0);
    textSize(32);
    text("Welcome to the Art Museum", width / 2, height / 2.5 + sin(frameCount * 0.05) * 20);
    textSize(16);
    text("Press SPACE to enter", width / 2, height / 2 + 50);

  } else if (stage == 1) {
    background(20);
    stroke(225);
    strokeWeight(5);
    translate(width / 2, height / 2);

    for (int i = 0; i < NUM_LINES; i++) { 
      line(x1(t + i), y1(t + i), x2(t + i), y2(t + i));
    }
    t++; 

  } else if (stage == 2) {
    background(#eeeeee);

    mouseX = constrain(mouseX, 10, width);
    mouseY = constrain(mouseY, 10, height);

    yStep = mouseY;
    arcSize = mouseX;

    noFill();
    stroke(20);

    for (int y = 0; y < height; y += yStep) {
      sw = map(sin(radians(y + alpha)), -1, 1, 2, yStep);
      strokeWeight(sw);
      for (int x = 0; x < width + arcSize; x += arcSize) {
        arc(x, y, arcSize / 2, arcSize / 2, 0, PI);
        arc(x + arcSize / 2, y, arcSize / 2, arcSize / 2, PI, TWO_PI);
      }
    }
    alpha++; 

  } else if (stage == 3) {
    lights();
    
    fill(0);
    textSize(24);
    text("Click!", width / 2, 30);

    translate(width / 2, height / 2, 0);
    rotateX(frameCount * 0.01);
    rotateY(frameCount * 0.01);

    fill(r, g, b);
    noStroke();
  
    box(200);
  }
}

float x1(float t) {
  return -sin(t / 10) * 100 + sin(t / 5) * 20;
}

float y1(float t) {
  return cos(t / 10) * 100 + cos(t * 100); 
}

float x2(float t) {
  return sin(t / 10) * 300 + sin(t) * 2;
}

float y2(float t) {
  return -cos(t / 20) * 200 + cos(t / 12) * 20;
}

void randomizeColor() {
  r = random(255);
  g = random(255);
  b = random(255);
}

void keyPressed() {
  if (key == ' ') {
    stage = (stage + 1) % 4;  // cycle through stages
  }
}

void mousePressed() {
  if (stage == 3) {
    randomizeColor();
  }
}
