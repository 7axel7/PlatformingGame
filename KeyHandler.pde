StringList keyList = new StringList("87", "83", "65", "68");

void keyPressed() {
  keyHandler(str(keyCode), 0);
}

void keyReleased() {
  keyHandler(str(keyCode), 1);
}

void keyHandler(String code, int type) {
  boolean change = true;
  if (type == 1) change = false;
  for (int i = 0; i < keyList.size(); i ++) 
    if (code.equals(keyList.get(i))) p.keys[i] = change;
}
