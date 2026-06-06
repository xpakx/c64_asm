; ------------
; Commodore 64 ASM - Raster Interrupt Version
; ------------

.include 'header.asm'
COUNTER = $02
TIMER_TICK = $03
SCREEN = $0400

.include 'basic.asm'

*= $0810 

start:
    jsr clr_scr
    lda #RED
    sta BORDER_COLOR
    lda #BLACK
    sta BG_COLOR

    lda #9
    sta COUNTER
    clc
    adc #$30
    sta SCREEN

    lda #15
    sta TIMER_TICK

    jsr init_interrupts

program_loop:

get_key:
    jsr GETIN
    beq program_loop
        
    cmp #Q_KEY
    beq exit_prog

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

init_interrupts:
    sei
    lda #%01111111
    sta CIA1_ICR

    and $D011
    sta $D011

    lda CIA1_ICR
    lda CIA2_ICR
    
    lda #242
    sta VIC_RASTER

    lda VIC_CONTROL_1
    and #%01111111
    sta VIC_CONTROL_1

    lda #<irq
    sta IRR_ADDR_LOW
    lda #>irq
    sta IRR_ADDR_HIGH

    lda #%00000001
    sta VIC_IRM
    
    cli
    rts

clean_interrupts:
    sei
    
    lda #%00000000
    sta VIC_IRM
    
    lda #%10000001
    sta CIA1_ICR
    
    lda #$31
    sta IRR_ADDR_LOW
    lda #$EA
    sta IRR_ADDR_HIGH

    asl VIC_IRR
    
    cli
    rts

irq:
    dec TIMER_TICK
    bne exit_irq

    lda #15
    sta TIMER_TICK

    dec COUNTER
    lda COUNTER

    bne update_digit
    lda #9
    sta COUNTER
update_digit:
    clc
    adc #$30
    sta SCREEN

exit_irq:
    asl VIC_IRR
    jmp $EA31


.include 'subroutines.asm'
