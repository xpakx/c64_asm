.PHONY: run build

build: hello.prg hello2.prg

hello.prg: hello.asm
	64tass hello.asm -o hello.prg

hello2.prg: hello2.asm
	64tass hello2.asm -o hello2.prg

run: hello.prg
	x64sc hello.prg

run2: hello2.prg
	x64sc hello2.prg
