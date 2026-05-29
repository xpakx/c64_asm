#include "raylib.h"
#include <string.h>

#define ROWS 21
#define COLS 24

int main() {
   const int screenWidth = 1200;
   const int screenHeight = 1200;
   const int cellScale = 40;
   bool isMulticolor = false;

   Color drawing[ROWS][COLS];

   for (int i = 0; i < ROWS; i++) {
	   for (int j = 0; j < COLS; j++) {
		   drawing[i][j] = RAYWHITE;
	   }
   }

   InitWindow(screenWidth, screenHeight, "C64 Sprite Editor");

   SetTargetFPS(60);

   while (!WindowShouldClose())
   {
	   if (IsKeyPressed(KEY_SPACE)) isMulticolor = !isMulticolor;
	   int cols = isMulticolor ? (int) (COLS/2) : COLS;
	   int rows = ROWS;
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
	   for (int i = 0; i < rows; i++) {
		   for (int j = 0; j < cols; j++) {
			   DrawRectangle(
					   startX + (j * cellScale * colMult)+1, 
					   startY + (i * cellScale)+1, 
					   cellScale * colMult -2, 
					   cellScale-2, 
					   drawing[i][j]
					);
		   }
	   }
	   EndDrawing();
   }

   CloseWindow();
   return 0;
}

