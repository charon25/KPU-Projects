int lightSensorPin = 0;

int N = 50;
  
void setup() {
  Serial.begin(9600);
}

int oldValue = 0;

void loop() {
  double somme = 0;
  for (int i = 0 ; i < N ; i++) {
    somme += analogRead(lightSensorPin);
    //delay(1);
  }
  Serial.println((String)(int)somme);
}
