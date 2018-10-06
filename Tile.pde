ArrayList<Tile> tiles;
boolean active = false;

int tileSize = 28;
class Tile {
  boolean pressed = false;
  int rotation = 0;
  float x;
  float y;
  float drawx;
  float drawy;
  float xsize = tileSize;
  float ysize = tileSize;
  int type;

  Tile(float x, float y, int type, int rotation) {
    this.type = type;
    this.x = x;
    this.y = y;
    this.rotation = rotation;
    this.drawx = x;
    this.drawy = y;
    if (type == 3) {
      if (rotation == 0) {
        drawy = (y+tileSize*2/5);
        ysize = ceil(tileSize*1/5+1);
      }
      if (rotation == 1) {
        drawx = (x+tileSize*2/5);
        xsize = ceil(tileSize*1/5);
      }
      if (rotation == 2) {
        drawy = (y-tileSize*2/5);
        ysize = ceil(tileSize*1/5);
      }
      if (rotation == 3) {
        drawx = (x-tileSize*2/5);
        xsize = ceil(tileSize*1/5);
      }
    } else if (type == 4 || type == 5) {
      xsize = ceil(tileSize/2);
      ysize = ceil(tileSize/2);
    }
  }

  void display() {
    float temp = 0;
    rectMode(CENTER);
    if (editing)
      temp = 0.5;

    if (type == 1) {
      fill(0, 0, 0);
    } else if (type == 2) {
      fill(255, 0, 0);
    } else if (type == 3) {
      fill(100, 255, 100);
    }
    if (type == 4) {
      if (active) fill(0, 0, 0);
      else fill(255, 0, 0);
    }
    if (type == 5) {
      if (active) fill(255, 0, 0);
      else fill(0, 0, 0);
    }
    if (type == 4 || type == 5) {
      if (active == pressed) {
        if (active && type == 4 || !active && type == 5) {
          placeBlock(int(x/tileSize), int(y/tileSize), 2 ,false);
        } else {
          placeBlock(int(x/tileSize), int(y/tileSize), 1 ,false);
        }
        if (active) pressed = false;
        else pressed = true;
      }
    }
    rect((drawx-CX-temp*tileSize)*SM, (drawy-CY-temp*tileSize)*SM, xsize*SM, ysize*SM);
  }

  void detect() {
    if (type==3) {
      if (drawx+xsize/2 > p.x-p.size/2 && drawx-xsize/2 < p.x+p.size/2
        && drawy+ysize/2 > p.y-p.size/2 && drawy-ysize/2 < p.y+p.size/2) {
        if (pressed == false) {
          pressed = true;
          active = !active;
        }
      } else if (pressed == true) {
        pressed = false;
      }
    }
  }
}



void createTile(int x, int y, int type, boolean deleting,int rotation) {
  if (-1 <= type && type <= 10) {
    for (int i = tiles.size()-1; i >= 0; i--) {
      if (int(tiles.get(i).x/tileSize)==x&&int(tiles.get(i).y/tileSize)==y) {
        if (!(!deleting && (tiles.get(i).type == 4 || tiles.get(i).type == 5)))
        tiles.remove(i);
      }
    }
  }
  if (1 <= type && type <= 10) {
    Tile tile = new Tile(x*tileSize, y*tileSize, type, rotation);
    tiles.add(tile);
  }
}

void placeBlock(int x, int y, int type) {
  placeBlock(x,y,type,true,0);
}
void placeBlock(int x, int y, int type, boolean deleting) {
  placeBlock(x,y,type,deleting,0);
}

void placeBlock(int x, int y, int type, boolean deleting, int rotation) {
  if (x > 0 && x < mapwidth+1 && y > 0 && y < mapheight+1) {
    createTile(x, y, type,deleting,rotation);
  }
  if (type < 10) {
    if (y == 1) {
      createTile(x, mapheight+1, type,deleting,rotation);
      if (x == mapwidth) {
        createTile(0, mapheight+1, type,deleting,rotation);
      }
    } 
    if (x == mapwidth) {
      createTile(0, y, type,deleting,rotation);
      if (y == mapheight) {
        createTile(x, 0, type,deleting,rotation);
        createTile(0, 0, type,deleting,rotation);
      }
    } else if (y == mapheight) {
      createTile(x, 0, type,deleting,rotation);
    }
    if (y ==  mapheight-1) {
      createTile(x, -1, type,deleting,rotation);
      if (x == mapwidth) {
        createTile(0, -1, type,deleting,rotation);
      }
    }
  }
}
