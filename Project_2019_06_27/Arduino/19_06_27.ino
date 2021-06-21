int URECHO = 3;
int URTRIG = 5;

int N = 1;

unsigned int DistanceMeasured = 0;

void setup()
{
  Serial.begin(9600);
  pinMode(URTRIG, OUTPUT);
  digitalWrite(URTRIG, HIGH);
  pinMode(URECHO, INPUT);
  delay(100);
}

void loop()
{
  float somme = 0;
  int k = 0;
  int val;
  for (int i = 0 ; i < N; i++) {
    val = PWM_Mode();
    if (val >= 0) {
      somme += val;
      k++;
    }
    delay(2);
  }
  somme = somme / (float)k;
  Serial.println(10 * round(somme/10));
  PWM_Mode();
}

int PWM_Mode()
{
  digitalWrite(URTRIG, LOW);
  digitalWrite(URTRIG, HIGH);
  unsigned long LowLevelTime = pulseIn(URECHO, LOW) ;
  if (LowLevelTime >= 45000) {
    return -1;
  }
  else {
    return LowLevelTime;
  }
}
