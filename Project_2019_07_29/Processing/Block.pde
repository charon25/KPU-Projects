public class Block {
  public PVector pos;
  public int W;
  public int H;
  public float S;

  public Block(float x, float y, int w, int h, float s) {
    this.pos = new PVector(x, y);
    this.W = w;
    this.H = h;
    this.S = s;
  }

  public ArrayList<Wall> getWalls() {
    int T;
    do {
      T = int(random(360));
    } while (T > 90 && T < 150);
    ArrayList<Wall> output = new ArrayList<Wall>();
    output.add(new Wall(this.pos.x, this.pos.y, this.pos.x + this.W * this.S, this.pos.y, T));
    output.add(new Wall(this.pos.x, this.pos.y, this.pos.x, this.pos.y + this.H * this.S, T));
    output.add(new Wall(this.pos.x + this.W * this.S, this.pos.y + this.H * this.S, this.pos.x + this.W * this.S, this.pos.y, T));
    output.add(new Wall(this.pos.x + this.W * this.S, this.pos.y + this.H * this.S, this.pos.x, this.pos.y + this.H * this.S, T));
    return output;
  }

  public boolean collides(ArrayList<Block> blocks) {
    for (int i = 0; i < blocks.size(); i++) {
      if (collision(this.pos.x, this.pos.y, this.W * this.S, this.H * this.S, blocks.get(i).pos.x, blocks.get(i).pos.y, blocks.get(i).W * blocks.get(i).S, blocks.get(i).H * blocks.get(i).S)) {
        return true;
      }
    }
    return false;
  }
}
