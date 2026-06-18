; ------------
; Commodore 64 ASM - Raster Interrupt Version
; ------------

.include '../common/header.asm'
COUNTER = $02
TIMER_TICK = $03
END_FLAG = $04
SCREEN = $0400

.include '../common/basic.asm'

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

    lda #60
    sta TIMER_TICK

    lda #0
    sta END_FLAG

    jsr init_interrupts

program_loop:
    bit END_FLAG
    bmi exit_prog
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

    lda #60
    sta TIMER_TICK

    lda COUNTER
    beq exit_irq

    dec COUNTER
    
    lda COUNTER
    bne update_digit
    lda #$FF
    sta END_FLAG
    lda COUNTER
update_digit:
    clc
    adc #$30
    sta SCREEN

exit_irq:
    LDA #<irq2
    STA $0314
    LDA #>irq2
    STA $0315

    lda #150
    sta $D012

    asl VIC_IRR     ; ack
    jmp $EA31



irq2:
    lda #YELLOW
    sta BORDER_COLOR

    ; set next interrupt at line 200
    LDA #<irq3
    STA $0314
    LDA #>irq3
    STA $0315

    lda #200
    sta $D012

    asl $D019
    jmp $EA31


irq3:
    lda #BLACK
    sta BORDER_COLOR
    lda #RED
    sta BG_COLOR

    ; set previous interrupt
    lda #<irq
    sta $0314
    lda #>irq
    sta $0315

    lda #242
    sta $D012

    asl $D019
    jmp $EA31


.include 'subroutines.asm'
