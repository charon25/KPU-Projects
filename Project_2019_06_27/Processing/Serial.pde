int readSerial() {
  if (myPort.available() > 0) {
    String val = myPort.readStringUntil('\n');
    return int(val.trim());
  } else {
    return -1;
  }
}
