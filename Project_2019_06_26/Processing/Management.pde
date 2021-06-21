void reset() {
  //Personnage
  caracX = (H - caracWidth) / 2;
  caracY = (H - caracHeight) / 2;
  direction = 0;

  //Rubis
  rubis = new ArrayList<Rubis>();
  rubisToRemove = new ArrayList<Rubis>();
  cooldownRubis = 40;
  timeLeftRubis = 0;

  //Fireball
  fireballs = new ArrayList<Fireball>();
  fireballsToRemove = new ArrayList<Fireball>();
  cooldownFireball = 35;
  timeLeftFireball = 0;
  
  //PowerUps
  powerups = new ArrayList<PowerUp>();
  powerupsToRemove = new ArrayList<PowerUp>();
  rubisPUCount = 0;

  //Jeu
  score = 0;
  gameState = 2;
  pickedRubis = 0;
  startingTime = millis();
  lives = 5;
}

void init() {
  //Textures
  bgTexture = loadImage("background.png");
  caracterTextures = new PImage[4];
  for (int i = 0; i < 4; i++) {
    caracterTextures[i] = loadImage("carac" + str(i + 1) + ".png");
  }
  caracWidth = caracterTextures[0].width;
  caracHeight = caracterTextures[0].height;
  rubisTextures = new PImage[3];
  for (int i = 0; i < 3; i++) {
    rubisTextures[i] = loadImage("rubis" + str(i + 1) + ".png");
  }
  rubisWidth = rubisTextures[0].width;
  rubisHeight = rubisTextures[0].height;
  fireballTexture = loadImage("fireball.png");
  fireballWidth = fireballTexture.width;
  fireballHeight = fireballTexture.height;
  heartTexture = loadImage("heart.png");
  heartWidth = heartTexture.width;
  heartHeight = heartTexture.height;
  powerupTextures = new PImage[3];
  powerupWidth = new int[3];
  powerupHeight = new int[3];
  for (int i = 0; i < 3; i++) {
    powerupTextures[i] = loadImage("powerup" + str(i + 1) + ".png");
    powerupWidth[i] = powerupTextures[i].width;
    powerupHeight[i] = powerupTextures[i].height;
  }
  //Démarrage
  image(bgTexture, 0, 0);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(50);
  text("Touch a sensor\nto begin the game", H / 2, H / 2);
  reset();
}

void loseLife() {
  lives--;
  if (lives == 0) {
    lost();
  }
}

void lost() {
  gameState = 2;
  image(bgTexture, 0, 0);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(35);
  text("Game Over !\nFinal score : " + score + "\nTouch a sensor to start a new game", H / 2, H / 2 - 150);
  deathCooldown = 100;
}
