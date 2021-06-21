void setDir(int[] ser) {
  isMovingCar = isOne(ser, false);
  if (ser[0] == 1 && ser[2] == 0) {
    carDir = 3;
  }
  if (ser[0] == 0 && ser[2] == 1) {
    carDir = 1;
  }
  if (ser[1] == 1 && ser[3] == 0) {
    carDir = 0;
  }
  if (ser[1] == 0 && ser[3] == 1) {
    carDir = 2;
  }
  if (ser[4] == 1) {
    carAttack();
  }
}

void moveShowCar() {
  if (isMovingCar) {
    switch (carDir) {
    case 0:
      carPos.y -= carVelocity;
      if (carPos.y < 0) {
        carPos.y = 0;
      }
      for (int i = 0; i < obstacles.size(); i++) {
        if (obstacles.get(i).collidesWithCar()) {
          carPos.y = obstacles.get(i).getY() + obstacles.get(i).getH();
          break;
        }
      }
      for (int i = 0; i < enemies.size(); i++) {
        if (enemies.get(i).collidesWithCar()) {
          carPos.y = enemies.get(i).getY() + enemies.get(i).getH();
          break;
        }
      }
      break;
    case 1:
      carPos.x += carVelocity;
      if (carPos.x > H - carWidth) {
        carPos.x = H - carWidth;
      }
      for (int i = 0; i < obstacles.size(); i++) {
        if (obstacles.get(i).collidesWithCar()) {
          carPos.x = obstacles.get(i).getX() - carWidth;
          break;
        }
      }
      for (int i = 0; i < enemies.size(); i++) {
        if (enemies.get(i).collidesWithCar()) {
          carPos.x = enemies.get(i).getX() - carWidth;
          break;
        }
      }
      break;
    case 2:
      carPos.y += carVelocity;
      if (carPos.y > H - carHeight) {
        carPos.y = H - carHeight;
      }
      for (int i = 0; i < obstacles.size(); i++) {
        if (obstacles.get(i).collidesWithCar()) {
          carPos.y = obstacles.get(i).getY() - carHeight;
          break;
        }
      }
      for (int i = 0; i < enemies.size(); i++) {
        if (enemies.get(i).collidesWithCar()) {
          carPos.y = enemies.get(i).getY() - carHeight;
          break;
        }
      }
      break;
    case 3:
      carPos.x -= carVelocity;
      if (carPos.x < 0) {
        carPos.x = 0;
      }
      for (int i = 0; i < obstacles.size(); i++) {
        if (obstacles.get(i).collidesWithCar()) {
          carPos.x = obstacles.get(i).getX() + obstacles.get(i).getW();
          break;
        }
      }
      for (int i = 0; i < enemies.size(); i++) {
        if (enemies.get(i).collidesWithCar()) {
          carPos.x = enemies.get(i).getX() + enemies.get(i).getW();
          break;
        }
      }
      break;
    }
  }
  if (carAttackTimeLeft > 0) {
    carAttackTimeLeft--;
    image(carAttackTextures[carDir], carPos.x, carPos.y);
  } else {
    image(carIdleTextures[carDir], carPos.x, carPos.y);
  }
}

void carAttack() {
  carAttackTimeLeft = carAttackCooldown;
  float X, Y;
  int W, H;
  switch (carDir) {
  case 0:
    X = carPos.x;
    Y = carPos.y - carHeight / 2;
    W = carWidth;
    H = carHeight / 2;
    break;
  case 2:
    X = carPos.x;
    Y = carPos.y + carHeight;
    W = carWidth;
    H = carHeight / 2;
    break;
  case 3:
    X = carPos.x - carHeight / 2;
    Y = carPos.y;
    W = carHeight / 2;
    H = carHeight;
    break;
  default:
    X = carPos.x + carWidth;
    Y = carPos.y;
    W = carHeight / 2;
    H = carHeight;
    break;
  }
  for (int i = 0; i < enemies.size(); i++) {
    if (collision(X, Y, W, H, enemies.get(i).getX(), enemies.get(i).getY(), enemies.get(i).getW(), enemies.get(i).getH())) {
      enemiesToRemove.add(enemies.get(i));
      if (kills > 0 && kills % 9 == 0) {
        lives++;
      }
      kills++;
    }
  }
}
