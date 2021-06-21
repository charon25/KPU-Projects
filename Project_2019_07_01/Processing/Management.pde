void init() {
  loadTextures();
  frameRate(120);
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
  gameState = 0;
  textSize(40);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Press the button\nto start the game !", H / 2, H / 2);
}

void loadTextures() {
  bgTexture = loadImage("bg.png");
  carIdleTextures = new PImage[4];
  carAttackTextures = new PImage[4];
  for (int i = 0; i < 4; i++) {
    carIdleTextures[i] = loadImage("carI" + str(i) + ".png");
    carAttackTextures[i] = loadImage("carA" + str(i) + ".png");
  }
  carWidth = carIdleTextures[0].width;
  carHeight = carAttackTextures[0].height;
  obsTextures = new PImage[3];
  for (int i = 0; i < 3; i++) {
    obsTextures[i] = loadImage("obstacle" + str(i + 1) + ".png");
  }
  ennIdleTextures = new PImage[4];
  ennAttackTextures = new PImage[4];
  for (int i = 0; i < 4; i++) {
    ennIdleTextures[i] = loadImage("ennI" + str(i) + ".png");
    ennAttackTextures[i] = loadImage("ennA" + str(i) + ".png");
  }
  ennWidth1 = ennIdleTextures[1].width;
  ennWidth2 = ennIdleTextures[2].width;
  ennHeight1 = ennIdleTextures[1].height;
  ennHeight2 = ennIdleTextures[2].height;
  shotTextures = new PImage[4];
  for (int i = 0; i < 4; i ++) {
    shotTextures[i] = loadImage("shot" + str(i + 1) + ".png");
  }
  shotWidth = shotTextures[0].width;
  shotHeight = shotTextures[0].height;
  heartTexture = loadImage("heart.png");
  heartWidth = heartTexture.width;
  heartHeight = heartTexture.height;
}

void reset(boolean partial) {
  //Jeu
  if (!partial) {
    gameState = 0;
    level = 1;
    lives = 7;
    kills = 0;
  }

  //Personnage
  carPos = new PVector((H - carWidth) / 2, (H - carHeight) / 2);
  carDir = 1;

  //Obstacles
  obstacles = new ArrayList<Obstacle>();
  summonObstacles();

  //Ennemis
  enemies = new ArrayList<Enemy>();
  enemiesToRemove = new ArrayList<Enemy>();
  summonEnemies(level);

  //Shots
  shots = new ArrayList<Shot>();
  shotsToRemove = new ArrayList<Shot>();
}

void loseLife() {
  if (invincibilityLeft <= 0) {
    lives--;
    invincibilityLeft = 100;
    if (lives <= 0) {
      lose();
    }
  }
}

void lose() {
  gameState = 0;
  deathCooldown = 150;
  textSize(35);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Game Over !\nLevel reached : " + str(level) + " (" + str(kills) + " kills)\nPress the button \nto start a new game", H / 2, H / 2);
}
