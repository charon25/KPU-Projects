public class Fireball {
  private float X;
  private float Y;
  private PVector dir;

  public Fireball(float X, float Y, float XT, float YT) {
    this.X = X;
    this.Y = Y;
    dir = new PVector(XT - X, YT - Y);
    dir.setMag(1);
  }

  public void show() {
    image(fireballTexture, this.X, this.Y);
  }

  public void move() {
    PVector temp = dir.copy().mult(fireballVelocity);
    this.X += temp.x;
    this.Y += temp.y;
    if (this.X < -fireballWidth || this.Y < -fireballHeight || this.X > H  || this.Y > H) {
      fireballsToRemove.add(this);
    }
  }

  public boolean collidingWithCarac() {
    if (this.X > caracX + caracWidth - 5
      || this.X + fireballWidth + 5 < caracX
      || this.Y > caracY + caracHeight - 5
      || this.Y + fireballHeight + 5 <caracY) {
      return false;
    } else {
      return true;
    }
  }
}

void manageFireballs() {
  timeLeftFireball++;
  if (timeLeftFireball >= cooldownFireball) {
    summonFireball();
    timeLeftFireball = 0;
  }
  for (int k = 0; k < fireballs.size(); k++) {
    fireballs.get(k).move();
    fireballs.get(k).show();
    if (fireballs.get(k).collidingWithCarac()) {
      fireballsToRemove.add(fireballs.get(k));
      loseLife();
    }
  }
  for (int k = 0; k < fireballsToRemove.size(); k++) {
    fireballs.remove(fireballsToRemove.get(k));
  }
  fireballsToRemove = new ArrayList<Fireball>();
}

void summonFireball() {
  float r = random(1000);
  Fireball fb;
  if (r <250) {
    fb = new Fireball(random(H - fireballWidth), 1, caracX + caracWidth / 2 + random(-250, 250), caracY + caracHeight / 2 + random(-250, 250));
  } else if (r < 500) {
    fb = new Fireball(H - 1, random(H - fireballHeight), caracX + caracWidth / 2 + random(-250, 250), caracY + caracHeight / 2 + random(-250, 250));
  } else if (r < 750) {
    fb = new Fireball(random(H - fireballWidth), H - 1, caracX + caracWidth / 2 + random(-250, 250), caracY + caracHeight / 2 + random(-250, 250));
  } else {
    fb = new Fireball(1, random(H - fireballHeight), caracX + caracWidth / 2 + random(-250, 250), caracY + caracHeight / 2 + random(-250, 250));
  }
  fireballs.add(fb);
}
