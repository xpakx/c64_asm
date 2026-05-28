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
	cmp #UP_KEY
	beq move_up
	cmp #DOWN_KEY
	beq move_down
	cmp #LEFT_KEY
	beq move_left
	cmp #RIGHT_KEY
	beq move_right

	cmp #S_KEY
	beq scale

	jmp program_loop

move_up:
	lda SPRITE_0_Y
	sec
	sbc #10
	sta SPRITE_0_Y
	jmp program_loop

move_down:
	lda SPRITE_0_Y
	clc
	adc #10
	sta SPRITE_0_Y
	jmp program_loop

move_left:
	lda SPRITE_0_X
	sec
	sbc #10
	sta SPRITE_0_X
	jmp program_loop

move_right:
	lda SPRITE_0_X
	clc
	adc #10
	sta SPRITE_0_X
	jmp program_loop

scale:
	jsr toggle_scale
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

toggle_scale:
	lda HORIZONTAL_EXPAND
	eor #1
	sta HORIZONTAL_EXPAND
	sta VERTICAL_EXPAND
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
