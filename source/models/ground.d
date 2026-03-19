module models.ground;

import raylib;

class Ground 
{
	private int groundConst() { return GetScreenHeight() / 4 + GetScreenHeight()/30; }

	int groundY() { return GetScreenHeight() - groundConst(); }

	void draw(int cameraX)
	{
		int posY = groundY();
		DrawRectangle(0, posY, GetScreenWidth(), groundConst(), Colors.DARKBLUE);
		// make small white lines at intervals of 1000
		for (int x = -cameraX % 1000; x < GetScreenWidth(); x += 1000)
		{
			DrawLine(x, posY, x, GetScreenHeight(), Colors.WHITE);
		}
	}
}