public class Star {
  private PVector pos;
  private int type;
  private boolean got;

  public Star(int type) {
    this.type = type;
    this.pos = new PVector(Xpos[type], -starHeight);
    this.got = false;
  }

  public int getType() {
    return this.type;
  }

  public float getY() {
    return this.pos.y;
  }

  public boolean hasBeenHit() {
    return got;
  }

  public void hit() {
    this.got = true;
  }

  public void move() {
    this.pos.y += starSpeed;
    if (this.pos.y + starHeight > 530) {
      starsToRemove.add(this);
      total++;
      if (!got) {
        hp -= 0.02;
      }
    }
  }

  public void show() {
    image(starTextures[this.type], this.pos.x, this.pos.y);
  }
}

void manageStars() {
  starTimeLeft--;
  if (starTimeLeft <= 0) {
    starTimeLeft = int(random(minStarCD, maxStarCD));
    summonStar();
  }
  for (int i = 0; i < stars.size(); i++) {
    stars.get(i).move();
    stars.get(i).show();
  }
  for (int i = 0; i < starsToRemove.size(); i++) {
    stars.remove(starsToRemove.get(i));
  }
  starsToRemove = new ArrayList<Star>();
}

void summonStar() {
  int type = int(random(3));
  stars.add(new Star(type));
}
