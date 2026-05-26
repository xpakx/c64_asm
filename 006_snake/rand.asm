; using SID chip for random number
init_rand:
	lda #$FF
	sta $D40E
	sta $D40F
	lda #$80
	sta $D412
	rts

get_rand:
	lda $D41B
	rts

generate_apple:
	lda $D41B
	and #$3F
	; TODO: maybe better to just decrement instead of rerolling?
	cmp #40
	bcs generate_apple
	sta apple_col
rand_row:
	lda $D41B
	and #$1F
	cmp #25
	bcs rand_row
	sta apple_row
	rts
