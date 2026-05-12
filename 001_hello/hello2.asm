; ------------
; Commodore 64 ASM
; ------------

CHROUT = $FFD2
PLOT = $FFF0

; ---------
; Constants
; ---------
SCREEN_RAM = $0400
COLOR_RAM = $D800
CUR_COLOR = $0286

WHITE = $01     ;1 decimal

; ------------------------------------------------
; BASIC stub
; let program to be run without typing `sys mem-addr`
; ------------------------------------------------

*= $0801      ;start of BASIC
.word next
.word 10
.byte $9e
.text "2064"
.byte 0
next:
.word 0
; ------------------------------------------------
;  END BASIC stub
; ------------------------------------------------

*= $0810      ;3 bytes after stub (customary gap)

start:
     lda #$93
     jsr CHROUT

     ; use PLOT routine to move cursor
     ; reg x for row, reg y for column
     ldx #$0A
     ldy #$0A
     clc
     jsr PLOT

     lda #WHITE
     sta CUR_COLOR  

     ldx #$00

print_loop:
     lda message,x
     beq forever
     jsr CHROUT
     inx
     jmp print_loop

forever:
     jmp forever

message:
     .text "HELLO WORLD"
     .byte 0
