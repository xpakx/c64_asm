.PHONY: run build

build: hello.prg

hello.prg: hello.asm
	64tass hello.asm -o hello.prg

run: hello.prg
	x64sc hello.prg
