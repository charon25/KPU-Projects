void init() {
  try {
    String portName = Serial.list()[0];
    myPort = new Serial(this, portName, 9600);
    delay(350);
    println("Initialisation terminée !");
  } 
  catch (Exception ex) {
    println("Erreur de connexion !");
    exit();
  }
  //Textures
  bgTexture = loadImage("background.jpg");
  
  caracTexture = loadImage("carac.png");
  caracWidth = caracTexture.width;
  caracHeight = caracTexture.height;
  
  enemyTexture = loadImage("enemy.png");
  enemyWidth = enemyTexture.width;
  enemyHeight = enemyTexture.height;
  
  starTextures = new PImage[3];
  for (int i = 0; i<3; i++) {
    starTextures[i] = loadImage("star" + str(i + 1) + ".png");
  }
  starWidth = starTextures[0].width;
  starHeight = starTextures[0].height;
  
  heartTexture = loadImage("heart.png");
  heartWidth = heartTexture.width;
  heartHeight = heartTexture.height;
  
  //Jeu
  image(bgTexture, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(33);
  text("Put your hand above the sensor\nto start the game !", H / 2, H / 2);
  reset();
}

void reset() {
  //Personnage
  caracY = H / 2;

  //Ennemis
  enemies = new ArrayList<Enemy>();
  enemiesToRemove = new ArrayList<Enemy>();
  timeLeftEnemy = int(random(minEnemyCD, maxEnemyCD));

  //Etoiles
  stars = new ArrayList<Star>();
  starsToRemove = new ArrayList<Star>();
  timeLeftStar = int(random(minStarCD, maxStarCD));

  //Jeu
  score = 0;
  deathCooldown = 100;
  gameState = 2;
  startingTime = millis();
  lives = 3;
}

void loseLife() {
  lives--;
  if (lives <= 0) {
    lost();
  }
}

void lost() {
  gameState = 2;
  deathCooldown = 100;
  textAlign(CENTER, CENTER);
  textSize(30);
  text("Game Over !\nFinal score : " + score + "\nPut your hand above the sensor\nto start a new game", H / 2, H / 2);
}
