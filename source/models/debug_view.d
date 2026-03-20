module models.debug_view;

import raylib;

class DebugView 
{
	void draw(int cameraX)
	{
		// draw thin red lines every 110 pixels
        // make each line extend 2000 pizels in either direction
        for (int i = 0; i < 8000; i += 110)
        {
            DrawLine(i-cameraX, -6000, i-cameraX, 6000, Colors.RED);
        }
        for (int i = 0; i < 6000; i += 110)
        {
            DrawLine(-6000-cameraX, i, 6000-cameraX, i, Colors.RED);
        }
	}
}