module models.block;

import raylib;

import models.level_object;
import models.player;

import helpers;

class Block : LevelObject
{
    int size;
    this(int x, int y)
    {
        this.size = 110;
        super(x, y);
    }
    override void update(ref PlayerCube player)
    {
        // nothing for now
    }

    override void draw(int cameraX)
    {
        // transform 110 pixels down
        DrawRectangleCentered(x - cameraX, y, size, size, Colors.BLACK);
    }
}