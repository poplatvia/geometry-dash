module models.debug_block;

import raylib;

import models.level_object;
import models.player;

import std.string;

import helpers;

class DebugBlock : LevelObject
{
    int size;
    string id;

    this(int x, int y, string id)
    {
        this.size = 110;
        this.id = id.dup;
        super(x, y);
    }
    override void update(ref PlayerCube player)
    {}

    override void draw(int cameraX, int cameraY)
    {
        // transform 110 pixels down
        DrawRectangleCentered(x - cameraX, y + cameraY, size, size, ColorAlpha(Colors.RED, 0.25));
        // draw id in the middle of the block
        DrawText(id.toStringz, x - cameraX - 10, y + cameraY - 10, 20, Colors.WHITE);
    }
}