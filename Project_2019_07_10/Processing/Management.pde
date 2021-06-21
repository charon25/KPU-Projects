void init() {
  loadTextures();
  try {
    String portName = Serial.list()[0];
    myPort = new Serial(this, portName, 57600);
    delay(150);
    println("Initialisation terminée !");
  } 
  catch (Exception ex) {
    println("Erreur de connexion !");
    exit();
  }
  reset();
}

void loadTextures() {
  bgTexture = loadImage("background.jpg");
  resistanceTexture = loadImage("resistance.png");
  resWidth = resistanceTexture.width;
  resHeight = resistanceTexture.height;
  buildingTextures = new PImage[NUMBER_OF_BUILDINGS];
  buildingTextures[0] = loadImage("child.png");
  buildingTextures[1] = loadImage("farm.png");
  buildingTextures[2] = loadImage("mine.png");
  buildingTextures[3] = loadImage("factory.png");
  buildingTextures[4] = loadImage("rocket.png");
  buildingTextures[5] = loadImage("wormhole.png");
  upgradeTexture = loadImage("upgrade.png");
  upgradeWidth = upgradeTexture.width;
  upgradeHeight = upgradeTexture.height;
  buildingWidth = buildingTextures[0].width; 
  buildingHeight = buildingTextures[0].height;
  frameTexture = loadImage("frame.png");
  smallFrameTexture = loadImage("frame_small.png");
}

void reset() {
  //Jeu
  gameState = 1;
  playState = 0;
  resistances = 0.0;
  resSize = 1.0;
  selectedBuilding = 0;
  cancelNextOne = false;
  startTime = millis();

  //Bâtiments
  buildN = new int[NUMBER_OF_BUILDINGS];
  upgradeN = new int[NUMBER_OF_BUILDINGS];
}
