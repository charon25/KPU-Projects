int analogSensorPin1 = 0;
int analogSensorPin2 = 2;
int digitalSensorPin = 7;

void setup() {
  Serial.begin(57600);
  pinMode(digitalSensorPin, INPUT);
}

void loop() {
  String output;
  if (analogRead(analogSensorPin1) >= 10) {
    output = "1/";
  } else {
    output = "0/";
  }
  if (analogRead(analogSensorPin2) < 128) {
    output += "1/";
  } else {
    output += "0/";
  }
  if (digitalRead(digitalSensorPin) == HIGH) {
    output += "1";
  } else {
    output += "0";
  }
  Serial.println(output);
  delay(10);
}
