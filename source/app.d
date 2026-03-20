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

	Portal[] portals = [
		new BluePortal(4200, 0),
		new BluePortal(4700, 200),
		new YellowPortal(4700, 600),
		new YellowPortal(2700, 700)
	];

	Background background = new Background();

	DebugView debugView = new DebugView();

	float cameraX = 0;

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
			cameraX = player.worldX - player.x;
		}

        BeginDrawing();
        background.draw(cast (int) cameraX);
		foreach (LevelObject object ; objects)
		{
			object.update(player);
			object.draw(cast (int) cameraX);
		}
		foreach (Portal portal ; portals)
		{
			portal.update(player);
			portal.draw(cast (int) cameraX);
		}
		ground.draw(cast (int) cameraX);
		player.update(ground);
		player.draw();
		debugView.draw(cast (int) cameraX);
        EndDrawing();
    }
    CloseWindow();
}