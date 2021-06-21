void setup() {
  size(300, 600);
  init();
}

void draw() {
  int[] ser = readSerial();
  if (gameState == 1) {
    image(bgTexture, 0, 0);
    drawStars();
    manageStars();
    manageTexts();
    if (ser[0] < 99) {
      if (ser[0] == 1 && oldValue[0] == 0) {
        pressStar(0);
      }
      if (ser[1] == 1 && oldValue[1] == 0) {
        pressStar(1);
      }
      if (ser[2] == 1 && oldValue[2] == 0) {
        pressStar(2);
      }
      oldValue[0] = ser[0];
      oldValue[1] = ser[1];
      oldValue[2] = ser[2];
    }
    drawInfos();
  } else {
    deathCooldown--;
    if (deathCooldown <= 0 && (ser[0] == 1 || ser[1] == 1 | ser[2] == 1)) {
      reset();
      gameState = 1;
      oldValue[0] = ser[0];
      oldValue[1] = ser[1];
      oldValue[2] = ser[2];
    }
  }
  myPort.clear();
}

void drawStars() {
  for (int i = 0 ; i < 3 ; i++) {
    image(starDarkTextures[i], Xpos[i], Ypos);
  }
}

void drawInfos() {
  textSize(25);
  fill(255);
  textAlign(LEFT, CENTER);
  if (total > 0) text(nf(100 * (float)hit / total, 0, 2) + " %  |  Score : " + score, 10, 540);
  
  if (hp > 1) hp = 1;
  hp -= 0.001;
  if (hp <= 0) lost();
  fill(255, 0, 0);
  rect(10, 560, (W - 20) * hp, 20);
}
