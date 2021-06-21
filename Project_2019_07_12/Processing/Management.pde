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

  deathCooldown = 100;
  textAlign(CENTER, CENTER);
  textSize(40);
  text("Shake the sensor\nto start the game !", H / 2, H / 2);

  reset();
}  

void loadTextures() {
  bgTexture = loadImage("background.jpg");
  carTexture = loadImage("caracter.png");
  carWidth = carTexture.width;
  carHeight = carTexture.height;
  fireballTexture = loadImage("fireball.png");
  fbWidth = fireballTexture.width;
  fbHeight = fireballTexture.height;
  slimeTextures = new PImage[3];
  for (int i = 0; i < 3; i++) {
    slimeTextures[i] = loadImage("slime" + str(i + 1) + ".png");
  }
  slimeWidth = slimeTextures[0].width;
  slimeHeight = slimeTextures[0].height;
  heartTexture = loadImage("heart.png");
  heartWidth = heartTexture.width;
  heartHeight = heartTexture.height;
}

void reset() {
  //Jeu
  gameState = 0;
  score = 0;
  kills = 0;
  lives = 3;

  //FireBall
  fireballs = new ArrayList<Fireball>();
  fireballsToRemove = new ArrayList<Fireball>();

  //Slimes
  slimes = new ArrayList<Slime>();
  slimesToRemove = new ArrayList<Slime>();
  slimeCooldown = maxSlimeCD;
  slimeTimeLeft = 2 * slimeCooldown;
}

void loseLife() {
  lives--;
  if (lives <= 0) {
    lost();
  }
}

void lost() {
  gameState = 0;
  deathCooldown = 120;
  textAlign(CENTER, CENTER);
  fill(255, 255, 0);
  textSize(35);
  text("Game Over !\nFinal score : " + score + " | Kills : " + kills + "\nShake the sensor\nto start a new game !", H / 2, H / 2 - 100);
}
