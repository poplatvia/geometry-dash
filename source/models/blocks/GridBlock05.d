module models.blocks.GridBlock05;

import raylib;

import models.block;
import models.player;

class GridBlock05 : Block
{
    this(int x, int y)
    {
        super(x, y);
    }

    override void update(ref PlayerCube player) {}

    override void draw(int cameraX, int cameraY)
    {
        int drawX = x - cameraX - size / 2;
        int drawY = y + cameraY - size / 2;

        // draw with 75% opacity
        DrawRectangle(drawX, drawY, size, size, ColorAlpha(Colors.BLACK, 0.75));
    }
}