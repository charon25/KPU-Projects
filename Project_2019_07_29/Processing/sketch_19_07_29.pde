void setup() {
  size(1000, 500);
  keys = new boolean[6];
  gameState = 0;
  level = 0;

  generateLevel();
}

void keyPressed() {
  gameState = 1;
  if (key == 'z') {
    keys[0] = true;
  } else if (key == 's') {
    keys[1] = true;
  } else if (key == 'q') {
    keys[2] = true;
  } else if (key == 'd') {
    keys[3] = true;
  } else if (key == 'a') {
    keys[4] = true;
  } else if (key == 'e') {
    keys[5] = true;
  }
}

void keyReleased() {
  if (key == 'z') {
    keys[0] = false;
  } else if (key == 's') {
    keys[1] = false;
  } else if (key == 'q') {
    keys[2] = false;
  } else if (key == 'd') {
    keys[3] = false;
  } else if (key == 'a') {
    keys[4] = false;
  } else if (key == 'e') {
    keys[5] = false;
  }
}



void draw() {
  background(0);
  if (gameState == 1) {
    stroke(255);
    for (int i = 0; i < walls.size(); i++ ) {
      line(walls.get(i).start.x, walls.get(i).start.y, walls.get(i).end.x, walls.get(i).end.y);
    }

    if (keys[0]) {
      car.forward(2);
    }
    if (keys[1]) {
      car.backward(2);
    }
    if (keys[2]) {
      car.left(2);
    }
    if (keys[3]) {
      car.right(2);
    }
    if (keys[4]) {
      car.rotate(radians(-5));
    }
    if (keys[5]) {
      car.rotate(radians(5));
    }
  
    push();
    rectMode(CORNER);
    noStroke();
    fill(0);
    rect(H, 0, H, H);
    pop();
    car.cast();
  } else {
    textAlign(CENTER, CENTER);
    textSize(40);
    fill(255);
    text("Press a key to start !", width / 2, height / 2);
  }
}
