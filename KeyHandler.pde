String[][] keyList = new String[][]{{"87", "38"}, {"83", "40"}, {"65", "37"}, {"68", "39"}, {"9"}, {"80"}, {"32"}, {"16"}, {"49"}, {"50"}, {"51"}, {"52"}, {"53"}, {"54"}, {"109", "189"}, {"107", "187"}, {"69"}, {"81"},{"82"}};
int typing = 0;
String[] text = {"", "", ""};

void keyPressed() {
  if (typing == 0)
    keyHandler(str(keyCode), true);
  else {
    int box = int((float) (typing+1)/3);
    if (keyCode == BACKSPACE) {
      if (text[box].length() > 0) {
        text[box] = text[box].substring(0, text[box].length()-1);
      }
    } else if (keyCode == DELETE) {
      text[box] = "";
    } else if (box > 0 && box < 3) {
      if (key == '1'||key == '2' ||key == '3' ||key == '4' ||key == '5' ||key == '6' ||key == '7' ||key == '8' ||key == '9' || key == '0') 
        text[box] = text[box] + key;
    } else if (key != '.' && keyCode != SHIFT && str(keyCode) != "20" && keyCode != ENTER)
      text[box] = text[box] + key;
    if (keyCode == ENTER) {
      typing += 1;
    }
  }
}


void keyReleased() {
  if (typing == 0)
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
