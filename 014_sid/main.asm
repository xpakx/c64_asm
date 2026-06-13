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

.include 'subroutines.asm'
