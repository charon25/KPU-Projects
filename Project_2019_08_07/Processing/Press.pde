void pressStar(int type) {
  boolean flag = false;
  for (int i = 0; i < stars.size(); i++) {
    if (stars.get(i).getType() == type) {
      float d = abs(stars.get(i).getY() - Ypos);
      if (d < 4) {
        flag = true;
        if (!stars.get(i).hasBeenHit()) {
          hit++;
          hp += 0.1;
          stars.get(i).hit();
          texts.add(new Text(type, "Perfect !"));
          score += 10;
        }
      } else if (d < 15) {
        flag = true;
        if (!stars.get(i).hasBeenHit()) {
          hit++;
          hp += 0.05;
          ;
          stars.get(i).hit();
          texts.add(new Text(type, "Great"));
          score += 5;
        }
      } else if (d < 20) {
        flag = true;
        if (!stars.get(i).hasBeenHit()) {
          hit++;
          hp += 0.02;
          ;
          stars.get(i).hit();
          texts.add(new Text(type, "Good"));
          score++;
        }
      }
    }
  }
  if (!flag) {
    texts.add(new Text(type, "Miss"));
    hp -= 0.03;
  }
}
