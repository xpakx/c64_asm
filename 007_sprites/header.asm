CHROUT = $FFD2
PLOT = $FFF0
GETIN = $FFE4

; ---------
; Constants
; ---------
SCREEN_RAM = $0400
COLOR_RAM = $D800
CUR_COLOR = $0286
BORDER_COLOR = $D020
BG_COLOR = $D021

STR_PTR = $FB      
LOW_TIME  = $A2
MID_TIME  = $A1
HIGH_TIME = $A1

VIC_BASE     = $D000
SPRITE_0_X   = $D000
SPRITE_0_Y   = $D001
SPRITE_MSB   = $D010
VIC_ENABLE   = $D015
SPRITE_COL_0 = $D027

HORIZONTAL_EXPAND = $D01D
VERTICAL_EXPAND = $D017

SPRITE_0_PTR = $07F8

; ---------
; Colors
; ---------
BLACK = $00
WHITE = $01     
RED = $02
CYAN = $03
PURPLE = $04
GREEN = $05
BLUE = $06
YELLOW = $07
ORANGE = $08
BROWN = $09
LIGHT_RED = $0A
GREY_1 = $0B
GREY_2 = $0C
LIGHT_GREEN = $0D
LIGHT_BLUE = $0E
GREY_3 = $0F

; ---------
; Keys
; ---------
DOWN_KEY  = $11
UP_KEY    = $91
RIGHT_KEY = $1D
LEFT_KEY  = $9D

SPACE_KEY = $20

A_KEY     = $41
B_KEY     = $42
C_KEY     = $43
D_KEY     = $44
E_KEY     = $45
F_KEY     = $46
G_KEY     = $47
H_KEY     = $48
I_KEY     = $49
J_KEY     = $4A
K_KEY     = $4B
L_KEY     = $4C
M_KEY     = $4D
N_KEY     = $4E
O_KEY     = $4F
P_KEY     = $50
Q_KEY     = $51
R_KEY     = $52
S_KEY     = $53
T_KEY     = $54
U_KEY     = $55
V_KEY     = $56
W_KEY     = $57
X_KEY     = $58
Y_KEY     = $59
Z_KEY     = $5A

KEY_0     = $30
KEY_1     = $31
KEY_2     = $32
KEY_3     = $33
KEY_4     = $34
KEY_5     = $35
KEY_6     = $36
KEY_7     = $37
KEY_8     = $38
KEY_9     = $39
