void move(int X, int Y) {
  caracX += X * caracVelocity;
  caracY += Y * caracVelocity;
  /*if (X == 1 ||Y == 1) {
    if (boolToInt(caracMode) == -1) {
      if (Y == 1) {
        direction = 0;
      } else {
        direction = 3;
      }
    } else {
      if (Y == 1) {
        direction = 2;
      } else {
        direction = 1;
      }
    }
  }*/
  if (caracX < 0) {
    caracX =0;
  }
  if (caracY < 0) {
    caracY=0;
  }
  if (caracX + caracWidth > H) {
    caracX = H - caracWidth;
  }
  if (caracY + caracHeight > H) {
    caracY = H - caracHeight;
  }
}

int boolToInt(boolean b) {
  if (b) {
    return -1;
  } else {
    return 1;
  }
}
