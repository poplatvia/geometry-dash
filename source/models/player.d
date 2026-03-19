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
	int rotation;
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

		if (!isOnGround)
			rotation += 5 * gravityDirection;

		int floorY = ground.groundY() - size / 2;
		int ceilY  = size / 2;

		if (y >= floorY)
		{
			y = floorY;
			velocityY = 0;
			isOnGround = true;
			rotation = (rotation + 45) / 90 * 90;  // snap to nearest 90°
		}
		if (y <= ceilY)
		{
			y = ceilY;
			velocityY = 0;
			isOnGround = true;
			rotation = (rotation + 45) / 90 * 90;  // snap to nearest 90°
		}

		if (IsKeyDown(KeyboardKey.KEY_SPACE))
			jump();
	}

	void jump()
	{
		if (isOnGround)
		{
			velocityY = -20 * gravityDirection; // Jump strength
			isOnGround = false;
		}
	}

	void draw()
	{
		float r = cast(float)rotation;
		Vector2 origin = Vector2(size / 2.0f, size / 2.0f);

		DrawRectanglePro(
			Rectangle(x, y, size, size),
			origin,  // pivot point (center)
			r,
			Colors.BLUE
		);

		int inner1 = size/2 + size/8;
		DrawRectanglePro(
			Rectangle(x, y, inner1, inner1),
			Vector2(inner1 / 2.0f, inner1 / 2.0f),
			r,
			Colors.BLACK
		);

		int inner2 = size/4;
		DrawRectanglePro(
			Rectangle(x, y, inner2, inner2),
			Vector2(inner2 / 2.0f, inner2 / 2.0f),
			r,
			Colors.WHITE
		);
	}
}