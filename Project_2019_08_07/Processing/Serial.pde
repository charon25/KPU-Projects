int[] readSerial() {
  int[] output = new int[3];
  if (myPort.available() > 0) {
    String val = myPort.readStringUntil('\n');
    try {
      for (int i = 0; i < 3; i++) {
        output[i] = int(split(val.trim(), "/")[i]);
      }
    } 
    catch (Exception ex) {
      output[0] = 99;
    }
  } else {
    output[0] = 99;
  }
  return output;
}
