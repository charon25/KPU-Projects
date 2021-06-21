public class Enemy {
  private float X;
  private float Y;
  private float velocity;
  private boolean dead;

  public Enemy(float Y, float velocity) {
    this.X = H;
    this.Y = Y;
    this.velocity = velocity;
    dead = false;
  }

  public boolean isDead() {
    return dead;
  }

  public void move() {
    X -= velocity;
    if (X < 0) {
      dead = true;
    }
  }

  public void show() {
    image(enemyTexture, X, Y);
  }

  public boolean collidesWithCarac() {
    if (this.X > caracX + caracWidth - 3
      || this.X + enemyWidth < caracX + 3
      || this.Y > caracY + caracHeight - 3
      || this.Y + enemyHeight < caracY + 3) {
      return false;
    } else {
      return true;
    }
  }
}

void manageEnemies() {
  timeLeftEnemy--;
  if (timeLeftEnemy <= 0) {
    timeLeftEnemy = int(random(minEnemyCD, maxEnemyCD));
    summonEnemy();
  }
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).move();
    enemies.get(i).show();
    if (enemies.get(i).isDead()) {
      enemiesToRemove.add(enemies.get(i));
      score++;
    }
    if (enemies.get(i).collidesWithCarac()) {
      for (int k = 0; k < enemies.size(); k++) {
        enemiesToRemove.add(enemies.get(k));
      }
      loseLife();
    }
  }
  for (int i = 0; i < enemiesToRemove.size(); i++) {
    enemies.remove(enemiesToRemove.get(i));
  }
  enemiesToRemove = new ArrayList<Enemy>();
}

void summonEnemy() {
  float Y = random(H - enemyHeight);
  float velocity = random(minEnemyVelocity, maxEnemyVelocity);
  enemies.add(new Enemy(Y, velocity));
}
