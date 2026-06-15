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


NOTE_DURATION = 24

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
        
        lda #$F0
        sta V1_SR

	lda #$00
	sta note_index
	lda #$01
	sta tick_counter
	sta frame_processed

program_loop:
	lda $D012
	bne reset_poll_flag

	lda frame_processed
	bne get_key
    
	lda #$01
    	sta frame_processed
    	jsr play_background_music
    	jmp get_key

reset_poll_flag:
	lda #$00
	sta frame_processed

get_key:
        jsr GETIN
        beq program_loop

        cmp #Q_KEY
        beq exit_prog

	jmp program_loop


exit_prog:
        lda #$00
        sta SID_VOL
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

	ldx note_index
	lda note_bank_high, x
	cmp #$FF
	bne load_note

	ldx #$00
	stx note_index
	lda note_bank_high, x

load_note:
	sta V1_FREQ_HI
	lda note_bank_low, x
	sta V1_FREQ_LO

	lda #$20
	sta V1_CTRL
	lda #$21
	sta V1_CTRL

	inx
	stx note_index

	lda #NOTE_DURATION
	sta tick_counter

music_done:
	rts



note_bank_high:
          ;c    d    e    f    g    a    h
    .byte $11, $13, $15, $17, $1A, $1D, $20

note_bank_low:
    .byte $65, $88, $ED, $3B, $13, $45, $DA

melody:
    .byte 0, 0, 4, 4, 5, 4, 3, 3, 2, 2, 1, 1, 0
    .byte $FF

note_index:   .byte 0
tick_counter: .byte 0
frame_processed:   .byte 0

.include 'subroutines.asm'
