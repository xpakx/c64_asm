; ------------
; Commodore 64 ASM
; ------------

.include '../common/header.asm'
SOURCE_LOW = $20
SOURCE_HIGH = $21

DEST_LOW = $24
DEST_HIGH = $25

.include '../common/basic.asm'

*= $0810 

start:
	jsr clr_scr
	lda #RED
	sta BORDER_COLOR
	lda #BLACK
	sta BG_COLOR

	jsr init_font
	jsr put_char
	jsr activate_multicolor

program_loop:


get_key:
        jsr GETIN
        beq program_loop
        
        cmp #Q_KEY
        beq exit_prog

	jmp program_loop

exit_prog:
	jsr disable_font
	jsr disable_multicolor
	jsr clr_scr
	lda #WHITE
	sta CUR_COLOR  
	lda #LIGHT_BLUE
	sta BORDER_COLOR
	lda #BLUE
	sta BG_COLOR
        rts

init_font:
	ldx #0
copy_font_loop:
	lda sprite_data,x
	sta $3008,x
	inx
	cpx #8
	bne copy_font_loop

	lda $D018
	and #%11110001     ; clear character memory bits
	ora #%00001100     ; Set character memory to slot 3/%011 (at $3000)
	sta $D018
	rts

disable_font:
	lda $D018
	and #%11110001
	ora #%00000100
	sta $D018
	rts

put_char:
	lda #$01 ;A
	sta SCREEN_RAM + $019A
	lda #WHITE
	sta COLOR_RAM + $019A
	rts

activate_multicolor:
	lda VIC_CONTROL_2  ; multicolor
	ora #%00010000
	sta VIC_CONTROL_2

	lda #GREEN
	sta $D022
	lda #YELLOW
	sta $D023

	lda #$09          ;multicolor flag for tile
	sta $D99A
	rts

disable_multicolor:
	lda VIC_CONTROL_2  ; multicolor
	and #%11101111
	sta VIC_CONTROL_2
	rts


.include 'subroutines.asm'


*= $2000
sprite_data:
	.byte %00000101
	.byte %00000101
	.byte %00000101
	.byte %00000101

	.byte %10101111
	.byte %10101111
	.byte %10101111
	.byte %10101111

