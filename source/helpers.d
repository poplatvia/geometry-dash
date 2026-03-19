module helpers;

import raylib;

void DrawRectangleCentered(int cx, int cy, int width, int height, Color color) {
    DrawRectangle(cx - width / 2, cy - height / 2, width, height, color);
}