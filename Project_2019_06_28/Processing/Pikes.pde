public class Pikes {
  private int X;
  private int Y;

  public Pikes(int X, int Y) {
    this.X = X;
    this.Y = Y;
  }

  public void show() {
    image(pikesTexture, X * tileH, Y * tileH);
  }
}

void summonPikes() {
  int n = max(1, snake.getSize() / 3);
  pikes = new ArrayList<Pikes>();
  for (int i = 0; i < n; i ++) {
    pikes.add(new Pikes(int(random(tileN)), int(random(tileN - 1))));
  }
}

void showPikes() {
  for (int i = 0; i < pikes.size(); i++) {
    pikes.get(i).show();
  }
}
