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
