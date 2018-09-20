ArrayList<Tile> tiles;

class Tile {
  float x;
  float y;
  float size = 20;
  Tile(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void update() {
    this.display();
  }

  void display() {
    rectMode(CENTER);
    fill(100, 0, 100);
    rect(x, y, size, size);
  }
}

void createTile(float x, float y) {
  Tile tile = new Tile(x, y);
  tiles.add(tile);
}
