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
    if (-1 <= type && type <= 2) {
        for (int i = tiles.size()-1; i >= 0; i--) {
            if (int(tiles.get(i).x/tileSize)==x&&int(tiles.get(i).y/tileSize)==y) {
                tiles.remove(i);
            }
        }
    }
    if (1 <= type && type <= 2) {
        Tile tile = new Tile(x*tileSize, y*tileSize, type);
        tiles.add(tile);
    }
}

void placeBlock(int x, int y, int type) {
    if (x > 0 && x < mapwidth+1 && y > 0 && y < mapheight+1) {
        createTile(x, y, type);
    }

    if (y == 1 && type < 2) {
        createTile(x, mapheight+1, type);
        if (x == mapwidth) {
            createTile(0, mapheight+1, type);
        }
    } 
    if (x == mapwidth) {
        createTile(0, y, type);
        if (y == mapheight) {
            createTile(x, 0, type);
            createTile(0, 0, type);
        }
    } else if (y == mapheight) {
        createTile(x, 0, type);
    }
    if (y ==  mapheight-1 && type == 1) {
        createTile(x, -1, type);
    }
}
