import processing.serial.*;
Serial myPort;

//Fenêtre
final int H = 500;
final int playH = 300;

//Textures
PImage bgTexture, padTexture, ballTexture;

//Tailles
int padWidth, padHeight;
int ballWidth, ballHeight;

//Pad
int padDir, padX;
final int padY = H - 50;
final float padVelocity = 6.5;

//Ball
Ball ball;
final int ballVelocity = 7;

//Briques
ArrayList<Brick> bricks;
ArrayList<Brick> bricksToRemove;
final int minBrickWidth = 25, maxBrickWidth = 150;
final int minBrickHeight = 10, maxBrickHeight = 75;

//Jeu
int score, maxScore;
int lives;
int gameState, deathCooldown;

void setup() {
  size(500, 500);
  init();
}

void draw() {
  if (gameState == 1) {
    image(bgTexture, 0, 0);
    int dir = readSerial();
    if (dir != 99) {
      padDir = dir;
    }
    moveShowPad();
    manageBricks();
    manageBall();
    drawInfos();
  } else if (gameState == 2) {
    deathCooldown--;
    if (deathCooldown <= 0) {
      int dir = readSerial();
      if (dir != 0 && dir != 99) {
        reset();
        gameState = 1;
      }
    }
  }

  myPort.clear();
}

void drawInfos() {
  textSize(20);
  textAlign(LEFT, LEFT);
  fill(255);
  text("Score : " + score, 5, H - 10);

  for (int v = 0; v < lives; v++) {
    image(ballTexture, H - (5 + (ballWidth + 5) * (v + 1)), H - ballHeight - 5);
  }
}
