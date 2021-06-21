public class Rubis {
  private float X;
  private float Y;
  private int type;
  private int timeLeft;

  public Rubis(float X, float Y, int type) {
    this.X = X;
    this.Y = Y;
    this.type = type;
    if (rubisPUCount == 0) {
      timeLeft = int(random(350, 600));
    } else {
      timeLeft = int(random(250, 450));
    }
  }

  public float getX() {
    return X;
  }

  public float getY() {
    return Y;
  }

  public PImage getImage() {
    return rubisTextures[type];
  }

  public void age() {
    timeLeft--;
    if (timeLeft <= 0) {
      rubisToRemove.add(this);
    }
  }

  public int getValue() {
    switch (type) {
    case 0:
      return 1;
    case 1:
      return 5;
    case 2:
      return 10;
    default:
      return 0;
    }
  }

  public void show() {
    image(this.getImage(), this.X, this.Y);
  }

  public boolean collidingWithCarac() {
    if (this.X > caracX + caracWidth
      || this.X + rubisWidth < caracX
      || this.Y > caracY + caracHeight
      || this.Y + rubisHeight <caracY) {
      return false;
    } else {
      return true;
    }
  }
}

void manageRubis() {
  timeLeftRubis++;
  if (timeLeftRubis >= cooldownRubis) {
    summonRubis();
    if (rubisPUCount == 0) {
      timeLeftRubis = 0;
    } else {
      timeLeftRubis = cooldownRubis - 3;
      rubisPUCount--;
    }
  }
  for (int k = 0; k < rubis.size(); k++) {
    rubis.get(k).show();
    rubis.get(k).age();
    if (rubis.get(k).collidingWithCarac()) {
      score += rubis.get(k).getValue();
      pickedRubis++;
      rubisToRemove.add(rubis.get(k));
    }
  }
  for (int k = 0; k < rubisToRemove.size(); k++) {
    rubis.remove(rubisToRemove.get(k));
  }
  rubisToRemove = new ArrayList<Rubis>();
}

void summonRubis() {
  float X = random(H - rubisWidth);
  float Y = random(H - rubisHeight);
  int type;
  float r = random(1000);
  if (r < 750) {
    type = 0;
  } else if (r < 950) {
    type = 1;
  } else {
    type = 2;
  }
  rubis.add(new Rubis(X, Y, type));
}
