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

prepare_sprite:
	lda #$80
	sta SPRITE_0_PTR

	lda #100
	sta SPRITE_0_X
	sta SPRITE_0_Y

	lda #0
	sta SPRITE_MSB

	lda #GREEN
	sta SPRITE_COL_0

	lda #1
	sta VIC_ENABLE

program_loop:

get_key:
        jsr GETIN
        beq program_loop
        
        cmp #Q_KEY
        beq exit_prog

	jmp program_loop

exit_prog:
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

.include 'subroutines.asm'



*= $2000
sprite_data:
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $AA, $AA, $AA
    .byte $00
