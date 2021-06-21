public class Slime {
  public PVector position;
  public PVector direction;
  public float angle;
  public int hp;

  public Slime(float X0, float Y0, float XT, float YT, float angle) {
    this.position = new PVector(X0, Y0);
    this.direction = new PVector(XT - X0, YT - Y0);
    this.direction.setMag(1);
    this.angle = angle;
    this.hp = int(random(1, 4));
  }

  public PVector getPosition() {
    return position;
  }

  public void move() {
    this.position.x += this.direction.x * slimeVelocity;
    this.position.y += this.direction.y * slimeVelocity;
    if (this.position.x < -slimeWidth || this.position.x > H || this.position.y < -slimeHeight || this.position.y > H) {
      slimesToRemove.add(this);
    }
    if (collision(this.position.x, this.position.y, slimeWidth, slimeHeight, (H - carWidth) / 2, H - carHeight - 20, carWidth, carHeight)) {
      slimesToRemove.addAll(slimes);
      loseLife();
    }
  }

  public void show() {
    if (hp > 0) {
      float X0 = this.position.x + slimeWidth / 2;
      float Y0 = this.position.y + slimeHeight / 2;
      translate(X0, Y0);
      rotate(angle);
      image(slimeTextures[hp - 1], -slimeWidth / 2, -slimeHeight / 2);
      rotate(-angle);
      translate(-X0, -Y0);
    }
  }

  public void loseHP() {
    hp--;
    score++;
    if (hp <= 0) {
      slimesToRemove.add(this);
      score += 2;
      kills++;
    }
  }
}

void manageSlimes() {
  slimeTimeLeft--;
  if (slimeTimeLeft <= 0) {
    summonSlime();
    if (slimeCooldown > minSlimeCD) {
      slimeCooldown -= 3;
    }
    slimeTimeLeft = slimeCooldown;
  }
  for (int i = 0; i < slimes.size(); i++) {
    slimes.get(i).move();
    slimes.get(i).show();
  }
  for (int i = 0; i < slimesToRemove.size(); i++) {
    slimes.remove(slimesToRemove.get(i));
  }
  slimesToRemove = new ArrayList<Slime>();
}

void summonSlime() {
  int r = int(random(3));
  float X0, Y0;
  float XT = H / 2 - slimeWidth / 2;
  float YT =  H - carHeight / 2 - 20 - slimeHeight / 2;
  if (r == 0) {
    X0 = -slimeWidth + 1;
    Y0 = random(H * 0.75);
  } else if (r == 1) {
    X0 = random(H);
    Y0 = -slimeHeight + 1;
  } else {
    X0 = H - 1;
    Y0 = random(H * 0.75);
  }
  PVector dir = new PVector(XT - X0, YT - Y0);
  dir.setMag(1);
  slimes.add(new Slime(X0, Y0, XT, YT, acos(dir.x) - PI / 2));
}
