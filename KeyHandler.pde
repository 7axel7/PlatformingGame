String[][] keyList = new String[][]{{"87","38"}, {"83","40"}, {"65","37"}, {"68","39"}, {"9"}, {"80"}, {"32"}, {"16"}, {"49"}, {"50"}, {"51"}, {"52"}, {"53"}, {"54"}, {"109"}, {"107"}};

void keyPressed() {
  keyHandler(str(keyCode), true);
}

void keyReleased() {
  keyHandler(str(keyCode), false);
}

void keyHandler(String code, boolean type) {
  for (int i = 0; i < keyList.length; i ++) {
    for (int j = 0; j < keyList[i].length; j ++) {
      if (code.equals(keyList[i][j])) {
        p.keys[i] = type;
      }
    }
  }
}

boolean mouse;
void mousePressed() {
  mouse = true;
}

void mouseReleased() {
  mouse = false;
}
