String[][] keyList = new String[][]{{"87", "38"}, {"83", "40"}, {"65", "37"}, {"68", "39"}, {"9"}, {"80"}, {"32"}, {"16"}, {"49"}, {"50"}, {"51"}, {"52"}, {"53"}, {"54"}, {"109", "189"}, {"107", "187"}, {"69"}};
int typing = 0;
String text = "";

void keyPressed() {
    if (typing == 0)
        keyHandler(str(keyCode), true);
    else {
        if (keyCode == BACKSPACE) {
            if (text.length() > 0) {
                text = text.substring(0, text.length()-1);
            }
        } else if (keyCode == DELETE) {
            text = "";
        } else if (keyCode == ENTER) {
            typing = 2;
        } else if (key != '.'&&keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && text.length() <= 10) {
            text = text + key;
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
