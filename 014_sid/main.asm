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

.include 'basic.asm'

*= $0810 

start:
	jsr clr_scr
	lda #RED
	sta BORDER_COLOR
	lda #BLACK
	sta BG_COLOR

init:
	lda #$01
        sta SID_VOL
        
        lda #$09
        sta V1_AD
        
        lda #$00
        sta V1_SR

        ldy #$00

program_loop:

get_key:
        jsr GETIN
        beq program_loop
        
        cmp #Q_KEY
        beq exit_prog

	cmp #KEY_1
	beq play_c

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

play_c:
	lda #$20
	sta V1_CTRL

	lda #$65            
	sta V1_FREQ_LO
	lda #$11            
	sta V1_FREQ_HI

	lda #$21
	sta V1_CTRL

	jmp program_loop

.include 'subroutines.asm'
