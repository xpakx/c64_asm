; ------------
; Commodore 64 ASM
; ------------

.include 'header.asm'
.include 'basic.asm'

*= $0810 

start:
	jsr clr_scr
	lda #RED
	sta BORDER_COLOR
	lda #BLACK
	sta BG_COLOR

	jsr init_bitmap

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

init_bitmap:
	lda #%00011000
	sta VIC_MEM_PTR

	lda #%00111011
	sta VIC_CONTROL_1

	lda #%11001000
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

.include 'subroutines.asm'


*= $2000
sprite_data:
    .byte %00111100
    .byte %01111110
    .byte %11011011
    .byte %11111111
    .byte %11111111
    .byte %11111111
    .byte %01111110
    .byte %00111100
    .byte $00
