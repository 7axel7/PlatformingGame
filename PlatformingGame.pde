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
int t;
float SM = 0.1;
float CX = 0;
float CY = 0;

void setup() {
  for (int i = 0; i < tileTypes.length; i++) {
    for (int j = 0; j < tileTypes[0].length; j++) {
      if (tileTypes[i][j]!= -1) numTileTypes++;
    }
  }
  surface.setResizable(true);
  size(700, 700);
  startGame();
}

void startGame() {
  SM = (float) min(width, height)/784*(1/float(max(mapwidth, mapheight)))*tileSize;
  textSize = int(0.01*min(width, height));
  p = new Player(spawnX, spawnY);
  tiles = new ArrayList<Tile>();
  choosingFile = false;
  noStroke();
  //                     t,   x,   y,  dy,jumps
  state = new float[][]{{0, -100, -100, 0, 0}, 
    {0, -100, -100, 0, 0}, 
    {0, -100, -100, 0, 0}};

  xRec = new float[]{-100};
  yRec = new float[]{-100};
  cloneX = -100;
  cloneY = -100;
}

void draw() {
  //println(frameRate);
  t++;
  background(255);
  updateScreen();
  if (p.keys[16]) {
    choosingFile = false;
    if (changingSettings) {
      changingSettingsEnd();
      changingSettings = false;
    }

    p.keys[16] = false;
    editing = !editing;
    pause = false;
    if (editing) {
      pause = true;
    } else editEnd();
  }
  if (editing) {
    edit();
  }
  if (p.keys[4]) {
    p.keys[4] = false;
    choosingFile = !choosingFile;
    if (choosingFile) {
      selectingTile = false;
      chooseFileInit();
    }
  }
  if (choosingFile) {
    chooseFile();
  }
  if (tasMaster&& !editing) tasUpdate();
  if (t%gameSpeed == 0 && !pause || frameSkip) {
    if (tasMaster) tasUpdate2();
    frameSkip = false;
    updateMovement();
    if (gameSpeed != 1) {
    }
  }
}

void updateMovement() {
  p.move();
}
void updateScreen() {
  if (!editing)
    p.display();
  for (int i = tiles.size()-1; i >= 0; i--) {
    Tile tile = tiles.get(i);
    tile.detect();
    tile.display();
  }
}

boolean collisionBox(float x, float y, float xsize, float ysize, float x2, float y2) {
  if (x+xsize/2 > x2 && x-xsize/2 < x2
    && y+ysize/2 > y2 && y-ysize/2 < y2)
    return true;
  return false;
}
