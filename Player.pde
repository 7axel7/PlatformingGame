class Player {
  color pcolor = color(100, 100, 255);
  float x;
  float y;
  float dy;
  float speed = 4; //multiple of tile size
  float jumpheight = 9;
  float size = 18;
  float gravity = 0.425;
  int maxjumps = 2;
  int jumps = 0;
  float maxfallspeed = 7;
  boolean grounded = false;
  boolean lastgrounded = false;
  boolean[] keys = new boolean[32];
  Player(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void effect(int type) {
    if (type == 2) death();
  }

  void death() {
    x = spawnX;
    y = spawnY;
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

    if (x+size > mapwidth*tileSize) {
      rect((x-mapwidth*tileSize-CX)*SM, (y-CY)*SM, size*SM, size*SM);
      if (y+size > mapheight*tileSize) {
        rect((x-mapwidth*tileSize-CX)*SM, (y-mapheight*tileSize-CY)*SM, size*SM, size*SM);
        rect((x-CX)*SM, (y-mapheight*tileSize-CY)*SM, size*SM, size*SM);
      } else if (y-size < 0) {
        rect((x-mapwidth*tileSize-CX)*SM, (y+mapheight*tileSize-CY)*SM, size*SM, size*SM);
        rect((x-CX)*SM, (y+mapheight*tileSize-CY)*SM, size*SM, size*SM);
      }
    } else if (x-size < 0) {
      rect((x+mapwidth*tileSize-CX)*SM, (y-CY)*SM, size*SM, size*SM);
      if (y+size > mapheight*tileSize) {
        rect((x+mapwidth*tileSize-CX)*SM, (y-mapheight*tileSize-CY)*SM, size*SM, size*SM);
        rect((x-CX)*SM, (y-mapheight*tileSize-CY)*SM, size*SM, size*SM);
      } else if (y-size < 0) {
        rect((x+mapwidth*tileSize-CX)*SM, (y+mapheight*tileSize-CY)*SM, size*SM, size*SM);
        rect((x-CX)*SM, (y+mapheight*tileSize-CY)*SM, size*SM, size*SM);
      }
    } else if (y+size > mapheight*tileSize) {
      rect((x-CX)*SM, (y-mapheight*tileSize-CY)*SM, size*SM, size*SM);
    } else if (y-size < 0) {
      rect((x-CX)*SM, (y+mapheight*tileSize-CY)*SM, size*SM, size*SM);
    }
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
    if (x > mapwidth*tileSize) x -= mapwidth*tileSize;
    else if (x < 0) x += mapwidth*tileSize;
    if (y > mapheight*tileSize) y -= mapheight*tileSize;
    else if (y < 0) y += mapheight*tileSize;
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
