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

	lda #0
	sta SPRITE_MSB

	; color sprite
	lda #%01
	sta VIC_ENABLE

	lda #%01
	sta SPRITE_MULTICOLOR_ENABLE

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

	lda #%10
	sta VIC_ENABLE

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
    .byte $00,$a8,$40
    .byte $02,$a9,$90
    .byte $0a,$aa,$40
    .byte $2a,$aa,$a0
    .byte $2e,$aa,$e0
    .byte $ae,$66,$e8
    .byte $b2,$66,$38
    .byte $b2,$ee,$38
    .byte $b2,$aa,$38
    .byte $20,$b8,$20
    .byte $00,$64,$00
    .byte $02,$56,$00
    .byte $0a,$56,$80
    .byte $09,$55,$80
    .byte $05,$55,$40
    .byte $05,$55,$40
    .byte $05,$55,$40
    .byte $01,$55,$00
    .byte $00,$88,$00
    .byte $00,$88,$00
    .byte $00,$44,$00
    .byte $00


contour_data:
    .byte $00,$a8,$40
    .byte $02,$a9,$90
    .byte $0a,$aa,$40
    .byte $2a,$aa,$a0
    .byte $2e,$aa,$e0
    .byte $ae,$66,$e8
    .byte $b2,$66,$38
    .byte $b2,$ee,$38
    .byte $b2,$aa,$38
    .byte $20,$b8,$20
    .byte $00,$64,$00
    .byte $02,$56,$00
    .byte $0a,$56,$80
    .byte $09,$55,$80
    .byte $05,$55,$40
    .byte $05,$55,$40
    .byte $05,$55,$40
    .byte $01,$55,$00
    .byte $00,$88,$00
    .byte $00,$88,$00
    .byte $00,$44,$00
    .byte $00
