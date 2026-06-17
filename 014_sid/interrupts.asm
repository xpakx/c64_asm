; ------------
; Commodore 64 ASM
; ------------

.include '../common/header.asm'

FRAME_FLAG = $02
TIMER_TICK = $03
NOTE_DURATION = $04
NOTE_INDEX = $05

.include '../common/basic.asm'

*= $0810 

start:
	jsr clr_scr
	lda #RED
	sta BORDER_COLOR
	lda #BLACK
	sta BG_COLOR

init:
	lda #$04
        sta SID_VOL
        
        lda #$09
        sta V1_AD
        
        lda #$80
        sta V1_SR

	lda #$00
	sta NOTE_INDEX

	lda #15
	sta TIMER_TICK
	lda #0
	sta FRAME_FLAG
	jsr init_interrupts
	lda #1
	sta NOTE_DURATION


program_loop:
	bit FRAME_FLAG
	bpl get_key
	jsr play_background_music
	lda #0
	sta FRAME_FLAG
get_key:
        jsr GETIN
        beq program_loop

        cmp #Q_KEY
        beq exit_prog

	jmp program_loop


exit_prog:
        lda #$00
        sta SID_VOL
	jsr clean_interrupts
	jsr clr_scr
	lda #WHITE
	sta CUR_COLOR  
	lda #LIGHT_BLUE
	sta BORDER_COLOR
	lda #BLUE
	sta BG_COLOR
        rts

play_background_music:
	dec NOTE_DURATION
	lda NOTE_DURATION
	bne music_done

	lda #$20
	sta V1_CTRL


	ldx NOTE_INDEX

	lda melody,x
	cmp #$FF
	bne load_note

	ldx #$00
	stx NOTE_INDEX
	lda melody,x

load_note:
	tax

	clc
	adc #$30
	sta $0400

	lda note_bank_high,x
	sta V1_FREQ_HI
	lda note_bank_low, x
	sta V1_FREQ_LO

	lda #$21
	sta V1_CTRL


	ldx NOTE_INDEX
	lda melody_dur,x
	tax
	lda duration,x
	sta NOTE_DURATION

	inc NOTE_INDEX

music_done:
	rts

init_interrupts:
	sei
	lda #%01111111
	sta CIA1_ICR

	and $D011
	sta $D011

	lda CIA1_ICR
	lda CIA2_ICR
    
	lda #242
	sta VIC_RASTER

	lda VIC_CONTROL_1
	and #%01111111
	sta VIC_CONTROL_1

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
    	sta IRR_ADDR_HIGh
	
    	asl VIC_IRR
    
    	cli
    	rts

irq:
    	dec TIMER_TICK
    	bne exit_irq

    	lda #15
    	sta TIMER_TICK

    	lda #%10000000
    	sta FRAME_FLAG
exit_irq:
    	asl VIC_IRR
    	jmp $EA31


note_bank_high:
	       ;c    d    e    f    g    a    h
    	.byte $11, $13, $15, $17, $1A, $1D, $20

note_bank_low:
	.byte $65, $88, $ED, $3B, $13, $45, $DA

duration:
	.byte 4, 2, 1

melody:
	.byte 0, 0, 4, 4, 5, 5, 4, 3, 3, 2, 2, 1, 1, 0
	.byte 5, 5, 4, 4, 3, 3, 2, 5, 5, 4, 4, 3, 3, 2
	.byte 0, 0, 4, 4, 5, 5, 4, 3, 3, 2, 2, 1, 1, 0
	.byte $FF
melody_dur:
	.byte 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0
	.byte 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0
	.byte 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0

.include 'subroutines.asm'
