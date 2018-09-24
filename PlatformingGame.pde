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
int mapwidth = 4;
int mapheight = 4;

float spawnX = 1;
float spawnY = 1;
//                t,   x     ,y   ,dy,jumps
float[][] state = {{0, -100, -100, 0, 0}, 
  {0, -100, -100, 0, 0}, 
  {0, -100, -100, 0, 0}};

float[] xRec = {-100};
float[] yRec = {-100};
float cloneX;
float cloneY;
boolean recording = false;

boolean editing = false;
boolean tasMaster = true;
boolean choosingFile = false;
boolean pause = false;
boolean frameSkip = false;
int gameSpeed = 1;
int t;
int[] selectedfile = {0, 0};

int[] selected = {0, 0};
int[][] map;
String[] filenames;
String[][] filenames2;
float SM = 0.1;
float CX = 0;
float CY = 0;

void setup() {
  surface.setResizable(true);
  size(700, 700);
  startGame();
}

void goToMap(int[] selected, String[][] filenames) {
  String fileName = filenames[selected[0]][selected[1]];
  fileName += ".txt";
  String[] lines = loadStrings("maps/" + fileName);
  if (lines.length==0) return;
  String[] info = lines[0].split(",");
  mapwidth = int(info[0]);
  mapheight = int(info[1]);
  spawnX = int(info[2])*tileSize;
  spawnY = int(info[3])*tileSize;
  startGame();
  for (int i = 1; i < lines.length; i++) {
    String[] currFile = lines[i].split(",");
    if (int(currFile[0]) == 1) {
      createTile(int(currFile[1]), int(currFile[2]), 1);
    }
    if (int(currFile[2]) == 1) {
      createTile(int(currFile[1]), mapheight+1, 1);
    }
    if (int(currFile[2]) ==  mapheight-1) {
      createTile(int(currFile[1]), -1, 1);
    }
    if (int(currFile[1]) == mapwidth) {
      createTile(0, int(currFile[2]), 1);
      if (int(currFile[2]) == mapheight) {
        createTile(int(currFile[1]), 0, 1);
        createTile(0, 0, 1);
      }
    } else if (int(currFile[2]) == mapheight) {
      createTile(int(currFile[1]), 0, 1);
    }
  }
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
  //println("Listing all filenames in a directory: ");
  String path = sketchPath()+ "/maps";
  filenames = listFileNames(path);
  for (int i = 0; i < filenames.length; i ++) {
    filenames[i] = filenames[i].substring(0, filenames[i].length()-4);
  }
  filenames2 = new String[int(filenames.length/5+1)][5];
  for (int i = 0; i < filenames.length; i ++) {
    filenames2[int(i/5)][i%5] = filenames[i];
  }
}

void chooseFile() {
  fill(100);
  rect(width/2, height/2, width*3/4, height*3/4);        
  for (int i = 0; i < filenames2.length; i++) {
    for (int j = 0; j < filenames2[0].length; j++) {
      if (filenames2[i][j]!= null) {
        fill(200);
        if (selected[0] == i && selected[1] == j) {
          fill(150);
        }

        float x = width*1/4+width*1/8*j;
        float y = height*1/4+width*1/8*i;
        float xsize = width*1/12;
        float ysize = height*1/12;
        rectMode(CENTER);
        rect(x, y, xsize, ysize);
        if (p.keys[0] && selected[0] > 0) {
          p.keys[0] = false;
          selected[0] -=1;
        } else if (p.keys[1] && selected[0] < filenames2.length-1 && (selected[0]+1)*5+selected[1] < filenames.length) {
          p.keys[1] = false;
          selected[0] +=1;
        } else if (p.keys[2] && selected[1] > 0) {
          p.keys[2] = false;
          selected[1] -=1;
        } else if (p.keys[3] && selected[1] < filenames2[0].length-1&& (selected[0])*5+selected[1]+1 < filenames.length) {
          p.keys[3] = false;
          selected[1] +=1;
        }
        if (p.keys[6]) {
          p.keys[6] = false;
          goToMap(selected, filenames2);
        }




        if (collisionBox(x, y, xsize, ysize, mouseX, mouseY) && mouse) {
          if (selected[0] == i && selected[1] == j) {
            println(i, j);
          }
          selected[0] = i;
          selected[1] = j;
          mouse = false;
        }

        fill(0);
        textAlign(CENTER);
        text(filenames2[i][j], x, y);
      }
    }
  }
}

void startGame() {
  SM = (float) min(width, height)/784*(1/float(min(mapwidth, mapheight)))*tileSize;
  p = new Player(spawnX, spawnY);
  tiles = new ArrayList<Tile>();
  choosingFile = false;
  noStroke();
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
  if (p.keys[6]&&!choosingFile) { 
    p.keys[6] = false;
    frameSkip = true;
  }
  for (int i = 0; i < 3; i++) {
    fill(80*i, 200, 70+255-80*i);
    rect((state[i][1]-CX)*SM, (state[i][2]-CY)*SM, p.size/2*SM, p.size/2*SM);
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

boolean collisionBox(float x, float y, float xsize, float ysize, float x2, float y2) {
  if (x+xsize/2 > x2 && x-xsize/2 < x2
    && y+ysize/2 > y2 && y-ysize/2 < y2)
    return true;
  return false;
}
