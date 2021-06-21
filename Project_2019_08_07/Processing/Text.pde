public class Text {
  private int type;
  private String txt;
  private PVector pos;
  private int age;

  public Text(int type, String txt) {
    this.type = type;
    this.txt = txt;
    this.pos = new PVector(Xpos[this.type] + starWidth / 2, Ypos - starHeight / 2);
    this.age = 30;
  }

  public void show() {
    textSize(25);
    textAlign(CENTER, CENTER);
    if (this.txt == "Perfect !") {
      fill(255, 0, 0);
    } else if (this.txt == "Great") {
      fill(255, 255, 0);
    } else if (this.txt == "Good") {
      fill(0, 192, 0);
    } else if (this.txt == "Miss") {
      fill(255);
    }
    text(this.txt, this.pos.x, this.pos.y);
  }

  public void age() {
    this.age--;
    if (age <= 0) {
      textsToRemove.add(this);
    }
  }
}

void manageTexts() {
  for (int i = 0; i < texts.size(); i++) {
    texts.get(i).show();
    texts.get(i).age();
  }
  for (int i = 0; i < textsToRemove.size(); i++) {
    texts.remove(textsToRemove.get(i));
  }
  textsToRemove = new ArrayList<Text>();
}
