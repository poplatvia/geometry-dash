module models.blocks.GridBlock08;

import raylib;

import models.block;

class GridBlock08 : Block
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

        DrawLineEx(Vector2(drawX+thickness/2, drawY), Vector2(drawX+thickness/2, drawY + size), thickness, Colors.WHITE);
        DrawLineEx(Vector2(drawX+size-thickness/2, drawY), Vector2(drawX+size-thickness/2, drawY + size), thickness, Colors.WHITE);
    }
}