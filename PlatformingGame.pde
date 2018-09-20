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
void setup() {
  
  size(800, 800);
  startGame();
}

void startGame() {
  p = new Player(200, 200);
  tiles = new ArrayList<Tile>();
  createTile(100, 100);
  createTile(120, 100);
  createTile(140, 100);
  createTile(160, 100);
  createTile(180, 100);
  createTile(100, 80);
  createTile(200, 100);
  createTile(220, 100);
  createTile(240, 100);
  createTile(260, 100);
  createTile(280, 100);
  createTile(200, 80);
}

void draw() {
  background(255);
  p.update();
  for (int i = tiles.size()-1; i >= 0; i--) {
    Tile tile = tiles.get(i);
    tile.update();
  }
}
