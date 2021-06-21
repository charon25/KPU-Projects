void shoot() {
  carTimeLeft--;
  if (carTimeLeft <= 0) {
    fireballs.add(new Fireball(H / 2, H - carHeight / 2 - 20, carAngle));
    carTimeLeft = carCooldown;
  }
}

void drawCaracter() {
  int X0 = H / 2;
  int Y0 = H - carHeight / 2 - 20;
  translate(X0, Y0);
  rotate(carAngle);
  image(carTexture, - carWidth / 2, - carHeight / 2);
  rotate(-carAngle);
  translate(-X0, -Y0);
}

void drawInfos() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Score : " + score + " | Kills : " + kills, H / 2, 20);

  for (int v = 0; v < lives; v++) {
    image(heartTexture, H - (5 + (heartWidth + 5) * (v + 1)), H - heartHeight - 5);
  }
}
