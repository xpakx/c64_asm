; ------------
; Commodore 64 ASM
; ------------

.include 'header.asm'
.include 'basic.asm'

*= $0810 

start:
	lda #GREEN
	sta CUR_COLOR  
	lda #RED
	sta BORDER_COLOR
	lda #BLACK
	sta BG_COLOR

print_player:
	jsr clr_scr

	ldx player_row
	ldy player_col
	clc
	jsr PLOT

	lda #$30
 	jsr CHROUT

get_key:
        jsr GETIN
        beq get_key
        
        cmp #Q_KEY
        beq exit_prog

        cmp #UP_KEY
        beq move_up
        
        cmp #DOWN_KEY
        beq move_down
        
        cmp #LEFT_KEY
        beq move_left
        
        cmp #RIGHT_KEY
        beq move_right
        
        jmp get_key

move_up:
	lda player_row
	beq get_key
	dec player_row
	jmp turn

move_down:
	lda player_row
	cmp #$18
	beq get_key
	inc player_row
	jmp turn

move_left:
	lda player_col
	beq get_key
	dec player_col
	jmp turn

move_right:
	lda player_col
	cmp #$27
	beq get_key
	inc player_col
	jmp turn

turn:
	; TODO
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

