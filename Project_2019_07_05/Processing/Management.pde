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
  textAlign(CENTER, CENTER);
  textSize(35);
  text("Put your hand above the sensor\nto start the game !", H / 2, H / 2);

  reset();
}

void loadTextures() {
  bgTexture = loadImage("background.jpg");
  carTextures = new PImage[7];
  starTextures = new  PImage[7];
  for (int i = 0; i < 7; i++) {
    carTextures[i] = loadImage("car" + str(i + 1) + ".png");
    starTextures[i] = loadImage("star" + str(i+1) + ".png");
  }
  carWidth = carTextures[0].width;
  carHeight = carTextures[0].height;
  starWidth = starTextures[0].width;
  starHeight = starTextures[0].height;
  heartTexture = loadImage("heart.png");
  heartWidth = heartTexture.width;
  heartHeight = heartTexture.height;
}

void reset() {
  //Jeu
  gameState = 1;
  lives = 3;
  startingTime = millis();

  //Personnage
  carPos = new PVector(10, (H - carHeight) / 2);

  //Etoiles
  timeLeftStar = 10;
  stars = new ArrayList<Star>();
  starsToRemove = new ArrayList<Star>();
}

void loseLife() {
  lives--;
  if (lives <= 0) {
    gameState = 0;
    textAlign(CENTER, CENTER);
    textSize(30);
    fill(255);
    text("Game Over !\nFinal score : " + score + "\nPut your hand above the sensor\nto start a new game", H / 2, H / 2);
    deathCooldown = 100;
  }
}
