void setup() {
  size(599, 599);
  init();
}

void draw() {
  if (gameState == 1) {
    if (myPort.available() > 0) {
      String val = myPort.readStringUntil('\n');
      val = val.trim();
      if (val.contains("1")) {
        click();
      } else if (val.contains("2")) {
        changeSelectedBuilding();
      } else if (val.contains("3")) {
        buy();
      }
    }
    computePerSecond();
    give();
    drawObjects();
   myPort.clear();
  }
}
