clear_bitmap:
	lda #$00
	sta DEST_LOW
	lda #$20
	sta DEST_HIGH
	ldx #32
clear_bitmap_loop:
	ldy #0
	lda #0
clear_bitmap_byte:
	dey
	sta (DEST_LOW),y
	bne clear_bitmap_byte

	inc DEST_HIGH
	dex
	bne clear_bitmap_loop
	rts

init_bitmap_hires:
	lda #%00011000
	sta VIC_MEM_PTR

	lda #%00111011
	sta VIC_CONTROL_1

	lda #%11001000
	sta VIC_CONTROL_2
	rts

init_bitmap_mult:
	lda #%00011000
	sta VIC_MEM_PTR

	lda #%00111011
	sta VIC_CONTROL_1

	lda #%11011000
	sta VIC_CONTROL_2
	rts

disable_bitmap:
	lda #%00011011
	sta VIC_CONTROL_1

	lda #%00010100
	sta VIC_MEM_PTR

	lda #%00001000
	sta VIC_CONTROL_2
    
	jsr clr_scr
	rts
