module models.blocks.GridBlock04;

import raylib;

import models.block;

class GridBlock04 : Block
{
    this(int x, int y)
    {
        super(x, y);
    }

    override void draw(int cameraX, int cameraY)
    {
        int drawX = x - cameraX - size / 2;
        int drawY = y + cameraY - size / 2;

        DrawRectangle(drawX, drawY, size, size, Colors.BLACK);
        
        // Draw a very very small rectangle in the upper left corner of the block
        DrawRectangle(drawX, drawY, size/10, size/10, Colors.WHITE);
    }
}