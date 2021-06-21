void moveShowPad() {
  padX += padVelocity * padDir;
  if (padX < 0) {
    padX = 0;
  }
  if (padX > H - padWidth) {
    padX = H - padWidth;
  }
  image(padTexture, padX, padY);
}
