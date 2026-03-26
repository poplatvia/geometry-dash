module models.level_object;

import models.player;

abstract class LevelObject {
    int x, y;

    this(int x, int y) {
        this.x = x;
        this.y = y;
    }

    abstract void update(ref Player player);
    abstract void draw(int camera, int cameraY);
}