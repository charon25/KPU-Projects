int accelPin = 5;
int rotationPin = 0;

int value, oldValue, oldRotation;

void setup() {
  Serial.begin(57600);
  oldValue = 0;
}

void loop() {
  value = analogRead(accelPin);
  int rot = analogRead(rotationPin);
  if (abs(rot - oldRotation) < 10) {
    rot = oldRotation;
  }
  if (abs(value - oldValue) > 100) {
    Serial.println("1/" + (String)(rot / 10));
  } else {
    Serial.println("0/" + (String)(rot / 10));
  }
  oldValue = value;
  oldRotation = rot;
  delay(25);
}
