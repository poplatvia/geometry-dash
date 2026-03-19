module models.background;

import raylib;

class Background 
{
	void draw(int cameraX)
	{
		DrawRectangle(0, 0, GetScreenWidth(), GetScreenHeight(), Colors.DARKGRAY);
		// distant pillars at intervals of 500
		int sparsity = 1500;
		for (int x = -cameraX % sparsity; x < GetScreenWidth()*4; x += sparsity)
		{
			DrawRectangle(x/4, 0, 50, GetScreenHeight(), Colors.GRAY);
		}

		sparsity = 500;
		for (int x = -cameraX % sparsity; x < GetScreenWidth()*4; x += sparsity)
		{
			DrawRectangle(x/2, 0, 50, GetScreenHeight(), Colors.LIGHTGRAY);
		}

	}
}