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
	jsr init_interrupts


program_loop:

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

init_interrupts:
	sei
	lda #%01111111
	sta $DC0D

	and $D011
	sta $D011


	sta $DC0D
	sta $DD0D

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

irq:
	lda #YELLOW
	sta BORDER_COLOR

	ldx #$B0
pause:
	dex
	bne pause

	lda #BLACK
	sta BORDER_COLOR
	lda #RED
	sta BG_COLOR

	asl $D019 ; ack interrupt
	jmp $EA31 ; jump to standard interrupt service routine

.include 'subroutines.asm'
