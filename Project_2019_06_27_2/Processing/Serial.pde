int readSerial() {
  if (myPort.available() > 0) {
    String val = myPort.readStringUntil('\n');
    try {
      int value = int(val.trim());
      if (value == 0) {
        return 0;
      } else if (value < 100) {
        return 1;
      } else {
        return -1;
      }
    } 
    catch (Exception ex) {
      return 99;
    }
  } else {
    return 99;
  }
}
