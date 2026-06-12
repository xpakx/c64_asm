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
	jsr init_interrupts

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
	jsr clean_interrupts
	jsr clr_scr
	lda #WHITE
	sta CUR_COLOR  
	lda #LIGHT_BLUE
	sta BORDER_COLOR
	lda #BLUE
	sta BG_COLOR
        rts

init_interrupts:
	sei
	; DC0D write uses value of bit 7 for all set bits
	lda #%01111111
	sta $DC0D

	and $D011
	sta $D011

	; these registers behave differently on write and on read
	lda $DC0D    ; read to clear flags
	lda $DD0D    ; read to clear flags

	lda #150   ; raster line for interrupt
	sta $D012

	lda #<irq
	sta $0314
	lda #>irq
	sta $0315

	lda #%00000001
	sta $D01A

	cli
	rts

clean_interrupts:
	sei

	lda #%00000000
	sta $D01A       

	lda #%10000001  
	sta $DC0D       

	lda #$31
	sta $0314
	lda #$EA
	sta $0315

	asl $D019       

	cli
	rts

irq:
	lda #YELLOW
	sta BORDER_COLOR

	lda #160
	sta SPRITE_0_X
	sta SPRITE_0_Y

	; set next interrupt at line 200
	LDA #<irq2
	STA $0314
	LDA #>irq2
	STA $0315
	lda #200
	sta $D012

	asl $D019
	jmp $EA31


irq2:
	lda #BLACK
	sta BORDER_COLOR
	lda #RED
	sta BG_COLOR

	lda #100
	sta SPRITE_0_X
	sta SPRITE_0_Y

	; set previous interrupt
	lda #<irq
	sta $0314
	lda #>irq
	sta $0315
	lda #150
	sta $D012

	asl $D019
	jmp $EA81

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
