
//EDITOR VARIABLES
int numTileTypes = 0;
int[][] tileTypes = {{0, 1, 2, 3}, {5, 6, 7, 8}, {11, 12, 13, -1}};
int[] tileTypeSelected = {0, 0};
boolean selectingTile = false;
boolean editing = false;
boolean changingSettings = false;


void editEnd() {
  p = new Player(spawnX, spawnY);
  t = 0;
  selectingTile = false;
}

void edit() {
  if (p.keys[17]) {
    p.keys[17] = false;
    selectingTile = !selectingTile;
    if (selectingTile) {
      choosingFile = false;
      changingSettings = false;
    }
  }


  if (!selectingTile && !choosingFile) { //Show placement
    int x = int(((mouseX)/SM+CX)/tileSize)+1;
    int y = int(((mouseY)/SM+CY)/tileSize)+1;
    int type = (tileTypeSelected[0])*4+tileTypeSelected[1]-1;
    fill(0, 0, 0, 0);
    if (type == 1)fill(100, 0, 100, 150);
    else if (type == 2) {
      fill(255, 0, 0, 150);
    }
    rectMode(CORNER);
    rect(((x-1)*tileSize-CX)*SM, ((y-1)*tileSize-CY)*SM, tileSize*SM, tileSize*SM);

    if (mouse) { //Place tile
      placeBlock(x, y, type);
    }
  }
  if (p.keys[7]) {
    p.keys[7] = false;
    changingSettings = !changingSettings;
    if (changingSettings) {
      choosingFile = false;
      selectingTile = false;
    }
  }
  stroke(0);
  for (int i = 0; i < mapwidth; i++) {
    line((i*tileSize-CX)*SM, -CY*SM, (i*tileSize-CX)*SM, (tileSize*mapheight-CY)*SM);
  }
  for (int i = 0; i < mapheight; i++) {
    line(-CX*SM, (i*tileSize-CY)*SM, (tileSize*mapwidth-CX)*SM, (i*tileSize-CY)*SM);
  }
  noStroke();
  if (mouse) {
  }
  if (selectingTile) {
    selectTile();
  }
  if (changingSettings) {
    changingSettings();
  }
}

void selectTile() {
  rectMode(CENTER);
  fill(100);
  rect(width/2, height/2, width*3/4, height*3/4); // Backround Box

  fill(200);
  rect(width/3, height*1/16, width/8, height/16); // Save Box
  fill(0);
  textAlign(CENTER);
  text("Save", width/3, height*1/16);
  if (collisionBox(width/3, height*1/16, width/8, height/16, mouseX, mouseY) && mouse) {
    selectingTile = false;
    mouse = false;
    saveMap("maps/"+filenames2[currmap[0]][currmap[1]]);
  }

  fill(200);
  rect(width*2/3, height*1/16, width/8, height/16); // Save As Box
  fill(0);
  text("Save As:", width*2/3, height*1/16);
  if (typing != 0) {
    fill(100);
    rect(width*5/6, height*1/16, width/8+2, height/16+2); // Save As Box 2
    fill(200);
    rect(width*5/6, height*1/16, width/8, height/16); // Save As Box 3
    fill(0);
    text(text[0], width*5/6, height*1/16);
  }
  if (collisionBox(width*2/3, height*1/16, width/8, height/16, mouseX, mouseY) && mouse || typing == 2) {
    if (typing == 0) typing = 1;
    else {
      typing = 0;
      selectingTile = false;
      if (text[0].equals("")) {
        text[0] = "untitled";
      }
      boolean temp = false;
      int copy = 0;
      while (temp == false) {
        temp = true;
        for (int i = 0; i < filenames2.length; i++) {
          for (int j = 0; j < filenames2[0].length; j++) {
            if ((text[0]+str(copy)+".txt").equals(filenames2[i][j])||(copy == 0 && (text[0]+".txt").equals(filenames2[i][j]))) {
              temp = false;
              copy++;
            }
          }
        }
      }
      if (copy >= 1)
        text[0] += str(copy);

      saveMap("maps/"+text[0]+".txt");
      text[0] = "";
      chooseFileInit();
    }
    mouse = false;
  }

  for (int i = 0; i < tileTypes.length; i++) {
    for (int j = 0; j < tileTypes[0].length; j++) {
      if (tileTypes[i][j]!=-1) {
        float x = width*1/4+width*1/6*j;
        float y = height*1/4+width*1/6*i;
        float xsize = width*1/8;
        float ysize = height*1/8;
        rectMode(CENTER);
        if (tileTypeSelected[0] == i && tileTypeSelected[1] == j) {
          fill(color(tileTypes[i][j]*20, 0, 205));
          rect(x, y, xsize+width/32, ysize+height/32);
        }
        fill(color(tileTypes[i][j]*20+50, 50, 255));
        rect(x, y, xsize, ysize);
        if (p.keys[0] && tileTypeSelected[0] > 0) {
          p.keys[0] = false;
          tileTypeSelected[0] -=1;
        } else if (p.keys[1] && tileTypeSelected[0] < tileTypes.length-1 && (tileTypeSelected[0]+1)*4+tileTypeSelected[1] < numTileTypes) {
          p.keys[1] = false;
          tileTypeSelected[0] +=1;
        } else if (p.keys[2] && tileTypeSelected[1] > 0) {
          p.keys[2] = false;
          tileTypeSelected[1] -=1;
        } else if (p.keys[3] && tileTypeSelected[1] < tileTypes[0].length-1&& (tileTypeSelected[0])*4+tileTypeSelected[1]+1 < numTileTypes) {
          p.keys[3] = false;
          tileTypeSelected[1] +=1;
        }

        if (collisionBox(x, y, xsize, ysize, mouseX, mouseY) && mouse) {
          tileTypeSelected[0] = i;
          tileTypeSelected[1] = j;
          mouse = false;
        }
      }
    }
  }
}

void changingSettings() {
  rectMode(CENTER);
  fill(100);
  rect(width/2, height/2, width*3/4, height*3/4); // Backround Box

  fill(200);
  rect(width/3, height*3/16, width/8, height/16); // Save Box
  fill(0);
  textAlign(CENTER);
  text("Width", width/3, height*3/16);
  if (collisionBox(width/3, height*3/16, width/8, height/16, mouseX, mouseY) && mouse) {
    mouse = false;
    typing = 3;
  }
  if (typing == 3) {
    fill(100);
    rect(width*8/16, height*3/16, width/8+2, height/16+2); // Save As Box 2
    fill(200);
    rect(width*8/16, height*3/16, width/8, height/16); // Save As Box 3
    fill(0);
    text(text[1], width*8/16, height*3/16);
    println(text[1]);
  } else if (typing == 4) {
    fill(255, 0, 0, 150);
    mapwidth = int(text[1]);
    typing = 0;
  }
}
