void carMove() {
  if (carDir == 0) {
    carDistance = max(carDistance - carVelocity / 2, 0);
  } else {
    carDistance = min(carDistance + carVelocity, maxCarDistance);
  }
}

void carShow() {
  float X = carDistance * cos(carAngle) + (H - carWidth) / 2;
  float Y = -carDistance * sin(carAngle) + (H - carHeight) / 2;
  image(carTextures[max(lives - 1, 0)], X, Y);
}

PVector getCarPosition() {
  float X = carDistance * cos(carAngle) + (H - carWidth) / 2;
  float Y = -carDistance * sin(carAngle) + (H - carHeight) / 2;
  return new PVector(X, Y);
}
