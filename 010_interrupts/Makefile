.PHONY: run build run2 buld2

build: program.prg

program.prg: *.asm
	64tass main.asm -o program.prg

run: program.prg
	x64sc program.prg




build2: chain.prg

chain.prg: *.asm
	64tass chain.asm -o chain.prg

run2: chain.prg
	x64sc chain.prg
