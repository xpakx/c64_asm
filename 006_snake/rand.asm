; -----------------
; Initializing rand
; (uses SID chip)
; -----------------
init_rand:
	lda #$FF
	sta $D40E
	sta $D40F
	lda #$80
	sta $D412
	rts

init_rand_seed:
	lda LOW_TIME
	bne non_zero_seed
	lda #$FF
	sta $D40E
non_zero_seed:
	sta $D40E
	sta $D40F
	lda #$80
	sta $D412
	rts

; ------------------------
; generating random number
; ------------------------
get_rand:
	lda $D41B
	rts

; -------------------------------
; moving apple to random position
; -------------------------------
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
