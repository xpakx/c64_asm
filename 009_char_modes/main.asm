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

	jsr init_font
	jsr put_char

program_loop:

get_key:
        jsr GETIN
        beq program_loop
        
        cmp #Q_KEY
        beq exit_prog

	jmp program_loop

exit_prog:
	jsr disable_font
	jsr clr_scr
	lda #WHITE
	sta CUR_COLOR  
	lda #LIGHT_BLUE
	sta BORDER_COLOR
	lda #BLUE
	sta BG_COLOR
        rts

init_font:
	rts

disable_font:
	rts

put_char:
	lda #$01 ;A
	sta SCREEN_RAM + $019A
	lda #WHITE
	sta COLOR_RAM + $019A
	rts


.include 'subroutines.asm'


*= $2000
sprite_data:
    .byte %00111100
    .byte %01111110
    .byte %11011011
    .byte %11111111
    .byte %11011011
    .byte %11100111
    .byte %01111110
    .byte %00111100
    .byte $00
