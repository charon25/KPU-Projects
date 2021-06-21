int sensorPin = 0;
int N = 40;

void setup() {
  Serial.begin(9600);
}


void loop() {
  double somme = 0;
  for (int i = 0 ; i < N ; i++) {
    somme += analogRead(sensorPin);
    delay(1);
  }
  somme = somme / (double)N;
  Serial.println((int)somme);
}
