public class Fruit {
  private int X;
  private int Y;

  public Fruit(int X, int Y) {
    this.X = X;
    this.Y = Y;
  }

  public void show() {
    image(fruitTexture, X * tileH, Y * tileH);
  }
}

void generateFruit() {
  int X = int(random(1, tileN - 1));
  int Y = int(random(1, tileN - 1));
  fruit = new Fruit(X, Y);
}
