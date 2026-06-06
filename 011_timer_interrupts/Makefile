.PHONY: run build run2 buld2 run3 build3 snake build4

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




build3: dual.prg

dual.prg: *.asm
	64tass dual.asm -o dual.prg

run3: dual.prg
	x64sc dual.prg




build4: snake.prg

snake.prg: snake.asm
	64tass snake.asm -o snake.prg

snake: snake.prg
	x64sc snake.prg
