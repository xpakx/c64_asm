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

	jsr print_segments


get_key:
        jsr GETIN
        beq check_timer
        
        cmp #Q_KEY
        beq exit_prog

        cmp #UP_KEY
	bne test_down
        jsr dir_up
test_down:
        cmp #DOWN_KEY
	bne test_left
        jsr dir_down
test_left:
        cmp #LEFT_KEY
	bne test_right
        jsr dir_left
test_right:
        cmp #RIGHT_KEY
	bne check_timer
        jsr dir_right

check_timer:
	sec
	lda LOW_TIME            ; Load clock
    	sbc last_time
	cmp #30
    	bcc get_key

    	
    	; Update target_time
	lda LOW_TIME
	sta last_time 

	jmp auto_move


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

auto_move:
	jsr move_segments

move_head:
	lda next_dir
	sta direction
	cmp #%00000001
	beq move_down
	cmp #%00000010
	beq move_up
	cmp #%00000100
	beq move_left
	cmp #%00001000
	beq move_right

	jmp move_down


dir_up:
	lda direction
	cmp #%00000001
	beq set_death_flag
	lda #%00000010
	sta next_dir
	rts

dir_down:
	lda direction
	cmp #%00000010
	beq set_death_flag
	lda #%00000001
	sta next_dir
	rts

dir_left:
	lda direction
	cmp #%00001000
	beq set_death_flag
	lda #%00000100
	sta next_dir
	rts

dir_right:
	lda direction
	cmp #%00000100
	beq set_death_flag
	lda #%00001000
	sta next_dir
	rts

set_death_flag:
	lda #%01
	sta death_flag
	rts


.include 'subroutines.asm'
.include 'segments.asm'

direction:
	.byte %00000001   ;last bit is down, then up, left, right
next_dir:
	.byte %00000001

player_row:
 	.byte $0A

player_col:
 	.byte $0A

last_time:
	.byte 30

death_flag:
	.byte %0

segments_len:
	.byte 3
segments:
 	.byte $09
 	.byte $0A
 	.byte $08
 	.byte $0A
 	.byte $07
 	.byte $0A
