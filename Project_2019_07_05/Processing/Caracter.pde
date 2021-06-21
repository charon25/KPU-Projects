void carMove() {
  carPos.y += carDir * carVelocity;
  if (carPos.y < 0) {
    carPos.y = 0;
  } else if (carPos.y + carHeight > H) {
    carPos.y = H - carHeight;
  }
}

void carShow() {
  image(carTextures[carType], carPos.x, carPos.y);
}

void changeCarType() {
 carType = int(random(carTextures.length)); 
}
