//TAS VARIABLES
boolean tasMaster = true;
float[][] state;
float[] xRec;
float[] yRec;
float cloneX;
float cloneY;
boolean recording = false;
boolean pause = false;
boolean frameSkip = false;
int gameSpeed = 1;


void tasUpdate() {
    if (p.keys[5]) {
        p.keys[5] = false;
        pause = !pause;
    }
    if (p.keys[6]&&!choosingFile) { 
        p.keys[6] = false;
        frameSkip = true;
    }
    for (int i = 0; i < 3; i++) {
        fill(80*i, 200, 70+255-80*i);
        rectMode(CENTER);
        if(!selectingTile && !choosingFile)
        rect((state[i][1]-CX)*SM, (state[i][2]-CY)*SM, p.size/2*SM, p.size/2*SM);
        if (p.keys[11+i]) {
            state[i][0] = t;
            state[i][1] = p.x; 
            state[i][2] = p.y; 
            state[i][3] = p.dy; 
            state[i][4] = p.jumps;
        }
        if (p.keys[8+i]) {
            p.keys[8+i] = false;
            if (state[i][1] != -100) {
                t = int(state[i][0]);
                p.x = state[i][1]; 
                p.y = state[i][2]; 
                p.dy = state[i][3]; 
                p.jumps = int(state[i][4]);
            }
        }
    }
    if (p.keys[15] && gameSpeed > 1) {
        p.keys[15] = false;
        gameSpeed -=1;
    }
    if (p.keys[14] && gameSpeed < 20) {
        p.keys[14] = false;

        gameSpeed +=1;
    }
}


void tasUpdate2() {
    if (p.keys[7]) {
        if (!recording) {
            xRec = new float[0];
            yRec = new float[0];
        }
        recording = true;
        xRec = concat(new float[] {p.x}, xRec);
        yRec = concat(new float[] {p.y}, yRec);
    } else if (xRec.length > 0) {
        recording = false;
        rectMode(CENTER);
        fill(p.pcolor);
        cloneX = xRec[xRec.length-1];
        cloneY = yRec[yRec.length-1];
        xRec = shorten(xRec);
        yRec = shorten(yRec);
    }
}
