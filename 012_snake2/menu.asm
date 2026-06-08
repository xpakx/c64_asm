switch_to_game:
    sei
    lda #<game_logic
    sta scene_logic + 1
    lda #>game_logic
    sta scene_logic + 2

    lda #<game_keys
    sta scene_keys + 1
    lda #>game_keys
    sta scene_keys + 2

    cli
    rts

menu_logic:
    rts

menu_keys:
    cmp #SPACE_KEY
    bne menu_end
    jsr switch_to_game
menu_end:
    rts
