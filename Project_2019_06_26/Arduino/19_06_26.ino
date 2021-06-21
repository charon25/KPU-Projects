int flameSensorPin = 0;
int lightSensorPin = 2;

int N = 25;

void setup() {
  Serial.begin(9600);
}

void loop() {
  double somme = 0;
  for (int i = 0 ; i < N ; i++) {
    somme += analogRead(flameSensorPin);
  }
  somme = somme / (double)N;
  double somme2 = 0;
  for (int i = 0 ; i < N ; i++) {
    somme2 += analogRead(lightSensorPin);
  }
  somme2 = somme2 / (double)N;
  String flame = "", light = "";
  if (somme < 8) {flame = "1";}
  else {flame = "-1";}
  if (somme2 < 128) {light = "1";}
  else {light = "-1";}
  Serial.println(flame + "/" + light);
  delay(25);
}
