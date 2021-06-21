public class PowerUp {
  private float X;
  private float Y;
  private int type; //1 : une vie, 2 : plus de rubis, 3 : plus de fireballs

  public PowerUp(float X, float Y, int type) {
    this.X = X;
    this.Y = Y;
    this.type = type;
  }

  public float getX() {
    return X;
  }

  public float getY() {
    return Y;
  }

  public PImage getImage() {
    return powerupTextures[type];
  }

  public void show() {
    image(this.getImage(), this.X, this.Y);
  }

  public boolean collidingWithCarac() {
    if (this.X > caracX + caracWidth
      || this.X + powerupWidth[type] < caracX
      || this.Y > caracY + caracHeight
      || this.Y + powerupHeight[type] <caracY) {
      return false;
    } else {
      return true;
    }
  }

  public void collide() {
    if (type == 0) {
      lives++;
    } else if (type == 1) {
      timeLeftRubis = cooldownRubis;
      rubisPUCount = 20;
    } else if (type == 2) {
      for (int k = 0; k < fireballs.size(); k++) {
        fireballsToRemove.add(fireballs.get(k));
      }
      timeLeftFireball = -cooldownFireball;
    }
  }
}

void managePowerups() {
  float r = random(1000);
  if (r < 3) {//28) {
    summonPowerups();
  }
  for (int k = 0; k < powerups.size(); k++) {
    powerups.get(k).show();
    if (powerups.get(k).collidingWithCarac()) {
      powerups.get(k).collide();
      powerupsToRemove.add(powerups.get(k));
    }
  }
  for (int k = 0; k < powerupsToRemove.size(); k++) {
    powerups.remove(powerupsToRemove.get(k));
  }
  powerupsToRemove = new ArrayList<PowerUp>();
}

void summonPowerups() {
  int type = int(random(3));
  float X = random(H - powerupWidth[type]);
  float Y = random(H - powerupHeight[type]);
  powerups.add(new PowerUp(X, Y, type));
}
