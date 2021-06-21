void setup() {
  size(500, 500);
  init();
}


void draw() {
  int[] ser = readSerial();
  if (gameState == 1) {
    image(bgTexture, 0, 0);
    if (ser[0] < 99) {
      if (ser[0] == 1) {
        shoot();
      }
      if (ser[1] < 15) {
        ser[1] = 15;
      } else if (ser[1] > 100) {
        ser[1] = 100;
      }
      carAngle = map((float)ser[1], 100, 15, -PI / 2, PI / 2);
    }
    drawCaracter();
    manageFireballs();
    drawInfos();
    manageSlimes();
  } else {
    deathCooldown--;
    if (deathCooldown <= 0 && ser[0] == 1) {
      reset();
      gameState = 1;
    }
  }
  myPort.clear();
}
