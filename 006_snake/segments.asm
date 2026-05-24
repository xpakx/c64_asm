; -----------------
; Printing Segments
; -----------------
print_segments:
 	ldx #$00
	lda #LIGHT_GREEN
	sta CUR_COLOR  

segments_loop:
	cpx segments_len
	beq end_segments_loop

	txa
	pha

	asl
	tax
	ldy segments+1,x
	lda segments,x
	tax

	clc
	jsr PLOT

	pla
	tax

	lda #KEY_0
 	jsr CHROUT

 	inx
 	bne segments_loop

end_segments_loop:
	rts


; ---------------
; Moving Segments
; ---------------
move_segments:
 	ldx segments_len
	dex

move_segments_loop:
	txa
	pha

	asl
	tax

	lda segments-2,x
	sta segments,x
	lda segments-1,x
	sta segments+1,x

	pla
	tax

 	dex
	cpx #$00
 	bne move_segments_loop

move_first_seg:
	lda player_row
	sta segments
	lda player_col
	sta segments+1

	rts
