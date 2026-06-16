; ------------
; Commodore 64 ASM
; ------------

.include 'header.asm'
V1_FREQ_LO = $D400
V1_FREQ_HI = $D401
V1_CTRL    = $D404
V1_AD      = $D405
V1_SR      = $D406
SID_VOL    = $D418


NOTE_DURATION = 50
TIMER_TICK = $01
FRAME_FLAG = $02

.include 'basic.asm'

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
	sta note_index
	sta tick_counter

	lda #15
	sta TIMER_TICK
	lda #0
	sta FRAME_FLAG
	jsr init_interrupts


program_loop:


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
	dec tick_counter
	lda tick_counter
	bne music_done
	lda #$20
	sta V1_CTRL


	ldx note_index

	lda melody,x
	cmp #$FF
	bne load_note

	ldx #$00
	stx note_index
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


	ldx note_index
	lda melody_dur,x
	tax
	lda duration,x
	sta tick_counter

	inc note_index

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
    sta vic_irm
    
    lda #%10000001
    sta cia1_icr
    
    lda #$31
    sta irr_addr_low
    lda #$ea
    sta irr_addr_high

    asl vic_irr
    
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
    jmp $ea31


note_bank_high:
          ;c    d    e    f    g    a    h
    .byte $11, $13, $15, $17, $1A, $1D, $20

note_bank_low:
    .byte $65, $88, $ED, $3B, $13, $45, $DA

duration:
    .byte 104, 52, 26, 13

melody:
    .byte 0, 0, 4, 4, 5, 5, 4, 3, 3, 2, 2, 1, 1, 0
    .byte 5, 5, 4, 4, 3, 3, 2, 5, 5, 4, 4, 3, 3, 2
    .byte 0, 0, 4, 4, 5, 5, 4, 3, 3, 2, 2, 1, 1, 0
    .byte $FF
melody_dur:
    .byte 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0
    .byte 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0
    .byte 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0

note_index:   .byte 0
tick_counter: .byte 0
frame_processed:   .byte 0

.include 'subroutines.asm'
