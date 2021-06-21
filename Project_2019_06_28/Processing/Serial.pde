int[] readSerial() {
  int[] output = new int[2];
  if (myPort.available() > 0) {
    String val = myPort.readStringUntil('\n');
    try {
      output[0] = int(split(val.trim(), "/")[0]);
      output[1] = int(split(val.trim(), "/")[1]);
    } 
    catch (Exception ex) {
      output[0] = -1;
    }
  } else {
    output[0] = -1;
  }
  return output;
}
