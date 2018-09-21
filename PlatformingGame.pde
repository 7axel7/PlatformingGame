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
  p = new Player(128, 200);
  tiles = new ArrayList<Tile>();
  for (int j = 0; j < 4; j++) {
    for (int i = 0; i < 20; i++) {
      createTile(100 + 28*i, 300+6*28*j, 1);
      if (i % 4 == 0) 
        createTile(100 + 28*i, 300-28+6*28*j, 1);
      if (i % 16 == 0) {
        createTile(100 + 28*i, 300-28*2+6*28*j, 1);
        createTile(100 + 28*i, 300-28*4+6*28*j, 2);
      }
    }
  }
}

void draw() {
  background(255);
  p.update();
  for (int i = tiles.size()-1; i >= 0; i--) {
    Tile tile = tiles.get(i);
    tile.update();
  }
  //println(frameRate);
}
