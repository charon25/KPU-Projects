public class Brick {
  private float X;
  private float Y;
  private float w;
  private float h;
  private color C;
  private boolean destroyed;

  public Brick(float X, float Y, float w, float h, color C) {
    this.X = X;
    this.Y = Y;
    this.w = w;
    this.h = h;
    this.C = C;
    destroyed = false;
  }

  public float getX() {
    return X;
  }
  public float getY() {
    return Y;
  }
  public float getW() {
    return w;
  }
  public float getH() {
    return h;
  }
  public boolean isDestroyed() {
    return destroyed;
  }

  public void show() {
    if (!destroyed) {
      fill(C);
      rect(X, Y, w, h);
    }
  }

  public void destroy() {
    destroyed = true;
  }
}

void manageBricks() {
  if (bricks.size() == 0) {
    won();
  }
  for (int k = 0; k < bricks.size(); k++) {
    bricks.get(k).show();
    if (bricks.get(k).isDestroyed()) {
      bricksToRemove.add(bricks.get(k));
    }
  }
  for (int k = 0; k < bricksToRemove.size(); k++) {
    bricks.remove(bricksToRemove.get(k));
  }
  bricksToRemove = new ArrayList<Brick>();
}

void createBricks() {
  int w = int(random(minBrickWidth, maxBrickWidth));
  int h = int(random(minBrickHeight, maxBrickHeight));
  int Nx = (H - 100) / (w + 5) ;
  int Ny = (playH - 30) / (h + 5) - 1;
  int N = Nx * Ny;
  maxScore = N * (N + 1) / 2;
  int offsetX = (H - Nx * (w + 5) + 5) / 2;
  int offsetY = 40;
  for (int x = 0; x < Nx; x++) {
    for (int y = 0; y < Ny; y++) {
      bricks.add(new Brick(offsetX + x * (w + 5), offsetY + y * (h + 5), w, h, randomColor()));
    }
  }
}

color randomColor() {
  return color(int(random(256)), int(random(256)), int(random(256)));
}
