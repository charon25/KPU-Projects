int sensorPin1 = 0;
int sensorPin2 = 2;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int val1 = analogRead(sensorPin1);
  int val2 = analogRead(sensorPin2);
  String s1, s2;
  if (val1 == 0) {
    s1 = "0";
  } else {
    s1 = "1";
  }
  if (val2 <= 128) {
    s2 = "1";
  } else {
    s2 = "0";
  }
  Serial.println(s1 + "/" + s2);
  delay(50);
}
