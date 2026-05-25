; ---------------
; Check collision
; ---------------
check_collision:
	lda player_row
	cmp apple_row
	bne finish_collision
	lda player_col
	cmp apple_col
	bne finish_collision

	lda #%01
	sta grow_flag

finish_collision:
	rts
