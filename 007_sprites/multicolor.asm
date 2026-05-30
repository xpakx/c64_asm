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

	lda #1 ;first bit is first sprite
	sta VIC_ENABLE

	; multicolor setup
	lda #1 ;first bit is first sprite
	sta SPRITE_MULTICOLOR_ENABLE

	lda #CYAN
	sta SPRITE_MULTICOLOR_0
    
	lda #PURPLE
	sta SPRITE_MULTICOLOR_1
    
	lda #GREEN
	sta SPRITE_COL_0

program_loop:

get_key:
        jsr GETIN
        beq program_loop
        
        cmp #Q_KEY
        beq exit_prog

test_up_key:
	cmp #UP_KEY
	bne test_down_key
	jsr move_up
	jmp program_loop
test_down_key:
	cmp #DOWN_KEY
	bne test_left_key
	jsr move_down
	jmp program_loop
test_left_key:
	cmp #LEFT_KEY
	bne test_right_key
	jsr move_left
	jmp program_loop
test_right_key:
	cmp #RIGHT_KEY
	bne test_scale_key
	jsr move_right
	jmp program_loop
test_scale_key:
	cmp #S_KEY
	bne after_keys
	jsr toggle_scale
	jmp program_loop
after_keys:
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
.include 'movement.asm'



*= $2000
sprite_data:
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $1b,$1b,$1b
    .byte $00
