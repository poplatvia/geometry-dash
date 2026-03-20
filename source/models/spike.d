module models.spike;

import raylib;

import models.level_object;
import models.player;

class Spike : LevelObject
{
    int size;
    this(int x, int y)
    {
        this.size = 120;
        super(x, y);
    }
    override void update(ref PlayerCube player)
    {
        // Hitbox will be MUCH smaller than the actual spike for better gameplay
        int playerLeft = cast (int) (player.worldX - player.size / 2);
        int playerRight = cast (int) (player.worldX + player.size / 2);
        int playerTop = cast (int) (player.y - player.size / 2);
        int playerBottom = cast (int) (player.y + player.size / 2);

        int spikeLeft = x - size/4;
        int spikeRight = x + size/4;
        int spikeTop = y - size/4;
        int spikeBottom = y + size/4;

        if (playerRight > spikeLeft && playerLeft < spikeRight &&
            playerBottom > spikeTop && playerTop < spikeBottom)
        {
            // Collision detected, reset player position
            player.worldX = 0;
            player.y = 200;
            player.velocityY = 0;
            player.isOnGround = true;
        }
    }

    override void draw(int cameraX)
    {
        DrawTriangle(
            Vector2((x - cameraX) - size, y + size),
            Vector2((x - cameraX) + size, y + size),
            Vector2((x - cameraX), y - size),
            Colors.GRAY
        );
    }
}