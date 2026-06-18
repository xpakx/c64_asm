; ------------
; Commodore 64 ASM
; ------------

.include '../common/header.asm'
.include '../common/basic.asm'

*= $0810 

start:
	lda #WHITE
	sta CUR_COLOR  

prepare_text:
	jsr clr_scr ; prolly would be better to clear only current cursor while moving and move this back to start label
	ldx text_row
	ldy text_col
	clc
	jsr PLOT

	lda #<message
	sta STR_PTR
	lda #>message
	sta STR_PTR+1

	jsr print_str

loop:
        jsr GETIN
        beq loop
        
        cmp #Q_KEY
        beq exit_prog

        cmp #M_KEY
        beq change_text_color

        cmp #B_KEY
        beq change_border_color

        cmp #S_KEY
        beq change_bg_color

        cmp #UP_KEY
        beq move_up
        
        cmp #DOWN_KEY
        beq move_down
        
        cmp #LEFT_KEY
        beq move_left
        
        cmp #RIGHT_KEY
        beq move_right
        
        jmp loop

change_text_color:
	inc CUR_COLOR
	jmp prepare_text

change_border_color:
	inc BORDER_COLOR
	jmp loop

change_bg_color:
	inc BG_COLOR
	jmp loop

move_up:
	lda text_row
	beq loop		; if we already in row 0
	dec text_row
	jmp prepare_text

move_down:
	lda text_row
	cmp #$18
	beq loop
	inc text_row
	jmp prepare_text

move_left:
	lda text_col
	beq loop
	dec text_col
	jmp prepare_text

move_right:
	lda text_col
	cmp #$28 - (end_msg - message) + 1
	beq loop
	inc text_col
	jmp prepare_text

exit_prog:
	jsr clr_scr
	lda #WHITE
	sta CUR_COLOR  
	lda #LIGHT_BLUE
	sta BORDER_COLOR
	lda #BLUE
	sta BG_COLOR
        rts

message:
 	.text "HELLO"
 	.byte 0
end_msg:

text_row:
 	.byte $0A

text_col:
 	.byte $0A

.include 'subroutines.asm'
