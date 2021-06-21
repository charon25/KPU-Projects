void init() {
  bgTexture = loadImage("background.jpg");
  image(bgTexture, 0, 0);
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
  snakeTextures = new PImage[14];
  snakeTextures[0] = loadImage("snake0.png");
  snakeTextures[1] = loadImage("snake1.png");
  for (int i = 0; i < 4; i++) {
    snakeTextures[i + 2] = loadImage("snakeT" + str(i) + ".png");
  }
  for (int i = 0; i < 4; i++) {
    snakeTextures[i + 6] = loadImage("snakeH" + str(i) + ".png");
  }
  snakeTextures[10] = loadImage("snakeE00.png");
  snakeTextures[11] = loadImage("snakeE01.png");
  snakeTextures[12] = loadImage("snakeE10.png");
  snakeTextures[13] = loadImage("snakeE11.png");
  fruitTexture = loadImage("fruit.png");
  pikesTexture = loadImage("pikes.png");

  textAlign(CENTER, CENTER);
  textSize(40);
  fill(255);
  text("Touch a sensor\nto start the game !", H / 2, H / 2);
  deathCooldown = 50;
  reset();
}

void reset() {
  //Serpent
  snake = new Snake(0, tileN / 2, 1);
  oldG = 0;
  oldD = 0;

  //Fruits//Piques
  generateFruit();
  summonPikes();

  //Jeu
  gameState = 0;
}

void lost() {
  textAlign(CENTER, CENTER);
  textSize(35);
  fill(255);
  text("Game Over !\nFinal score : " + str(snake.getSize() - 1) + "\nTouch a sensor\nto start a new game !", H / 2, H / 2);
  deathCooldown = 100;
  gameState = 0;
}
