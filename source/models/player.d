module models.player;

import raylib;
import helpers;

// Similar to geometry dash cube
public struct PlayerCube 
{
	int x;
	int y;
	int size;
	int velocityY;
	bool isOnGround;
	int gravityDirection = 1; // 1 for normal gravity, -1 for reversed

	this(int x, int y, int size)
	{
		this.x = x;
		this.y = y;
		this.size = size;
		this.velocityY = 0;
		this.isOnGround = false;
	}

	void update()
	{
		// Apply gravity
		velocityY += gravityDirection; // Gravity strength
		y += velocityY;

		// Floor
		if (gravityDirection == 1 && y >= 500)
		{
			y = 500;
			velocityY = 0;
			isOnGround = true;
		}
		// Ceiling
		if (gravityDirection == -1 && y <= 0)
		{
			y = 0;
			velocityY = 0;
			isOnGround = true;
		}

		if (IsKeyDown(KeyboardKey.KEY_SPACE))
		{
			jump();
		}
		if (IsKeyDown(KeyboardKey.KEY_D))
		{
			x += 5;
		}
		if (IsKeyDown(KeyboardKey.KEY_A))
		{
			x -= 5;
		}
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