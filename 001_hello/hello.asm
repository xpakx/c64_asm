; ------------
; Commodore 64 ASM
; Hello world
; load and run from memory with `sys 828`
; ------------


; -----------
; Constants
; -----------
SCREEN_RAM = $0400
COLOR_RAM = $D800
CHROUT = $FFD2

WHITE = $01


; ------
; CODE
; ------
* = $033C ;828, start of datasette buffer

start:
	lda #$93
	jsr CHROUT

	lda #$08 ;H
	sta SCREEN_RAM + $019A
	lda #WHITE
	sta COLOR_RAM + $019A

	lda #$05 ;E
	sta SCREEN_RAM + $019B
	lda #WHITE
	sta COLOR_RAM + $019B

	lda #$0C ;L
	sta SCREEN_RAM + $019C
	sta SCREEN_RAM + $019D
	lda #WHITE
	sta COLOR_RAM + $019C
	sta COLOR_RAM + $019D

	lda #$0F ;O
	sta SCREEN_RAM + $019E
	lda #WHITE
	sta COLOR_RAM + $019E

	lda #$20 ;space
	sta SCREEN_RAM + $019F


	lda #$17 ;W
	sta SCREEN_RAM + $01A0
	lda #WHITE
	sta COLOR_RAM + $01A0

	lda #$0F ;O
	sta SCREEN_RAM + $01A1
	lda #WHITE
	sta COLOR_RAM + $01A1

	lda #$12 ;R
	sta SCREEN_RAM + $01A2
	lda #WHITE
	sta COLOR_RAM + $01A2

	lda #$0C ;L
	sta SCREEN_RAM + $01A3
	lda #WHITE
	sta COLOR_RAM + $01A3

	lda #$04 ;D
	sta SCREEN_RAM + $01A4
	lda #WHITE
	sta COLOR_RAM + $01A4
forever:
	jmp forever
