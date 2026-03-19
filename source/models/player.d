module models.player;

import raylib;
import helpers;

import models.ground;

// Similar to geometry dash cube
public class PlayerCube 
{
	int x;
	int y;
	int size;
	int velocityY;
	bool isOnGround;
	int gravityDirection = 1; // 1 for normal gravity, -1 for reversed
	int speed = 500; // Horizontal speed in pixels per second
	float worldX; // Player's position in the world

	this() 
	{
		this.x = 710; // dynamically calculate this later based on screen size
		this.worldX = 710; // dynamically calculate this later based on screen size
		this.y = 500;
		this.size = 110; // dynamically calculate this later based on screen size
		this.velocityY = 0;
		this.isOnGround = false;
	}

	void update(Ground ground)
	{
		velocityY += gravityDirection;
		y += velocityY;

		int floorY = ground.groundY() - size / 2;
		int ceilY  = size / 2;

		if (y >= floorY)
		{
			y = floorY;
			velocityY = 0;
			isOnGround = true;
		}
		if (y <= ceilY)
		{
			y = ceilY;
			velocityY = 0;
			isOnGround = true;
		}

		if (IsKeyDown(KeyboardKey.KEY_SPACE))
			jump();
	}

	void jump()
	{
		if (isOnGround)
		{
			velocityY = -15 * gravityDirection; // Jump strength
			isOnGround = false;
		}
	}

	void draw()
	{
		DrawRectangleCentered(x, y, size, size, Colors.BLUE);
		DrawRectangleCentered(x, y, size/2+size/8, size/2+size/8, Colors.BLACK);
		DrawRectangleCentered(x, y, size/4, size/4, Colors.WHITE);
	}
}