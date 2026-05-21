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

	lda #$30
 	jsr CHROUT

print_enemies:
 	ldx #$00
	lda #RED
	sta CUR_COLOR  

enemies_loop
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

	lda #$30
 	jsr CHROUT

 	inx
	inx
 	bne enemies_loop

end_enemies_loop

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

enemies:
 	.byte $0
 	.byte $0
 	.byte $05
 	.byte $05
	.byte $FF
