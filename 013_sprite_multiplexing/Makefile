.PHONY: run build run2 build2

build: program.prg

program.prg: *.asm
	64tass main.asm -o program.prg

run: program.prg
	x64sc program.prg




build2: blocking.prg

blocking.prg: blocking.asm
	64tass blocking.asm -o blocking.prg

run2: blocking.prg
	x64sc blocking.prg
