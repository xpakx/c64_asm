; ------------
; Commodore 64 ASM - Snake
; ------------

.include '../common/header.asm'
.include 'snake_header.asm'
.include '../common/basic.asm'

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
    jsr init_menu


program_loop:
    bit FRAME_FLAG
    bpl get_key
scene_logic:
    jsr menu_logic
    lda #0
    sta FRAME_FLAG

get_key:
    jsr GETIN
    beq program_loop

    cmp #Q_KEY
    beq exit_prog
scene_keys:
    jsr menu_keys
    jmp program_loop

exit_prog:
    jsr switch_to_menu
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
    sta segments+1
    sta segments+3
    sta segments+5

    lda #3
    sta segments_len
    lda #$09
    sta segments
    lda #$08
    sta segments+2
    lda #$07
    sta segments+4

    lda #%00000001
    sta direction
    sta next_dir

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


.include 'scenes/movement.asm'
.include 'scenes/menu.asm'
.include 'utils/subroutines.asm'
.include 'utils/interrupts.asm'

seed:
    .byte $F5

segments_len:
    .byte 3
segments:
    .byte $09
    .byte $0A
    .byte $08
    .byte $0A
    .byte $07
    .byte $0A
