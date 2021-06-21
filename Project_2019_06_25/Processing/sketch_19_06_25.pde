import processing.serial.*;
import java.util.Map;

Serial myPort;
String val;
int maxValue = 1024;
int H = 500;
int L = 20;
PGraphics g;
boolean hasShot;
int caracSize, shotWidth, shotHeight, enemyWidth, enemyHeight;
int timeLeftEnemy, cooldownEnemy = 50, mininumEnemyCooldown = 24;
int enemyCycle, killedEnemies;
int timeLeftShot, cooldownShot = 50;
int timeLeftLaser, cooldownLaser = 2000;
float laserX;
int laserWidth, laserHeight, laserDuration = 40;
boolean doesLaserExists;
int minEnemyVelocity = 3;
int maxEnemyVelocity = 8;
float caracPos = H / 2;
int gameState; //0 : init, 1 : jeu en cours, 2 : fin, 3 : attente
float score;
int maxScoring = 1000;
float maxDistance = H * sqrt(2);
int cooldownWidth = 25;
int cooldownHeight = 100;
int timeElapsed, t0;

PImage bg, caracter, shot, enemy, laser;

ArrayList<Tir> shots;
ArrayList<Tir> shotsToRemove;
ArrayList<Ennemi> enemies;
ArrayList<Ennemi> enemiesToRemove;

void setup()
{
  size(500, 500);
  try {
    gameState = 0;
    String portName = Serial.list()[0];
    myPort = new Serial(this, portName, 9600);
    delay(500);
    println("Initialisation terminée !");
    val = myPort.readStringUntil('\n');
    maxValue = 1024;
    background(255);
    textSize(40);
    bg = loadImage("background.jpg");
    caracter = loadImage("caracter.png");
    shot = loadImage("shot.png");
    enemy = loadImage("enemy.png");
    laser = loadImage("laser.png");
    caracSize = caracter.width;
    shotWidth = shot.width;
    shotHeight = shot.height;
    enemyWidth = enemy.width;
    enemyHeight = enemy.height;
    laserWidth = laser.width;
    laserHeight = laser.height;
    reset();
    gameState = 3;
    timeLeftShot = cooldownShot;
  } 
  catch (Exception ex) {
    println("ERREUR DE CONNEXION !");
    exit();
  }
}

void draw() 
{  
  image(bg, 0, 0);
  if (gameState == 1) {
    image(caracter, caracPos, H - caracSize - 15);
    textAlign(LEFT, LEFT);
    textSize(18);
    fill(255, 219, 88);
    text("Score : " + round(score) + "\nTime : " + millisToString() + "\nKills : " + killedEnemies, 5, 20);
    if (myPort.available() > 0) {
      val = myPort.readStringUntil('\n');
      try {
        int shooting = int(split(val.trim(), "/")[0]);
        int pos = int(split(val.trim(), "/")[1]);
        int laser = int(split(val.trim(), "/")[2]);
        caracPos = map(pos, 1023, 0, 0, H - caracSize);
        if (shooting < maxValue / 8 && timeLeftShot >= cooldownShot) {
          if (!hasShot) {
            shot(pos);
            timeLeftShot = 0;
          }
          hasShot = true;
        } else {
          hasShot = false;
        }
        if (laser == 1 && timeLeftLaser >= cooldownLaser) {
          doesLaserExists = true;
          timeLeftLaser = 0;
        }
        if (timeLeftEnemy >= cooldownEnemy) {
          summonEnemy(pos);
          timeLeftEnemy = 0;
        }
      } 
      catch (Exception ex) {
      }
    }
    for (int i = 0; i < shots.size(); i++) {
      shots.get(i).move();
      image(shot, shots.get(i).X - shotWidth / 2, shots.get(i).Y - shotHeight / 2);
      if (shots.get(i).isDead) {
        shotsToRemove.add(shots.get(i));
      }
    }
    for (int i = 0; i < shotsToRemove.size(); i++) {
      shots.remove(shotsToRemove.get(i));
    }
    shotsToRemove = new ArrayList<Tir>();
    for (int i = 0; i < enemies.size(); i++) {
      if (enemies.get(i).collisionWithCarac()) {
        gameState = 2;
      }
      for (int k = 0; k < shots.size(); k++) {
        if (enemies.get(i).collisionWithShot(shots.get(k))) {
          score += round((maxDistance - enemies.get(i).distanceToCarac()) * maxScoring / maxDistance);
          enemiesToRemove.add(enemies.get(i));
          shotsToRemove.add(shots.get(k));
          enemyCycle++;
          killedEnemies++;
          timeLeftLaser += 0.07 * cooldownLaser;
        }
      }
      if (doesLaserExists && enemies.get(i).collisionWithLaser()) {
        score += round((maxDistance - enemies.get(i).distanceToCarac()) * maxScoring / maxDistance);
        enemiesToRemove.add(enemies.get(i));
        enemyCycle++;
        killedEnemies++;
      }
      enemies.get(i).move();
      image(enemy, enemies.get(i).X - enemyWidth / 2, enemies.get(i).Y - enemyHeight / 2);
      if (enemies.get(i).isDead) {
        enemiesToRemove.add(enemies.get(i));
      }
    }
    for (int i = 0; i < enemiesToRemove.size(); i++) {
      enemies.remove(enemiesToRemove.get(i));
    }
    enemiesToRemove = new ArrayList<Ennemi>();
    if (doesLaserExists) {
      laserX = caracPos + caracSize / 2;
      image(laser, laserX - laserWidth / 2, H - caracSize - 20 - laserHeight);
    }
    drawShotCooldown();
    drawLaserCooldown();
    score += 0.2;
    //--------------------------------
  } else if (gameState == 2) {
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255, 219, 88);
    text("Game Over\nScore final : " + round(score) + "\nShoot to start a new game", H / 2, H / 2);
    if (myPort.available() > 0) {
      val = myPort.readStringUntil('\n');
      try {
        if (int(split(val.trim(), "/")[0]) < maxValue / 8) {
          reset();
        }
      } 
      catch (Exception ex) {
      }
    }
    //--------------------------------
  } else if (gameState == 3) {
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255, 219, 88);
    text("Shoot to start\nthe game", H / 2, H / 2);
    if (myPort.available() > 0) {
      val = myPort.readStringUntil('\n');
      try {
        if (int(split(val.trim(), "/")[0]) < maxValue / 8) {
          reset();
        }
      } 
      catch (Exception ex) {
      }
    }
  }
  timeLeftEnemy++;
  timeLeftShot++;
  timeLeftLaser++;
  if (timeLeftLaser >= laserDuration) {
    doesLaserExists = false;
  }
  timeElapsed = millis() - t0;
  if (enemyCycle == 7 && cooldownEnemy > mininumEnemyCooldown) {
    cooldownEnemy -= 2;
    enemyCycle = 0;
  }
  myPort.clear();
}

void reset() {
  gameState = 1;
  score = 0;
  timeLeftShot = cooldownShot;
  shots = new ArrayList<Tir>();
  shotsToRemove = new ArrayList<Tir>();
  enemies = new ArrayList<Ennemi>();
  enemiesToRemove = new ArrayList<Ennemi>();
  doesLaserExists = false;
  timeLeftLaser = 0;
  enemyCycle = 0;
  killedEnemies = 0;
  t0 = millis();
}

void drawShotCooldown() {
  stroke(255);
  noFill();
  rect(H - 30 - 2 * cooldownWidth, 15, cooldownWidth, cooldownHeight);
  if (timeLeftShot < cooldownShot) {
    fill(255);
    rect(H - 30 - 2 * cooldownWidth, 15, cooldownWidth, cooldownHeight * timeLeftShot / cooldownShot);
  } else {
    fill(255, 0, 0);
    rect(H - 30 - 2 * cooldownWidth, 15, cooldownWidth, cooldownHeight);
  }
}

void drawLaserCooldown() {
  stroke(255);
  noFill();
  rect(H - 15 - cooldownWidth, 15, cooldownWidth, cooldownHeight);
  if (timeLeftLaser < cooldownLaser) {
    fill(255);
    rect(H - 15 - cooldownWidth, 15, cooldownWidth, cooldownHeight * timeLeftLaser / cooldownLaser);
  } else {
    fill(0, 255, 0);
    rect(H - 15 - cooldownWidth, 15, cooldownWidth, cooldownHeight);
  }
}

void shot(int pos) {
  Tir tir = new Tir(map(pos, 1023, 0, 0, H - caracSize) + caracSize / 2, H - caracSize - 20);
  shots.add(tir);
}

void summonEnemy(int pos) {
  float r = random(3);
  Ennemi e;
  if (r < 1) {
    float y = random(H / 2);
    float[] u = computeDirection(pos, 1, y);
    e = new Ennemi(1, y, random(minEnemyVelocity, maxEnemyVelocity) * u[0], random(minEnemyVelocity, maxEnemyVelocity) * u[1]);
  } else if (r < 2) {
    float x = random(H);
    float[] u = computeDirection(pos, x, 1);
    e = new Ennemi(x, 1, random(minEnemyVelocity, maxEnemyVelocity) * u[0], random(minEnemyVelocity, maxEnemyVelocity) * u[1]);
  } else {
    float y = random(H / 2);
    float[] u = computeDirection(pos, H - 1, y);
    e = new Ennemi(H - 1, y, random(minEnemyVelocity, maxEnemyVelocity) * u[0], random(minEnemyVelocity, maxEnemyVelocity) * u[1]);
  }
  enemies.add(e);
}

float[] computeDirection(int pos, float X, float Y) {
  float[] output = new float[2];
  float x = map(pos, 1023, 0, 0, H - caracSize) - X;
  float y = H - caracSize - 20 - Y;
  float r = sqrt(x * x + y * y);
  output[0] = x / r;
  output[1] = y / r;
  return output;
}

String millisToString() {
  int sec = timeElapsed / 1000;
  String S = str(sec % 60);
  if (S.length() == 1) {S = "0" + S;}
  String M = str(sec / 60);
  if (M.length() == 1) {M = "0" + M;}
  return M + ":" + S;
}

class Tir {
  public float X;
  public float Y;
  public boolean isDead;
  public float velocity;

  public Tir(float _X, float _Y) {
    this.X = _X;
    this.Y = _Y;
    this.velocity = 15;
    this.isDead = false;
  }

  public void move() {
    this.Y -= this.velocity;
    if (this.Y < 0) {
      this.isDead = true;
    }
  }
}

class Ennemi {
  public float X;
  public float Y;
  public float velX;
  public float velY;
  public boolean isDead;

  public Ennemi(float _X, float _Y, float _velX, float _velY) {
    this.X = _X;
    this.Y = _Y;
    this.velX = _velX;
    this.velY = _velY;
    this.isDead = false;
  }

  void move() {
    this.X += this.velX;
    this.Y += this.velY;
    if (this.X < 0 || this.X > H || this.Y < 0 || this.Y > H) {
      this.isDead = true;
    }
  }

  boolean collisionWithCarac() {
    if (this.X > caracPos + caracSize
      || this.X + enemyWidth < caracPos
      || this.Y > H - 20
      || this.Y + enemyHeight < H - caracSize - 20) {
      return false;
    } else {
      return true;
    }
  }

  boolean collisionWithShot(Tir shot) {
    if (this.X > shot.X + shotWidth
      || this.X + enemyWidth < shot.X
      || this.Y > shot.Y + shotHeight
      || this.Y + enemyHeight < shot.Y) {
      return false;
    } else {
      return true;
    }
  }
  
  boolean collisionWithLaser() {
    if (this.X > laserX + laserWidth / 2
      || this.X + enemyWidth < laserX - laserWidth / 2) {
      return false;
    } else {
      return true;
    }
  }

  float distanceToCarac() {
    return dist(this.X, this.Y, caracPos + caracSize / 2, H - 20 - caracSize / 2);
  }
}
