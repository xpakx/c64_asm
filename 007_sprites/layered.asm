; ----------------
; Commodore 64 ASM
; ----------------
; layered sprites
; ----------------

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

	lda #%00
	sta SPRITE_MSB
	lda #%11
	sta VIC_ENABLE
	lda #%01
	sta SPRITE_MULTICOLOR_ENABLE

	; color sprite

	lda #CYAN
	sta SPRITE_MULTICOLOR_0
    
	lda #PURPLE
	sta SPRITE_MULTICOLOR_1
    
	lda #GREEN
	sta SPRITE_COL_0

	; contour sprite
	lda #$81
	sta SPRITE_1_PTR

	lda #100
	sta SPRITE_1_X
	sta SPRITE_1_Y

	lda #GREEN
	sta SPRITE_COL_1

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
    .byte $00,$00,$00
    .byte $05,$55,$40
    .byte $05,$55,$50
    .byte $15,$55,$74
    .byte $15,$55,$74
    .byte $5d,$55,$74
    .byte $75,$55,$74
    .byte $75,$75,$74
    .byte $77,$67,$74
    .byte $15,$55,$94
    .byte $02,$aa,$00
    .byte $00,$aa,$00
    .byte $02,$21,$40
    .byte $01,$00,$60
    .byte $06,$00,$90
    .byte $08,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$a5,$00
    .byte $00


contour_data:
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00,$00,$00
    .byte $00
