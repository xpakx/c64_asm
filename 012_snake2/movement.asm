init_game:
    jsr generate_apple
    jsr draw_apple
    rts

game_logic:
    jsr clear_player
    jsr move_head
    jsr print_player
    rts


move_head:
    lda next_dir
    sta direction
    cmp #%00000001
    beq move_down
    cmp #%00000010
    beq move_up
    cmp #%00000100
    beq move_left
    cmp #%00001000
    beq move_right
    rts
move_up:
    lda PLAYER_ROW
    beq end_move
    dec PLAYER_ROW
    rts
move_down:
    lda PLAYER_ROW
    cmp #$18
    beq end_move
    inc PLAYER_ROW
    rts
move_left:
    lda PLAYER_COL
    beq end_move
    dec PLAYER_COL
    rts
move_right:
    lda PLAYER_COL
    cmp #$27
    beq end_move
    inc PLAYER_COL
    rts
end_move:
    rts


direction:
	.byte %00000001   ;last bit is down, then up, left, right
next_dir:
	.byte %00000001



game_keys:
    cmp #UP_KEY
    bne test_down
    lda direction
    cmp #%00000001
    beq post_dir
    lda #%00000010
    sta next_dir
    rts
test_down:
    cmp #DOWN_KEY
    bne test_right
    lda direction
    cmp #%00000010
    beq post_dir
    lda #%00000001
    sta next_dir
    rts
test_right:
    cmp #RIGHT_KEY
    bne test_left
    lda direction
    cmp #%00000100
    beq post_dir
    lda #%00001000
    sta next_dir
    rts
test_left:
    cmp #LEFT_KEY
    bne post_dir
    lda direction
    cmp #%00001000
    beq post_dir
    lda #%00000100
    sta next_dir
    rts
post_dir:
    rts


generate_apple:
    jsr get_rand
    and #$3F
    cmp #40
    bcs generate_apple
    sta APPLE_COL
rand_row:
    jsr get_rand
    lda $D41B
    and #$1F
    cmp #25
    bcs rand_row
    sta APPLE_ROW
    rts

draw_apple:
    lda #RED
    sta CUR_COLOR  

    ldx APPLE_ROW
    ldy APPLE_COL
    clc
    jsr PLOT

    lda #KEY_0
    jsr CHROUT
    rts
