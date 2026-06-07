move:
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
