class Player {
  color pcolor = color(100, 100, 255);
  float x;
  float y;
  float spawnx;
  float spawny;
  float dy;
  float speed = 4; //multiple of tile size
  float jumpheight = 10.5;
  float size = 18;
  float gravity = 0.5;
  int maxjumps = 2;
  int jumps = 0;
  float maxfallspeed = 8;
  boolean grounded = false;
  boolean lastgrounded = false;
  boolean[] keys = new boolean[32];
  Player(float x, float y) {
    this.x = x;
    this.y = y;
    spawnx = x;
    spawny = y;
  }

  void effect(int type) {
    if (type == 2) death();
  }

  void death() {
    x = spawnx;
    y = spawny;
    jumps = maxjumps-1;
    dy = 0;
  }

  void display() {
    if (tasMaster) {
      fill(pcolor);
      rect((cloneX-CX)*SM, (cloneY-CY)*SM, p.size*SM, p.size*SM);
      rectMode(CENTER);
    }


    rect((x-CX)*SM, (y-CY)*SM, size*SM, size*SM);
  }
  void move() {
    float newx = x;
    if (keys[2]&& !choosingFile) {
      newx-=speed;
    }
    if (keys[3]&& !choosingFile) {
      newx+=speed;
    }
    int tiletouch = collision(newx, y, size);
    if (tiletouch > 1) {
      effect(tiletouch);
      newx = x;
    }
    if (tiletouch == 0) {
      this.x = newx;
    }

    float newy = y;

    if (keys[0] && jumps > 0&& !choosingFile) {
      if (grounded!= true) jumps -=1;
      keys[0] = false;
      dy=-jumpheight;
    }
    dy += gravity;


    grounded = false;
    if (dy > maxfallspeed) dy = maxfallspeed;
    newy += dy;
    tiletouch = collision(x, newy, size);
    if (tiletouch > 1) { 
      effect(tiletouch);
      newy = y;
    } else if (tiletouch == 1) {// collides with wall
      if (dy > 0) grounded = true;
      float safey = y;
      for (int i = 0; i < sqrt(abs(dy))+1; i++) {
        if (collision(x, (safey+newy)/2, size) == 1) {
          newy = (safey+newy)/2;
        } else safey = (safey+newy)/2;
      }
      newy = round(safey);
      dy = 0;
    }
    if (grounded) {
      jumps = maxjumps;
    } else if (lastgrounded) jumps -=1;
    lastgrounded = grounded;
    this.y = newy;
    if (x > mapwidth*20) x -= mapwidth*20;
    else if (x < 0) x += mapwidth*20;
    if (y > mapheight*20) y -= mapheight*20;
    else if (y < 0) y += mapheight*20;
  }
}

int collision(float x, float y, float size) {
  int type = 0;
  for (int i = tiles.size()-1; i >=0; i--) {
    Tile tile = tiles.get(i);
    if (tile.x+tile.size/2 > x-size/2 && tile.x-tile.size/2 < x+size/2
      && tile.y+tile.size/2 > y-size/2 && tile.y-tile.size/2 < y+size/2)
      if (type < tile.type)
        type = tile.type;
  }
  return type;
}
