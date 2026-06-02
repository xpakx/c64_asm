; ------------
; Commodore 64 ASM
; ------------

.include 'header.asm'
SOURCE_LOW = $20
SOURCE_HIGH = $21

COLOR_LOW = $22
COLOR_HIGH = $23

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
	jsr init_bitmap_mult
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
	lda #$43
	sta (DEST_LOW),y
	lda #LIGHT_RED
	sta (COLOR_LOW),y
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

	lda #$D8
	sta COLOR_HIGH
	lda #$04
	sta COLOR_LOW
	rts


.include 'subroutines.asm'
.include 'bitmap.asm'


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
