public class Shot {
  private PVector position;
  private PVector direction;
  private int type;

  public Shot(float X0, float Y0, float XT, float YT, int type) {
    this.position = new PVector(X0, Y0);
    this.direction = new PVector(XT - X0, YT - Y0);
    this.direction.setMag(1);
    this.type = type;
  }

  public void move() {
    PVector temp = direction.copy().mult(shotVelocity);
    this.position.add(temp);
    if (this.position.x < -shotWidth || this.position.x > H || this.position.y < -shotHeight || this.position.y > H) {
      shotsToRemove.add(this);
    }
    for (int i = 0; i < obstacles.size(); i++) {
      if (obstacles.get(i).isColliding(this.position.x, this.position.y, shotWidth, shotHeight)) {
        shotsToRemove.add(this); 
        break;
      }
    }
    if (collidesWithCar()) {
      loseLife();
      shotsToRemove.add(this);
    }
  }

  public void show() {
    image(shotTextures[this.type], this.position.x, this.position.y);
  }

  public boolean collidesWithCar() {
    if (carPos.x > this.position.x + shotWidth - 3
      || carPos.x + carWidth < this.position.x + 3
      || carPos.y > this.position.y + shotHeight - 3
      || carPos.y + carHeight < this.position.y + 3) {
      return false;
    } else {
      return true;
    }
  }
}

void manageShots() {
  for (int i = 0; i < shots.size(); i++) {
    shots.get(i).move();
    shots.get(i).show();
  }
  for (int i = 0; i < shotsToRemove.size(); i++) {
    shots.remove(shotsToRemove.get(i));
  }
  shotsToRemove = new ArrayList<Shot>();
}
