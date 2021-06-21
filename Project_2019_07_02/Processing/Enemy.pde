public class Enemy {
  private PVector position;
  private PVector direction;
  private int age;
  private float distanceAtStart;

  public Enemy(float X0, float Y0, float XT, float YT) {
    this.position = new PVector(X0, Y0);
    this.direction = new PVector(XT - X0, YT - Y0);
    this.direction.setMag(1);
    this.age = enemyWarningTime;
    this.distanceAtStart = dist(X0, Y0, getCarPosition().x, getCarPosition().y);
  }

  public float getX() {
    return this.position.x;
  }
  public float getY() {
    return this.position.y;
  }

  public void move() {
    if (age > 0) {
      age--;
    } else {
      PVector temp = direction.copy().mult(enemyVelocity);
      this.position.x += temp.x;
      this.position.y += temp.y;
      if (this.position.x < -enemyWidth || this.position.x > H || this.position.y < -enemyHeight || this.position.y > H) {
        score += map(distanceAtStart, 0, maxDistance, 250, 0);
        enemiesToRemove.add(this);
      }
      temp = getCarPosition();
      if (collision(temp.x, temp.y, carWidth, carHeight, this.position.x, this.position.y, enemyWidth, enemyHeight)) {
        loseLife();
        enemiesToRemove.add(this);
      }
    }
  }

  public void show() {
    if (age > 0) {
      image(warningTexture, this.position.x, this.position.y);
    } else {
      image(enemyTexture, this.position.x, this.position.y);
    }
  }
}

void manageEnemies() {
  timeLeftEnemy--;
  if (timeLeftEnemy <= 0) {
    summonEnemy();
    timeLeftEnemy = enemyCooldown;
  }
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).move();
    enemies.get(i).show();
  }
  for (int i = 0; i < enemiesToRemove.size(); i++) {
    enemies.remove(enemiesToRemove.get(i));
  }
}

void summonEnemy() {
  int r = int(random(4));
  float X, Y;
  switch (r) {
  case 0:
    X = random(enemyWidth, H - enemyWidth);
    Y = 1;
    break;
  case 1:
    X = H - enemyWidth - 1;
    Y = random(enemyHeight, H - enemyHeight);
    break;
  case 2:
    X = random(enemyWidth, H - enemyWidth);
    Y = H - enemyHeight - 1;
    break;
  default:
    X = 1;
    Y = random(enemyHeight, H - enemyHeight);
    break;
  }
  enemies.add(new Enemy(X, Y, getCarPosition().x + 2 * random(-enemyWidth, enemyWidth), getCarPosition().y +  2 * random(-enemyHeight, enemyHeight)));
}
