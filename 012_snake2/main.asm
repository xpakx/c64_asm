; ------------
; Commodore 64 ASM - Raster Interrupt Version
; ------------

.include 'header.asm'
COUNTER = $02
TIMER_TICK = $03
TEMP = $06
SCREEN = $0400

DEST_LOW = $20
DEST_HIGH = $21
PLAYER_ROW = $22
PLAYER_COL = $23
FRAME_FLAG = $24

.weak
DEBUG = 0
.endweak

.include 'basic.asm'

*= $0810 

start:
    jsr clr_scr
    lda #RED
    sta BORDER_COLOR
    lda #BLACK
    sta BG_COLOR

.if DEBUG
    lda #9
    sta COUNTER
    clc
    adc #$30
    sta SCREEN
.endif

    lda #15
    sta TIMER_TICK

    jsr init_interrupts
    jsr init_player

    jsr get_rand
    tay
    lda #$40
    sta SCREEN,y

program_loop:
    bit FRAME_FLAG
    bpl get_key
    jsr move
    lda #0
    sta FRAME_FLAG

get_key:
    jsr GETIN
    beq program_loop
        
    cmp #Q_KEY
    beq exit_prog

    cmp #UP_KEY
    bne test_down
    lda direction
    cmp #%00000001
    beq program_loop
    lda #%00000010
    sta next_dir
    jmp program_loop
test_down:
    cmp #DOWN_KEY
    bne test_right
    lda direction
    cmp #%00000010
    beq program_loop
    lda #%00000001
    sta next_dir
    jmp program_loop
test_right:
    cmp #RIGHT_KEY
    bne test_left
    lda direction
    cmp #%00000100
    beq program_loop
    lda #%00001000
    sta next_dir
    jmp program_loop
test_left:
    cmp #LEFT_KEY
    bne post_dir
    lda direction
    cmp #%00001000
    beq program_loop
    lda #%00000100
    sta next_dir
    jmp program_loop
post_dir:
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


init_player:
    lda #$0A
    sta PLAYER_ROW
    sta PLAYER_COL
    rts

print_player:
    lda #GREEN
    sta CUR_COLOR  

    ldx PLAYER_ROW
    ldy PLAYER_COL
    clc
    jsr PLOT

    lda #KEY_0
    jsr CHROUT
    rts

clear_player:
    ldx PLAYER_ROW
    ldy PLAYER_COL
    clc
    jsr PLOT

    lda #$20
    jsr CHROUT
    rts

get_rand:
    lda seed
    asl
    asl
    asl
    asl
    asl
    asl
    asl
    clc
    adc seed
    clc
    adc 1
    sta seed
    rts


.include 'movement.asm'
.include 'subroutines.asm'
.include 'interrupts.asm'

seed:
	.byte $F5
