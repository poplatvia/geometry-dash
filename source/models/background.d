module models.background;

import raylib;

class Background 
{
	void draw()
	{
		DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Colors.DARKGRAY);
	}
}