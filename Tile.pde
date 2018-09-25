ArrayList<Tile> tiles;

int tileSize = 28;
class Tile {
  float x;
  float y;
  float size = tileSize;
  int type;
  Tile(float x, float y, int type) {
    this.type = type;
    this.x = x;
    this.y = y;
  }

  void display() {
    float temp = 0;
    if (!editing)
      rectMode(CENTER);
    else {
      rectMode(CORNER);
      temp = 1;
    }
    if (type == 1)fill(100, 0, 100);
    else if (type == 2) {
      fill(255, 0, 0);
    }
    rect((x-CX-temp*tileSize)*SM, (y-CY-temp*tileSize)*SM, size*SM, size*SM);
  }
}

void createTile(int x, int y, int type) {
  Tile tile = new Tile(x*tileSize, y*tileSize, type);
  tiles.add(tile);
}
