import raylib;

import std.stdio;
import std.math : sqrt;
import helpers;

import models.player;
import models.orb;
import models.portal;
import models.ground;
import models.background;
import models.debug_view;

import models.level_object;

import setup;

void main()
{
    // call this before using raylib
    validateRaylibBinding();
	// flag window as resizable
    SetConfigFlags(ConfigFlags.FLAG_FULLSCREEN_MODE);
	SetConfigFlags(ConfigFlags.FLAG_VSYNC_HINT);
	// get monitor dimensions for fullscreen
	InitWindow(0, 0, "SQUARE GAME 3");
    SetTargetFPS(60);

	Ground ground = new Ground();

	PlayerCube player = new PlayerCube();

	LevelObject[] objects = loadObjectsFromFile(ground);

	Background background = new Background();

	DebugView debugView = new DebugView();

	float cameraX = 0;
	float cameraY = 0;

    while (!WindowShouldClose())
    {
		if (IsKeyDown(KeyboardKey.KEY_D))
			{
			float dt = GetFrameTime();
			player.worldX += player.speed * dt;
			cameraX = player.worldX - player.x;
		}

		if (IsKeyDown(KeyboardKey.KEY_A))
		{
			float dt = GetFrameTime();
			player.worldX -= player.speed * dt;
			cameraX = player.worldX + player.x;
		}

		if (IsKeyDown(KeyboardKey.KEY_W))
		{
			player.worldY += 10;
			cameraY = player.worldY;
		}

		if (IsKeyDown(KeyboardKey.KEY_S))
		{
			player.worldY -= 10;
			cameraY = player.worldY;
		}

		player.update(ground);

        BeginDrawing();
        background.draw(cast (int) cameraX);
		ground.draw(cast (int) cameraX, cast (int) cameraY);
		foreach (LevelObject object ; objects)
		{
			object.update(player);
			object.draw(cast (int) cameraX, cast (int) cameraY);
		}
		player.draw();
		//debugView.draw(cast (int) cameraX, ground);
        EndDrawing();
    }
    CloseWindow();
}