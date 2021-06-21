public class Fireball {
  private PVector position;
  private PVector direction;
  private float angle;

  public Fireball(float X0, float Y0, float angle) {
    this.position = new PVector(X0, Y0);
    this.angle = angle;
    angle = PI / 2 - angle;
    this.direction = new PVector(cos(angle), -sin(angle));
  }

  public PVector getPosition() {
    return position;
  }

  public void move() {
    this.position.x += this.direction.x * fireballVelocity;
    this.position.y += this.direction.y * fireballVelocity;
    if (this.position.x < - fbWidth || this.position.x > H || this.position.y < -fbHeight || this.position.y > H) {
      fireballsToRemove.add(this);
    }
  }

  public void show() {
    float X0 = this.position.x + fbWidth / 2;
    float Y0 = this.position.y + fbHeight / 2;
    translate(X0, Y0);
    rotate(angle);
    image(fireballTexture, -fbWidth / 2, -fbHeight / 2);
    rotate(-angle);
    translate(-X0, -Y0);
  }
}

void manageFireballs() {
  for (int i = 0; i < fireballs.size(); i++) {
    fireballs.get(i).move();
    fireballs.get(i).show();
    for (int k = 0; k < slimes.size(); k++) {
      if (collision(fireballs.get(i).getPosition().x, fireballs.get(i).getPosition().y, fbWidth, fbHeight, slimes.get(k).getPosition().x, slimes.get(k).getPosition().y, slimeWidth, slimeHeight)) {
        slimes.get(k).loseHP();
        fireballsToRemove.add(fireballs.get(i));
      }
    }
  }
  for (int i = 0; i < fireballsToRemove.size(); i++) {
    fireballs.remove(fireballsToRemove.get(i));
  }
  fireballsToRemove = new ArrayList<Fireball>();
}
