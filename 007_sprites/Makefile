.PHONY: run build run2 build2

build: program.prg

program.prg: *.asm
	64tass main.asm -o program.prg

run: program.prg
	x64sc program.prg


build2: multicolor.prg

multicolor.prg: *.asm
	64tass multicolor.asm -o multicolor.prg

run2: multicolor.prg
	x64sc multicolor.prg
	
