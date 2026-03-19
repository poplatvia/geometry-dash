module models.ground;

import raylib;

class Ground 
{
	int y;

	this(int y) { this.y = y; }

	void draw()
	{
		DrawRectangle(0, y, GetScreenWidth(), GetScreenHeight() - y, Colors.DARKBLUE);
	}
}