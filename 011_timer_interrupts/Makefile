.PHONY: run build run2 build2

build: program.prg

program.prg: *.asm
	64tass main.asm -o program.prg

run: program.prg
	x64sc program.prg




build2: raster.prg

raster.prg: raster_timer.asm
	64tass raster_timer.asm -o raster.prg

run2: raster.prg
	x64sc raster.prg
