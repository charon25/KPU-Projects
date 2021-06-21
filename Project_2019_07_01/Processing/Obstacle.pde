public class Obstacle {
  private PVector position;
  private int type;
  private int w;
  private int h;

  public Obstacle(float X, float Y, int type) {
    this.position = new PVector(X, Y);
    this.type = type;
    this.w = obsTextures[this.type].width;
    this.h = obsTextures[this.type].height;
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

  public void show() {
    image(obsTextures[this.type], this.position.x, this.position.y);
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
  public boolean isColliding(float X, float Y, int W, int H) {
    if (X > this.position.x + this.w - 3
      || X + W < this.position.x + 3
      || Y > this.position.y + this.h - 3
      || Y + H < this.position.y + 3) {
      return false;
    } else {
      return true;
    }
  }
}

void manageObstacles() {
  for (int i = 0; i < obstacles.size(); i ++) {
    obstacles.get(i).show();
  }
}

void summonObstacles() {
  int N = int(random(3, 8));
  for (int i = 0; i< N; i++) {
    int type = int(random(3));
    int w = obsTextures[type].width, h = obsTextures[type].height;
    float X, Y;
    do {
      X = random(carWidth + 10, H - w - carWidth - 10);
      Y = random(carHeight + 10, H - h - carHeight - 10);
    } while (isCollidingWithObstacles(X, Y, w, h));
    obstacles.add(new Obstacle(X, Y, type));
  }
}
