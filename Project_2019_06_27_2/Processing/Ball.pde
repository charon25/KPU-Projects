public class Ball {
  private float X;
  private float Y;
  private float oldX;
  private float oldY;
  private PVector dir;
  private boolean dead;
  private int combo;

  public Ball(float X, float Y, float angle) {
    this.X = X;
    this.Y = Y;
    this.dir = new PVector(cos(angle), sin(angle));
    this.dead = false;
    this.combo = 0;
  }

  public boolean isDead() {
    return dead;
  }

  public void move() {
    this.oldX = X;
    this.oldY = Y;
    this.X += ballVelocity * this.dir.x;
    this.Y += ballVelocity * this.dir.y;
    if (this.X <= 0) {
      this.X = 0;
      this.dir.x = -this.dir.x;
    }
    if (this.Y <= 0) {
      this.Y = 0;
      this.dir.y = -this.dir.y;
    }
    if (this.X >= H - ballWidth) {
      this.X = H - ballWidth;
      this.dir.x = -this.dir.x;
    }
    if (this.collidesWithPad()) {
      this.combo = 0;
      this.Y = padY - ballHeight;
      this.dir.y = -this.dir.y;
      if (padDir != 0) {
        this.dir.x = abs(this.dir.x) * padDir;
      }
    }
    if (this.Y >= H - ballHeight) {
      dead = true;
    }
    Brick b = collidesWithBrick();
    if (b != null) {
      int colDir = collidingDirection(b);
      switch (colDir) {
      case 0:
        this.dir.x = -this.dir.x;
        break;
      case 1:
        this.dir.y = -this.dir.y;
        break;
      case 2:
        this.dir.x = -this.dir.x;
        break;
      case 3:
        this.dir.y = -this.dir.y;
        break;
      }
      this.combo++;
      score += this.combo;
      b.destroy();
    }
  }

  private boolean collidesWithPad() {
    if (this.X > padX + padWidth
      || this.X + ballWidth < padX
      || this.Y > padY + padHeight
      || this.Y + ballHeight < padY) {
      return false;
    } else {
      return true;
    }
  }

  private Brick collidesWithBrick() {
    for (int i = 0; i < bricks.size(); i++) {
      if (!bricks.get(i).isDestroyed() 
        && !(this.X > bricks.get(i).getX() + bricks.get(i).getW()
        || this.X + ballWidth < bricks.get(i).getX()
        || this.Y >bricks.get(i).getY() + bricks.get(i).getH()
        || this.Y + ballHeight < bricks.get(i).getY())) {
        return bricks.get(i);
      }
    }
    return null;
  }

  private int collidingDirection(Brick b) {
    if (this.oldX + ballWidth < b.getX()) {
      return 0;
    }
    if (this.oldY + ballHeight < b.getY()) {
      return 1;
    }
    if (this.oldX > b.getX() + b.getW()) {
      return 2;
    }
    if (this.oldY > b.getY() + b.getH()) {
      return 3;
    }
    return -1;
  }

  public void show() {
    image(ballTexture, this.X, this.Y);
  }
}

void manageBall() {
  ball.show();
  ball.move();
  if (ball.isDead()) {
    loseLife();
    ball = new Ball(padX + padWidth / 2 - ballWidth / 2, padY - ballHeight - 10, -random(PI / 4, PI * 3 / 4));
  }
}
