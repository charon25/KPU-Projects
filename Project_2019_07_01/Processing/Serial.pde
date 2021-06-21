int[] readSerial() {
  int[] output = new int[5];
  if (myPort.available() > 0) {
    String val = myPort.readStringUntil('\n');
    try {
      for (int k = 0; k < 5; k++) {
        output[k] = int(split(val.trim(), "/")[k]);
      }
    } 
    catch (Exception ex) {
      output[0] = -1;
    }
  } else {
    output[0] = -1;
  }
  return output;
}
