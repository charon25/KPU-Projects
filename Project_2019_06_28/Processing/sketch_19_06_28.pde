import processing.serial.*;
Serial myPort;

//Fenêtre
final int H = 800;
final int tileH = 32;
final int tileN = H / tileH;

//Textures
PImage bgTexture, fruitTexture, pikesTexture;
PImage[] snakeTextures;

//Serpent
Snake snake;
int oldG, oldD;
final int cooldownMoveSnake = 5;

//Fruit/Piques
Fruit fruit;
ArrayList<Pikes> pikes;

//Jeu
int gameState, deathCooldown;

void setup() {
  size(800, 800);
  init();
}

void draw() {
  int moves[] = readSerial();
  if (gameState == 1) {
    image(bgTexture, 0, 0);
    if (moves[0] >=0) {
      int G = moves[0];
      int D = moves[1];
      if (D != G) {
        if (G == 1 && G != oldG) {
          snake.changeDir(-1);
        }
        if (D == 1 && D != oldD) {
          snake.changeDir(1);
        }
      }
      oldG = G;
      oldD = D;
    }
    snake.move();
    fruit.show();
    showPikes();
    snake.show();
    drawInfos();
    if (snake.isDead()) {
      lost();
    }
  } else {
    deathCooldown--;
    if (deathCooldown <= 0 && (moves[0] == 1 || moves[1] == 1)) {
      reset();
      gameState = 1;
      oldG = 1;
      oldD = 1;
    }
  }

  myPort.clear();
}

void drawInfos() {
  textAlign(CENTER, CENTER);
  textSize(23);
  fill(255);
  text("Score : " + str(snake.getSize() - 1), H / 2, H - 20);
}
