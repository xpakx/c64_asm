#include "raylib.h"

int main() {
   const int screenWidth = 1200;
   const int screenHeight = 1200;
   const int cellScale = 40;
   bool isMulticolor = false;

   InitWindow(screenWidth, screenHeight, "C64 Sprite Editor");

   SetTargetFPS(60);

   while (!WindowShouldClose())
   {
	   if (IsKeyPressed(KEY_SPACE)) isMulticolor = !isMulticolor;
	   int cols = isMulticolor ? 12 : 24;
	   int rows = 21;
	   int colMult = isMulticolor ? 2 : 1;
	   BeginDrawing();

	   ClearBackground(RAYWHITE);

	   DrawText("C64 Sprite Editor", 10, 10, 20, DARKGRAY);
	   int startX = 100;
	   int startY = 100;

	   for (int i = 0; i <= cols; i++) {
		   DrawLine(
				   startX + i * cellScale * colMult,
				   startY,
				   startX + i * cellScale * colMult,
				   startY + rows * cellScale,
				   LIGHTGRAY
		   );
	   }
	   for (int j = 0; j <= rows; j++) {
		   DrawLine(
				   startX,
				   startY + j * cellScale,
				   startX + cols * cellScale * colMult,
				   startY + j * cellScale,
				   LIGHTGRAY
		   );
	   }

	   EndDrawing();
   }

   CloseWindow();
   return 0;
}

