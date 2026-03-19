module models.portal;

import raylib;
import models.player;

class Portal
{
	int x, y, width, height;

	this(int x, int y, int width, int height)
	{
		this.x = x; this.y = y; this.width = width; this.height = height;
	}

	void onTouch(ref PlayerCube player)
	{}

	protected bool isColliding(ref PlayerCube player)
	{ return false; }

	void draw()
	{}
}

class BluePortal : Portal
{
	this(int x, int y, int width, int height) { super(x, y, width, height); }

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
		return player.x + player.size / 2 > x - width / 2 &&
			   player.x - player.size / 2 < x + width / 2 &&
			   player.y + player.size / 2 > y - height / 2 &&
			   player.y - player.size / 2 < y + height / 2;
	}

	override void draw()
	{
		DrawRectangle(x - width / 2, y - height / 2, width, height, Colors.BLUE);
	}
}

class YellowPortal : Portal
{
	this(int x, int y, int width, int height) { super(x, y, width, height); }

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
		return player.x + player.size / 2 > x - width / 2 &&
			   player.x - player.size / 2 < x + width / 2 &&
			   player.y + player.size / 2 > y - height / 2 &&
			   player.y - player.size / 2 < y + height / 2;
	}

	override void draw()
	{
		DrawRectangle(x - width / 2, y - height / 2, width, height, Colors.YELLOW);
	}
}