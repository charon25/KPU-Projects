boolean collision(float X1, float Y1, int W1, int H1, float X2, float Y2, int W2, int H2) {
  return !(X1 > X2 + W2 || X1 + W1 < X2 || Y1 > Y2 + H2 || Y1 + H1 < Y2);
}
