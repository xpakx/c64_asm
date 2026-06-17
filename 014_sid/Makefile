.PHONY: run build run2 build2 run3 build3 run4 build4 run5 build5

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

	

build3: program3.prg

program3.prg: bgmusic.asm
	64tass bgmusic.asm -o program3.prg

run3: program3.prg
	x64sc program3.prg



build4: program4.prg

program4.prg: bank.asm
	64tass bank.asm -o program4.prg

run4: program4.prg
	x64sc program4.prg



build5: program5.prg

program5.prg: interrupts.asm
	64tass interrupts.asm -o program5.prg

run5: program5.prg
	x64sc program5.prg




build6: program6.prg

program6.prg: compressed.asm
	64tass compressed.asm -o program6.prg

run6: program6.prg
	x64sc program6.prg
