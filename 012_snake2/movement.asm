init_game:
    jsr clr_scr
    jsr print_player
    jsr print_segments
    jsr generate_apple
    jsr draw_apple
    rts

game_logic:
    jsr clear_player
    jsr redraw_last_segment
    jsr move_segments
    jsr move_head
    jsr print_player
    jsr print_first_segment
    
    jsr check_collision_apple
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


check_collision_apple:
    lda #%00000000
    sta GROW_FLAG

    lda PLAYER_ROW
    cmp APPLE_ROW
    bne finish_collision
    lda PLAYER_COL
    cmp APPLE_COL
    bne finish_collision

    lda #%10000000
    sta GROW_FLAG
    jsr generate_apple
    jsr draw_apple
finish_collision:
    rts


print_segments:
    ldx #$00
    lda #LIGHT_GREEN
    sta CUR_COLOR  
segments_loop:
    cpx segments_len
    beq end_segments_loop

    txa
    pha

    asl
    tax
    ldy segments+1,x
    lda segments,x
    tax

    clc
    jsr PLOT

    pla
    tax

    lda #KEY_0
    jsr CHROUT

    inx
    bne segments_loop
end_segments_loop:
    rts


redraw_last_segment:
    bit GROW_FLAG
    bmi end_redraw_segments
    jsr clear_last_segment
end_redraw_segments:
    rts

clear_last_segment:
    lda segments_len
    sec
    sbc #1

    asl
    tax
    ldy segments+1,x
    lda segments,x
    tax

    clc
    jsr PLOT

    lda #SPACE_KEY
    jsr CHROUT
    rts

print_first_segment:
    lda #LIGHT_GREEN
    sta CUR_COLOR      

    ldy segments+1
    ldx segments

    clc
    jsr PLOT

    lda #KEY_0
    jsr CHROUT
    rts



move_segments:
    bit GROW_FLAG
    bpl prepare_iterator

    lda segments_len
    inc segments_len

prepare_iterator:
    ldx segments_len
    dex

move_segments_loop:
    txa
    pha

    asl
    tax

    lda segments-2,x
    sta segments,x
    lda segments-1,x
    sta segments+1,x

    pla
    tax

    dex
    cpx #$00
    bne move_segments_loop

move_first_seg:
    lda PLAYER_ROW
    sta segments
    lda PLAYER_COL
    sta segments+1

    rts
