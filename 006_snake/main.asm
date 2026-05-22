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

	lda LOW_TIME
	sta last_time
	cli

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
        beq check_timer
        
        cmp #Q_KEY
        beq exit_prog

check_timer:
	sec
	lda LOW_TIME            ; Load clock
    	sbc last_time
	cmp #30
    	bcc get_key

    	
    	; Update target_time
	lda LOW_TIME
	sta last_time 
	jmp move_down

exit_prog:
	jsr clr_scr
	lda #WHITE
	sta CUR_COLOR  
	lda #LIGHT_BLUE
	sta BORDER_COLOR
	lda #BLUE
	sta BG_COLOR
        rts


move_up:
	lda player_row
	beq get_key
	dec player_row
	jmp print_player

move_down:
	lda player_row
	cmp #$18
	beq get_key
	inc player_row
	jmp print_player

move_left:
	lda player_col
	beq get_key
	dec player_col
	jmp print_player

move_right:
	lda player_col
	cmp #$27
	beq get_key
	inc player_col
	jmp print_player


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

last_time:
	.byte 30
