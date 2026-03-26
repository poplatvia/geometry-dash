module models.orb;

import raylib;
import models.player;
import models.level_object;

import std.math;


class Orb : LevelObject
{
    int radius;
    
    this(int x, int y, int radius)
    {
        super(x, y);
        this.radius = radius;
    }

    bool isNear(ref PlayerCube player)
    {
        int dx = cast (int) (player.worldX - x);
        int dy = cast (int) (player.y - y);
        int dist = cast(int)(sqrt(cast(float)(dx*dx + dy*dy)));
        return dist < radius + player.size / 2;
    }

    void onTouch(ref PlayerCube player) {}

    // Check proximity and apply effect if space pressed
    override void update(ref PlayerCube player)
    {
        if (isNear(player) && IsKeyPressed(KeyboardKey.KEY_SPACE))
            onTouch(player);
    }

    override void draw(int cameraX, int cameraY)
    {
        DrawCircle(x - cameraX, y - cameraY, radius, Colors.GRAY);
    }
}

class YellowOrb : Orb
{
    this(int x, int y, int radius) { super(x, y, radius); }

    override void onTouch(ref PlayerCube player)
    {
        player.velocityY = -15 * player.gravityDirection;
        player.isOnGround = false;
    }

    override void draw(int cameraX, int cameraY)
    {
        DrawRing(Vector2(x - cameraX, y - cameraY), 50, 55, 0, 360, 16, Colors.WHITE);
        DrawRing(Vector2(x - cameraX, y - cameraY), 35, 40, 0, 360, 16, Colors.WHITE);
        DrawCircle(x - cameraX, y - cameraY, 35, Colors.YELLOW);
    }
}

class PurpleOrb : Orb
{
	this(int x, int y, int radius) { super(x, y, radius); }

	override void onTouch(ref PlayerCube player)
	{
		player.velocityY = -5 * player.gravityDirection; // Weaker jump
	}

	override void draw(int cameraX, int cameraY)
	{
        DrawRing(Vector2(x - cameraX, y - cameraY), 50, 55, 0, 360, 16, Colors.WHITE);
        DrawRing(Vector2(x - cameraX, y - cameraY), 30, 35, 0, 360, 16, Colors.WHITE);
        DrawCircle(x - cameraX, y - cameraY, 30, Colors.PURPLE);
	}
}

class BlackOrb : Orb
{
	this(int x, int y, int radius) { super(x, y, radius); }

	override void onTouch(ref PlayerCube player)
	{
		player.velocityY = 100 * player.gravityDirection;
	}

	override void draw(int cameraX, int cameraY)
    {
        DrawRing(Vector2(x - cameraX, y - cameraY), 50, 55, 0, 360, 16, Colors.WHITE);
        DrawRing(Vector2(x - cameraX, y - cameraY), 35, 40, 0, 360, 16, Colors.WHITE);
        DrawCircle(x - cameraX, y - cameraY, 35, Colors.BLACK);
    }
}

class RedOrb : Orb
{
	this(int x, int y, int radius) { super(x, y, radius); }

	override void onTouch(ref PlayerCube player)
	{
		player.velocityY = -25 * player.gravityDirection; // Stronger jump
	}

	override void draw(int cameraX, int cameraY)
	{
        DrawRing(Vector2(x - cameraX, y - cameraY), 50, 55, 0, 360, 16, Colors.WHITE);
        DrawRing(Vector2(x - cameraX, y - cameraY), 45, 40, 0, 360, 16, Colors.WHITE);
        DrawCircle(x - cameraX, y - cameraY, 40, Colors.ORANGE);
	}
}