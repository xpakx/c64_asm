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
	lda #BLACK
	sta BORDER_COLOR
	lda #RED
	sta BG_COLOR

prepare_sprite:
	lda #%00
	sta SPRITE_MSB
	lda #%11
	sta VIC_ENABLE
	lda #%10
	sta SPRITE_MULTICOLOR_ENABLE

	; color sprite
	lda #$80
	sta SPRITE_1_PTR

	lda #100
	sta SPRITE_1_X
	sta SPRITE_1_Y

	lda #GREY_2
	sta SPRITE_MULTICOLOR_0

	lda #GREY_1
	sta SPRITE_COL_1
    
	lda #LIGHT_RED
	sta SPRITE_MULTICOLOR_1

	; contour sprite
	lda #$81
	sta SPRITE_0_PTR

	lda #100
	sta SPRITE_0_X
	sta SPRITE_0_Y

	lda #BLACK
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
	eor #11
	sta HORIZONTAL_EXPAND
	sta VERTICAL_EXPAND
	rts

.include 'subroutines.asm'
.include 'movement2.asm'



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
    .byte $06,$7d,$80
    .byte $09,$82,$70
    .byte $10,$02,$48
    .byte $24,$01,$84
    .byte $44,$00,$22
    .byte $85,$86,$22
    .byte $88,$82,$22
    .byte $89,$86,$22
    .byte $88,$00,$22
    .byte $48,$00,$44
    .byte $36,$01,$98
    .byte $01,$86,$80
    .byte $02,$ce,$60
    .byte $0d,$ff,$10
    .byte $11,$ff,$10
    .byte $13,$ff,$e0
    .byte $0f,$ff,$f0
    .byte $0f,$ff,$e0
    .byte $07,$ff,$c0
    .byte $00,$99,$00
    .byte $00,$66,$00
    .byte $00
