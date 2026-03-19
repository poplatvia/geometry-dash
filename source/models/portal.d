module models.portal;

import raylib;
import models.player;

class Portal
{
	int x, y;
	private int width, height;

	this(int x, int y)
	{
		this.x = x; this.y = y;
		this.width = 50; this.height = 100;
	}

	void onTouch(ref PlayerCube player)
	{}

	protected bool isColliding(ref PlayerCube player)
	{ return false; }

	void draw(int cameraX)
	{}
}

class BluePortal : Portal
{
	this(int x, int y) { super(x, y); }

	override void onTouch(ref PlayerCube player)
	{
		if (isColliding(player))
		{
			// Normal gravity
			player.gravityDirection = 1;
			player.isOnGround = false;
		}
	}

	protected override bool isColliding(ref PlayerCube player)
	{
		return player.worldX + player.size / 2 > x - width / 2 &&
			   player.worldX - player.size / 2 < x + width / 2 &&
			   player.y + player.size / 2 > y - height / 2 &&
			   player.y - player.size / 2 < y + height / 2;
	}

	override void draw(int cameraX)
	{
		DrawRectangle(x - width / 2 - cameraX, y - height / 2, width, height, Colors.BLUE);
	}
}

class YellowPortal : Portal
{
	this(int x, int y) { super(x, y); }

	override void onTouch(ref PlayerCube player)
	{
		if (isColliding(player))
		{
			// Upside down gravity
			player.gravityDirection = -1;
			player.isOnGround = false;
		}
	}

	protected override bool isColliding(ref PlayerCube player)
	{
		return player.worldX + player.size / 2 > x - width / 2 &&
			   player.worldX - player.size / 2 < x + width / 2 &&
			   player.y + player.size / 2 > y - height / 2 &&
			   player.y - player.size / 2 < y + height / 2;
	}

	override void draw(int cameraX)
	{
		DrawRectangle(x - width / 2 - cameraX, y - height / 2, width, height, Colors.YELLOW);
	}
}