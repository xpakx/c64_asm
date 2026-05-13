; ------------
; Commodore 64 ASM
; ------------

.include 'header.asm'
.include 'basic.asm'

*= $0810 

start:
	jsr clr_scr

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

	jsr print_str

forever:
 	jmp forever

message:
 	.text "HELLO WORLD"
 	.byte 0

.include 'subroutines.asm'
