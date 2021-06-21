void setup() {
  init();
  size(600, 600);
}

void draw() {
  int[] ser = readSerial();
  if (gameState == 1) {
    image(bgTexture, 0, 0);
    if (ser[0] >= 0) {
      carAngle = map(ser[0], 102, 0, PI / 2, 5 * PI / 2);
      carDir = ser[1];
    }
    carMove();
    carShow();
    manageEnemies();
    drawInfos();
  } else {
    deathCooldown--;
    if (deathCooldown <= 0 && ser[1] == 1) {
      reset();
      gameState = 1;
    }
  }
  myPort.clear();
}

void drawInfos() {
  timeElapsed = millis() - startingTime;
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(15);
  text("Score : " + int(score) + " | Time : " + millisToString(), H / 2, H - 20);
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
