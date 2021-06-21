public class Ray {
  public PVector pos;
  public float angle;

  public Ray(float x, float y, float angle) {
    this.pos = new  PVector(x, y);
    this.angle = angle;
  }

  public float distance(Wall wall) {
    float x1, x2, x3, x4, y1, y2, y3, y4;
    x1 = wall.start.x;
    y1 = wall.start.y;
    x2 = wall.end.x;
    y2 = wall.end.y;

    x3 = this.pos.x;
    y3 = this.pos.y;
    x4 = this.pos.x + cos(angle);
    y4 = this.pos.y + sin(angle);

    float t, u, denom;
    denom = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4) ) / denom;
    u = - ((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denom;
    if (t >= 0 && t <= 1 && u >= 0) {
      return dist(this.pos.x, this.pos.y, x1 + t * (x2 - x1), y1 + t * (y2 - y1));
    } else {
      return -1.0;
    }
  }

  public void move(float x, float y) {
    this.pos.x += x;
    this.pos.y += y;
  }

  public void rotate(float angle) {
    this.angle += angle;
  }
}
