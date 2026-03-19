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
    InitWindow(800, 600, "SQUARE GAME 3");
    SetTargetFPS(60);

	PlayerCube player = PlayerCube(100, 500, 50);

	Orb[] orbs = [
		new YellowOrb(400, 400, 20),
		new PurpleOrb(500, 300, 20),
		new BlackOrb(600, 300, 20),
		new RedOrb(300, 300, 20)
	];

	Portal[] portals = [
		new BluePortal(200, 0, 50, 100),
		new YellowPortal(700, 500, 50, 100)
	];

	Ground ground = new Ground(500);
	Background background = new Background();
    while (!WindowShouldClose())
    {
        BeginDrawing();
        background.draw();
		foreach (Orb orb ; orbs)
		{
			orb.update(player);
			orb.draw();
		}
		foreach (Portal portal ; portals)
		{
			portal.draw();
			portal.onTouch(player);
		}
		ground.draw();
		player.update();
		player.draw();
        EndDrawing();
    }
    CloseWindow();
}