import processing.serial.*;
import java.util.Map;

Serial myPort;
String val;
int maxValue = 1024;
int H = 500;
int L = 20;
PGraphics g;
int dureeNoir;
int dureeBlanc;
String letter;
String texte;
HashMap<String, String> morse;

void setup()
{
  size(500, 500);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  delay(3000);
  println("Initialisation terminée !");
  val = myPort.readStringUntil('\n');
  maxValue = int(val.trim());
  maxValue = 1024;
  letter = "";
  texte = "";
  morse = new HashMap<String, String>();
  setHashMap();
  background(255);
  textSize(40);
}

void draw() 
{
  fill(color(0, 0, 0));
  if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
    try {
      int value = int(val.trim());
      if (value > maxValue) {
        maxValue = value;
      }
      //background(255 * value / maxValue);
      if (value > maxValue / 6) {
        fill(255);
        rect(0, 450, 50, 50);
        if (dureeNoir > 0 && dureeNoir <= 8) {
          letter += ".";
        }
        if (dureeNoir > 8) {
          letter += "-";
        }
        dureeNoir = 0;
        dureeBlanc++;
        if (dureeBlanc > 25) {
          if (letter.length() > 4) {
            println("test");
            texte = "";
            letter = "";
            background(255);
          }
          if (morse.containsKey(letter)) {
            texte += morse.get(letter); 
            background(255);
            letter = "";
          }
        }
      } else {
        fill(0);
        rect(0, 450, 50, 50);
        dureeNoir++;
        dureeBlanc = 0;
        //background(0);
      }
    } 
    catch (Exception ex) {
    }
  }
  fill(255, 0, 0);
  text(letter, 50, 50);
  text(texte, H / 2 - 20 * texte.length(), H /2);
}


void setHashMap() {
  morse.put(".-", "A");
  morse.put("-...", "B");
  morse.put("-.-.", "C");
  morse.put("-..", "D");
  morse.put(".", "E");
  morse.put("..-.", "F");
  morse.put("--.", "G");
  morse.put("....", "H");
  morse.put("..", "I");
  morse.put(".---", "J");
  morse.put("-.-", "K");
  morse.put(".-..", "L");
  morse.put("--", "M");
  morse.put("-.", "N");
  morse.put("---", "O");
  morse.put(".--.", "P");
  morse.put("--.-", "Q");
  morse.put(".-.", "R");
  morse.put("...", "S");
  morse.put("-", "T");
  morse.put("..-", "U");
  morse.put("...-", "V");
  morse.put(".--", "W");
  morse.put("-..-", "X");
  morse.put("-.--", "Y");
  morse.put("--..", "Z");
}
