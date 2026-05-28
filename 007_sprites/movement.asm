move_up:
	lda SPRITE_0_Y
	sec
	sbc #10
	sta SPRITE_0_Y
	rts

move_down:
	lda SPRITE_0_Y
	clc
	adc #10
	sta SPRITE_0_Y
	rts

move_left:
	lda SPRITE_0_X
	sec
	sbc #10
	sta SPRITE_0_X
	rts

move_right:
	lda SPRITE_0_X
	clc
	adc #10
	sta SPRITE_0_X
	rts
