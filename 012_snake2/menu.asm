init_menu:
   ldx #$4A
   ldy #$0A
   jsr PLOT

   lda #WHITE
   sta CUR_COLOR  

   lda #<menu_msg
   sta STR_PTR
   lda #>menu_msg
   sta STR_PTR+1
   jsr print_str
   rts

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

    jsr init_game

    rts

switch_to_menu:
    sei
    lda #<menu_logic
    sta scene_logic + 1
    lda #>menu_logic
    sta scene_logic + 2

    lda #<menu_keys
    sta scene_keys + 1
    lda #>menu_keys
    sta scene_keys + 2

    cli
    rts

menu_logic:
    jsr get_rand
    rts

menu_keys:
    cmp #SPACE_KEY
    bne menu_end
    jsr switch_to_game
menu_end:
    rts


menu_msg:
    .text "PRESS FIRE TO START"
    .byte 0
