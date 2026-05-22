; ------------
; Commodore 64 ASM
; ------------

.include 'header.asm'
.include 'basic.asm'

*= $0810 

start:
	lda #RED
	sta BORDER_COLOR
	lda #BLACK
	sta BG_COLOR

print_player:
	jsr clr_scr

	lda #GREEN
	sta CUR_COLOR  

	ldx player_row
	ldy player_col
	clc
	jsr PLOT

	lda #KEY_0
 	jsr CHROUT

get_key:
        jsr GETIN
        beq get_key
        
        cmp #Q_KEY
        beq exit_prog
       
        jmp get_key

turn:
	jmp print_player

exit_prog:
	jsr clr_scr
	lda #WHITE
	sta CUR_COLOR  
	lda #LIGHT_BLUE
	sta BORDER_COLOR
	lda #BLUE
	sta BG_COLOR
        rts
	

.include 'subroutines.asm'

player_row:
 	.byte $0A

player_col:
 	.byte $0A

segments:
 	.byte $0
 	.byte $0
 	.byte $05
 	.byte $05
	.byte $FF
