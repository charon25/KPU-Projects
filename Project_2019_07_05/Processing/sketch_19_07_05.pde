void setup() {
  init();
  size(700, 700);
}

void draw() {
  int ser = readSerial();
  if (gameState == 1) {
    image(bgTexture, 0, 0);
    if (ser < 99) {
      carDir = ser;
    }
    carMove();
    carShow();
    manageStars();
    drawInfos();
  } else {
    deathCooldown--;
    if (deathCooldown <= 0 && ser < 99 && ser != 0) {
      reset();
      gameState = 1;
    }
  }
}

void drawInfos() {
  timeElapsed = millis() - startingTime;
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Score : " + score + " | Time : " + millisToString(), H / 2, H - 20);

  for (int v = 0; v < lives; v++) {
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
