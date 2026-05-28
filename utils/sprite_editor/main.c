#include "raylib.h"

int main() {
   const int screenWidth = 800;
   const int screenHeight = 450;

   InitWindow(screenWidth, screenHeight, "C64 Sprite Editor");

   SetTargetFPS(60);

   while (!WindowShouldClose())
   {
	   BeginDrawing();

	   ClearBackground(RAYWHITE);

	   DrawText("C64 Sprite Editor", 350, 200, 20, DARKGRAY);

	   EndDrawing();
   }

   CloseWindow();
   return 0;
}

