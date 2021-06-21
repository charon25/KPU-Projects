int readSerial() {
  if (myPort.available() > 0) {
    String val = myPort.readStringUntil('\n');
    try {
      return int(val.trim());
    } 
    catch (Exception ex) {
      return 99;
    }
  } else {
    return 99;
  }
}
