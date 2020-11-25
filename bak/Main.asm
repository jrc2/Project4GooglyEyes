; 10 SYS (2304)

*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $32, $33, $30, $34, $29, $00, $00, $00


*=$0900

EYE_FRONT_PIXELS=$2E80
EYE_LEFT_PIXELS=EYE_FRONT_PIXELS+64
EYE_RIGHT_PIXELS=EYE_LEFT_PIXELS+64
COUNTER BYTE 00


PROGRAM_START

; Sets up interrupt
        SEI ; disable interrupts
        LDA #<ANIMATION_ROUTINE ; loads low byte of ANIMATION_ROUTINE start address
        STA $0314 ; stores low byte to interrupt vector
        LDA #>ANIMATION_ROUTINE ; loads high byte of ANIMATION_ROUTINE start address
        STA $0315 ; stores high byte to interrupt vector
        CLI ; re-enable interrupts


; Copies eye sprite data
        LDX #63

loop_eye_data
        LDA EYE_FRONT_DATA,X
        STA EYE_FRONT_PIXELS,X
        LDA EYE_LEFT_DATA,X
        STA EYE_LEFT_PIXELS,X
        LDA EYE_RIGHT_DATA,X
        STA EYE_RIGHT_PIXELS,X
        DEX
        BPL loop_eye_data


; Sets eye sprite pointer to front sprite
        LDA #EYE_FRONT_PIXELS/64
        STA $07F8


; Sets eye sprite color
        LDA #$01 ; white
        STA $D027


; Sets eye sprite X location
        LDA #50
        STA $D000
        LDA $D010 ; load X-MSB
        ORA #%00000001 ; set extra bit for sprite #1 - this will make the X coordinate = 306
        STA $D010 ; write X-MSB register


; Sets eye sprite Y location
        LDA #60
        STA $D001


; Enables eye sprite
        LDA #%00000001
        STA $D015


PROGRAM_END
        RTS
        


; SUBROUTINES BEGIN AFTER THIS LINE

ANIMATION_ROUTINE
        LDX COUNTER
        INX
        STX COUNTER
        JMP $EA31 ; kernel handler

; END SUBROUTINES
        

EYE_FRONT_DATA
; eye_front
 BYTE $00,$7E,$00
 BYTE $03,$81,$C0
 BYTE $0C,$7E,$30
 BYTE $13,$FF,$C8
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $5F,$FF,$FA
 BYTE $5F,$C3,$FA
 BYTE $5F,$81,$FA
 BYTE $BF,$00,$FD
 BYTE $BF,$00,$FD
 BYTE $BF,$00,$FD
 BYTE $5F,$81,$FA
 BYTE $5F,$C3,$FA
 BYTE $5F,$FF,$FA
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $13,$FF,$C8
 BYTE $0C,$7E,$30
 BYTE $03,$81,$C0
 BYTE $00,$7E,$00
 BYTE $00

EYE_LEFT_DATA
; eye_left
 BYTE $00,$7E,$00
 BYTE $03,$81,$C0
 BYTE $0C,$7E,$30
 BYTE $13,$FF,$C8
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $5F,$FF,$FA
 BYTE $5C,$7F,$FA
 BYTE $58,$3F,$FA
 BYTE $B8,$3F,$FD
 BYTE $B8,$3F,$FD
 BYTE $B8,$3F,$FD
 BYTE $58,$3F,$FA
 BYTE $5C,$7F,$FA
 BYTE $5F,$FF,$FA
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $13,$FF,$C8
 BYTE $0C,$7E,$30
 BYTE $03,$81,$C0
 BYTE $00,$7E,$00
 BYTE $00

EYE_RIGHT_DATA
; eye right
 BYTE $00,$7E,$00
 BYTE $03,$81,$C0
 BYTE $0C,$7E,$30
 BYTE $13,$FF,$C8
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $5F,$FF,$FA
 BYTE $5F,$FE,$3A
 BYTE $5F,$FC,$1A
 BYTE $BF,$FC,$1D
 BYTE $BF,$FC,$1D
 BYTE $BF,$FC,$1D
 BYTE $5F,$FC,$1A
 BYTE $5F,$FE,$3A
 BYTE $5F,$FF,$FA
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $13,$FF,$C8
 BYTE $0C,$7E,$30
 BYTE $03,$81,$C0
 BYTE $00,$7E,$00
 BYTE $00

