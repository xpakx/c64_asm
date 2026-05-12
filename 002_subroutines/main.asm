; ------------
; Commodore 64 ASM
; ------------

CHROUT = $FFD2
PLOT = $FFF0

; ---------
; Constants
; ---------
SCREEN_RAM = $0400
COLOR_RAM = $D800
CUR_COLOR = $0286

WHITE = $01     

STR_PTR = $FB      

; ------------------------------------------------
; BASIC stub
; ------------------------------------------------
*= $0801      
.word next
.word 10
.byte $9e
.text "2064"
.byte 0
next:
.word 0

; ------------------------------------------------
; PROGRAM
; ------------------------------------------------
*= $0810 

start:
	jsr sub.clr_scr

	ldx #$0A
	ldy #$0A
	clc
	jsr PLOT

	lda #WHITE
	sta CUR_COLOR  

	lda #<message
	sta STR_PTR
	lda #>message
	sta STR_PTR+1

	jsr sub.print_str

forever:
 	jmp forever

message:
 	.text "HELLO WORLD"
 	.byte 0

.include 'subroutines.asm'
