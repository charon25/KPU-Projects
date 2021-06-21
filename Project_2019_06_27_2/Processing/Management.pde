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
  padTexture = loadImage("pad.png");
  padWidth = padTexture.width;
  padHeight = padTexture.height;
  ballTexture = loadImage("ball.png");
  ballWidth = ballTexture.width;
  ballHeight = ballTexture.height;

  textAlign(CENTER, CENTER);
  textSize(40);
  image(bgTexture, 0, 0);
  text("Touch the sensor\nto start the game !", H / 2, H / 2);
  reset();
}

void reset() {
  //Pad
  padX = (H - padWidth) / 2;

  //Balle
  ball = new Ball((H - ballWidth) / 2, padY - ballHeight - 10, -random(PI / 4, PI * 3 / 4));

  //Briques
  bricks = new ArrayList<Brick>();
  bricksToRemove = new ArrayList<Brick>();
  createBricks();

  //Jeu
  score = 0;
  lives = 5;
  gameState = 2;
  deathCooldown = 100;
}

void loseLife() {
  lives--;
  if (lives <= 0) {
    lost();
  }
}

void lost() {
  gameState = 2;
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255);
  text("Game Over !\nFinal score : " + score + "\nTouch the sensor\nto start a new game !", H / 2, H / 2);
  deathCooldown = 100;
}

void won() {
  gameState = 2;
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255);
  text("Congratulations !\nFinal score : " + score + " (max : " + maxScore + ")\nTouch a sensor\nto start a new game !", H / 2, H / 2);
}
