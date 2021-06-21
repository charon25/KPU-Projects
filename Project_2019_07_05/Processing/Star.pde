public class Star {
  private PVector position;
  private int type;

  public Star(float X, float Y, int type) {
    this.position = new PVector(X, Y);
    this.type = type;
  }

  public void move() {
    this.position.x -= starVelocity;
    if (this.position.x < -starWidth) {
      starsToRemove.add(this);
    }
    if (collision(this.position.x, this.position.y, carWidth, carHeight, carPos.x, carPos.y, carWidth, carHeight)) {
      if (this.type == carType) {
        changeCarType();
        score++;
      } else {
        loseLife();
      }
      starsToRemove.add(this);
    }
  }

  public void show() {
    image(starTextures[this.type], this.position.x, this.position.y);
  }
}

void manageStars() {
  timeLeftStar--;
  if (timeLeftStar <= 0) {
    timeLeftStar = cooldownStar;
    summonStar();
  }
  for (int i = 0; i < stars.size(); i++) {
    stars.get(i).move();
    stars.get(i).show();
  }
  for (int i = 0; i  < starsToRemove.size(); i++) {
    stars.remove(starsToRemove.get(i));
  }
  starsToRemove = new ArrayList<Star>();
}

void summonStar() {
  int type = int(random(starTextures.length));
  float Y = random(H - carHeight);
  stars.add(new Star(H, Y, type));
}
