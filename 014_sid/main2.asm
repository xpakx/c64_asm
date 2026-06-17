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

init:
	lda #$04
        sta SID_VOL
        
        lda #$09
        sta V1_AD
        
        lda #$F0
        sta V1_SR

        ldy #$00

program_loop:

get_key:
	lda $CB
        cmp #$40
        beq release
        
        jsr GETIN
        beq program_loop

        cmp #Q_KEY
        beq exit_prog

	cmp #KEY_1
	beq play_c
	cmp #KEY_2
	beq play_d
	cmp #KEY_3
	beq play_e
	cmp #KEY_4
	beq play_f
	cmp #KEY_5
	beq play_g
	cmp #KEY_6
	beq play_a
	cmp #KEY_7
	beq play_h

	jmp program_loop

release:
        jsr stop_note
	jmp program_loop

play_c:
	ldx #$65
	ldy #$11
	jsr play_note
	jmp program_loop

play_d:
	ldx #$88
	ldy #$13
	jsr play_note
	jmp program_loop

play_e:
	ldx #$ED
	ldy #$15
	jsr play_note
	jmp program_loop

play_f:
	ldx #$3B
	ldy #$17
	jsr play_note
	jmp program_loop

play_g:
	ldx #$13
	ldy #$1A
	jsr play_note
	jmp program_loop

play_a:
	ldx #$45
	ldy #$1D
	jsr play_note
	jmp program_loop

play_h:
	ldx #$DA
	ldy #$20
	jsr play_note
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

play_note:
	lda #$20
	sta V1_CTRL

	txa    
	sta V1_FREQ_LO
	tya
	sta V1_FREQ_HI

	lda #$21
	sta V1_CTRL
	rts

stop_note:
	lda #$20
	sta V1_CTRL
	rts

.include 'subroutines.asm'
