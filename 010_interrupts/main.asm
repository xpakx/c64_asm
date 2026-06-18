; ------------
; Commodore 64 ASM
; ------------

.include '../common/header.asm'
.include '../common/basic.asm'

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
	lda #%01111111
	sta CIA1_ICR

	and $D011
	sta $D011

	lda CIA1_ICR
	lda CIA2_ICR

	lda #150   ; raster line for interrupt
	sta VIC_RASTER

	lda #<irq
	sta IRR_ADDR_LOW
	lda #>irq
	sta IRR_ADDR_HIGH

	lda #%00000001
	sta VIC_IRM

	cli
	rts

clean_interrupts:
	sei

	lda #%00000000
	sta VIC_IRM

	lda #%10000001  
	sta CIA1_ICR       

	lda #$31
	sta IRR_ADDR_LOW
	lda #$EA
	sta IRR_ADDR_HIGH

	asl VIC_IRR

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

	asl VIC_IRR ; ack interrupt
	jmp $EA31 ; jump to standard interrupt service routine

.include 'subroutines.asm'
