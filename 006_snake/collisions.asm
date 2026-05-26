; ---------------------
; Check apple collision
; ---------------------
check_collision_apple:
	lda player_row
	cmp apple_row
	bne finish_collision
	lda player_col
	cmp apple_col
	bne finish_collision

	lda #%01
	sta grow_flag
	jsr generate_apple

finish_collision:
	rts

; --------------------
; Check self collision
; --------------------
check_collision_snake:
 	ldx #$03

snake_collision_loop:
	cpx segments_len
	beq end_snake_collision_loop
	
	txa
	asl
	tay

	lda player_row
	cmp segments,y
	bne snake_collision_continue

	lda player_col
	cmp segments+1,y
	bne snake_collision_continue

	lda #%01
	sta death_flag

snake_collision_continue:
	inx
	jmp snake_collision_loop

end_snake_collision_loop:
	rts
