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

loop:
        jsr GETIN
        beq loop
        
        cmp #Q_KEY
        beq exit_prog

        cmp #SPACE_KEY
        beq start_game

        cmp #UP_KEY
        beq move_up
        
        cmp #DOWN_KEY
        beq move_down
        
        cmp #LEFT_KEY
        beq move_left
        
        cmp #RIGHT_KEY
        beq move_right
        
        jmp loop

start_game:
	jmp print_player

move_up:
	lda player_row
	beq loop
	dec player_row
	jmp print_player

move_down:
	lda player_row
	cmp #$18
	beq loop
	inc player_row
	jmp print_player

move_left:
	lda player_col
	beq loop
	dec player_col
	jmp print_player

move_right:
	lda player_col
	cmp #$27
	beq loop
	inc player_col
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

player_row:
 	.byte $0A

player_col:
 	.byte $0A

.include 'subroutines.asm'
