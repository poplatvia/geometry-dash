module models.blocks.GridBlock02;

import raylib;

import models.block;

class GridBlock02 : Block
{
    this(int x, int y)
    {
        super(x, y);
    }

    override void draw(int cameraX, int cameraY)
    {
        int drawX = x - cameraX - size / 2;
        int drawY = y + cameraY - size / 2;

        int thickness = 6;

        DrawRectangle(drawX, drawY, size, size, Colors.BLACK);
        
        DrawLineEx(Vector2(drawX, drawY+thickness/2), Vector2(drawX + size, drawY+thickness/2), thickness, Colors.WHITE);
    }
}