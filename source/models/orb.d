module models.orb;

import raylib;
import models.player;

import std.math;


class Orb 
{
    int x, y, radius;

    this(int x, int y, int radius)
    {
        this.x = x; this.y = y; this.radius = radius;
    }

    bool isNear(ref PlayerCube player)
    {
        int dx = cast (int) (player.worldX - x);
        int dy = cast (int) (player.y - y);
        int dist = cast(int)(sqrt(cast(float)(dx*dx + dy*dy)));
        return dist < radius + player.size / 2;
    }

    // Check proximity and apply effect if space pressed
    void update(ref PlayerCube player)
    {
        if (isNear(player) && IsKeyPressed(KeyboardKey.KEY_SPACE))
            onTouch(player);
    }

    void onTouch(ref PlayerCube player) {}
    void draw(int cameraX) {}
}

class YellowOrb : Orb
{
    this(int x, int y, int radius) { super(x, y, radius); }

    override void onTouch(ref PlayerCube player)
    {
        player.velocityY = -15 * player.gravityDirection;
        player.isOnGround = false;
    }

    override void draw(int cameraX)
    {
        DrawCircle(x - cameraX, y, radius, Colors.YELLOW);
    }
}

class PurpleOrb : Orb
{
	this(int x, int y, int radius) { super(x, y, radius); }

	override void onTouch(ref PlayerCube player)
	{
		player.velocityY = -5 * player.gravityDirection; // Weaker jump
	}

	override void draw(int cameraX)
	{
		DrawCircle(x - cameraX, y, radius, Colors.PURPLE);
	}
}

class BlackOrb : Orb
{
	this(int x, int y, int radius) { super(x, y, radius); }

	override void onTouch(ref PlayerCube player)
	{
		player.velocityY = 100 * player.gravityDirection;
	}

	override void draw(int cameraX)
	{
		DrawCircle(x - cameraX, y, radius+radius/4, Colors.WHITE);
		DrawCircle(x - cameraX, y, radius, Colors.BLACK);
	}
}

class RedOrb : Orb
{
	this(int x, int y, int radius) { super(x, y, radius); }

	override void onTouch(ref PlayerCube player)
	{
		player.velocityY = -25 * player.gravityDirection; // Stronger jump
	}

	override void draw(int cameraX)
	{
		DrawCircle(x - cameraX, y, radius, Colors.RED);
	}
}