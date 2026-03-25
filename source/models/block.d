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
        // if touching the top of the block, on ground and reset velocity
        int playerLeft = cast (int) (player.worldX - player.size / 2);
        int playerRight = cast (int) (player.worldX + player.size / 2);
        int playerTop = cast (int) (player.y - player.size / 2);
        int playerBottom = cast (int) (player.y + player.size / 2);

        int blockLeft = x - size / 2;
        int blockRight = x + size / 2;
        int blockTop = y - size / 2;
        int blockBottom = y + size / 2;

        if (playerBottom > blockTop && playerTop < blockBottom && playerRight > blockLeft && playerLeft < blockRight)
        {
            player.y = blockTop - player.size / 2;
            player.velocityY = 0;
            player.isOnGround = true;
            player.snap();
        }
    }

    override void draw(int cameraX)
    {
        // transform 110 pixels down
        DrawRectangleCentered(x - cameraX, y, size, size, Colors.BLACK);
    }
}