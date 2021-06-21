void init() {
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
  loadTextures();
  image(bgTexture, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(45);
  fill(0);
  text("Press the button\nto start the new game", H / 2, H / 2);
  
  reset();
}

void loadTextures() {
  bgTexture = loadImage("background.jpg");
  carTextures = new PImage[5];
  for (int i = 0; i < 5; i++) {
    carTextures[i] = loadImage("car" + str(i) + ".png");
  }
  carWidth = carTextures[0].width;
  carHeight = 20;
  enemyTexture = loadImage("enemy.png");
  enemyWidth = enemyTexture.width;
  enemyHeight = enemyTexture.height;
  warningTexture = loadImage("warning.png");
}

void reset() {
  //Jeu
  gameState = 0;
  lives = 5;
  startingTime = millis();
  score = 0f;

  //Personnage
  carAngle = PI / 2;
  carDistance = 0f;

  //Ennemis
  enemies = new ArrayList<Enemy>();
  enemiesToRemove = new ArrayList<Enemy>();
  timeLeftEnemy = enemyCooldown;
}

void loseLife() {
  lives--;
  if (lives <= 0) {
    textAlign(CENTER, CENTER);
    textSize(35);
    fill(0);
    text("Game Over !\nFinal score : " + int(score) + "\nSurvival time : " + millisToString() + "\nPress the button\nto start a new game", H / 2, H / 2);
    gameState = 0;
    deathCooldown = 100;
  }
}
