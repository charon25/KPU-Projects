void setup() {
  init();
  size(750, 750);
}

void draw() {
  int[] ser = readSerial();
  if (gameState == 1) {
    image(bgTexture, 0, 0);
    if (ser[0] >= 0) {
      setDir(ser);
    }
    moveShowCar();
    manageObstacles();
    manageEnemies();
    manageShots();
    drawInfos();
    if (enemies.size() == 0) {
      level++;
      lives += 2;
      reset(true);
    }
    invincibilityLeft--;
  } else {
    deathCooldown--;
    if (deathCooldown <= 0 && ser[4] == 1) {
      reset(false);
      gameState = 1;
    }
  }

  myPort.clear();
}

boolean isOne(int[] ser, boolean withButton) {
  int maxIndex = withButton ? 5 : 4;
  for (int i = 0; i < maxIndex; i++) {
    if (ser[i] == 1) {
      return true;
    }
  }
  return false;
}

void drawInfos() {
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Level : " + level + " | Kills : " + kills, H / 2, H - 20);
  
  for (int v = 0 ; v < lives ; v++) {
    image(heartTexture, H - (5 + (heartWidth + 5) * (v + 1)), H - heartHeight - 5);
  }
}
