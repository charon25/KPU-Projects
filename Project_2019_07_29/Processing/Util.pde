boolean collision(float X1, float Y1, float W1, float H1, float X2, float Y2, float W2, float H2) {
  return !(X1 > X2 + W2 || X1 + W1 < X2 || Y1 > Y2 + H2 || Y1 + H1 < Y2);
}
