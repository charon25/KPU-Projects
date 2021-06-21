public class Enemy {
  private PVector position;
  private int direction;
  private int attackTimeLeft;
  private int w;
  private int h;
  private boolean firstShot;

  public Enemy(float X, float Y) {
    this.position = new PVector(X, Y);
    this.attackTimeLeft = int(enemyAttackCooldown * 1.5 + int(random(2 * enemyAttackCooldown)));
    this.direction = 0;
    this.w = ennWidth1;
    this.h = ennHeight1;
    firstShot = true;
  }

  public float getX() {
    return this.position.x;
  }
  public float getY() {
    return this.position.y;
  }
  public int getW() {
    return this.w;
  }
  public int getH() {
    return this.h;
  }

  public void age() {
    this.attackTimeLeft--;
    if (this.attackTimeLeft <= 0) {
      shoot();
      this.attackTimeLeft = enemyAttackCooldown + int(random(25));
    }
    PVector facing = carPos.copy().sub(this.position);
    if (facing.x <= 0) {
      if (abs(facing.x) < abs(facing.y)) {
        if (facing.y <= 0) {
          this.direction = 0;
        } else {
          this.direction = 2;
        }
      } else {
        this.direction = 3;
      }
    } else {
      if (abs(facing.x) < abs(facing.y)) {
        if (facing.y <= 0) {
          this.direction = 0;
        } else {
          this.direction = 2;
        }
      } else {
        this.direction = 1;
      }
    }
    switch (this.direction) {
    case 0:
      this.w = ennWidth1;
      this.h = ennHeight1;
      break;
    case 1:
      this.w = ennWidth1;
      this.h = ennHeight1;
      break;
    case 2:
      this.w = ennWidth2;
      this.h = ennHeight2;
      break;
    case 3:
      this.w = ennWidth1;
      this.h = ennHeight1;
      break;
    }
  }

  public boolean collidesWithCar() {
    if (carPos.x > this.position.x + this.w - 3
      || carPos.x + carWidth < this.position.x + 3
      || carPos.y > this.position.y + this.h - 3
      || carPos.y + carHeight < this.position.y + 3) {
      return false;
    } else {
      return true;
    }
  }
  public void show() {
    if ((enemyAttackCooldown - this.attackTimeLeft <= 25 && !firstShot) || this.attackTimeLeft <= 45) {
      image(ennAttackTextures[this.direction], this.position.x, this.position.y);
    } else {
      image(ennIdleTextures[this.direction], this.position.x, this.position.y);
    }
  }

  private void shoot() {
    float X = this.position.x, Y = this.position.y;
    switch (this.direction) {
    case 0:
      X+=40;
      Y+=2;
      break;
    case 1:
      X+=40;
      Y+=18;
      break;
    case 2:
      X+=34;
      Y+=46;
      break;
    case 3:
      X+=1;
      Y+=18;
      break;
    }
    shots.add(new Shot(X, Y, carPos.x + random(-10, 10), carPos.y + random(-10, 10), int(random(4))));
    firstShot = false;
  }
}

void manageEnemies() {
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).age();
    enemies.get(i).show();
  }
  for (int i = 0; i < enemiesToRemove.size(); i++) {
    enemies.remove(enemiesToRemove.get(i));
  }
  enemiesToRemove = new ArrayList<Enemy>();
}

void summonEnemies(int count) {
  int w = max(ennWidth1, ennWidth2);
  int h = max(ennHeight1, ennHeight2);
  float X;
  float Y;
  for (int i = 0; i < count; i++) {
    do {
      X = random(w, H - 2 * w);
      Y = random(h, H - 2 * h);
    } while (isCollidingWithObstacles(X, Y, w, h));
    enemies.add(new Enemy(X, Y));
  }
}

boolean isCollidingWithObstacles(float X, float Y, int w, int h) {
  for (int i = 0; i < obstacles.size(); i++) {
    if (obstacles.get(i).isColliding(X, Y, w, h)) {
      return true;
    }
  }
  return false;
}
