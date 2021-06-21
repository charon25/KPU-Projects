int sensorPin = 0;
int buttonPin = 8;

int oldState, oldStateButton;
double lastSent, buttonDuration, startButton;

void setup() {
  pinMode(buttonPin, INPUT);
  Serial.begin(57600);
  oldState = 0;
}

void loop() {
  int value = analogRead(sensorPin);
  int state;
  int buttonState = digitalRead(buttonPin);
  if (value < 128) {
    state = 1;
  } else {
    state = 0;
  }
  if (buttonState == 1 && oldStateButton == 0) {
    startButton = millis();
  } 
  if (buttonState == 0 && oldStateButton == 1) {
    buttonDuration = millis() - startButton;
  }
  if (buttonState == 1 && oldStateButton == 1 && millis() - startButton > 400) {
    startButton = millis();
    Serial.println("3");
  }
  if (state > 0 && oldState != state && millis() - lastSent > 60) {
    Serial.println(state);
    lastSent = millis();
  } else {
    if (buttonState == 0 && oldStateButton == 1) {
      if (buttonDuration < 400) {
        Serial.println("2");
      } else {
        Serial.println("3");
      }
    }
  }
  oldState = state;
  oldStateButton = buttonState;
}
