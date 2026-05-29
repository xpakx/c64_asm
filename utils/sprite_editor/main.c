#include "raylib.h"
#include <string.h>
#include <stdio.h>

#define ROWS 21
#define COLS 24


void draw_grid(int startX, int startY, int cellScale, int colMult, int rows, int cols) {
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
}

void draw_colors(int startX, int startY, int cellScale, int colMult, int rows, int cols, Color drawing[ROWS][COLS]) {
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
}

void check_click(int startX, int startY, int cellScale, int colMult, Color drawing[ROWS][COLS]) {
	if (IsMouseButtonDown(MOUSE_BUTTON_LEFT)) {
		Vector2 mousePos = GetMousePosition();

		int j = (int)((mousePos.x - startX) / (cellScale * colMult));
		int i = (int)((mousePos.y - startY) / cellScale);

		if (i >= 0 && i < ROWS && j >= 0 && j < COLS) {
			drawing[i][j] = GREEN;
		}
	}

	else if (IsMouseButtonDown(MOUSE_BUTTON_RIGHT)) {
		Vector2 mousePos = GetMousePosition();

		int j = (int)((mousePos.x - startX) / (cellScale * colMult));
		int i = (int)((mousePos.y - startY) / cellScale);

		if (i >= 0 && i < ROWS && j >= 0 && j < COLS) {
			drawing[i][j] = RAYWHITE;
		}
	}
}

void save_sprite_to_asm(Color drawing[ROWS][COLS], const char* filename) {
	FILE *file = fopen(filename, "w");
	if (!file) return;

	fprintf(file, "sprite_data:\n");

	for (int i = 0; i < 21; i++) {
		fprintf(file, "    .byte ");
		for (int b = 0; b < 3; b++) {
			unsigned char byte = 0;
			for (int bit = 0; bit < 8; bit++) {
				if (drawing[i][b * 8 + bit].r != RAYWHITE.r) {
					byte |= (1 << (7 - bit));
				}
			}
			fprintf(file, "$%02x%s", byte, (b < 2) ? "," : "");
		}
		fprintf(file, "\n");
	}

	fprintf(file, "    .byte $00\n");
	fclose(file);
}

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
	   if (IsKeyPressed(KEY_S)) save_sprite_to_asm(drawing, "sprite.asm");

	   int cols = isMulticolor ? (int) (COLS/2) : COLS;
	   int rows = ROWS;
	   int colMult = isMulticolor ? 2 : 1;
	   int startX = 100;
	   int startY = 100;
	   check_click(startX, startY, cellScale, colMult, drawing);
	   BeginDrawing();

	   ClearBackground(RAYWHITE);

	   DrawText("C64 Sprite Editor", 10, 10, 20, DARKGRAY);
	   draw_grid(startX, startY, cellScale, colMult, rows, cols);
	   draw_colors(startX, startY, cellScale, colMult, rows, cols, drawing);

	   EndDrawing();
   }

   CloseWindow();
   return 0;
}
