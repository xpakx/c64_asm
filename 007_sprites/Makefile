.PHONY: run build run2 build2 run3 build3

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
	



build3: layered.prg

layered.prg: *.asm
	64tass layered.asm -o layered.prg

run3: layered.prg
	x64sc layered.prg
	
