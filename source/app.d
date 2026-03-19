import raylib;

import std.stdio;
import std.math : sqrt;
import helpers;

import models.player;
import models.orb;
import models.portal;
import models.ground;
import models.background;

void main()
{
    // call this before using raylib
    validateRaylibBinding();
	// flag window as resizable
    SetConfigFlags(ConfigFlags.FLAG_FULLSCREEN_MODE);
	SetConfigFlags(ConfigFlags.FLAG_VSYNC_HINT);
	// get monitor dimensions for fullscreen
	InitWindow(GetMonitorWidth(0), GetMonitorHeight(0), "SQUARE GAME 3");
    SetTargetFPS(60);

	PlayerCube player = new PlayerCube();

	Orb[] orbs = [
		new YellowOrb(1400, 400, 20),
		new PurpleOrb(1500, 300, 20),
		new BlackOrb(1600, 300, 20),
		new RedOrb(1300, 300, 20)
	];

	Portal[] portals = [
		new BluePortal(1200, 0),
		new YellowPortal(1700, 500),
		new BluePortal(1700, 300)
	];

	Ground ground = new Ground();
	Background background = new Background();

	float cameraX = 0;
	immutable float playerScreenX = 100;

    while (!WindowShouldClose())
    {
		float dt = GetFrameTime();
		player.worldX += player.speed * dt;
		cameraX = player.worldX - playerScreenX;

        BeginDrawing();
        background.draw(cast (int) cameraX);
		foreach (Orb orb ; orbs)
		{
			orb.update(player);
			orb.draw(cast (int) cameraX);
		}
		foreach (Portal portal ; portals)
		{
			portal.draw(cast (int) cameraX);
			portal.onTouch(player);
		}
		ground.draw(cast (int) cameraX);
		player.update(ground);
		player.draw();
        EndDrawing();
    }
    CloseWindow();
}