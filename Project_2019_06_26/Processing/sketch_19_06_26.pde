import processing.serial.*;
Serial myPort;

//Textures et fenêtre
final int H = 800;
PImage[] caracterTextures, rubisTextures, powerupTextures; //1 : ^, 2 : >, 3 : V, 4 : <
PImage bgTexture, fireballTexture, heartTexture;
Rubis a;

//Tailles
int caracWidth, caracHeight;
int rubisWidth, rubisHeight;
int fireballWidth, fireballHeight;
int heartWidth, heartHeight;
int[] powerupWidth, powerupHeight;

//Personnage
float caracX = H / 2, caracY = H / 2;
final float caracVelocity = 5;
int direction;

//Rubis
ArrayList<Rubis> rubis;
ArrayList<Rubis> rubisToRemove;
int cooldownRubis, timeLeftRubis;

//Fireball
ArrayList<Fireball> fireballs;
ArrayList<Fireball> fireballsToRemove;
final float fireballVelocity = 5;
int cooldownFireball, timeLeftFireball;

//PowerUps
ArrayList<PowerUp> powerups;
ArrayList<PowerUp> powerupsToRemove;
int rubisPUCount;

//Jeu
int score, gameState, pickedRubis, deathCooldown, timeElapsed, startingTime, lives;

void setup() {
  try {
    String portName = Serial.list()[0];
    myPort = new Serial(this, portName, 9600);
    delay(250);
    println("Initialisation terminée !");
  } 
  catch (Exception ex) {
    println("Erreur de connexion !");
    exit();
  }
  //Fenêtre
  size(800, 800);
  init();
}

void draw() {
  if (gameState == 1) {
    image(bgTexture, 0, 0);
    int[] serial = readSerial();
    int X = 0, Y = 0;
    if (serial[0] != 99) {
      X = serial[0];
      Y = serial[1];
      move(X, Y);
    }
    manageRubis();
    manageFireballs();
    managePowerups();
    drawInfos();
    image(caracterTextures[direction], caracX, caracY);
  } else if (gameState == 2) {
    deathCooldown--;
    if (deathCooldown <= 0) {
      int[] serial = readSerial();
      if (serial[1] == 1) {
        reset();
        gameState = 1;
      }
    }
  }
  myPort.clear();
}

int[] readSerial() {
  int[] output = new int[3];
  if (myPort.available() > 0) {
    String val = myPort.readStringUntil('\n');
    try {
      output[0] = int(split(val.trim(), "/")[0]);
      output[1] = int(split(val.trim(), "/")[1]);
    } 
    catch (Exception ex) {
      output[0] = 99;
    }
  } else {
    output[0] = 99;
  }
  return output;
}

void drawInfos() {
  timeElapsed = millis() - startingTime;
  float rubisPerMinute = (float)pickedRubis / ((float)timeElapsed / 60000);
  textAlign(LEFT, LEFT);
  fill(255, 219, 88);
  textSize(15);
  text("Score : " + score + "\nTime : " + millisToString() + "\nRubis picked up : " + pickedRubis + " (" + nf(rubisPerMinute, 0, 1) + "/min)", 5, 20);
  
  for (int v = 0 ; v < lives ; v++) {
    image(heartTexture, 5 + (heartWidth + 5) * v, H - heartHeight - 5);
  }
}

String millisToString() {
  int sec = timeElapsed / 1000;
  String S = str(sec % 60);
  if (S.length() == 1) {
    S = "0" + S;
  }
  String M = str(sec / 60);
  if (M.length() == 1) {
    M = "0" + M;
  }
  return M + ":" + S;
}
