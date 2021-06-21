void drawObjects() {
  image(bgTexture, 0, 0);
  if (resSize < 1) {
    resSize += 0.01;
    PImage temp = resistanceTexture.copy();
    temp.resize(int(resSize * resWidth), int(resSize * resHeight));
    float tempWidth = resSize * resWidth;
    float tempHeight = resSize * resHeight;
    image(temp, (H - tempWidth) / 2, (H / 3 - tempHeight) / 2);
  } else {
    resSize = 1.0; 
    image(resistanceTexture, (H - resWidth) / 2, (H / 3 - resHeight) / 2);
  }
  textAlign(CENTER, CENTER);
  textSize(15);
  text("Resistances : " + (int)(resistances) + "\nPer second : " + nf(resPerSecond, 0, 1), H / 2, (H / 3 - resHeight) / 4);

  textSize(12);
  for (int i = 0; i < NUMBER_OF_BUILDINGS; i++) {
    int X = i % 3;
    int Y = int(i / 3);
    image(buildingTextures[i], buildingSpace * (X + 1) + buildingWidth * X, H / 3 + Y * (buildingHeight + 70));
    image(upgradeTexture, buildingSpace * (X + 1) + buildingWidth * (X + 1) + 7, H / 3 + Y * (buildingHeight + 70));
    textSize(12);
    fill(255);
    text(buildNames[i] + " : " + buildN[i] + "\n" + nf((float)(buildN[i] * buildProductions[i] * pow(1.2, upgradeN[i])), 0, 1) + " R/s\nPrice : " + (int)buildPrices[i] + " R", buildingSpace * (X + 1) + buildingWidth * (X + 0.5), H / 3 + Y * (buildingHeight + 70) + buildingHeight + 35);
    textSize(9);
    fill(255, 255, 0);
    text((int)upgradePrices[i] + " R\n" + upgradeN[i] + " (+" + int(100*(pow(1.2, upgradeN[i]) - 1)) + "%)", buildingSpace * (X + 1) + buildingWidth * (X + 1) + 12 + upgradeWidth / 2, H / 3 + Y * (buildingHeight + 70) + upgradeHeight + 12);
  }
  fill(255);

  int tempIndex = selectedBuilding / 2;
  int X = tempIndex % 3;
  int Y = int(tempIndex / 3);
  if (selectedBuilding % 2 == 0) {
    image(frameTexture, buildingSpace * (X + 1) + buildingWidth * X, H / 3 + Y * (buildingHeight + 70));
  } else {
    image(smallFrameTexture, buildingSpace * (X + 1) + buildingWidth * (X + 1) + 12, H / 3 + Y * (buildingHeight + 70));
  }
}
