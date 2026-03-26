module models.blocks.GridBlock07;

import raylib;

import models.block;

class GridBlock07 : Block
{
    this(int x, int y)
    {
        super(x, y);
    }

    override void draw(int cameraX, int cameraY)
    {
        int drawX = x - cameraX - size / 2;
        int drawY = y + cameraY - size / 2;

        //DrawRectangle(drawX, drawY, size, size, Colors.BLACK);

        DrawLineEx(Vector2(drawX, drawY + size / 2), Vector2(drawX + size, drawY + size / 2), 20, Colors.RED);
        DrawLineEx(Vector2(drawX + size / 2, drawY), Vector2(drawX + size / 2, drawY + size), 20, Colors.RED);
        DrawLineEx(Vector2(drawX + size / 4, drawY + size / 4), Vector2(drawX + 3 * size / 4, drawY + 3 * size / 4), 20, Colors.RED);
    }
}