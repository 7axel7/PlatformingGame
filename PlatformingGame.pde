/* Platforming Game
 * By Alex Eliasmith
 *
 * Feature goals:
 * Level Editor
 *
 *
 *
 */


Player p;
int mapwidth = 40;
int mapheight = 40;

//                t,   x     ,y   ,dy,jumps
float[][] state = {{0, -100, -100, 0, 0}, 
  {0, -100, -100, 0, 0}, 
  {0, -100, -100, 0, 0}};

float[] xRec = {-100};
float[] yRec = {-100};
float cloneX;
float cloneY;
boolean recording = false;

boolean tasMaster = true;
boolean choosingFile = false;
boolean pause = false;
boolean frameSkip = false;
int gameSpeed = 1;
int t;

int[][] map;
String[] filenames;

void setup() {
  size(800, 800);
  startGame();
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

void chooseFileInit() {
  println("Listing all filenames in a directory: ");
  String path = sketchPath()+ "/maps";
  filenames = listFileNames(path);
  printArray(filenames);
}

void chooseFile() {
  fill(100);
  rect(width/2, height/2, width*3/4, height*3/4);
  for (int i = 0; i < filenames.length; i++) {
    fill(200);
    float x = width*1/4+width*1/8*i;
    float y = height*1/4;
    rectMode(CENTER);
    rect(x, y, width*1/12, height*1/12);
    fill(0);
    textAlign(CENTER);
    text(filenames[i], x, y);
  }
}

void startGame() {
  p = new Player(128, 200);
  tiles = new ArrayList<Tile>();
  for (int j = 0; j < 4; j++) {
    for (int i = 0; i < 20; i++) {
      createTile(3 + i, 10+6*j, 1);
      if (i % 4 == 0) 
        createTile(3+i, 10-1+6*j, 1);
      if (i % 16 == 0) {
        createTile(3+i, 10-2*j, 1);
        createTile(4+i, 10-4+6*j, 2);
      }
    }
  }
}

void draw() {
  t++;
  background(255);
  if (tasMaster) tasUpdate();
  if (t%gameSpeed == 0 && !pause || frameSkip) {
    if (tasMaster) tasUpdate2();
    frameSkip = false;
    updateMovement();
    if (gameSpeed != 1) {
    }
  }


  updateScreen();
  if (p.keys[4]) {
    p.keys[4] = false;
    choosingFile = !choosingFile;
    if (choosingFile) {
      chooseFileInit();
    }
  }
  if (choosingFile) {
    chooseFile();
  }
  //println(frameRate);
}

void updateMovement() {
  p.move();
}
void updateScreen() {
  p.display();
  for (int i = tiles.size()-1; i >= 0; i--) {
    Tile tile = tiles.get(i);
    tile.display();
  }
}

void tasUpdate() {
  if (p.keys[5]) {
    p.keys[5] = false;
    pause = !pause;
  }
  if (p.keys[6]) { 
    p.keys[6] = false;
    frameSkip = true;
  }
  for (int i = 0; i < 3; i++) {
    fill(80*i, 200, 70+255-80*i);
    rect(state[i][1], state[i][2], p.size/2, p.size/2);
    rectMode(CENTER);
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
  if (p.keys[16] && gameSpeed < 20) {
    p.keys[16] = false;

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
