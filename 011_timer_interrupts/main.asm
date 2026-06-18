; ------------
; Commodore 64 ASM
; ------------

.include '../common/header.asm'
COUNTER = $02
TIMER_TICK = $03
SCREEN = $0400
.include '../common/basic.asm'

*= $0810 

start:
	jsr clr_scr
	lda #RED
	sta BORDER_COLOR
	lda #BLACK
	sta BG_COLOR


	lda #9
	sta COUNTER
	clc
	adc #$30
	sta SCREEN

	lda #60
	sta TIMER_TICK

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
	lda #<irq
	sta IRR_ADDR_LOW
	lda #>irq
	sta IRR_ADDR_HIGH
	cli
	rts

clean_interrupts:
	sei
	lda #$31
	sta IRR_ADDR_LOW
	lda #$EA
	sta IRR_ADDR_HIGH
	cli
	rts

irq:
	dec TIMER_TICK
	bne exit_irq ; not yet 60

	lda #60
	sta TIMER_TICK

	lda COUNTER
	beq exit_irq

	dec COUNTER
    
	lda COUNTER
	clc
	adc #$30
	sta SCREEN
exit_irq:
	jmp $EA31

.include 'subroutines.asm'
