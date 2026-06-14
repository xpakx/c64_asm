.PHONY: run build run2 build2

build: program.prg

program.prg: *.asm
	64tass main.asm -o program.prg

run: program.prg
	x64sc program.prg
	


build2: program2.prg

program2.prg: main2.asm
	64tass main2.asm -o program2.prg

run2: program2.prg
	x64sc program2.prg
