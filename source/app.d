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
		new YellowOrb(4400, 200, 20),
		new PurpleOrb(4500, 100, 20),
		new BlackOrb(4600, 200, 20),
		new RedOrb(4300, 200, 20)
	];

	Portal[] portals = [
		new BluePortal(4200, 0),
		new BluePortal(4700, 200),
		new YellowPortal(4700, 600),
		new YellowPortal(2700, 700)
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