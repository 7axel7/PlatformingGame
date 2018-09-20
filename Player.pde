class Player {
  float x;
  float y;
  float dy;
  float speed = 2;
  float jumpheight = 8;
  float size = 14;
  float gravity = 0.6;
  int maxjumps = 2;
  int jumps = 0;
  float maxfallspeed = 10;
  boolean grounded = false;
  boolean[] keys = new boolean[16];
  Player(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    this.move();
    this.display();
  }

  void display() {
    rectMode(CENTER);
    fill(100, 0, 0);

    rect(x, y, size, size);
  }
  void move() {
    float newx = x;
    if (keys[2]) {
      newx-=speed;
    }
    if (keys[3]) {
      newx+=speed;
    }
    if (collision(newx, y, size) != true) {
      this.x = newx;
    }

    float newy = y;

    if (keys[0] && jumps > 0) {
      jumps -= 1;
      keys[0] = false;
      dy=-jumpheight;
    }
    dy += gravity;
    if (dy > maxfallspeed) dy = maxfallspeed;
    newy += dy;
    if (collision(x, newy, size)) {// collides with wall
      float safey = y;
      for (int i = 0; i < sqrt(dy); i++) {
        if (collision(x, (safey+newy)/2, size)) {
          newy = (safey+newy)/2;
        } else safey = (safey+newy)/2;
      }
      newy = safey;
      dy = 0;
    }
    this.y = newy;
    if (x > mapwidth*20) x = 0;
    else if (x < 0) x = mapwidth*20;
    if (y > mapheight*20) y = 0;
    else if (y < 0) y = mapheight*20;
    if (grounded) {
      jumps = maxjumps;
    }
    grounded = false;
  }
}

boolean collision(float x, float y, float size) {
  for (int i = tiles.size()-1; i >=0; i--) {
    Tile tile = tiles.get(i);
    if (tile.x+tile.size/2 > x-size/2 && tile.x-tile.size/2 < x+size/2
      && tile.y+tile.size/2 > y-size/2 && tile.y-tile.size/2 < y+size/2)
      return true;
  }
  return false;
}
