public class Snake {
  private int dir;
  private ArrayList<PVector> body;
  private int timeLeftMove;
  private boolean dead;

  public Snake(int X, int Y, int dir) {
    this.dir = dir;
    this.body = new ArrayList<PVector>();
    this.body.add(new PVector(X, Y));
    timeLeftMove = cooldownMoveSnake;
    dead = false;
  }

  public void changeDir(int d) {
    this.dir += d;
    if (this.dir > 3) {
      this.dir = 0;
    }
    if (this.dir < 0) {
      this.dir = 3;
    }
  }

  public boolean isDead() {
    return dead;
  }

  public int getSize() {
    return this.body.size();
  }

  public void move() {
    timeLeftMove--;
    if (timeLeftMove <= 0) {
      timeLeftMove = cooldownMoveSnake;
      PVector last = this.body.get(this.body.size() - 1).copy();
      for (int i = this.body.size() - 1; i > 0; i--) {
        this.body.get(i).x = this.body.get(i - 1).x;
        this.body.get(i).y = this.body.get(i - 1).y;
      }
      switch (this.dir) {
      case 0:
        this.body.get(0).y--;
        break;
      case 1:
        this.body.get(0).x++;
        break;
      case 2:
        this.body.get(0).y++;
        break;
      case 3:
        this.body.get(0).x--;
        break;
      }
      if (this.body.get(0).x == fruit.X && this.body.get(0).y == fruit.Y) {
        this.body.add(last);
        generateFruit();
        summonPikes();
      }
      if (isDeadPrivate()) {
        dead = true;
      }
    }
  }

  private boolean isDeadPrivate() {
    if (this.body.get(0).x < 0 || this.body.get(0).x >= tileN || this.body.get(0).y < 0 || this.body.get(0).y >= tileN) {
      return true;
    }
    for (int k = 1; k < this.body.size(); k++) {
      if (this.body.get(0).x == this.body.get(k).x && this.body.get(0).y == this.body.get(k).y) {
        return true;
      }
    }
    for (int k = 0; k < pikes.size(); k++) {
      if (this.body.get(0).x == pikes.get(k).X && this.body.get(0).y == pikes.get(k).Y) {
        return true;
      }
    }
    return false;
  }

  public void show() {
    switch (this.dir) {
    case 0:
      image(snakeTextures[6], tileH * this.body.get(0).x, tileH * this.body.get(0).y);
      break;
    case 1:
      image(snakeTextures[7], tileH * this.body.get(0).x, tileH * this.body.get(0).y);
      break;
    case 2:
      image(snakeTextures[8], tileH * this.body.get(0).x, tileH * this.body.get(0).y);
      break;
    case 3:
      image(snakeTextures[9], tileH * this.body.get(0).x, tileH * this.body.get(0).y);
      break;
    }
    for (int i = 1; i < this.body.size() - 1; i++) {
      if (this.body.get(i + 1).x == this.body.get(i - 1).x) {
        image(snakeTextures[1], tileH * this.body.get(i).x, tileH * this.body.get(i).y);
      } else if (this.body.get(i + 1).y == this.body.get(i - 1).y) {
        image(snakeTextures[0], tileH * this.body.get(i).x, tileH * this.body.get(i).y);
      } else {
        if ((this.body.get(i + 1).x == this.body.get(i).x - 1 && this.body.get(i - 1).y == this.body.get(i).y - 1) || (this.body.get(i - 1).x == this.body.get(i).x - 1 && this.body.get(i + 1).y == this.body.get(i).y - 1)) {
          image(snakeTextures[4], tileH * this.body.get(i).x, tileH * this.body.get(i).y);
        } else if ((this.body.get(i + 1).x == this.body.get(i).x + 1 && this.body.get(i - 1).y == this.body.get(i).y - 1) || (this.body.get(i - 1).x == this.body.get(i).x + 1 && this.body.get(i + 1).y == this.body.get(i).y - 1)) {
          image(snakeTextures[5], tileH * this.body.get(i).x, tileH * this.body.get(i).y);
        } else if ((this.body.get(i + 1).x == this.body.get(i).x + 1 && this.body.get(i - 1).y == this.body.get(i).y + 1) || (this.body.get(i - 1).x == this.body.get(i).x + 1 && this.body.get(i + 1).y == this.body.get(i).y + 1)) {
          image(snakeTextures[2], tileH * this.body.get(i).x, tileH * this.body.get(i).y);
        } else {
          image(snakeTextures[3], tileH * this.body.get(i).x, tileH * this.body.get(i).y);
        }
      }
    }
    if (this.body.size() > 1) {
      int L = this.body.size() - 1;
      if (this.body.get(L - 1).x == this.body.get(L).x - 1) {
        image(snakeTextures[13], tileH * this.body.get(L).x, tileH * this.body.get(L).y);
      } else if (this.body.get(L - 1).x == this.body.get(L).x + 1) {
        image(snakeTextures[12], tileH * this.body.get(L).x, tileH * this.body.get(L).y);
      } else if (this.body.get(L - 1).y == this.body.get(L).y - 1) {
        image(snakeTextures[10], tileH * this.body.get(L).x, tileH * this.body.get(L).y);
      } else {
        image(snakeTextures[11], tileH * this.body.get(L).x, tileH * this.body.get(L).y);
      }
    }
  }
}
