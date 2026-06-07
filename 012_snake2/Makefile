.PHONY: run build debug

build: program.prg

program.prg: *.asm
	64tass main.asm -o program.prg

run: program.prg
	x64sc program.prg

program_debug.prg: *.asm
	64tass -D DEBUG=1 main.asm -o program_debug.prg

debug: program_debug.prg
	x64sc program_debug.prg
