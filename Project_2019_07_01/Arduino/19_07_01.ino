int sensor1_A = 0;
int sensor2_A = 2;
int sensor3_A = 4;
int sensor4_D = 8;
int button_D = 4;

void setup() {
  pinMode(sensor4_D, INPUT);
  pinMode(button_D, INPUT);
  Serial.begin(57600);
}

void loop() {
  String v1, v2, v3;
  if (analogRead(sensor1_A) > 0) {
    v1 = "1";
  } else {
    v1 = "0";
  }
  if (analogRead(sensor2_A) < 100) {
    v2 = "1";
  } else {
    v2 = "0";
  }
  if (analogRead(sensor3_A) < 10) {
    v3 = "1";
  } else {
    v3 = "0";
  }
  Serial.println(v1 + "/" + v2 + "/" + v3 + "/" + (String)digitalRead(sensor4_D) + "/" + (String)digitalRead(button_D));
  delay(20);
}
