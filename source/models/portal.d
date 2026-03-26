module models.portal;

import raylib;
import models.player;
import models.level_object;

class Portal : LevelObject
{
	private int width, height;

	this(int x, int y)
	{
		super(x, y);
		this.width = 50; this.height = 100;
	}

	protected bool isColliding(ref PlayerCube player)
	{
		return player.worldX + player.size / 2 > x - width / 2 &&
			   player.worldX - player.size / 2 < x + width / 2 &&
			   player.y + player.size / 2 > y - height / 2 &&
			   player.y - player.size / 2 < y + height / 2;
	}
}

class BluePortal : Portal
{
	this(int x, int y) { super(x, y); }

	override void update(ref PlayerCube player)
	{
		if (isColliding(player))
		{
			// Normal gravity
			player.gravityDirection = 1;
			player.isOnGround = false;
		}
	}

	override void draw(int cameraX, int cameraY)
	{
		DrawRectangle(x - width / 2 - cameraX, y - height * 2 - cameraY, width, height * 3, Colors.BLUE);
	}
}

class YellowPortal : Portal
{
	this(int x, int y) { super(x, y); }

	override void update(ref PlayerCube player)
	{
		if (isColliding(player))
		{
			// Upside down gravity
			player.gravityDirection = -1;
			player.isOnGround = false;
		}
	}

	override void draw(int cameraX, int cameraY)
	{
		DrawRectangle(x - width / 2 - cameraX, y - height * 2 - cameraY, width, height * 3, Colors.YELLOW);
	}
}

public class GreenPortal : Portal
{
	private bool wasColliding = false;

	this(int x, int y) { super(x, y); }

	override void update(ref PlayerCube player)
	{
		bool colliding = isColliding(player);
		if (colliding && !wasColliding)
		{
			player.gravityDirection *= -1;
			player.isOnGround = false;
		}

		wasColliding = colliding;
	}

	override void draw(int cameraX, int cameraY)
	{
		DrawRectangle(x - width / 2 - cameraX, y - height * 2 - cameraY, width, height * 3, Colors.GREEN);
	}
}

public class CubePortal : Portal
{
	private bool wasColliding = false;

	this(int x, int y) { super(x, y); }

	override void update(ref PlayerCube player)
	{
		bool colliding = isColliding(player);
		if (colliding && !wasColliding)
		{
			player.mode = Mode.Cube;
		}

		wasColliding = colliding;
	}

	override void draw(int cameraX, int cameraY)
	{
		DrawRectangle(x - width / 2 - cameraX, y - height * 2 - cameraY, width, height * 3, Colors.GREEN);
	}
}

public class ShipPortal : Portal
{
	private bool wasColliding = false;

	this(int x, int y) { super(x, y); }

	override void update(ref PlayerCube player)
	{
		bool colliding = isColliding(player);
		if (colliding && !wasColliding)
		{
			player.mode = Mode.Ship;
		}

		wasColliding = colliding;
	}

	override void draw(int cameraX, int cameraY)
	{
		DrawRectangle(x - width / 2 - cameraX, y - height * 2 - cameraY, width, height * 3, Colors.PURPLE);
	}
}