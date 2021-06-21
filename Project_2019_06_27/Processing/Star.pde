public class Star {
  private float X;
  private float Y;
  private float velocity;
  private int value;
  private boolean dead;

  public Star(float Y, int value) {
    this.X = H;
    this.Y = Y;
    this.velocity = starVelocity;
    this.value = value;
    this.value = min(3, max(1, this.value));
  }

  public boolean isDead() {
    return this.dead;
  }
  public int getValue() {
    return this.value;
  }

  public void move() {
    this.X -= this.velocity;
    if (this.X < 0) {
      this.dead = true;
    }
  }

  public void show() {
    image(starTextures[this.value - 1], this.X, this.Y);
  }

  public boolean collidesWithCarac() {
    if (this.X > caracX + caracWidth
      || this.X + starWidth < caracX
      || this.Y > caracY + caracHeight
      || this.Y + starHeight < caracY) {
      return false;
    } else {
      return true;
    }
  }
}

void manageStars() {
  timeLeftStar--;
  if (timeLeftStar <= 0) {
    timeLeftStar = int(random(minStarCD, maxStarCD));
    summonStar();
  }
  for (int i = 0; i < stars.size(); i++) {
    stars.get(i).move();
    stars.get(i).show();
    if (stars.get(i).isDead()) {
      starsToRemove.add(stars.get(i));
    }
    if (stars.get(i).collidesWithCarac()) {
      score += stars.get(i).getValue() * 10;
      starsToRemove.add(stars.get(i));
    }
  }
  for (int i = 0; i < starsToRemove.size(); i++) {
    stars.remove(starsToRemove.get(i));
  }
  starsToRemove = new ArrayList<Star>();
}

void summonStar() {
  float Y = random(H - starHeight);
  int value = int(random(minStarValue, maxStarValue + 1));
  stars.add(new Star(Y, value));
}
