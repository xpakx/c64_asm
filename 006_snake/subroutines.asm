print_str:
	pha
	tya
	pha
 	ldy #$00        ; Switched to y, bc we need indexed addressing mode

print_loop:
	lda (STR_PTR),y
 	beq print_done
 	jsr CHROUT
 	iny
 	bne print_loop

print_done:
	pla
	tax
	pla
 	rts

clr_scr:
	lda #$93
	jsr CHROUT
	rts
