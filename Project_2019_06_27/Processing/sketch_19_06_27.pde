import processing.serial.*;
Serial myPort;

//Fenêtre
final int H = 600;

//Textures
PImage bgTexture, caracTexture, enemyTexture, heartTexture;
PImage[] starTextures;

//Tailles
int caracWidth, caracHeight;
int enemyWidth, enemyHeight;
int starWidth, starHeight;
int heartWidth, heartHeight;

//Personnage
float caracY;
final int caracX = 5;

//Ennemis
ArrayList<Enemy> enemies;
ArrayList<Enemy> enemiesToRemove;
final int minEnemyCD = 20, maxEnemyCD = 40;
int timeLeftEnemy;
final int minEnemyVelocity = 4, maxEnemyVelocity = 10;

//Etoiles
ArrayList<Star> stars;
ArrayList<Star> starsToRemove;
final int minStarCD = 25, maxStarCD = 50;
int timeLeftStar;
final int starVelocity = 8;
final int minStarValue = 1, maxStarValue = 3;

//Jeu
final int minValue = 200, maxValue = 1200;
int score, lives;
int timeElapsed, startingTime;
int gameState, deathCooldown;

void setup() {
  init();
  size(600, 600);
}

void draw() {
  if (gameState == 1) {
    image(bgTexture, 0, 0);
    float h = readSerial();
    if (h > 0 && h <= maxValue) {
      caracY = map(h, minValue, maxValue, H - caracHeight, 0);
    }
    image(caracTexture, 5, caracY);
    manageEnemies();
    manageStars();
    drawInfos();
  } else if (gameState == 2) {
    deathCooldown--;
    if (deathCooldown <= 0) {
      int val = readSerial();
      if (val > minValue && val < maxValue) {
        reset();
        gameState = 1;
      }
    }
  }
  myPort.clear();
}

void drawInfos() {
  timeElapsed = millis() - startingTime;
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Score : " + score + " | Time : " + millisToString(), H / 2, H - 20);
  
  for (int v = 0 ; v < lives ; v++) {
    image(heartTexture, H - (5 + (heartWidth + 5) * (v + 1)), H - heartHeight - 5);
  }
}

String millisToString() {
  int sec = timeElapsed / 1000;
  String S = str(sec % 60);
  if (S.length() == 1) {
    S = "0" + S;
  }
  String M = str(sec / 60);
  if (M.length() == 1) {
    M = "0" + M;
  }
  return M + ":" + S;
}
