void init() {
  loadTextures();
  image(bgTexture, 0, 0);
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

  int offset = (W - 3 * starWidth) / 4;
  Xpos = new int[3];
  for (int i = 0; i < 3; i++) {
    Xpos[i] = offset + i * (starWidth + offset);
  }

  reset();
  deathCooldown = 60;
  textSize(40);
  textAlign(CENTER, CENTER);
  text("Use a sensor\n to start a\nnew game !", W / 2, H / 2);
}

void loadTextures() {
  bgTexture = loadImage("background.jpg");
  starTextures = new PImage[3];
  starDarkTextures = new PImage[3];
  for (int i = 0; i < 3; i++) {
    starTextures[i] = loadImage("star" + str(i + 1) + ".png");
    starDarkTextures[i] = loadImage("star" + str(i + 1) + "_dark.png");
  }
  starWidth = starTextures[0].width;
  starHeight = starTextures[1].height;
}


void reset() {
  gameState = 0;
  oldValue = new int[3];
  total = 0;
  hit = 0;
  hp = 1;
  score = 0;

  stars = new ArrayList<Star>();
  starsToRemove = new ArrayList<Star>();
  texts = new ArrayList<Text>();
  textsToRemove = new ArrayList<Text>();
}

void lost() {
  gameState = 0;

  deathCooldown = 90;
  textSize(35);
  textAlign(CENTER, CENTER);
  text("Game over !\nFinal score : " + score + "\n\nUse a sensor\n to start a\nnew game !", W / 2, H / 2 - 100);
}
