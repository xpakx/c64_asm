.PHONY: run build run2 buld2 run3 build3

build: program.prg

program.prg: *.asm
	64tass main.asm -o program.prg

run: program.prg
	x64sc program.prg




build2: raster_timer.prg

raster_timer.prg: raster_timer.asm
	64tass raster_timer.asm -o raster_timer.prg

run2: raster_timer.prg
	x64sc raster_timer.prg




build3: dual.prg

dual.prg: *.asm
	64tass dual.asm -o dual.prg

run3: dual.prg
	x64sc dual.prg
