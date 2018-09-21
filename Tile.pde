ArrayList<Tile> tiles;

float tileSize = 28;
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
    rectMode(CENTER);
    if (type == 1)fill(100, 0, 100);
    else if (type == 2){fill(255,0,0);}
    rect(x, y, size, size);
  }
}

void createTile(int x, int y, int type) {
  Tile tile = new Tile(x*tileSize, y*tileSize, type);
  tiles.add(tile);
}
