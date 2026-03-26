module models.player;

import raylib;
import helpers;

import std.conv;

import models.ground;

enum Mode {
	Cube,
	Ship,
	Wave
}

// Similar to geometry dash cube
public class PlayerCube 
{
	int x;
	int y;
	int size;
	float velocityY;
	int rotation;
	bool isOnGround;
	int gravityDirection = 1; // 1 for normal gravity, -1 for reversed
	int speed = 700; // Horizontal speed in pixels per second
	float worldX; // Player's position in the world
	float worldY; // Player's position in the world
	Mode mode;

	this() 
	{
		this.x = 710; // dynamically calculate this later based on screen size
		this.worldX = -500; // dynamically calculate this later based on screen size
		this.worldY = 0;
		this.y = 500;
		this.size = 110; // dynamically calculate this later based on screen size
		this.velocityY = 0;
		this.isOnGround = false;
		mode = Mode.Cube;
	}

	void snap() 
	{
		rotation = (rotation + 45) / 90 * 90;
	}

	void update(Ground ground)
	{
		velocityY += gravityDirection * 1.64;
		y += to!int(velocityY);

		if (!isOnGround)
			rotation += 5 * gravityDirection;

		int floorY = ground.groundY() - size / 2;
		int ceilY  = size / 2 - 10000;

		if (y >= floorY)
		{
			y = floorY;
			velocityY = 0;
			if (gravityDirection == 1)
			{
				isOnGround = true;
			}
			snap();
		}
		if (y <= ceilY)
		{
			y = ceilY;
			velocityY = 0;
			if (gravityDirection == -1)
			{
				isOnGround = true;
			}
			snap();
		}

		if (IsKeyDown(KeyboardKey.KEY_SPACE))
			jump();
	}

	void jump()
	{
		switch (mode)
		{
			case Mode.Cube:
				if (isOnGround)
				{
					velocityY = -32 * gravityDirection; // Jump strength
					isOnGround = false;
				}
				break;
			case Mode.Ship:
				velocityY = -15 * gravityDirection;
				isOnGround = false;
				break;
			case Mode.Wave:
				velocityY = -10 * gravityDirection;
				isOnGround = false;
				break;
			default:
				break;
		}
	}

	void draw()
	{
		switch (mode)
		{
			case Mode.Cube:
				float r = cast(float)rotation;
				Vector2 origin = Vector2(size / 2.0f, size / 2.0f);

				DrawRectanglePro(
					Rectangle(x, y+worldY, size, size),
					origin,  // pivot point (center)
					r,
					Colors.BLUE
				);

				int inner1 = size/2 + size/8;
				DrawRectanglePro(
					Rectangle(x, y+worldY, inner1, inner1),
					Vector2(inner1 / 2.0f, inner1 / 2.0f),
					r,
					Colors.BLACK
				);

				int inner2 = size/4;
				DrawRectanglePro(
					Rectangle(x, y+worldY, inner2, inner2),
					Vector2(inner2 / 2.0f, inner2 / 2.0f),
					r,
					Colors.WHITE
				);
				break;
			case Mode.Ship:
				DrawTriangle(
					Vector2(x, y+worldY - size / 2),
					Vector2(x - size / 2, y+worldY + size / 2),
					Vector2(x + size / 2, y+worldY + size / 2),
					Colors.GREEN
				);
				break;
			case Mode.Wave:
				DrawTriangle(
					Vector2(x, y+worldY - size / 2),
					Vector2(x - size / 2, y+worldY + size / 2),
					Vector2(x + size / 2, y+worldY + size / 2),
					Colors.PURPLE
				);
				break;
			default:
				break;
		}
	}
}