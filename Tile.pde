ArrayList<Tile> tiles;

class Tile {
  float x;
  float y;
  float size = 28;
  int type;
  Tile(float x, float y, int type) {
    this.type = type;
    this.x = x;
    this.y = y;
  }
  void update() {
    this.display();
  }

  void display() {
    rectMode(CENTER);
    if (type == 1)fill(100, 0, 100);
    else if (type == 2){fill(255,0,0);}
    rect(x, y, size, size);
  }
}

void createTile(float x, float y, int type) {
  Tile tile = new Tile(x, y, type);
  tiles.add(tile);
}
