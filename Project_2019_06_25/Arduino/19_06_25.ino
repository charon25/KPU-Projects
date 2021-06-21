int potentiometerPin = 1;
int lightSensorPin = 0;
int touchSensorPin = 2;

int N = 25;
  
void setup() {
  Serial.begin(9600);
  pinMode(touchSensorPin, INPUT);
}

int oldValue = 0;

void loop() {
  double somme = 0;
  for (int i = 0 ; i < N ; i++) {
    somme += analogRead(lightSensorPin);
    //delay(1);
  }
  somme = somme / (double)N;
  double somme2 = 0;
  for (int i = 0 ; i < N ; i++) {
    somme2 += analogRead(potentiometerPin);
    //delay(1);
  }
  somme2 = somme2 / (double)N;
  Serial.println((String)(int)somme + "/" + (String)(int)somme2 + "/" + (String)digitalRead(touchSensorPin));
  //delay(15);
}
