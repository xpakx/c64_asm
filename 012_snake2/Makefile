.PHONY: run build debug

build: bin/program.prg

bin: 
	mkdir -p bin

bin/program.prg: *.asm **/*.asm bin
	64tass main.asm -o bin/program.prg

run: bin/program.prg
	x64sc bin/program.prg

bin/debug.prg: *.asm **/*.asm bin
	64tass -D DEBUG=1 main.asm -o bin/debug.prg

debug: bin/debug.prg
	x64sc bin/debug.prg
