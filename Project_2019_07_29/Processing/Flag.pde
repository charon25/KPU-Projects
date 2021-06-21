public class Flag {
  public PVector pos;
  public int H;
  public int W;

  public Flag(float x, float y) {
    this.pos = new PVector(x, y);
    W = int(random(10, 70));
    H = int(random(10, 70));
  }

  public ArrayList<Wall> getWalls() {
    ArrayList<Wall> output = new ArrayList<Wall>();
    output.add(new Wall(this.pos.x, this.pos.y, this.pos.x + this.W, this.pos.y, 120));
    output.add(new Wall(this.pos.x, this.pos.y, this.pos.x, this.pos.y + this.H, 120));
    output.add(new Wall(this.pos.x + this.W, this.pos.y + this.H, this.pos.x + this.W, this.pos.y, 120));
    output.add(new Wall(this.pos.x + this.W, this.pos.y + this.H, this.pos.x, this.pos.y + this.H, 120));
    return output;
  }

  public boolean collidesWithBlocks(ArrayList<Block> blocks) {
    for (int i = 0; i < blocks.size(); i++) {
      if (collision(this.pos.x, this.pos.y, this.W, this.H, blocks.get(i).pos.x, blocks.get(i).pos.y, blocks.get(i).W * blocks.get(i).S, blocks.get(i).H * blocks.get(i).S)) {
        return true;
      }
    }
    return false;
  }
}
