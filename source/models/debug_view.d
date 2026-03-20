module models.debug_view;

import raylib;

import models.ground;

class DebugView 
{
	void draw(int cameraX, ref Ground ground)
	{
		// draw thin red lines every 110 pixels
        // make each line extend 2000 pizels in either direction
        int offset = ground.groundY() % 110;
        for (int i = -110*10; i < 8000; i += 110)
        {
            DrawLine(i-cameraX, -6000 + offset, i-cameraX, 6000 + offset, Colors.RED);
        }
        for (int i = -110*10; i < 110*10; i += 110)
        {
            DrawLine(-6000-cameraX, i + offset, 6000-cameraX, i + offset, Colors.RED);
        }
	}
}