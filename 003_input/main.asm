; ------------
; Commodore 64 ASM
; ------------

.include 'header.asm'
.include 'basic.asm'

*= $0810 

start:
	jsr clr_scr

	ldx #$01
	ldy #$00
	clc
	jsr PLOT

	lda #WHITE
	sta CUR_COLOR  

	lda #<message
	sta STR_PTR
	lda #>message
	sta STR_PTR+1

	jsr print_str

	ldx #$03
	ldy #$00
	clc
	jsr PLOT

loop:
        jsr GETIN
        beq loop
        
        cmp #$20	; PETSCII $20 is spacebar
        beq exit_prog
        
        jsr CHROUT	; otherwise print the letter
        jmp loop

exit_prog:
	jsr clr_scr
        rts

message:
 	.text "PRESS LETTERS TO WRITE, SPACE TO EXIT"
 	.byte 0

.include 'subroutines.asm'
