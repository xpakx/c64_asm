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
