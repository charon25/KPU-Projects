int sensorPin = 0;
int buttonPin = 8;

void setup() {
  Serial.begin(57600);
  pinMode(buttonPin, INPUT);
}

void loop() {
  String s;
  int value = analogRead(sensorPin);
  if (value < 124) {
    s = digitalRead(buttonPin) == 0 ? "-1" : "1";
  } else {
    s = "0";
  }
  Serial.println(s);
  delay(25);
}
