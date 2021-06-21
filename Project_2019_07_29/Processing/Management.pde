void generateLevel() {
  walls = new ArrayList<Wall>();
  blocks = new ArrayList<Block>();

  for (int i = 0; i < 2 * level; i++) {
    Block b;
    do {
      b = new Block(random(H), random(H), int(random(1, 4)), int(random(1, 4)), random(10, 50));
    } while (b.collides(blocks));
    blocks.add(b);
  }

  for (int i = 0; i < 2 * level; i++) {
    walls.addAll(blocks.get(i).getWalls());
  }
  do {
    car = new Caracter(random(10, H - 10), random(10, H - 10));
  } while (car.collidesWithBlocks(0, 0));
  
  do {
    F = new Flag(random(10, H - 10), random(10, H - 10));
  } while (F.collidesWithBlocks(blocks));
  
  walls.addAll(F.getWalls());

  walls.add(new Wall(10, 10, 10, H - 10, 0));
  walls.add(new Wall(10, 10, H - 10, 10, 0));
  walls.add(new Wall(H - 10, H - 10, 10, H - 10, 0));
  walls.add(new Wall(H - 10, H - 10, H - 10, 10, 0));
}
