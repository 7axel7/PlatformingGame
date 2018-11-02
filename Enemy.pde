ArrayList<Enemy> Enemies;

class Enemy {
    float x;
    float y;
    float size = 20;
    float loopDuration;
    float[][] path = {{0, 0}, {100, 100}};
    float[] pathDuration;
    int currNode = 0;
    Enemy(float x, float y, int type, int rotation) {
        this.x = x;
        this.y = y;

        //calculate pathduration as percentage of total path
        float[] pathDist = new float[path.length-1];
        for (int i = 0; i < path.length-1; i++) {
            pathDist[i] = 0;
        }
    }
    void display() {
        rect((x-CX)*SM, (y-CY)*SM, size*SM, size*SM);
    }
    void move() {
    }
}
