.PHONY: run build

build: main

main: main.c
	gcc main.c -o main -I./libs -Wall -L./libs -lraylib -lm

run: main
	LD_LIBRARY_PATH=./libs ./main
