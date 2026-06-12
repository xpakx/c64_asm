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

wait_raster_150:
	bit $D011
	bmi wait_raster_150   ; bit 7 set -> lines 256+
	lda $D012
	cmp #150
	bne wait_raster_150

	lda #YELLOW
	sta BORDER_COLOR

	lda #160
	sta SPRITE_0_X
	sta SPRITE_0_Y


wait_raster_200:
	lda $D012
	cmp #200
	bne wait_raster_200

	lda #BLACK
	sta BORDER_COLOR
	lda #RED
	sta BG_COLOR

	lda #100
	sta SPRITE_0_X
	sta SPRITE_0_Y

get_key:
        jsr GETIN
        beq program_loop
        
        cmp #Q_KEY
        beq exit_prog

	jmp program_loop

exit_prog:
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
    .byte $01,$ff,$80
    .byte $04,$00,$60
    .byte $04,$00,$60
    .byte $08,$00,$00
    .byte $08,$00,$20
    .byte $06,$06,$20
    .byte $12,$02,$20
    .byte $06,$46,$20
    .byte $10,$a0,$40
    .byte $0c,$01,$80
    .byte $03,$06,$80
    .byte $05,$9e,$60
    .byte $1b,$ff,$10
    .byte $23,$ff,$10
    .byte $27,$ff,$e0
    .byte $1f,$ff,$f0
    .byte $1f,$ff,$e0
    .byte $0f,$ff,$c0
    .byte $01,$32,$00
    .byte $01,$32,$00
    .byte $00,$cc,$00
    .byte $00
