void click() {
  resistances++;
  resSize = 0.9;
}

void changeSelectedBuilding() {
  selectedBuilding++;
  if (selectedBuilding >= NUMBER_OF_BUILDINGS * 2) {
    selectedBuilding = 0;
  }
}

void buy() {
  if (selectedBuilding % 2 == 0) {
    int temp = selectedBuilding / 2;
    if (resistances >= buildPrices[temp]) {
      resistances -= buildPrices[temp];
      buildN[temp]++;
      buildPrices[temp] *= 1.1;
    }
  } else {
    int temp = (selectedBuilding - 1) / 2;
    if (resistances >= upgradePrices[temp]) {
      resistances -= upgradePrices[temp];
      upgradeN[temp]++;
      upgradePrices[temp] *= 1.5;
    }
  }
}

void give() {
  if ((millis() - startTime) % 250 <= 17) {
    if (!given) {
      resistances += resPerSecond / 4;
      given = true;
    }
  } else {
    given = false;
  }
}

void computePerSecond() {
  resPerSecond = 0.0;
  for (int i = 0; i < NUMBER_OF_BUILDINGS; i++) {
    resPerSecond += buildN[i] * buildProductions[i] * pow(1.2, upgradeN[i]);
  }
}
