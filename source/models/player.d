module models.player;

import raylib;
import helpers;

import std.conv;
import std.math.trigonometry;

import models.ground;

enum Mode {
	Cube,
	Ship,
	Wave
}

struct Point {
	int x;
	int y;
}

// Similar to geometry dash cube
public class Player
{
	int x;
	int y;
	int size;
	float velocityY;
	int rotation;
	bool isOnGround;
	bool isJumping;
	bool wasJumping;
	int gravityDirection = 1; // 1 for normal gravity, -1 for reversed
	int speed = 700; // Horizontal speed in pixels per second
	float worldX; // Player's position in the world
	float worldY; // Player's position in the world
	Mode mode;
	Point[] trail;

	this() 
	{
		this.x = 710; // dynamically calculate this later based on screen size
		this.worldX = -500; // dynamically calculate this later based on screen size
		this.worldY = 0;
		this.y = 500;
		this.size = 110; // dynamically calculate this later based on screen size
		this.velocityY = 0;
		this.isOnGround = false;
		this.isJumping = false;
		mode = Mode.Cube;
	}

	void snap() 
	{
		rotation = (rotation + 45) / 90 * 90;
	}

	void update(Ground ground)
	{
		switch (mode)
		{
			case Mode.Cube:
				velocityY += gravityDirection * 1.64 * 1.8;
				break;
			case Mode.Ship:
				velocityY += gravityDirection;
				break;
			case Mode.Wave:
				if (!isJumping)
				{
					velocityY = 25 * gravityDirection;
				}
				break;
			default:
				break;

		}
		y += to!int(velocityY);
		

		if (!isOnGround)
			rotation += 10 * gravityDirection;

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

		if (IsKeyDown(KeyboardKey.KEY_SPACE)) {
			isJumping = true;
			jump();
		}
		else {
			isJumping = false;
		}

		if (((isJumping && !wasJumping) || (!isJumping && wasJumping)) && (mode == Mode.Wave))
		{
			trail ~= Point(to!int(worldX), y);
		}

		wasJumping = isJumping;
	}

	void jump()
	{
		switch (mode)
		{
			case Mode.Cube:
				if (isOnGround)
				{
					velocityY = -40 * gravityDirection; // Jump strength
					isOnGround = false;
				}
				break;
			case Mode.Ship:
				velocityY = -15 * gravityDirection;
				isOnGround = false;
				break;
			case Mode.Wave:
				velocityY = -25 * gravityDirection;
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
				// Calculate the angle the wave is heading based on velocity
				float angle = atan2(to!real(velocityY), to!real(speed)) * RAD2DEG;
				
				// Define triangle points relative to origin
				Vector2 p1 = Vector2(0, -size / 2);           // Tip (points forward)
				Vector2 p2 = Vector2(-size / 2, size / 2);    // Bottom left
				Vector2 p3 = Vector2(size / 2, size / 2);     // Bottom right
				
				auto rotate = (Vector2 point, float rot) {
					float rad = rot * DEG2RAD;
					float cos_a = cos(rad);
					float sin_a = sin(rad);
					return Vector2(
						point.x * cos_a - point.y * sin_a,
						point.x * sin_a + point.y * cos_a
					);
				};
				
				Vector2 center = Vector2(x, y + worldY);
				DrawTriangle(
					center + rotate(p1, angle),
					center + rotate(p2, angle),
					center + rotate(p3, angle),
					Colors.GREEN
				);
				
				break;
			case Mode.Wave:
				// draw a line from the player to each point in the trail
				if (trail.length > 1)
				{
					for (size_t i = 1; i < trail.length; i++)
					{
						Point point1 = trail[i - 1];
						Point point2 = trail[i];
						// draw line with thickness
						DrawLineEx(
							Vector2(point1.x - to!int(worldX) + x, point1.y + to!int(worldY)),
							Vector2(point2.x - to!int(worldX) + x, point2.y + to!int(worldY)),
							20,
							Colors.WHITE
						);
					}
				}
				
				// draw an extra line from the player to the last point in the trail
				if (trail.length > 0)
				{
					Point lastPoint = trail[$ - 1];
					DrawLineEx(
						Vector2(x, y + to!int(worldY)),
						Vector2(lastPoint.x - to!int(worldX) + x, lastPoint.y + to!int(worldY)),
						20,
						Colors.WHITE
					);
				}

				float angle = (velocityY * gravityDirection > 0) ? 135.0f : 45.0f;
				
				// Define triangle points relative to origin
				Vector2 p1 = Vector2(0, -size / 2);           // Tip (points forward)
				Vector2 p2 = Vector2(-size / 2, size / 2);    // Bottom left
				Vector2 p3 = Vector2(size / 2, size / 2);     // Bottom right
				
				auto rotate = (Vector2 point, float rot) {
					float rad = rot * DEG2RAD;
					float cos_a = cos(rad);
					float sin_a = sin(rad);
					return Vector2(
						point.x * cos_a - point.y * sin_a,
						point.x * sin_a + point.y * cos_a
					);
				};
				
				Vector2 center = Vector2(x, y + worldY);
				DrawTriangle(
					center + rotate(p1, angle),
					center + rotate(p2, angle),
					center + rotate(p3, angle),
					Colors.PURPLE
				);
				break;
			default:
				break;
		}
	}

	void death() {
		this.worldX = 0;
		this.y = 200;
		this.velocityY = 0;
		this.isOnGround = true;
		this.trail = [];
	}
}