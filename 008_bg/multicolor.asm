; ------------
; Commodore 64 ASM
; ------------

.include 'header.asm'
SOURCE_LOW = $20
SOURCE_HIGH = $21

DEST_LOW = $24
DEST_HIGH = $25

.include 'basic.asm'

*= $0810 

start:
	jsr clr_scr
	lda #RED
	sta BORDER_COLOR
	lda #BLACK
	sta BG_COLOR

	jsr clear_bitmap
	jsr init_bitmap
	jsr draw_bitmap

program_loop:

get_key:
        jsr GETIN
        beq program_loop
        
        cmp #Q_KEY
        beq exit_prog

	jmp program_loop

exit_prog:
	jsr disable_bitmap
	lda #0
	sta VIC_ENABLE
	jsr clr_scr
	lda #WHITE
	sta CUR_COLOR  
	lda #LIGHT_BLUE
	sta BORDER_COLOR
	lda #BLUE
	sta BG_COLOR
        rts

draw_bitmap:
	lda #<sprite_data
	sta SOURCE_LOW
	lda #>sprite_data
	sta SOURCE_HIGH

	; TODO position
	jsr get_screen_pos
bitmap_next_line:
	ldy #0
bitmap_next_byte:
	lda (SOURCE_LOW),y
	sta (DEST_LOW),y
	iny
	cpy #8
	bne bitmap_next_byte
color:
	jsr get_col_mem_pos
	ldy #0
	lda #$40
	sta (DEST_LOW),y
	rts


; TODO, use x, y pos from x and y register
get_screen_pos:
	lda #<$2020
	sta DEST_LOW
	lda #>$2020
	sta DEST_HIGH
	rts

get_col_mem_pos:
	lda #$04
	sta DEST_HIGH
	lda #$04
	sta DEST_LOW
	rts

init_bitmap:
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

.include 'subroutines.asm'


*= $1500
sprite_data:
	.byte %00000101
	.byte %00000101
	.byte %00000101
	.byte %00000101

	.byte %10101111
	.byte %10101111
	.byte %10101111
	.byte %10101111
