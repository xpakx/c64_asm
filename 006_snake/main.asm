; ------------
; Commodore 64 ASM
; ------------

.include 'header.asm'
.include 'basic.asm'

*= $0810 

start:
	lda #RED
	sta BORDER_COLOR
	lda #BLACK
	sta BG_COLOR

	lda $A0
	clc
	adc #30
	sta target_time

print_player:
	jsr clr_scr

	lda #GREEN
	sta CUR_COLOR  

	ldx player_row
	ldy player_col
	clc
	jsr PLOT

	lda #KEY_0
 	jsr CHROUT

get_key:
        jsr GETIN
        beq check_timer
        
        cmp #Q_KEY
        beq exit_prog

check_timer:
	lda $A0            ; Load clock
    	sec
    	sbc target_time
    	cmp #30            ; 30 jiffies
    	bcc get_key

    	; --- 30 jiffies have passed ---
    	inc player_row
    	
    	; Update target_time
	clc
	lda target_time
	adc #30
	sta target_time 

    	jmp print_player

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

player_row:
 	.byte $0A

player_col:
 	.byte $0A

segments:
 	.byte $0
 	.byte $0
 	.byte $05
 	.byte $05
	.byte $FF

target_time:
	.byte 0
