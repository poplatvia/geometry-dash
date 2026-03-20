module models.block;

import raylib;

import models.level_object;
import models.player;

class Block : LevelObject
{
    int size;
    this(int x, int y)
    {
        this.size = 120;
        super(x, y);
    }
    override void update(ref PlayerCube player)
    {
        // nothing for now
    }

    override void draw(int cameraX)
    {
        DrawRectangle(x - cameraX - size/2, y - size/2, size, size, Colors.BLACK);
    }
}