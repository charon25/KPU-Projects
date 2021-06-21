public class Caracter {
  public ArrayList<Ray> rays;
  public PVector pos;
  public float A0;

  public Caracter(float x, float y) {
    this.rays = new ArrayList<Ray>();
    for (float i = -fov / 2; i < fov / 2; i += 0.08) {
      this.rays.add(new Ray(x, y, radians(i)));
    }
    pos = new PVector(x, y);
  }

  public void cast() {
    this.A0 = rays.get(0).angle + radians(fov / 2);

    int minIndex, minT;
    float minDistance, distance;
    float W = (float)(H) / rays.size();
    for (int i = 0; i < rays.size(); i++) {
      minDistance = H * sqrt(2);
      minIndex = -1;
      minT = 0;
      for (int k = 0; k < walls.size(); k++) {
        distance = rays.get(i).distance(walls.get(k));
        if (distance >= 0 && distance < minDistance) {
          minDistance = distance;
          minIndex = k;
          minT = walls.get(k).T;
        }
      }
      if (minIndex >= 0) {
        distance = rays.get(i).distance(walls.get(minIndex));
        rectMode(CENTER);
        noStroke();
        //fill(map(distance * distance, 0, H * H * 2, 255, 0));
        colorMode(HSB, 360, 100, 100);
        //fill(map(distance, 0, H * sqrt(2), 255, 0));
        fill(minT, 100, map((distance), 0, (H * sqrt(2)), 100, 0));
        rect(500 + i * W + W / 2, H/2, W, map(distance * cos(rays.get(i).angle - A0), 0, H * sqrt(2), H * 0.95, 0));
        //println(distance * cos(rays.get(i).angle - A0));
        colorMode(RGB, 255, 255, 255);
        stroke(255, 0, 0);
        //line(rays.get(i).pos.x, rays.get(i).pos.y, rays.get(i).pos.x + distance * cos(rays.get(i).angle), rays.get(i).pos.y + distance * sin(rays.get(i).angle));
      }
    }
    push();
    stroke(255, 0, 0);
    strokeWeight(4);
    point(this.pos.x, this.pos.y);
    strokeWeight(1);
    stroke(0, 0, 255);
    line(this.pos.x, this.pos.y, this.pos.x + 25 * cos(this.A0 - radians(fov / 2)), this.pos.y + 25 * sin(this.A0 - radians(fov / 2)));
    line(this.pos.x, this.pos.y, this.pos.x + 25 * cos(this.A0 + radians(fov / 2)), this.pos.y + 25 * sin(this.A0 + radians(fov / 2)));
    pop();
  }

  public boolean collidesWithBlocks(float dx, float dy) {
    for (int i = 0; i < blocks.size(); i++) {
      if (collision(this.pos.x + dx, this.pos.y + dy, 1, 1, blocks.get(i).pos.x, blocks.get(i).pos.y, blocks.get(i).W * blocks.get(i).S, blocks.get(i).H * blocks.get(i).S)) {
        return true;
      }
    }
    return false;
  }

  public void move(float x, float y) {
    if (collision(this.pos.x, this.pos.y, 1, 1, F.pos.x, F.pos.y, F.W, F.H)) {
      level++;
      generateLevel();
    }
    if (!collidesWithBlocks(x, y)) {
      this.pos.x += x;
      this.pos.y += y;
      for (int i = 0; i < rays.size(); i ++) {
        rays.get(i).pos = pos;
      }
    }
    if (this.pos.x <= 10) {
      this.pos.x = 11;
    } else if (this.pos.x >= H - 10) {
      this.pos.x = H - 11;
    }
    if (this.pos.y <= 10) {
      this.pos.y = 11;
    } else if (this.pos.y >= H - 10) {
      this.pos.y = H - 11;
    }
  }

  public void rotate(float angle) {
    for (int i = 0; i < rays.size(); i ++) {
      rays.get(i).rotate(angle);
    }
  }

  public void forward(float amount) {
    this.move(amount * cos(this.A0), amount * sin(this.A0));
  }

  public void backward(float amount) {
    this.forward(-amount);
  }

  public void left(float amount) {
    this.move(amount * sin(this.A0), amount * cos(this.A0));
  }

  public void right(float amount) {
    this.move(-amount * sin(this.A0), amount * cos(this.A0));
  }
}
