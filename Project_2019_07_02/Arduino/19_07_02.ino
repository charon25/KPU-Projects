int buttonPin = 7;
int sensorPin = 0;

int N = 50;

void setup() {
  pinMode(buttonPin, INPUT);
  Serial.begin(57600);
}

void loop() {
  int somme = 0;
  for (int i = 0 ;i < N;i++) {
    somme += (analogRead(sensorPin) / 10);
  }
  somme = somme / N;
  Serial.println((String)(somme) + "-" + (String)digitalRead(buttonPin));
  delay(15);
}
