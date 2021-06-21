public class Wall {
  public PVector start;
  public PVector end;
  public int T;
  
  public Wall(float x1, float y1, float x2, float y2, int t) {
    start = new PVector(x1, y1);
    end = new PVector(x2, y2);
    this.T = t;
  }
}
