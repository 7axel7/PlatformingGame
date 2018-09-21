StringList keyList = new StringList("87", "83", "65", "68", "9","80","32","16","49","50","51","52","53","54","109","107");

void keyPressed() {
  keyHandler(str(keyCode), true);
}

void keyReleased() {
  keyHandler(str(keyCode), false);
}

void keyHandler(String code, boolean type) {
  for (int i = 0; i < keyList.size(); i ++) {
    if (code.equals(keyList.get(i))) {
      p.keys[i] = type;
    }
  }
}
