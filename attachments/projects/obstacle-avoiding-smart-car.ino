int photocellPin = A0;
int ledPin1 = 9;
int ledPin2 = 4;
int motorPin = 7;
int sensorVal = 0;

void setup() {
  Serial.begin(9600);
  pinMode(photocellPin, INPUT);
  pinMode(ledPin1, OUTPUT);
  pinMode(ledPin2, OUTPUT);
  pinMode(motorPin, OUTPUT);
}

void loop() {
  sensorVal = analogRead(photocellPin);
  Serial.println(sensorVal);

  if(sensorVal <= 512){
    digitalWrite(ledPin1, HIGH);
    digitalWrite(ledPin2, LOW);
    digitalWrite(motorPin, LOW);
  }
  else{
    digitalWrite(ledPin1, LOW);
    digitalWrite(ledPin2, HIGH);
    digitalWrite(motorPin, HIGH);
  }
}
