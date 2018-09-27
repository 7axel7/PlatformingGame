
//MAP VARIABLES
int mapwidth = 4;
int mapheight = 4;
float spawnX = 1;
float spawnY = 1;
boolean choosingFile = false;
int[] selectedfile = {0, 0};
int[][] map;
String[] filenames;
String[][] filenames2;

void chooseFile() {
    rectMode(CENTER);
    fill(100);
    rect(width/2, height/2, width*3/4, height*3/4);        
    for (int i = 0; i < filenames2.length; i++) {
        for (int j = 0; j < filenames2[0].length; j++) {
            if (filenames2[i][j]!= null) {
                fill(200);
                if (selected[0] == i && selected[1] == j) {
                    fill(150);
                }

                float x = width*1/4+width*1/8*j;
                float y = height*1/4+width*1/8*i;
                float xsize = width*1/12;
                float ysize = height*1/12;
                rectMode(CENTER);
                rect(x, y, xsize, ysize);
                if (p.keys[0] && selected[0] > 0) {
                    p.keys[0] = false;
                    selected[0] -=1;
                } else if (p.keys[1] && selected[0] < filenames2.length-1 && (selected[0]+1)*5+selected[1] < filenames.length) {
                    p.keys[1] = false;
                    selected[0] +=1;
                } else if (p.keys[2] && selected[1] > 0) {
                    p.keys[2] = false;
                    selected[1] -=1;
                } else if (p.keys[3] && selected[1] < filenames2[0].length-1&& (selected[0])*5+selected[1]+1 < filenames.length) {
                    p.keys[3] = false;
                    selected[1] +=1;
                }
                if (p.keys[6]) {
                    p.keys[6] = false;
                    goToMap(selected, filenames2);
                }

                if (collisionBox(x, y, xsize, ysize, mouseX, mouseY) && mouse) {
                    if (selected[0] == i && selected[1] == j) {
                        goToMap(selected, filenames2);
                    }
                    selected[0] = i;
                    selected[1] = j;
                    mouse = false;
                }

                fill(0);
                textAlign(CENTER);
                text(filenames2[i][j], x, y);
            }
        }
    }
}

void chooseFileInit() {
    //println("Listing all filenames in a directory: ");
    String path = sketchPath()+ "/maps";
    filenames = listFileNames(path);
    for (int i = 0; i < filenames.length; i ++) {
        filenames[i] = filenames[i].substring(0, filenames[i].length()-4);
    }
    filenames2 = new String[int(filenames.length/5+1)][5];
    for (int i = 0; i < filenames.length; i ++) {
        filenames2[int(i/5)][i%5] = filenames[i];
    }
}

String[] listFileNames(String dir) {
    File file = new File(dir);
    if (file.isDirectory()) {
        String names[] = file.list();
        return names;
    } else {
        // If it's not a directory
        return null;
    }
}

void goToMap(int[] selected, String[][] filenames) {
    String fileName = filenames[selected[0]][selected[1]];
    fileName += ".txt";
    String[] lines = loadStrings("maps/" + fileName);
    if (lines.length==0) return;
    String[] info = lines[0].split(",");
    mapwidth = int(info[0]);
    mapheight = int(info[1]);
    spawnX = int(info[2])*tileSize;
    spawnY = int(info[3])*tileSize;
    startGame();
    for (int i = 1; i < lines.length; i++) {
        String[] currFile = lines[i].split(",");
        placeBlock(int(currFile[1]), int(currFile[2]), int(currFile[0]));
    }
}

void saveMap(){

}
