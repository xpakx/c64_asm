MENU_TIMER = $29
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

   lda #7
   sta MENU_TIMER
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
    dec MENU_TIMER
    bne menu_logic_after_reset
    lda #7

    sta MENU_TIMER

    ldx #$4A
    ldy #$0A
    clc
    jsr PLOT

    lda #BLACK
    sta CUR_COLOR  

    lda #<menu_msg
    sta STR_PTR
    lda #>menu_msg
    sta STR_PTR+1
    jsr print_str
menu_logic_after_reset:
    lda MENU_TIMER
    cmp #6
    bne menu_logic_end

    ldx #$4A
    ldy #$0A
    clc
    jsr PLOT
    lda #WHITE
    sta CUR_COLOR  

    lda #<menu_msg
    sta STR_PTR
    lda #>menu_msg
    sta STR_PTR+1
    jsr print_str
menu_logic_end:
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
