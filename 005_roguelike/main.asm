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

print_enemies:
 	ldx #$00
	lda #RED
	sta CUR_COLOR  

enemies_loop:
	lda enemies,x
	cmp #$FF            ; end-of-list marker ($FF)
	beq end_enemies_loop


	txa
	pha

	ldy enemies+1,x
	lda enemies,x
	tax

	clc
	jsr PLOT

	pla
	tax

	lda #KEY_0
 	jsr CHROUT

 	inx
	inx
 	bne enemies_loop

end_enemies_loop:

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

	jsr detect_collisions
	beq turn
	inc player_row
	jmp turn

move_down:
	lda player_row
	cmp #$18
	beq get_key
	inc player_row
	jsr detect_collisions
	beq turn
	dec player_row
	jmp turn

move_left:
	lda player_col
	beq get_key
	dec player_col
	jsr detect_collisions
	beq turn
	inc player_col
	jmp turn

move_right:
	lda player_col
	cmp #$27
	beq get_key
	inc player_col
	jsr detect_collisions
	beq turn
	dec player_col
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

detect_collisions:
 	ldx #$00

collision_loop:
	lda enemies,x
	cmp #$FF            ; end-of-list marker ($FF)
	beq end_collision_loop

	cmp player_row
	bne no_collision
	lda enemies+1,x
	cmp player_col
	bne no_collision
	lda #$FF
	rts
no_collision:
 	inx
	inx
 	bne collision_loop

end_collision_loop:
	lda #$00
	rts
	

.include 'subroutines.asm'

player_row:
 	.byte $0A

player_col:
 	.byte $0A

enemies:
 	.byte $0
 	.byte $0
 	.byte $05
 	.byte $05
	.byte $FF
