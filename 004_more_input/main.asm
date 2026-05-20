; ------------
; Commodore 64 ASM
; ------------

.include 'header.asm'
.include 'basic.asm'

*= $0810 

start:
	lda #WHITE
	sta CUR_COLOR  

prepare_text:
	jsr clr_scr

	ldx #$01
	ldy #$00
	clc
	jsr PLOT

	lda #<message
	sta STR_PTR
	lda #>message
	sta STR_PTR+1

	jsr print_str

loop:
        jsr GETIN
        beq loop
        
        cmp #Q_KEY
        beq exit_prog

        cmp #M_KEY
        beq change_text_color
        
        jmp loop

change_text_color:
	inc CUR_COLOR
	jmp prepare_text


exit_prog:
	jsr clr_scr
	lda #WHITE
	sta CUR_COLOR  
        rts

message:
 	.text "H"
 	.byte 0

.include 'subroutines.asm'
