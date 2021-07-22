int wallSpeed = 5;
int wallInterval = 200;
float lastAddTime = 0;
int minGapHeight = 400;
int maxGapHeight = 300;
int wallWidth = 100;
float airfriction = 0.0001;
float friction = 0.1;
float gravity = 1;
float ballSpeedVert = 0;
float ballSpeedHorizon = 0;
int ballX, ballY;
int ballSize = 20;
int randHeight;


color wallColors = color(0);
// This arraylist stores data of the gaps between the walls. Actuals walls are drawn accordingly.
// [gapWallX, gapWallY, gapWallWidth, gapWallHeight]
ArrayList<int[]> walls = new ArrayList<int[]>();

void gameScreen() {
  background(#B190EA);
  drawBall();
  applyHorizontalSpeed();
  wallAdder();
  wallHandler();
}

void drawBall() {
  actor7.update3();
  actor7.display(#6424D3);
}

void applyHorizontalSpeed(){
  ballX += ballSpeedHorizon;
  ballSpeedHorizon -= (ballSpeedHorizon * airfriction);
}


void wallAdder() {
  if (millis()-lastAddTime > wallInterval) {
    randHeight = round(random(minGapHeight, maxGapHeight));
    int randY = round(random(0, height-randHeight));
    actor7.groundY = randHeight;
    // {gapWallX, gapWallY, gapWallWidth, gapWallHeight}
    int[] randWall = {width, randY, wallWidth, randHeight-50};
    walls.add(randWall);
    lastAddTime = millis();
    
  }
  
}

void wallHandler() {
  for (int i = 0; i < walls.size(); i++) {
    wallRemover(i);
    wallMover(i);
    wallDrawer(i);
  }
}

void wallDrawer(int index) {
  int[] wall = walls.get(index);
  // get gap wall settings 
  int gapWallX = wall[0];
  int gapWallY = wall[1];
  int gapWallWidth = wall[2];
  int gapWallHeight = wall[3];
  // draw actual walls
  rectMode(CORNER);
  fill(wallColors);
  rect(gapWallX, 0, gapWallWidth, gapWallY - 50);
  rect(gapWallX, gapWallY+gapWallHeight, gapWallWidth, height-(gapWallY+gapWallHeight));
}
void wallMover(int index) {
  int[] wall = walls.get(index);
  wall[0] -= wallSpeed;
}
void wallRemover(int index) {
  int[] wall = walls.get(index);
  if (wall[0]+wall[2] <= 0) {
    walls.remove(index);
    
  }
}
