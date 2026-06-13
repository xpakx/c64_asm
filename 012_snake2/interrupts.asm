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

.if DEBUG
    dec COUNTER
    lda COUNTER

    bne update_digit
    lda #9
    sta COUNTER
update_digit:
    clc
    adc #$30
    sta SCREEN
.endif

logic:
    lda #%10000000
    sta FRAME_FLAG

exit_irq:
    asl VIC_IRR
    jmp $EA31
