// This sketch will send out a canon D50 trigger signal (probably works with most canons)
// See the full tutorial at http://www.ladyada.net/learn/sensors/ir.html
// this code is public domain, please enjoy!

int IRledPin =  12;    // LED connected to digital pin 12
int buttonPin = 3;     // footswitch connected to digital #3

// The setup() method runs once, when the sketch starts

void setup()   {                
  // initialize the IR digital pin as an output:
  pinMode(IRledPin, OUTPUT);      
  
  pinMode(buttonPin, INPUT);
  digitalWrite(buttonPin, HIGH); // pullup on
  
  Serial.begin(9600);
}

void loop()                     
{
  if (! digitalRead(buttonPin)) {
    // footswitch pressed
    Serial.println("Sending IR signal");
  
    SendCanonCode();
     
    delay(3*1000);  // wait 3 seconds (* 1000 milliseconds)
  }
}

// This procedure sends a 38KHz pulse to the IRledPin 
// for a certain # of microseconds. We'll use this whenever we need to send codes
void pulseIR(long microsecs) {
  // we'll count down from the number of microseconds we are told to wait
  
  cli();  // this turns off any background interrupts
  
  while (microsecs > 0) {
    // 38 kHz is about 13 microseconds high and 13 microseconds low
   digitalWrite(IRledPin, HIGH);  // this takes about 3 microseconds to happen
   delayMicroseconds(10);         // hang out for 10 microseconds
   digitalWrite(IRledPin, LOW);   // this also takes about 3 microseconds
   delayMicroseconds(10);         // hang out for 10 microseconds

   // so 26 microseconds altogether
   microsecs -= 26;
  }
  
  sei();  // this turns them back on
}

void SendCanonCode() {
  // This is the code for my particular Canon, for others use the tutorial
  // to 'grab' the proper code from the remote
  
  pulseIR(2080);
  delay(27);
  pulseIR(440);
  delayMicroseconds(1500);
  pulseIR(460);
  delayMicroseconds(3440);
  pulseIR(480);

    
  delay(65); // wait 65 milliseconds before sending it again
  
  pulseIR(2000);
  delay(27);
  pulseIR(440);
  delayMicroseconds(1500);
  pulseIR(460);
  delayMicroseconds(3440);
  pulseIR(480);
}

