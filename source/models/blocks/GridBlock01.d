module models.blocks.GridBlock01;

import raylib;

import models.block;

class GridBlock01 : Block
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

        DrawLineEx(Vector2(drawX+thickness/2, drawY), Vector2(drawX+thickness/2, drawY + size), thickness, Colors.WHITE);
        DrawLineEx(Vector2(drawX+size-thickness/2, drawY), Vector2(drawX+size-thickness/2, drawY + size), thickness, Colors.WHITE);

        DrawLineEx(Vector2(drawX, drawY+thickness/2), Vector2(drawX + size, drawY+thickness/2), thickness, Colors.WHITE);
        DrawLineEx(Vector2(drawX, drawY + size - thickness/2), Vector2(drawX + size, drawY + size - thickness/2), thickness, Colors.WHITE);
    }
}