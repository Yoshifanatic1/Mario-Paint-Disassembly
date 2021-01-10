
;#############################################################################################################
;#############################################################################################################

macro MPAINTBank00Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

CODE_008000:
	SEI
	CLC
	XCE
	REP.b #$20
	LDA.w #$0000
	STA.l !RAM_MPAINT_Global_DemoActiveFlag
	LDA.w #$0000
	STA.l $000008
CODE_008013:
	SEP.b #$20
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_DMAEnable
	STZ.w !REGISTER_HDMAEnable
	LDA.b #$80
	STA.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_InitialScreenSettings
	STZ.w !REGISTER_JoypadSerialPort1
	REP.b #$30
	LDX.w #$1FFF
	TXS
	LDY.w #$0000
	PHY
	PLD
	DEX
CODE_008035:
	ADC.b $00,x
	DEX
	BNE.b CODE_008035
	STA.b $02
	LDX.w #$1FFE
CODE_00803F:
	STZ.b $00,x
	DEX
	DEX
	CPX.w #$0008
	BNE.b CODE_00803F
	SEP.b #$30
	LDA.b #DATA_188000
	STA.b $CC
	LDA.b #DATA_188000>>8
	STA.b $CD
	LDA.b #DATA_188000>>16
	STA.b $CE
	JSL.l CODE_01DF25
	LDA.b #$02
	JSL.l CODE_01D308
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w $0122
	LDA.b #$8F
	STA.w !REGISTER_ScreenDisplayRegister
	STA.w $0104
	JSR.w CODE_00849D
	JSL.l CODE_01E06F
	JSR.w CODE_00833B
	JSR.w CODE_00837D
	LDA.b #$80
	STA.w !REGISTER_OAMAddressHi
	LDA.b #$00
	STA.w !REGISTER_OAMAddressLo
	JSR.w CODE_0084AF
	JSL.l CODE_01E06F
	JSL.l CODE_01E2F3
	LDA.w $0122
	AND.b #$CF
	STA.w $0122
	REP.b #$30
	LDA.w #$80AD
	STA.w $017E
	LDA.w #$0000
	STA.w $0180
	CLI
	STZ.w $0220
	JMP.w CODE_0084D5

;--------------------------------------------------------------------

CODE_0080AD:
	RTL

;--------------------------------------------------------------------

CODE_0080AE:
	RTI

;--------------------------------------------------------------------

CODE_0080AF:
	REP.b #$30
	PHB
	PHD
	PHA
	PHX
	PHY
	PEA.w $0000
	PLD
	PHK
	PLB
	SEP.b #$30
	LDA.w !REGISTER_IRQEnable
	BIT.b #$80
	BEQ.b CODE_0080CC
	PHK
	PEA.w CODE_0080CC-$01
	JMP.w [$017E]

CODE_0080CC:
	REP.b #$30
	PLY
	PLX
	PLA
	PLD
	PLB
	RTI

;--------------------------------------------------------------------

CODE_0080D4:
	REP.b #$30
	PHB
	PHD
	PHA
	PHX
	PHY
	PEA.w $0000
	PLD
	PHK
	PLB
	SEP.b #$30
	LDA.w !REGISTER_NMIEnable
	JSL.l CODE_01E429
	JSL.l CODE_01E460
	JSL.l CODE_01E59B
	LDA.w $016A
	BEQ.b CODE_00810F
	JSL.l CODE_01E500
	JSL.l CODE_01E6CA
	JSL.l CODE_01E103
	JSL.l CODE_01E60C
	JSL.l CODE_01E66B
	JSL.l CODE_01E1AB
CODE_00810F:
	JSR.w CODE_0081CA
	JSR.w CODE_00823C
	INC.w $016C
	JSL.l CODE_01E747
	JSL.l CODE_01D9E1
	JSR.w CODE_00815B
	JSL.l CODE_01DCB9
	JSR.w CODE_008187
	JSL.l CODE_01DDB8
	JSL.l CODE_01DDE1
	JSL.l CODE_01DE2D
	DEC.w $1B1D
	DEC.w $1B20
	REP.b #$30
	JSL.l CODE_0FC000
	LDA.w $099F
	BEQ.b CODE_008152
	LDA.w !RAM_MPAINT_Global_HeldButtonsLoP2
	CMP.w #!Joypad_L|!Joypad_R|!Joypad_Start|!Joypad_Select
	BNE.b CODE_008152
	JMP.w CODE_0082A7

CODE_008152:
	STZ.w $016A
	PLY
	PLX
	PLA
	PLD
	PLB
	RTI

;--------------------------------------------------------------------

CODE_00815B:
	LDA.w $09A7
	BEQ.b CODE_00817E
	LDA.w $016C
	LSR
	LSR
	LSR
	LSR
	AND.b #$06
	TAX
	LDA.w DATA_00817F,x
	STA.w MPAINT_Global_OAMBuffer[$00].Tile
	LDA.w DATA_00817F+$01,x
	STA.w MPAINT_Global_OAMBuffer[$00].Prop
	LDA.w MPAINT_Global_UpperOAMBuffer[$00].Slot
	ORA.b #$02
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot
CODE_00817E:
	RTS

DATA_00817F:
	dw $310C,$310E,$312C,$312E

;--------------------------------------------------------------------

CODE_008187:
	LDA.w $1B1F
	BEQ.b CODE_0081C1
	LDA.w $1B20
	BPL.b CODE_0081C1
	LDA.w $1B21
	CLC
	ADC.b #$04
	CMP.b #$08
	BCC.b CODE_00819D
	LDA.b #$00
CODE_00819D:
	STA.w $1B21
	TAX
	LDA.w DATA_0081C2,x
	CLC
	ADC.w MPAINT_Global_OAMBuffer[$00].XDisp
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp
	LDA.w DATA_0081C2+$01,x
	CLC
	ADC.w MPAINT_Global_OAMBuffer[$00].YDisp
	STA.w MPAINT_Global_OAMBuffer[$00].YDisp
	LDA.w DATA_0081C2+$02,x
	STA.w MPAINT_Global_OAMBuffer[$00].Tile
	LDA.w DATA_0081C2+$03,x
	STA.w $1B20
CODE_0081C1:
	RTS

DATA_0081C2:
	dw $0000,$1024,$0000,$1026

;--------------------------------------------------------------------

; Note: Routine that animates the bomb icon.

CODE_0081CA:
	LDA.w $058D
	BNE.b CODE_0081D0
	RTS

CODE_0081D0:
	PHP
	REP.b #$10
	LDY.w #DATA_00822A
	CMP.b #$00
	BMI.b CODE_0081E7
	LDY.w #DATA_008230
	LDA.w $016C
	BIT.b #$08
	BEQ.b CODE_0081E7
	LDY.w #DATA_008236
CODE_0081E7:
	PHY
	LDA.b #$01
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDY.w #$0000
	LDA.b #$21
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$33
	STA.w !REGISTER_VRAMAddressHi
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	INY
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	INY
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	INY
	LDA.b #$22
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$33
	STA.w !REGISTER_VRAMAddressHi
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	INY
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	INY
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	PLY
	PLP
	RTS

DATA_00822A:
	dw $ECDC,$DDFC,$FDED

DATA_008230:
	dw $EADA,$DBFA,$FBEB

DATA_008236:
	dw $E8D8,$D9F8,$F9E9

;--------------------------------------------------------------------

CODE_00823C:
	LDA.w $0589
	BNE.b CODE_008247
	LDA.b $AA
	CMP.b #$07
	BEQ.b CODE_008248
CODE_008247:
	RTS

CODE_008248:
	PHP
	REP.b #$10
	LDY.w #DATA_00829B
	LDA.w $016C
	BIT.b #$10
	BEQ.b CODE_008258
	LDY.w #DATA_0082A1
CODE_008258:
	PHY
	LDA.b #$01
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDY.w #$0000
	LDA.b #$29
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$33
	STA.w !REGISTER_VRAMAddressHi
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	INY
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	INY
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	INY
	LDA.b #$2A
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$33
	STA.w !REGISTER_VRAMAddressHi
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	INY
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	INY
	LDA.b ($01,S),y
	STA.w !REGISTER_WriteToVRAMPortLo
	PLY
	PLP
	RTS

DATA_00829B:
	dw $8676,$7796,$9787

DATA_0082A1:
	dw $8878,$7998,$9989

;--------------------------------------------------------------------

CODE_0082A7:
	SEP.b #$30
	PEA.w $0000
	PLD
	PEA.w $0000
	PLB
	PLB
	JSR.w CODE_0082D5
	JMP.w CODE_008000

CODE_0082B8:
	SEP.b #$30
	PEA.w $0000
	PLD
	PEA.w $0000
	PLB
	PLB
	JSR.w CODE_0082D5
	SEI
	CLC
	XCE
	REP.b #$20
	LDA.w #$0000
	STA.l !RAM_MPAINT_Global_DemoActiveFlag
	JMP.w CODE_008013

CODE_0082D5:						; Note: Yes, this bit of code was disassembled correctly.
	JSL.l CODE_01E30E
	LDX.b #$FF
	LDY.b #$FF
CODE_0082DD:
	LDA.l $7FFFFF
	LDA.l $7FFFFF
	LDA.l $7FFFFF
	LDA.l $7FFFFF
	DEY
	BNE.b CODE_0082DD
	DEX
	BNE.b CODE_0082DD
	LDA.b #$02
	STA.w !REGISTER_APUPort2
	LDX.b #$FF
	LDY.b #$FF
CODE_0082FC:
	LDA.l $7FFFFF
	LDA.l $7FFFFF
	LDA.l $7FFFFF
	LDA.l $7FFFFF
	DEY
	BNE.b CODE_0082FC
	DEX
	BNE.b CODE_0082FC
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	LDX.b #$FF
	LDY.b #$FF
CODE_008324:
	LDA.l $7FFFFF
	LDA.l $7FFFFF
	LDA.l $7FFFFF
	LDA.l $7FFFFF
	DEY
	BNE.b CODE_008324
	DEX
	BNE.b CODE_008324
	RTS

;--------------------------------------------------------------------

CODE_00833B:
	LDA.b #$01
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STA.w $0122
	STZ.w !REGISTER_ProgrammableIOPortOutput
	STZ.w !REGISTER_Multiplicand
	STZ.w !REGISTER_Multiplier
	STZ.w !REGISTER_DividendLo
	STZ.w !REGISTER_DividendHi
	STZ.w !REGISTER_Divisor
	STZ.w !REGISTER_HCountTimerLo
	STZ.w $0125
	STZ.w !REGISTER_HCountTimerHi
	STZ.w $0126
	STZ.w !REGISTER_VCountTimerLo
	STZ.w $0123
	STZ.w !REGISTER_VCountTimerHi
	STZ.w $0124
	STZ.w !REGISTER_DMAEnable
	STZ.w !REGISTER_HDMAEnable
	STZ.w $0127
	STZ.w !REGISTER_EnableFastROM
	STZ.w $0128
	RTS

;--------------------------------------------------------------------

CODE_00837D:
	LDA.b #$8F
	STA.w !REGISTER_ScreenDisplayRegister
	STA.w $0104
	LDA.b #$02
	STA.w !REGISTER_OAMSizeAndDataAreaDesignation
	STA.w $0105
	LDA.b #$00
	STA.w !REGISTER_OAMAddressHi
	STA.w $0107
	STZ.w !REGISTER_OAMAddressLo
	STZ.w $0106
	STZ.w !REGISTER_OAMDataWritePort
	STZ.w !REGISTER_OAMDataWritePort
	LDA.b #$09
	STA.w !REGISTER_BGModeAndTileSizeSetting
	STA.w $0108
	STZ.w !REGISTER_MosaicSizeAndBGEnable
	STZ.w $0109
	LDA.b #$30
	STA.w !REGISTER_BG1AddressAndSize
	STA.w $010A
	LDA.b #$34
	STA.w !REGISTER_BG2AddressAndSize
	STA.w $010B
	LDA.b #$38
	STA.w !REGISTER_BG3AddressAndSize
	STA.w $010C
	STZ.w !REGISTER_BG4AddressAndSize
	STZ.w $010D
	LDA.b #$06
	STA.w !REGISTER_BG1And2TileDataDesignation
	STA.w $010E
	LDA.b #$66
	STA.w !REGISTER_BG3And4TileDataDesignation
	STA.w $010F
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG4HorizScrollOffset
	STZ.w !REGISTER_BG4HorizScrollOffset
	STZ.w !REGISTER_BG4VertScrollOffset
	STZ.w !REGISTER_BG4VertScrollOffset
	STZ.w !REGISTER_VRAMAddressIncrementValue
	STZ.w !REGISTER_Mode7TilemapSettings
	STZ.w $0110
	STZ.w !REGISTER_Mode7MatrixParameterA
	STZ.w !REGISTER_Mode7MatrixParameterB
	STZ.w !REGISTER_Mode7MatrixParameterC
	STZ.w !REGISTER_Mode7MatrixParameterD
	STZ.w !REGISTER_Mode7CenterX
	STZ.w !REGISTER_Mode7CenterY
	STZ.w !REGISTER_BG1And2WindowMaskSettings
	STZ.w $0111
	STZ.w !REGISTER_BG3And4WindowMaskSettings
	STZ.w $0112
	STZ.w !REGISTER_ObjectAndColorWindowSettings
	STZ.w $0113
	STZ.w !REGISTER_BGWindowLogicSettings
	STZ.w $0118
	STZ.w !REGISTER_ColorAndObjectWindowLogicSettings
	STZ.w $0119
	STZ.w !REGISTER_Window1LeftPositionDesignation
	STZ.w $0114
	STZ.w !REGISTER_Window2LeftPositionDesignation
	STZ.w $0116
	LDA.b #$01
	STA.w !REGISTER_Window1RightPositionDesignation
	STA.w $0115
	STA.w !REGISTER_Window2RightPositionDesignation
	STA.w $0117
	LDA.b #$13
	STA.w !REGISTER_MainScreenLayers
	STA.w $011A
	STA.w !REGISTER_MainScreenWindowMask
	STA.w $011C
	LDA.b #$13
	STA.w !REGISTER_SubScreenLayers
	STA.w $011B
	STA.w !REGISTER_SubScreenWindowMask
	STA.w $011D
	LDA.b #$30
	STA.w !REGISTER_ColorMathInitialSettings
	STA.w $011E
	LDA.b #$00
	STA.w !REGISTER_ColorMathSelectAndEnable
	STA.w $011F
	LDA.b #$E0
	STA.w !REGISTER_FixedColorData
	STA.w $0120
	LDA.b #$00
	STA.w !REGISTER_InitialScreenSettings
	STA.w $0121
	RTS

;--------------------------------------------------------------------

CODE_00849D:
	REP.b #$30
	LDA.w #$0000
	LDX.w #$2000
	LDY.w #$2000
	JSL.l CODE_01E060
	SEP.b #$30
	RTS

;--------------------------------------------------------------------

CODE_0084AF:
	REP.b #$30
	LDA.w #$3DFE
	JSL.l CODE_01E024
	LDA.w #$3FFF
	JSL.l CODE_01E033
	LDA.w #$03FE
	JSL.l CODE_01E042
	SEP.b #$30
	JSL.l CODE_01DE97
	JSL.l CODE_01DEB2
	JSL.l CODE_01DECD
	RTS

;--------------------------------------------------------------------

CODE_0084D5:
	REP.b #$30
	STZ.w $0538
	LDA.w #$0030
	STA.w $09CF
	LDA.w #$0034
	STA.w $012A
	LDA.w #$0010
	STA.w $012C
	STZ.w $09A7
	STZ.w $09D4
	STZ.w $04BF
	STZ.w $04C4
	LDA.w #$0001
	STA.w $04C1
	LDA.w #$0080
	STA.w !RAM_MPAINT_Global_CursorXPosLo
	LDA.w #$0080
	STA.w !RAM_MPAINT_Global_CursorYPosLo
	SEP.b #$20
	LDA.b #!RAM_MPAINT_Canvas_CanvasGFXBuffer
	STA.b $0A
	LDA.b #!RAM_MPAINT_Canvas_CanvasGFXBuffer>>8
	STA.b $0B
	LDA.b #!RAM_MPAINT_Canvas_CanvasGFXBuffer>>16
	STA.b $0C
	LDA.b #!RAM_MPAINT_Canvas_CanvasGFXBuffer>>16
	STA.b $0F
	REP.b #$30
	LDA.w #$007E
	STA.w $0212
	PHB
	SEP.b #$20
	LDA.b #$7F0000>>16
	PHA
	PLB
	REP.b #$20
	LDX.w #$0000
CODE_008530:
	STZ.w $7F0000,x
	INX
	INX
	BNE.b CODE_008530
	PLB
	STZ.w $0206
	JSL.l CODE_008A75
	STZ.w $0208
	INC.w $0206
CODE_008545:
	JSL.l CODE_01E2CE
	LDA.w $0208
	BNE.b CODE_008545
	LDA.w #$0100
	STA.w $0448
	LDA.b $02
	JSL.l CODE_01E238
	STZ.b $B8
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	STZ.w $0EB8
	STZ.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	LDA.w #$0004
	STA.w $19AE
	LDA.w #$00FC
	STA.w $19B0
	LDA.w #$001C
	STA.w $19B2
	LDA.w #$00C4
	STA.w $19B4
	JSL.l CODE_018000
	JSR.w CODE_00E25C
	JSL.l CODE_01E895
	JSR.w CODE_00DE8E
	SEP.b #$20
	JSL.l CODE_01D388
	JSL.l CODE_01E30E
	LDA.b #DATA_1A8000
	STA.b $CC
	LDA.b #DATA_1A8000>>8
	STA.b $CD
	LDA.b #DATA_1A8000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
	REP.b #$20
	JSL.l CODE_01E2F3
	LDA.w #$0001
	STA.w $1012
	INC
	INC
	JSL.l CODE_01D2BF
	STZ.w $19C2
	LDA.w #$0000
	STA.l $7E3FFC
	STZ.w $19FA
	STZ.w $19AC
	LDA.w #$FFFF
	STA.w $19A8
	JSR.w CODE_0087EE
	LDA.w #$0000
	JSR.w CODE_00B66C
	LDA.w #$0000
	JSR.w CODE_00B6F4
	JSR.w CODE_00E64F
	JSL.l CODE_01E2CE
	LDA.w #$FFFF
	STA.w $09A9
	LDA.w #$0000
	PHA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	JSL.l CODE_01E2CE
	JSL.l CODE_01E794
	LDA.w #$FFF0
	STA.w $04D4
	LDA.w #$0008
	STA.w $04D8
	LDA.w #$0110
	STA.w $04D6
	LDA.w #$00D8
	STA.w $04DA
	STZ.w $04D0
	JSL.l CODE_01E06F
	STZ.w $09D1
	STZ.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	STZ.w $09AB
	STZ.b $AA
	STZ.b $AE
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	STZ.w !RAM_MPAINT_Canvas_EraseToolSize
	STZ.w $0EB8
	STZ.w $0EBC
	STZ.w $0EBA
	STZ.w $1988
	LDA.w #$0002
	STA.w $1A08
	STA.l $7E3FFE
	STZ.w $1B18
	STZ.w $09D6
	JSR.w CODE_00BA78
	JSR.w CODE_00F39E
	LDA.w #$0140
	STA.w $09A1
CODE_00865A:
	REP.b #$30
	LDY.w #$0004
	STY.w $0446
	JSR.w CODE_008B48
	JSL.l CODE_008683
	JSR.w CODE_0087A8
	JSR.w CODE_009378
	LDA.w $0545
	BEQ.b CODE_008679
	JSR.w CODE_00878F
	BCC.b CODE_00867D
CODE_008679:
	JSL.l CODE_01E09B
CODE_00867D:
	JSL.l CODE_01E2CE
	BRA.b CODE_00865A

;--------------------------------------------------------------------

CODE_008683:
	LDA.w $04CA
	BNE.b CODE_008690
	LDA.w $1B26
	BIT.w #$0001
	BEQ.b CODE_0086C1
CODE_008690:
	LDA.w $05A7
	AND.w #$00FF
	BNE.b CODE_00869F
CODE_008698:
	LDA.w #$0258
	STA.w $09A1
	RTL

CODE_00869F:
	STZ.w $04CA
	SEP.b #$20
	LDA.b #$01
	STA.w $05A6
	REP.b #$20
	LDA.w #$0027
	JSL.l CODE_01962C
	LDX.w #$00D8
	LDY.w #$00CA
	LDA.w #$0195
	JSL.l CODE_01F91E
	BRA.b CODE_008698

CODE_0086C1:
	LDA.w $05A6
	AND.w #$00FF
	BNE.b CODE_00869F
	LDA.w $04D0
	CMP.w #$0006
	BNE.b CODE_0086D4
	JMP.w CODE_00877E

CODE_0086D4:
	CMP.w #$0007
	BNE.b CODE_0086DC
	JMP.w CODE_00877E

CODE_0086DC:
	LDA.w $0EB8
	CMP.w #$0001
	BNE.b CODE_0086E7
	JMP.w CODE_00877E

CODE_0086E7:
	LDX.b $AA
	LDA.w DATA_00877F,x
	AND.w #$00FF
	STA.w $09A5
	CMP.w #$00FF
	BNE.b CODE_0086FA
	JMP.w CODE_00877E

CODE_0086FA:
	LDA.w $09A1
	BEQ.b CODE_008706
	BMI.b CODE_00873A
	DEC.w $09A1
	BNE.b CODE_00877E
CODE_008706:
	LDA.w #DATA_01CFB4
	JSL.l CODE_01CDE1
	LDA.w $09A5
	CMP.w #$0002
	BEQ.b CODE_008730
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	LDY.w $0EB8
	BPL.b CODE_00871F
	LDA.w $0EBE
CODE_00871F:
	CMP.w #$00E0
	BCS.b CODE_00872B
	LDA.w #$0026
	JSL.l CODE_019DFE
CODE_00872B:
	LDA.w $09A5
	BEQ.b CODE_008737
CODE_008730:
	LDA.w #$0027
	JSL.l CODE_019DFE
CODE_008737:
	DEC.w $09A1
CODE_00873A:
	LDA.w $09A5
	CMP.w #$0002
	BEQ.b CODE_00876A
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	LDY.w $0EB8
	BPL.b CODE_00874C
	LDA.w $0EBE
CODE_00874C:
	CMP.w #$00E0
	BCS.b CODE_008765
	LDA.w #$0026
	JSL.l CODE_01962C
	LDX.w #$00EC
	LDY.w #$0007
	LDA.w #$0194
	JSL.l CODE_01F91E
CODE_008765:
	LDA.w $09A5
	BEQ.b CODE_00877E
CODE_00876A:
	LDA.w #$0027
	JSL.l CODE_01962C
	LDX.w #$00D8
	LDY.w #$00CA
	LDA.w #$0195
	JSL.l CODE_01F91E
CODE_00877E:
	RTL

DATA_00877F:
	dw $0000,$00FF,$FF00,$00FF
	dw $0100,$FF01,$FFFF,$00FF

;--------------------------------------------------------------------

CODE_00878F:
	LDA.w $04CA
	BNE.b CODE_0087A3
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00CC
	BCS.b CODE_0087A3
	DEC.w $0545
	BEQ.b CODE_0087A3
	CLC
	RTS

CODE_0087A3:
	STZ.w $0545
	SEC
	RTS

;--------------------------------------------------------------------

CODE_0087A8:
	LDA.w $09D6
	ASL
	TAX
	JMP.w (DATA_0087B0,x)

DATA_0087B0:
	dw CODE_008BEB
	dw CODE_00C900
	dw CODE_00CC10
	dw CODE_00C460
	dw CODE_00C4D6
	dw CODE_00BBD8
	dw CODE_00CF9B
	dw CODE_00D03E
	dw CODE_00D069
	dw CODE_00D2F6
	dw CODE_00D321
	dw CODE_00D505
	dw CODE_00D50D
	dw CODE_0094E5
	dw CODE_0094E5
	dw CODE_0094E5
	dw CODE_0094E5
	dw CODE_0094E5
	dw CODE_0094E5
	dw CODE_0094E5
	dw CODE_0094E5
	dw CODE_00D8F1
	dw CODE_00DB59
	dw CODE_00DB84
	dw CODE_00DBE4
	dw CODE_00DC29
	dw CODE_00DC8B
	dw CODE_00DCC5
	dw CODE_00DD6D
	dw CODE_00E4B9
	dw CODE_00EC88

;--------------------------------------------------------------------

CODE_0087EE:
	PHP
	SEP.b #$30
	JSL.l CODE_01E30E
	JSL.l CODE_01E87B
	JSL.l CODE_01E88A
	SEI
	LDA.b #$00
CODE_008800:
	DEC
	BNE.b CODE_008800
	STZ.w !REGISTER_CGRAMAddress					; Optimization: Why the long string of DMA setups with 8-bit A?
	LDA.b #$00
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToCGRAMPort
	STA.w DMA[$00].Destination
	LDA.b #DATA_02FE00
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_02FE00>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_02FE00>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$02
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$60
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_04C000
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_04C000>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_04C000>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$20
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$70
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_058000
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_058000>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_058000>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$08
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$74
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_038000
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_038000>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_038000>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$12
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$7D
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_04FA00
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_04FA00>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_04FA00>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$06
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$40
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_088000
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_088000>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_088000>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$40
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$06
	STA.w !REGISTER_BG1And2TileDataDesignation
	STA.w $010E
	LDA.b #$66
	STA.w !REGISTER_BG3And4TileDataDesignation
	STA.w $010F
	LDA.b #$F0
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$3F
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #$10
	LDA.b #$FF
CODE_008964:
	STA.w !REGISTER_WriteToVRAMPortLo
	STA.w !REGISTER_WriteToVRAMPortHi
	DEX
	BNE.b CODE_008964
	REP.b #$30
	LDA.w #$3DFE
	JSL.l CODE_01E024
	LDA.w #$3FFF
	JSL.l CODE_01E033
	JSR.w CODE_0089B1
	JSR.w CODE_008A16
	JSR.w CODE_008A39
	JSR.w CODE_0089C3
	JSL.l CODE_01DE97
	CLI
	JSL.l CODE_01E2F3
	PLP
	RTS

;--------------------------------------------------------------------

CODE_008994:
	JSR.w CODE_0087EE
	LDA.w #$0007
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	LDA.w $04D0
	CMP.w #$0006
	BNE.b CODE_0089AD
	INC.w $09AB
CODE_0089AD:
	JSR.w CODE_00A363
	RTL

;--------------------------------------------------------------------

CODE_0089B1:
	PHP
	REP.b #$30
	LDA.w $19FA
	BNE.b CODE_0089BE
	JSR.w CODE_00C414
	BRA.b CODE_0089C1

CODE_0089BE:
	JSR.w CODE_00C3DE
CODE_0089C1:
	PLP
	RTS

;--------------------------------------------------------------------

CODE_0089C3:
	PHP
	REP.b #$30
	LDX.w #$003E
	LDA.w #$21EE
CODE_0089CC:
	STA.l $7E2000,x
	DEX
	DEX
	BPL.b CODE_0089CC
	LDX.w #$001E
	LDA.w #$210F
CODE_0089DA:
	STA.l $7E2040,x
	DEC
	DEX
	DEX
	BPL.b CODE_0089DA
	LDX.w #$001E
	LDA.w #$211F
CODE_0089E9:
	STA.l $7E2080,x
	DEC
	DEX
	DEX
	BPL.b CODE_0089E9
	LDX.w #$001E
	LDA.w #$212F
CODE_0089F8:
	STA.l $7E2060,x
	DEC
	DEX
	DEX
	BPL.b CODE_0089F8
	LDX.w #$001E
	LDA.w #$213F
CODE_008A07:
	STA.l $7E20A0,x
	DEC
	DEX
	DEX
	BPL.b CODE_008A07
	PLP
	RTS

;--------------------------------------------------------------------

CODE_008A12:
	JSR.w CODE_008A16
	RTL

CODE_008A16:
	PHP
	PHB
	SEP.b #$20
	LDA.b #$7E
	PHA
	PLB
	REP.b #$30
	LDX.w #$063E
	LDA.w #$02DF
CODE_008A26:
	STA.l $7E2800,x
	DEX
	DEX
	DEC
	CMP.w #$001F
	BNE.b CODE_008A26
	JSL.l CODE_01DEB2
	PLB
	PLP
	RTS

;--------------------------------------------------------------------

CODE_008A39:
	PHP
	REP.b #$30
	LDA.w #$2FFC
	JSL.l CODE_01E042
	LDX.w #$0000
CODE_008A46:
	LDA.w #$03FE
	STA.l $7E3102,x
	INX
	INX
	TXA
	AND.w #$003F
	CMP.w #$003E
	BNE.b CODE_008A5E
	TXA
	CLC
	ADC.w #$0002
	TAX
CODE_008A5E:
	CPX.w #$0540
	BNE.b CODE_008A46
	LDA.w #$0004
	STA.w $0178
	LDA.w #$0004
	STA.w $0176
	JSL.l CODE_01DECD
	PLP
	RTS

;--------------------------------------------------------------------

CODE_008A75:
	REP.b #$30
	LDA.w #$0000
	LDX.w #$BFFE
CODE_008A7D:
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	DEX
	DEX
	BNE.b CODE_008A7D
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	RTL

;--------------------------------------------------------------------

CODE_008A8A:
	JSR.w CODE_008A8E
	RTL

CODE_008A8E:
	PHP
	REP.b #$30
	TXA
	AND.w #$00F8
	XBA
	LSR
	STA.w $198C
	PHA
	TXA
	AND.w #$0007
	ASL
	CLC
	ADC.b $01,S
	TAY
	PLA
	LDX.w #$0040
CODE_008AA8:
	LDA.w #$0000
	STA.b [$0A],y
	TYA
	CLC
	ADC.w #$0010
	TAY
	DEX
	BNE.b CODE_008AA8
	JSR.w CODE_008AC2
	INC.w $0202
	JSL.l CODE_01E2CE
	PLP
	RTS

;--------------------------------------------------------------------

CODE_008AC2:
	STZ.w $0202
	LDX.w $0204
	LDY.w #$0000
CODE_008ACB:
	LDA.w DATA_008AF5,y
	STA.w $0182,x
	INY
	INY
	INX
	INX
	CPY.w #$000A
	BCC.b CODE_008ACB
	LDA.w $0204
	CLC
	ADC.w #$0009
	STA.w $0204
	LDA.w $198C
	CLC
	ADC.b $0A
	STA.w $0183
	LDA.w $198C
	LSR
	STA.w $0189
	RTS

DATA_008AF5:
	db $02 : dl $7E0000 : dw $0400,$0080,$0000

;--------------------------------------------------------------------

CODE_008AFF:
	JSR.w CODE_008B03
	RTL

CODE_008B03:
	REP.b #$30
	LDY.w #$5FFE
CODE_008B08:
	TYX
	LDA.b [$0A],y
	STA.l $7FA000,x
	DEY
	DEY
	BPL.b CODE_008B08
	RTS

;--------------------------------------------------------------------

CODE_008B14:
	JSR.w CODE_008B18
	RTL

CODE_008B18:
	REP.b #$30
	LDY.w #$5FFE
CODE_008B1D:
	TYX
	LDA.l $7FA000,x
	STA.b [$0A],y
	DEY
	DEY
	BPL.b CODE_008B1D
	RTS

;--------------------------------------------------------------------

CODE_008B29:
	PHP
	REP.b #$30
	LDA.w #$0000
	LDX.w #$5FFE
CODE_008B32:
	STA.l $7F0000,x
	DEX
	DEX
	BPL.b CODE_008B32
	PLP
	RTS

;--------------------------------------------------------------------

CODE_008B3C:
	JSR.w CODE_008B48
	RTL

;--------------------------------------------------------------------

CODE_008B40:
	JSR.w CODE_008BEB
	RTL

;--------------------------------------------------------------------

CODE_008B44:
	JSR.w CODE_009378
	RTL

;--------------------------------------------------------------------

CODE_008B48:
	LDA.w !RAM_MPAINT_Global_MouseXDisplacementLo
	AND.w #$00FF
	BIT.w #!Mouse_MovingLeft>>24
	BEQ.b CODE_008B56
	ORA.w #$FF00
CODE_008B56:
	CLC
	ADC.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w $04D6
	BPL.b CODE_008B67
	CMP.w $04D4
	BMI.b CODE_008B67
	STA.w !RAM_MPAINT_Global_CursorXPosLo
CODE_008B67:
	LDA.w !RAM_MPAINT_Global_MouseYDisplacementLo
	AND.w #$00FF
	BIT.w #!Mouse_MovingUp>>24
	BEQ.b CODE_008B75
	ORA.w #$FF00
CODE_008B75:
	CLC
	ADC.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w $04DA
	BPL.b CODE_008B86
	CMP.w $04D8
	BMI.b CODE_008B86
	STA.w !RAM_MPAINT_Global_CursorYPosLo
CODE_008B86:
	LDY.w #$0004
	LDA.w !RAM_MPAINT_Global_MouseXDisplacementLo
	ORA.w !RAM_MPAINT_Global_MouseYDisplacementLo
	AND.w #$00FF
	BEQ.b CODE_008B97
	LDY.w #$0001
CODE_008B97:
	TYA
	PHA
	EOR.w $1B28
	AND.b $01,S
	ASL
	ORA.b $01,S
	STA.w $1B26
	STA.w $1B28
	PLA
	RTS

;--------------------------------------------------------------------

CODE_008BA9:
	JSR.w CODE_008D2C
	STX.b $A2
	STA.b $A8
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
	BNE.b CODE_008BBA
	CPX.w #$0002
	BEQ.b CODE_008BC3
CODE_008BBA:
	LDA.w $04CA
	BIT.w #$0020
	BNE.b CODE_008BC3
	RTS

CODE_008BC3:
	JMP.w CODE_009598

;--------------------------------------------------------------------

CODE_008BC6:
	JSR.w CODE_008E0B
	PHA
	CPX.w #$000A
	BEQ.b CODE_008BE1
	CPX.w #$0024
	BEQ.b CODE_008BE1
	CPX.w #$0044
	BEQ.b CODE_008BE1
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_008BE9
CODE_008BE1:
	PLA
	STX.b $A4
	STA.b $AC
	JMP.w CODE_0095E7

CODE_008BE9:
	PLA
	RTS

;--------------------------------------------------------------------

CODE_008BEB:
	LDA.b $20
	BNE.b CODE_008C35
	STZ.w $053B
	JSR.w CODE_009001
	LDA.w $04CA
	BIT.w #$0011
	BEQ.b CODE_008C0F
	LDA.w $19AA
	BNE.b CODE_008C10
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0018
	BCC.b CODE_008BA9
	CMP.w #$00C8
	BCS.b CODE_008BC6
CODE_008C0F:
	RTS

CODE_008C10:
	LDA.w $099F
	BEQ.b CODE_008C27
	LDA.b $AA
	CMP.w #$0007
	BEQ.b CODE_008C27
	LDA.w $04CA
	BIT.w #$0002
	BEQ.b CODE_008C27
	JMP.w CODE_009760

CODE_008C27:
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_008C0F
	JSR.w CODE_008B03
	JMP.w CODE_009564

CODE_008C35:
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BEQ.b CODE_008C6B
	JSR.w CODE_0091C7
	BCS.b CODE_008C48
	JMP.w CODE_009564

CODE_008C48:
	LDA.w $04CA
	BIT.w #$0010
	BNE.b CODE_008C0F
	STZ.b $20
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0005
	BCS.b CODE_008C64
	LDA.w #$0018
	JSL.l CODE_01D368
CODE_008C64:
	LDA.b $AE
	BEQ.b CODE_008C0F
	JMP.w CODE_008B18

CODE_008C6B:
	LDY.w $099F
	BEQ.b CODE_008C87
	LDA.b $AA
	CMP.w #$0007
	BEQ.b CODE_008C87
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCS.b CODE_008C87
	LDA.w $04CA
	BIT.w #$0002
	BNE.b CODE_008CC4
CODE_008C87:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCC.b CODE_008CE7
	JSR.w CODE_008E0B
	LDA.w $04CA
	CPX.w #$000A
	BEQ.b CODE_008CAB
	CPX.w #$0024
	BEQ.b CODE_008CAB
	CPX.w #$0044
	BEQ.b CODE_008CAB
	BIT.w #$0020
	BNE.b CODE_008CB0
	BRA.b CODE_008CE7

CODE_008CAB:
	BIT.w #$0022
	BEQ.b CODE_008CE7
CODE_008CB0:
	CPX.w #$000B
	BEQ.b CODE_008CC4
	CPX.w #$0025
	BEQ.b CODE_008CC4
	CPX.w #$002C
	BEQ.b CODE_008CC4
	CPX.w #$0056
	BNE.b CODE_008CC7
CODE_008CC4:
	JMP.w CODE_009760

CODE_008CC7:
	CPX.w #$0000
	BEQ.b CODE_008CE7
	CPX.w #$0008
	BEQ.b CODE_008D13
	LDA.w $19C0
	BNE.b CODE_008CDD
	CPX.w #$0025
	BEQ.b CODE_008D13
	BRA.b CODE_008CE2

CODE_008CDD:
	CPX.w #$0026
	BEQ.b CODE_008D13
CODE_008CE2:
	STZ.b $20
	JMP.w CODE_008BEB

CODE_008CE7:
	LDA.b $20
	CMP.w #$0003
	BNE.b CODE_008D03
	JSR.w CODE_009001
	LDA.w $19AA
	BNE.b CODE_008D00
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_008D2B
	BRA.b CODE_008D13

CODE_008D00:
	JMP.w CODE_009564

CODE_008D03:
	JSR.w CODE_0091C7
	BCS.b CODE_008D0B
	JMP.w CODE_009564

CODE_008D0B:
	LDA.w $04CA
	BIT.w #$0010
	BNE.b CODE_008D2B
CODE_008D13:
	LDA.w #$0007
	JSL.l CODE_01D368
	STZ.b $20
	STZ.w $1996
	STZ.w $1998
	STZ.w $199A
	STZ.w $199C
	STZ.w $199E
CODE_008D2B:
	RTS

;--------------------------------------------------------------------

CODE_008D2C:
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
	BNE.b CODE_008D9C
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	LDX.w #$0000
CODE_008D37:
	CMP.w DATA_008D5C,x
	BCC.b CODE_008D41
	CMP.w DATA_008D5C+$02,x
	BCC.b CODE_008D4F
CODE_008D41:
	INX
	INX
	INX
	INX
	CPX.w #$0040
	BNE.b CODE_008D37
	LDX.w #$0000
	BRA.b CODE_008D5B

CODE_008D4F:
	TXA
	LSR
	LSR
	LDX.w #$0001
	CMP.w #$000F
	BCC.b CODE_008D5B
	INX
CODE_008D5B:
	RTS

DATA_008D5C:
	dw $0018,$0025,$0026,$0033,$0034,$0041,$0042,$004F
	dw $0050,$005D,$005E,$006B,$006C,$0079,$007A,$0087
	dw $0088,$0095,$0096,$00A3,$00A4,$00B1,$00B2,$00BF
	dw $00C0,$00CD,$00CE,$00DB,$00DC,$00E9,$00EC,$00FC

;--------------------------------------------------------------------

CODE_008D9C:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	LDX.w #$0000
CODE_008DA2:
	CMP.w DATA_008DCB,x
	BCC.b CODE_008DAC
	CMP.w DATA_008DCB+$02,x
	BCC.b CODE_008DBA
CODE_008DAC:
	INX
	INX
	INX
	INX
	CPX.w #$0040
	BNE.b CODE_008DA2
	LDX.w #$0000
	BRA.b CODE_008DCA

CODE_008DBA:
	TXA
	LSR
	LSR
	LDX.w #$0001
	CMP.w #$0006
	BCC.b CODE_008DCA
	SEC
	SBC.w #$0004
	TAX
CODE_008DCA:
	RTS

DATA_008DCB:
	dw $0018,$0025,$0026,$0033,$0034,$0041,$0042,$004F
	dw $0050,$005D,$005E,$006B,$006C,$0079,$007A,$0087
	dw $0088,$0095,$0096,$00A3,$00A4,$00B1,$00B2,$00BF
	dw $00C0,$00CD,$00CE,$00DB,$00DC,$00E9,$00EC,$00FC

;--------------------------------------------------------------------

CODE_008E0B:
	LDA.b $AA
	ASL
	TAX
	LDA.w DATA_008E49,x
	PHA
	INC
	INC
	PHA
	LDA.w DATA_008E69,x
	STA.w $1A0E
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	LDY.w #$0000
CODE_008E22:
	CMP.b ($03,S),y
	BCC.b CODE_008E2A
	CMP.b ($01,S),y
	BCC.b CODE_008E3A
CODE_008E2A:
	INY
	INY
	INY
	INY
	CPY.w $1A0E
	BNE.b CODE_008E22
	PLA
	PLA
	LDX.w #$0000
	BRA.b CODE_008E48

CODE_008E3A:
	PLA
	PLA
	TYA
	LSR
	LSR
	PHA
	LDA.w DATA_008FE1,x
	CLC
	ADC.b $01,S
	TAX
	PLA
CODE_008E48:
	RTS

DATA_008E49:
	dw DATA_008E89,DATA_008EB9,DATA_008EF1,DATA_008EF1,DATA_008F21,DATA_008F3D,DATA_008F3D,DATA_008F3D
	dw DATA_008F69,DATA_008F99,DATA_008F99,DATA_008F99,DATA_008FB9,DATA_008FB9,DATA_008FB9,DATA_008FB9

DATA_008E69:
	dw $0030,$0038,$0000,$0030,$001C,$0000,$0000,$002C
	dw $0030,$0000,$0000,$0020,$0000,$0000,$0000,$0028

DATA_008E89:
	dw $0028,$0037,$0038,$0047,$0048,$0057,$0058,$0067
	dw $0068,$0077,$0080,$008F,$0098,$00A7,$00A8,$00B7
	dw $00B8,$00C7,$0010,$001F,$00D0,$00DF,$00E8,$00EF

DATA_008EB9:
	dw $0008,$0017,$0020,$002F,$0030,$003F,$0040,$004F
	dw $0050,$005F,$0060,$006F,$0070,$007F,$0080,$008F
	dw $0090,$009F,$00A0,$00AF,$00B0,$00BF,$00C0,$00CF
	dw $00D0,$00DF,$00E0,$00EF

DATA_008EF1:
	dw $0008,$0017,$0038,$0047,$0048,$0057,$0058,$0067
	dw $0068,$0077,$0078,$0087,$0090,$009F,$00A8,$00B7
	dw $00B8,$00C7,$0020,$002F,$00D0,$00DF,$00E8,$00EF

DATA_008F21:
	dw $0008,$0017,$0028,$0037,$0040,$004F,$0058,$0067
	dw $0070,$007F,$00D0,$00DF,$00E8,$00EF

DATA_008F3D:
	dw $0010,$001F,$0020,$002F,$0030,$003F,$0048,$0057
	dw $0060,$006F,$0078,$0087,$0090,$009F,$00A0,$00AF
	dw $00B8,$00C7,$00D0,$00DF,$00E8,$00EF

DATA_008F69:
	dw $0008,$0017,$0020,$002F,$0030,$003F,$0068,$0077
	dw $0078,$0087,$0088,$0097,$0098,$00A7,$00A8,$00B7
	dw $00C0,$00CF,$00D0,$00DF,$00E0,$00EF,$0050,$005F

DATA_008F99:
	dw $0008,$0017,$0028,$0037,$0050,$005F,$0060,$006F
	dw $0088,$0097,$00A0,$00AF,$00B8,$00C7,$00D8,$00E7

DATA_008FB9:
	dw $0008,$0017,$0028,$0037,$0038,$0047,$0048,$0057
	dw $0058,$0067,$0068,$0077,$0078,$0087,$0088,$0097
	dw $0098,$00A7,$00D8,$00E7

DATA_008FE1:
	dw $0001,$000D,$0000,$001B,$0027,$0000,$0000,$002E
	dw $0039,$0000,$0000,$0045,$0000,$0000,$0000,$004D

;--------------------------------------------------------------------

CODE_009001:
	JSR.w CODE_0091C7
	BCS.b CODE_009007
	RTS

CODE_009007:
	STZ.w $19A6
	STZ.w $19AA
	LDA.w $19FA
	BEQ.b CODE_009016
	LDA.w $19C2
	INC
CODE_009016:
	ASL
	TAX
	LDA.w DATA_00926C,x
	PHA
	LDY.w #$0002
	LDA.b ($01,S),y
	TAX
	LDY.w #$0000
	LDA.b ($01,S),y
	ASL
	ASL
	CLC
	ADC.w #$0004
	TAY
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
CODE_009031:
	CMP.b ($01,S),y
	INY
	INY
	BCC.b CODE_00903B
	CMP.b ($01,S),y
	BCC.b CODE_00904B
CODE_00903B:
	INY
	INY
	INC.w $19A6
	DEX
	BNE.b CODE_009031
	LDA.w #$FFFF
	STA.w $19A6
	BRA.b CODE_00907E

CODE_00904B:
	LDA.w $19A6
	XBA
	STA.w $19A6
	LDY.w #$0000
	LDA.b ($01,S),y
	TAX
	LDY.w #$0004
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
CODE_00905E:
	CMP.b ($01,S),y
	INY
	INY
	BCC.b CODE_009068
	CMP.b ($01,S),y
	BCC.b CODE_009078
CODE_009068:
	INY
	INY
	INC.w $19A6
	DEX
	BNE.b CODE_00905E
	LDA.w #$FFFF
	STA.w $19A6
	BRA.b CODE_00907E

CODE_009078:
	JSR.w CODE_009082
	INC.w $19AA
CODE_00907E:
	PLA
	JMP.w CODE_0090C4

CODE_009082:
	LDA.w $19FA
	BEQ.b CODE_00908B
	LDA.w $19C2
	INC
CODE_00908B:
	ASL
	TAX
	LDA.w DATA_0092C8,x
	PHA
	LDA.w $19A6
	AND.w #$00FF
	PHA
	LDA.w $19A7
	AND.w #$00FF
	TAY
	BEQ.b CODE_0090AC
	LDA.b $01,S
CODE_0090A3:
	CLC
	ADC.w DATA_0092D0,x
	DEY
	BNE.b CODE_0090A3
	STA.b $01,S
CODE_0090AC:
	PLA
	ASL
	ASL
	ASL
	TAY
	LDX.w #$0000
CODE_0090B4:
	LDA.b ($01,S),y
	STA.w $19AE,x
	INY
	INY
	INX
	INX
	CPX.w #$0008
	BNE.b CODE_0090B4
	PLA
	RTS

CODE_0090C4:
	LDA.w $19AA
	BNE.b CODE_0090D0
	LDA.w $19AC
	BNE.b CODE_0090E7
	BRA.b CODE_0090FA

CODE_0090D0:
	LDA.w $19A6
	CMP.w $19A8
	BEQ.b CODE_0090FA
	LDA.w #$0001
	PHA
	LDA.w $19A6
	BMI.b CODE_0090E6
	PHA
	JSR.w CODE_009107
	PLA
CODE_0090E6:
	PLA
CODE_0090E7:
	LDA.w #$0000
	PHA
	LDA.w $19A8
	BMI.b CODE_0090F5
	PHA
	JSR.w CODE_009107
	PLA
CODE_0090F5:
	PLA
	JSL.l CODE_01DE97
CODE_0090FA:
	LDA.w $19AA
	STA.w $19AC
	LDA.w $19A6
	STA.w $19A8
	RTS

CODE_009107:
	PHD
	TSC
	SEC
	SBC.w #$0010
	TCS
	TCD
	LDA.w $19FA
	BEQ.b CODE_009118
	LDA.w $19C2
	INC
CODE_009118:
	ASL
	TAX
	LDA.w DATA_009185,x
	STA.b $01
	LDY.w #$0000
	LDA.b ($01),y
	STA.b $05
	INY
	INY
	LDA.b ($01),y
	STA.b $07
	LDA.b $15
	AND.w #$00FF
	TAY
	LDA.b $16
	AND.w #$00FF
	TAX
CODE_009138:
	INY
	INY
	INY
	DEX
	BPL.b CODE_009138
	DEY
	TYA
	ASL
	TAY
	LDA.b ($01),y
	STA.b $03
	STZ.b $09
	LDA.b $17
	BEQ.b CODE_009151
	LDA.w #$1400
	STA.b $09
CODE_009151:
	LDY.w #$0000
CODE_009154:
	TYA
	CLC
	ADC.b $03
	TAX
	LDA.l $7E2000,x
	AND.w #$E3FF
	ORA.b $09
	STA.l $7E2000,x
	INY
	INY
	TYA
	AND.w #$003F
	CMP.b $05
	BNE.b CODE_009179
	TYA
	CLC
	ADC.w #$0040
	SEC
	SBC.b $05
	TAY
CODE_009179:
	CPY.b $07
	BNE.b CODE_009154
	TSC
	CLC
	ADC.w #$0010
	TCS
	PLD
	RTS

DATA_009185:
	dw DATA_00918D,DATA_009193,DATA_0091A1,DATA_0091B1

DATA_00918D:
	dw $0040,$0580,$00C0

DATA_009193:
	dw $0020,$02C0,$00C0,$00E0,$0000,$0380,$03A0

DATA_0091A1:
	dw $0014,$02C0,$00C2,$00D6,$00EA,$0382,$0396,$03AA

DATA_0091B1:
	dw $0014,$01C0,$00C2,$00D6,$00EA,$0282,$0296,$02AA
	dw $0442,$0456,$046A

;--------------------------------------------------------------------

CODE_0091C7:
	LDA.w $19AA
	BNE.b CODE_0091CE
	SEC
	RTS

CODE_0091CE:
	LDA.w $19FA
	BEQ.b CODE_0091D7
	LDA.w $19C2
	INC
CODE_0091D7:
	ASL
	TAX
	LDA.w DATA_00926C,x
	PHA
	LDA.w $19A6
	AND.w #$00FF
	ASL
	ASL
	CLC
	ADC.w #$0004
	TAY
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0005
	BCC.b CODE_009209
	CMP.w #$0007
	BEQ.b CODE_009209
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.b ($01,S),y
	BMI.b CODE_009269
	INY
CODE_009202:
	INY
	CMP.b ($01,S),y
	BPL.b CODE_009269
	BRA.b CODE_00921E

CODE_009209:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CLC
	ADC.w #$0008
	CMP.b ($01,S),y
	BMI.b CODE_009269
	INY
	INY
	SEC
	SBC.w #$0011
	CMP.b ($01,S),y
	BPL.b CODE_009269
CODE_00921E:
	LDA.w $19A6
	AND.w #$FF00
	XBA
	LDY.w #$0000
	CLC
	ADC.b ($01,S),y
	ASL
	ASL
	CLC
	ADC.w #$0004
	TAY
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0005
	BCC.b CODE_009251
	CMP.w #$0007
	BEQ.b CODE_009251
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.b ($01,S),y
	BMI.b CODE_009269
	INY
	INY
	CMP.b ($01,S),y
	BPL.b CODE_009269
	BRA.b CODE_009266

CODE_009251:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CLC
	ADC.w #$0008
	CMP.b ($01,S),y
	BMI.b CODE_009269
	INY
	INY
	SEC
	SBC.w #$0011
	CMP.b ($01,S),y
	BPL.b CODE_009269
CODE_009266:
	PLA
	CLC
	RTS

CODE_009269:
	PLA
	SEC
	RTS

DATA_00926C:
	dw DATA_009274,DATA_009280,DATA_009294,DATA_0092AC

DATA_009274:
	dw $0001,$0001,$0004,$00FC,$001C,$00C4

DATA_009280:
	dw $0002,$0002,$0004,$007C,$0084,$00FC,$001C,$006C
	dw $0074,$00C4

DATA_009294:
	dw $0003,$0002,$000C,$0054,$005C,$00A4,$00AC,$00F4
	dw $001C,$006C,$0074,$00C4

DATA_0092AC:
	dw $0003,$0003,$000C,$0054,$005C,$00A4,$00AC,$00F4
	dw $001C,$004C,$0054,$0084,$008C,$00BC

DATA_0092C8:
	dw DATA_0092D8,DATA_0092E0,DATA_009300,DATA_009330

DATA_0092D0:
	dw $0000,$0002,$0003,$0003

DATA_0092D8:
	dw $0000,$00F8,$001C,$00C4

DATA_0092E0:
	dw $0000,$0078,$001C,$006C,$0080,$00F8,$001C,$006C
	dw $0000,$0078,$0074,$00C4,$0080,$00F8,$0074,$00C4

DATA_009300:
	dw $0008,$0050,$001C,$006C,$0058,$00A0,$001C,$006C
	dw $00A8,$00F0,$001C,$006C,$0008,$0050,$0074,$00C4
	dw $0058,$00A0,$0074,$00C4,$00A8,$00F0,$0074,$00C4

DATA_009330:
	dw $0008,$0050,$001C,$004C,$0058,$00A0,$001C,$004C
	dw $00A8,$00F0,$001C,$004C,$0008,$0050,$0054,$0084
	dw $0058,$00A0,$0054,$0084,$00A8,$00F0,$0054,$0084
	dw $0008,$0050,$008C,$00BC,$0058,$00A0,$008C,$00BC
	dw $00A8,$00F0,$008C,$00BC

;--------------------------------------------------------------------

CODE_009378:
	JSL.l CODE_01E8F6
	PHP
	LDA.w $1996
	PHA
	LDA.w $04D0
	LDY.w !RAM_MPAINT_Global_CursorYPosLo
	CPY.w #$001C
	BCC.b CODE_0093A5
	LDX.w $19FA
	BEQ.b CODE_0093A0
	LDX.w $19C2
	CPX.w #$0002
	BNE.b CODE_0093A0
	CPY.w #$00BC
	BCS.b CODE_0093A5
	BRA.b CODE_0093C6

CODE_0093A0:
	CPY.w #$00C4
	BCC.b CODE_0093C6
CODE_0093A5:
	LDY.w $19AA
	BNE.b CODE_0093C6
	LDY.w $09D1
	BNE.b CODE_0093C6
CODE_0093AF:
	LDA.w $19A0
	BNE.b CODE_0093C3
	LDA.w $1998
	STA.w $199C
	LDA.w $199A
	STA.w $199E
	INC.w $19A0
CODE_0093C3:
	LDA.w #$000C
CODE_0093C6:
	CMP.w #$000C
	BEQ.b CODE_0093E4
	LDY.w $0567
	BNE.b CODE_0093AF
	LDY.w $19A0
	BEQ.b CODE_0093E4
	LDY.w $199C
	STY.w $1998
	LDY.w $199E
	STY.w $199A
	STZ.w $19A0
CODE_0093E4:
	CMP.w #$0006
	BNE.b CODE_0093FF
	LDY.b $20
	BNE.b CODE_0093F6
	STZ.w $1996
	STZ.w $1998
	STZ.w $199A
CODE_0093F6:
	LDY.w $19C0
	BEQ.b CODE_0093FF
	CLC
	ADC.w #$000A
CODE_0093FF:
	XBA
	STA.w $19A2
	XBA
	AND.w #$00FF
	ASL
	TAX
	LDA.w DATA_0094E6,x
	PHA
	LDA.w DATA_0094E6+$02,x
	SEC
	SBC.b $01,S
	DEC
	DEC
	DEC
	STA.w $19A3
	SEP.b #$20
	LDY.w #$0002
	LDA.b ($01,S),y
	STA.w $19A4
	STZ.w $19A5
	LDY.w #$0000
	LDA.b ($01,S),y
	ASL
	CMP.b #$80
	ROR
	BPL.b CODE_009434
	DEC.w $19A5
CODE_009434:
	CLC
	ADC.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp
	LDA.w $19A5
	ADC.w !RAM_MPAINT_Global_CursorXPosHi
	AND.b #$01
	STA.w $19A5
	LDA.b ($01,S),y
	AND.b #$80
	ORA.w $1996
	STA.w $1996
	INY
	LDA.b ($01,S),y
	ASL
	CMP.b #$80
	ROR
	CLC
	ADC.w !RAM_MPAINT_Global_CursorYPosLo
	STA.w MPAINT_Global_OAMBuffer[$00].YDisp
	LDA.b ($01,S),y
	CMP.b #$80
	ROL
	ASL
	ORA.w $19A5
	STA.w $19A5
	REP.b #$20
	LDA.b $01,S
	CMP.w #DATA_009515
	SEP.b #$20
	BNE.b CODE_00948D
	LDA.w $0EB8
	BNE.b CODE_009480
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CMP.b #$70
	BCC.b CODE_00948D
CODE_009480:
	LDA.b #$6C
	STA.w MPAINT_Global_OAMBuffer[$00].Tile
	LDA.w $09CF
	STA.w MPAINT_Global_OAMBuffer[$00].Prop
	BRA.b CODE_0094CF

CODE_00948D:
	LDA.w $19A3
	BEQ.b CODE_0094C0
	LDA.w $1998
	CMP.w $19A4
	BCC.b CODE_0094A0
	STZ.w $1998
	INC.w $199A
CODE_0094A0:
	LDA.w $199A
	CMP.w $19A3
	BCC.b CODE_0094AB
	STZ.w $199A
CODE_0094AB:
	LDA.w $1996
	BEQ.b CODE_0094B3
	INC.w $1998
CODE_0094B3:
	REP.b #$20
	LDA.w $199A
	AND.w #$00FF
	INC
	INC
	TAY
	SEP.b #$20
CODE_0094C0:
	INY
	LDA.b ($01,S),y
	STA.w MPAINT_Global_OAMBuffer[$00].Tile
	LDA.w $19A2
	ORA.w $09CF
	STA.w MPAINT_Global_OAMBuffer[$00].Prop
CODE_0094CF:
	LDA.w $19A5
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot
	AND.b #$03
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot
	REP.b #$20
	PLA
	PLA
	STA.w $1996
	PLP
CODE_0094E5:
	RTS

DATA_0094E6:
	dw DATA_00950C,DATA_00950F,DATA_009512,DATA_009515,DATA_009518,DATA_00951B,DATA_00951E,DATA_009523
	dw DATA_009526,DATA_009529,DATA_009532,DATA_009537,DATA_00953C,DATA_009545,DATA_00954E,DATA_009553
	dw DATA_009556,DATA_00955B,CODE_009564

DATA_00950C:	db $00,$FE,$00
DATA_00950F:	db $7E,$FD,$02
DATA_009512:	db $7F,$FD,$04
DATA_009515:	db $78,$F7,$06
DATA_009518:	db $00,$80,$08
DATA_00951B:	db $00,$F8,$0A
DATA_00951E:	db $00,$FF,$08,$22,$C4
DATA_009523:	db $78,$F7,$6E
DATA_009526:	db $00,$FF,$24
DATA_009529:	db $80,$80,$03,$E4,$E6,$E8,$EA,$EC,$EE
DATA_009532:	db $00,$F1,$08,$2A,$2C
DATA_009537:	db $00,$80,$08,$28,$2A
DATA_00953C:	db $80,$00,$03,$0C,$0D,$0E,$1C,$1D,$1E
DATA_009545:	db $80,$00,$03,$CA,$CB,$CC,$DA,$DB,$DC
DATA_00954E:	db $F8,$F8,$08,$E0,$E2
DATA_009553:	db $7C,$FC,$2C
DATA_009556:	db $00,$FF,$08,$C0,$C2
DATA_00955B:	db $80,$80,$03,$E4,$E6,$E8,$EA,$EC,$EE	

;--------------------------------------------------------------------

CODE_009564:
	LDA.w $04D0
	AND.w #$00FF
	SEC
	SBC.w #$0004
	BPL.b CODE_009573
	LDA.w #$0000
CODE_009573:
	CMP.w #$000C
	BNE.b CODE_00957B
	LDA.w #$0002
CODE_00957B:
	LDY.w $0567
	BEQ.b CODE_009583
	LDA.w #$0005
CODE_009583:
	ASL
	TAX
	JMP.w (DATA_009588,x)

DATA_009588:
	dw CODE_009C25
	dw CODE_009DAB
	dw CODE_009DFB
	dw CODE_009C25
	dw CODE_009C25
	dw CODE_0094E5
	dw CODE_0094E5
	dw CODE_0094E5

;--------------------------------------------------------------------

CODE_009598:
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_0095A4
	RTS

CODE_0095A4:
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
	BNE.b CODE_0095BB
	LDA.w $0EB8
	BNE.b CODE_0095DA
	LDA.b $A2
	ASL
	TAX
	JMP.w (DATA_0095B5,x)

DATA_0095B5:
	dw CODE_0094E5
	dw CODE_009853
	dw CODE_00987B

CODE_0095BB:
	LDA.b $A2
	ASL
	TAX
	JMP.w (DATA_0095C2,x)

DATA_0095C2:
	dw CODE_0094E5
	dw CODE_00A509
	dw CODE_00A55B
	dw CODE_00A617
	dw CODE_00A637
	dw CODE_00A6F7
	dw CODE_00A792
	dw CODE_00A8A8
	dw CODE_00A8FF
	dw CODE_00A95D
	dw CODE_00A9BE
	dw CODE_0094E5

CODE_0095DA:
	LDA.b $A2
	ASL
	TAX
	JMP.w (DATA_0095E1,x)

DATA_0095E1:
	dw CODE_0094E5
	dw CODE_00E817
	dw CODE_00E87A

;--------------------------------------------------------------------

CODE_0095E7:
	LDA.b $A4
	ASL
	TAX
	JMP.w (DATA_0095EE,x)

DATA_0095EE:
	dw CODE_0094E5
	dw CODE_0098C3
	dw CODE_0098C3
	dw CODE_0098C3
	dw CODE_0098F8
	dw CODE_009928
	dw CODE_009A35
	dw CODE_00995B
	dw CODE_00998B
	dw CODE_00A4B4
	dw CODE_0096A1
	dw CODE_009760
	dw CODE_009BBA
	dw CODE_009A9E
	dw CODE_009B63
	dw CODE_009B63
	dw CODE_009B63
	dw CODE_009B96
	dw CODE_009B63
	dw CODE_009B63
	dw CODE_009B63
	dw CODE_009B96
	dw CODE_009B63
	dw CODE_009B63
	dw CODE_009B63
	dw CODE_009B96
	dw CODE_009760
	dw CODE_00C42A
	dw CODE_0098C3
	dw CODE_0098C3
	dw CODE_0098C3
	dw CODE_0098F8
	dw CODE_009928
	dw CODE_009A35
	dw CODE_00995B
	dw CODE_00A4B4
	dw CODE_0096A1
	dw CODE_009760
	dw CODE_00C6EF
	dw CODE_00C42A
	dw CODE_00CAD7
	dw CODE_00E7D9
	dw CODE_00998B
	dw CODE_0099E1
	dw CODE_009760
	dw CODE_00C6EF
	dw CODE_00CAD7
	dw CODE_00E7D9
	dw CODE_00D869
	dw CODE_00C42A
	dw CODE_00EB7A
	dw CODE_00CE22
	dw CODE_00E3F7
	dw CODE_00C9E3
	dw CODE_009734
	dw CODE_0096A6
	dw CODE_009BBA
	dw CODE_00EAA4
	dw CODE_00E9A1
	dw CODE_00E9A1
	dw CODE_00EA12
	dw CODE_00EA12
	dw CODE_00EA12
	dw CODE_00EA12
	dw CODE_00EA12
	dw CODE_00E848
	dw CODE_00EA69
	dw CODE_009760
	dw CODE_0096A1
	dw CODE_00EF6E
	dw CODE_00F9A7
	dw CODE_00FA08
	dw CODE_00FA08
	dw CODE_00FEF9
	dw CODE_00FEF9
	dw CODE_00FEF9
	dw CODE_00FA65
	dw CODE_00969C
	dw CODE_00969C
	dw CODE_00969C
	dw CODE_00969C
	dw CODE_00969C
	dw CODE_00969C
	dw CODE_00969C
	dw CODE_00969C
	dw CODE_00969C
	dw CODE_009760

;--------------------------------------------------------------------

CODE_00969C:
	JSL.l CODE_01D409
	RTS

;--------------------------------------------------------------------

CODE_0096A1:
	JSL.l CODE_01D3BA
	RTS

;--------------------------------------------------------------------

CODE_0096A6:
	JSL.l CODE_019F6C
	RTS

;--------------------------------------------------------------------

CODE_0096AB:
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BEQ.b CODE_0096BB
	CMP.w #$0007
	BNE.b CODE_0096C1
CODE_0096BB:
	LDA.w $1B10
	STA.w $04D0
CODE_0096C1:
	LDA.w $04D0
	AND.w #$FF00
	ORA.b $AC
	STA.w $04D0
	RTS

;--------------------------------------------------------------------

CODE_0096CD:
	PHB
	PEA.w $0000
	PLB
	PLB
	LDA.w #$003E
	JSR.w CODE_00B66C
	LDA.w #$0001
	JSR.w CODE_00B6F4
	PLB
	RTL

;--------------------------------------------------------------------

CODE_0096E1:
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0003
	BNE.b CODE_0096F8
	LDA.w $0EB8
	BNE.b CODE_009725
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CMP.w #$0070
	BCS.b CODE_009714
CODE_0096F8:
	LDA.b $A8
	XBA
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B66C
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0008
	BEQ.b CODE_00970E
	JMP.w CODE_00B6F4

CODE_00970E:
	LDA.w $198A
	JMP.w CODE_00B6F4

CODE_009714:
	LDA.b $A8
	XBA
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B6F4
	LDA.w #$000D
	JSR.w CODE_00B66C
	JMP.w CODE_00A451

CODE_009725:
	LDA.w $0EBC
	JSR.w CODE_00B780
	LDA.w $0EBE
	JSR.w CODE_00B66C
	JMP.w CODE_00A451

CODE_009734:
	PHP
	LDA.w #$0006
	JSL.l CODE_01D368
	LDA.w $19FA
	BNE.b CODE_00975E
	SEP.b #$20
	LDA.b #$06
	STA.w $011A
CODE_009748:
	JSL.l CODE_01E2CE
	LDA.w $04CA
	BIT.b #$20
	BEQ.b CODE_009748
	LDA.b #$06
	JSL.l CODE_01D368
	LDA.b #$13
	STA.w $011A
CODE_00975E:
	PLP
	RTS

;--------------------------------------------------------------------

CODE_009760:
	LDA.w #$0009
	JSL.l CODE_01D368
	LDX.b $AA
	LDA.w DATA_009843,x
	AND.w #$00FF
	PHA
	PHX
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	STZ.w $0206
	JSR.w CODE_008B18
	STZ.w $0208
	INC.w $0206
CODE_009784:
	JSL.l CODE_01E2CE
	LDA.w $0208
	BNE.b CODE_009784
	LDA.b $AA
	BEQ.b CODE_0097B8
	CMP.w #$0001
	BEQ.b CODE_0097C0
	CMP.w #$0003
	BEQ.b CODE_0097C5
	CMP.w #$0004
	BEQ.b CODE_0097D8
	CMP.w #$0008
	BEQ.b CODE_0097ED
	CMP.w #$000F
	BNE.b CODE_0097AD
	JMP.w CODE_009834

CODE_0097AD:
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	RTS

CODE_0097B8:
	LDA.w $04D0
	AND.w #$00FF
	BRA.b CODE_009837

CODE_0097C0:
	LDA.w $1988
	BRA.b CODE_009837

CODE_0097C5:
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BEQ.b CODE_0097AD
	CMP.w #$0007
	BNE.b CODE_009837
	DEC
	BRA.b CODE_009837

CODE_0097D8:
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_0097AD
	LDA.w $19C0
	BRA.b CODE_009837

CODE_0097E8:
	LDA.w #$0001
	BRA.b CODE_009837

CODE_0097ED:
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
	BNE.b CODE_009821
	LDA.w $0EB8
	BMI.b CODE_00980A
	JSR.w CODE_00EB3B
	PHA
	LDA.w $0EBA
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	RTS

CODE_00980A:
	JSR.w CODE_00EB3B
	PHA
	LDA.w #$0007
	PHA
	LDA.w $0EBA
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0003
	PHA
	JSR.w CODE_009FC4
	RTS

CODE_009821:
	LDA.w #$0008
	PHA
	LDA.w $0EBA
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	RTS

CODE_009834:
	LDA.w $0997
CODE_009837:
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	RTS

DATA_009843:
	db $08,$0C,$FF,$07,$02,$FF,$FF,$FF
	db $09,$00,$FF,$FF,$FF,$FF,$FF,$08

;--------------------------------------------------------------------

CODE_009853:
	LDA.w #$0004
	JSL.l CODE_01D368
	LDA.b $A8
	AND.w #$00FF
	XBA
	STA.b $A8
	LDA.w $04D0
	CMP.w #$0007
	BNE.b CODE_00986D
	LDA.w $1B10
CODE_00986D:
	AND.w #$00FF
	ORA.b $A8
	STA.w $04D0
	JSR.w CODE_0096E1
	JMP.w CODE_00E64F

;--------------------------------------------------------------------

CODE_00987B:
	LDY.w #$0010
	LDA.w $04CA
	AND.w #$0044
	BNE.b CODE_009887
	RTS

CODE_009887:
	BIT.w #$0040
	BNE.b CODE_00988F
	LDY.w #$FFF0
CODE_00988F:
	PHY
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CLC
	ADC.b $01,S
	CMP.w #$0060
	BNE.b CODE_00989D
	CLC
	ADC.b $01,S
CODE_00989D:
	AND.w #$00F0
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	PLY
	LSR
	LSR
	LSR
	LSR
	CMP.w #$0006
	BCC.b CODE_0098AD
	DEC
CODE_0098AD:
	CLC
	ADC.w #$0062
	JSL.l CODE_01D368
	LDA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_0098C3:
	LDA.w #$0001
	JSL.l CODE_01D368
	STZ.b $B8
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w $19FA
	BEQ.b CODE_0098D6
	DEC.b $AC
CODE_0098D6:
	JSR.w CODE_0096AB
	LDA.w $04D0
	AND.w #$00FF
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	LDA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_0098F8:
	LDA.w #$0001
	JSL.l CODE_01D368
	STZ.b $B8
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$0003
	STA.b $AC
	JSR.w CODE_0096AB
	LDA.w #$0003
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	LDA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_009928:
	LDA.w #$0001
	JSL.l CODE_01D368
	LDA.w #$0001
	STA.b $B8
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$0004
	STA.b $AC
	JSR.w CODE_0096AB
	LDA.w #$0004
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	LDA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_00995B:
	LDA.w #$0006
	JSL.l CODE_01D368
	STZ.b $B8
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$0005
	STA.b $AC
	JSR.w CODE_0096AB
	LDA.w #$0005
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	LDA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_00998B:
	LDA.w #$0006
	JSL.l CODE_01D368
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_0099A2
	LDA.w $19C0
	BEQ.b CODE_0099E0
CODE_0099A2:
	CMP.w #$0007
	BEQ.b CODE_0099AD
	LDA.w $04D0
	STA.w $1B10
CODE_0099AD:
	STZ.b $B8
	STZ.w $1996
	STZ.w $1998
	STZ.w $199A
	STZ.w $19C0
	LDA.w $04D0
	AND.w #$F000
	ORA.w #$0006
	STA.w $04D0
	LDA.w #$0006
	LDY.b $AA
	BEQ.b CODE_0099D1
	LDA.w #$0000
CODE_0099D1:
	PHA
	PHY
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	INC.w $09AB
	JSR.w CODE_00A363
CODE_0099E0:
	RTS

;--------------------------------------------------------------------

CODE_0099E1:
	LDA.w #$0006
	JSL.l CODE_01D368
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_0099F8
	LDA.w $19C0
	BNE.b CODE_009A34
CODE_0099F8:
	CMP.w #$0007
	BEQ.b CODE_009A03
	LDA.w $04D0
	STA.w $1B10
CODE_009A03:
	STZ.b $B8
	STZ.w $1996
	STZ.w $1998
	STZ.w $199A
	LDA.w #$0001
	STA.w $19C0
	LDA.w $04D0
	AND.w #$F000
	ORA.w #$0006
	STA.w $04D0
	LDA.w #$0001
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	INC.w $09AB
	JSR.w CODE_00A363
CODE_009A34:
	RTS

;--------------------------------------------------------------------

CODE_009A35:
	LDA.w #$0002
	JSL.l CODE_01D368
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	STZ.b $B8
	LDA.w $04D0
	STA.w $1B12
	AND.w #$00FF
	CMP.w #$0006
	BEQ.b CODE_009A54
	CMP.w #$0007
	BNE.b CODE_009A5A
CODE_009A54:
	LDA.w $1B10
	STA.w $04D0
CODE_009A5A:
	LDA.w $04D0
	AND.w #$FF00
	ORA.w #$0008
	STA.w $04D0
	LDA.w $1988
	LSR
	LSR
	INC
	STA.b $AE
	LDA.w #$0001
	STA.b $AA
	LDA.w $1988
	PHA
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	PLA
	AND.w #$0003
	STA.w $198A
	CMP.w #$0003
	BNE.b CODE_009A90
	INC.b $B8
CODE_009A90:
	LDA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_009A9E:
	LDA.w #$0041
	JSL.l CODE_01D368
	LDA.w $1B12
	AND.w #$00FF
	CMP.w #$0006
	BEQ.b CODE_009AB5
	CMP.w #$0007
	BNE.b CODE_009ACA
CODE_009AB5:
	PHA
	LDA.w $04D0
	AND.w #$FF00
	ORA.b $01,S
	STA.w $1B10
	PLA
	LDA.w $1B12
	STA.w $04D0
	BRA.b CODE_009AD7

CODE_009ACA:
	PHA
	LDA.w $04D0
	AND.w #$FF00
	ORA.b $01,S
	STA.w $04D0
	PLA
CODE_009AD7:
	STZ.b $AE
	LDA.w $19FA
	BNE.b CODE_009AE2
	STZ.b $AA
	BRA.b CODE_009AE7

CODE_009AE2:
	LDA.w #$0003
	STA.b $AA
CODE_009AE7:
	STZ.b $B8
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0004
	BNE.b CODE_009AF6
	INC.b $B8
CODE_009AF6:
	CMP.w #$0007
	BEQ.b CODE_009B33
	CMP.w #$0006
	BEQ.b CODE_009B1F
	LDA.w $04D0
	AND.w #$00FF
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	LDA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

CODE_009B1F:
	LDA.w #$0006
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	INC.w $09AB
	JMP.w CODE_00A363

CODE_009B33:
	LDA.w #$0001
	STA.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$000F
	JSR.w CODE_00B66C
	LDA.w !RAM_MPAINT_Canvas_EraseToolSize
	CLC
	ADC.w #$0008
	JSR.w CODE_00B6F4
	LDA.w #$0007
	STA.w $04D0
	LDA.w #$0007
	LDY.b $AA
	BEQ.b CODE_009B57
	DEC
CODE_009B57:
	PHA
	PHY
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_009B63:
	LDA.w #$000B
	JSL.l CODE_01D368
	STZ.b $B8
	LDA.b $AC
	DEC
	STA.w $1988
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	LDA.b $AC
	DEC
	STA.w $1988
	PHA
	LSR
	LSR
	INC
	STA.b $AE
	PLA
	AND.w #$0003
	STA.w $198A
	JSR.w CODE_00B6F4
	JMP.w CODE_00E64F

;--------------------------------------------------------------------

CODE_009B96:
	LDA.w #$000B
	JSL.l CODE_01D368
	INC.b $B8
	LDA.b $AC
	DEC
	STA.w $1988
	PHA
	LSR
	LSR
	INC
	STA.b $AE
	PLA
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	JMP.w CODE_00E64F

;--------------------------------------------------------------------

CODE_009BBA:
	LDA.w #$0003
	JSL.l CODE_01D368
	LDA.b $AA
	EOR.w #$0007
	STA.b $AA
	CMP.w #$0007
	BEQ.b CODE_009BFB
	LDA.w #$0009
	PHA
	LDA.w $04D0
	AND.w #$00FF
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	LDA.w #$0010
	JSL.l CODE_009C1B
	LDA.w $04D0
	AND.w #$00FF
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	RTS

CODE_009BFB:
	LDA.w #$0000
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	LDA.w #$0010
	JSL.l CODE_009C1B
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	RTS

;--------------------------------------------------------------------

CODE_009C1B:
	PHA
	JSL.l CODE_01E2CE
	PLA
	DEC
	BNE.b CODE_009C1B
	RTL

;--------------------------------------------------------------------

CODE_009C25:
	LDA.b $AE
	BEQ.b CODE_009C2C
	JMP.w CODE_009CC7

CODE_009C2C:
	STZ.b $50
	LDA.w $09D4
	BNE.b CODE_009C87
	LDA.b $20
	BNE.b CODE_009C40
	LDA.w #$0001
	STA.b $BA
	STZ.b $BC
	STZ.b $BE
CODE_009C40:
	LDA.b $20
	BEQ.b CODE_009C4C
	LDA.w $1B26
	BIT.w #$0002
	BEQ.b CODE_009C51
CODE_009C4C:
	JSR.w CODE_009D7D
	BRA.b CODE_009C65

CODE_009C51:
	BIT.w #$0001
	BNE.b CODE_009C65
	LDA.w $04D0
	CMP.w #$0007
	BEQ.b CODE_009C65
	LDA.w #$0001
	JSL.l CODE_01D348
CODE_009C65:
	LDY.w #$0001
	LDA.w $04CA
	BIT.w #$0010
	BNE.b CODE_009C78
	LDA.w #$0018
	JSL.l CODE_01D368
	DEY
CODE_009C78:
	STY.b $20
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.b $22
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.b $24
	JMP.w CODE_00AAEF

CODE_009C87:
	LDA.b $20
	BNE.b CODE_009CA4
	LDA.w #$0001
	STA.b $BA
	STZ.b $BC
	STZ.b $BE
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.b $22
	STA.b $26
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.b $24
	STA.b $28
	BRA.b CODE_009CB6

CODE_009CA4:
	LDA.b $26
	STA.b $22
	LDA.b $28
	STA.b $24
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.b $26
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.b $28
CODE_009CB6:
	LDY.w #$0000
	LDA.w $04CA
	BIT.w #$0010
	BEQ.b CODE_009CC2
	INY
CODE_009CC2:
	STY.b $20
	JMP.w CODE_00AAFB

CODE_009CC7:
	LDA.w #$0001
	STA.b $50
	LDA.b $20
	BNE.b CODE_009CEA
	JSR.w CODE_008B03
	LDA.w #$0001
	STA.b $BA
	STA.b $BE
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.b $22
	STA.b $26
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.b $24
	STA.b $28
	BRA.b CODE_009CF4

CODE_009CEA:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.b $26
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.b $28
CODE_009CF4:
	LDY.w #$0000
	LDA.w $04CA
	BIT.w #$0010
	BEQ.b CODE_009D00
	INY
CODE_009D00:
	STY.b $20
	BEQ.b CODE_009D11
	LDA.w $1B26
	BIT.w #$0001
	BNE.b CODE_009D5A
	BIT.w #$0008
	BEQ.b CODE_009D14
CODE_009D11:
	JSR.w CODE_008B18
CODE_009D14:
	LDA.b $20
	BNE.b CODE_009D49
	LDA.w $198A
	LDY.b $B8
	BEQ.b CODE_009D22
	LDA.w #$0003
CODE_009D22:
	PHA
	LDA.b $AE
	CMP.w #$0003
	BNE.b CODE_009D2B
	DEC
CODE_009D2B:
	DEC
	ASL
	ASL
	CLC
	ADC.b $01,S
	CLC
	ADC.w #$001D
	JSL.l CODE_01D368
	PLA
	LDA.w #$0004
	STA.w $053B
	STZ.w $053D
	LDA.w #$0003
	STA.w $053F
CODE_009D49:
	LDA.b $AE
	CMP.w #$0002
	BEQ.b CODE_009D5B
	CMP.w #$0003
	BEQ.b CODE_009D60
	JSR.w CODE_00AAFB
	BRA.b CODE_009D63

CODE_009D5A:
	RTS

CODE_009D5B:
	JSR.w CODE_00AB26
	BRA.b CODE_009D63

CODE_009D60:
	JSR.w CODE_00AB8A
CODE_009D63:
	LDA.b $20
	BNE.b CODE_009D6E
	LDA.w #$0010
	JSL.l CODE_009C1B
CODE_009D6E:
	LDA.w #$0001
	JSL.l CODE_01D348
	LDA.w #$0018
	JSL.l CODE_01D368
	RTS

;--------------------------------------------------------------------

CODE_009D7D:
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0003
	BCC.b CODE_009DA2
	BEQ.b CODE_009D98
	CMP.w #$0004
	BEQ.b CODE_009D9D
	LDA.w #$0047
	CLC
	ADC.w !RAM_MPAINT_Canvas_EraseToolSize
	BRA.b CODE_009DA6

CODE_009D98:
	LDA.w #$0029
	BRA.b CODE_009DA6

CODE_009D9D:
	LDA.w #$001C
	BRA.b CODE_009DA6

CODE_009DA2:
	CLC
	ADC.w #$0019
CODE_009DA6:
	JSL.l CODE_01D368
	RTS

;--------------------------------------------------------------------

CODE_009DAB:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.b $86
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.b $88
	LDA.w $04D0
	AND.w #$0F00
	XBA
	TAX
	LDA.w DATA_009DEB,x
	AND.w #$00FF
	STA.b $6E
	LDA.w #$0025
	JSL.l CODE_01D368
	LDA.w #$0004
	STA.w $053B
	STZ.w $053D
	LDA.w #$0003
	STA.w $053F
	JSR.w CODE_00B3FF
	LDY.w #$0008
CODE_009DE1:
	PHY
	JSL.l CODE_01E2CE
	PLY
	DEY
	BNE.b CODE_009DE1
	RTS

DATA_009DEB:
	db $01,$02,$03,$04,$05,$06,$07,$08
	db $09,$0A,$0B,$0D,$0E,$0F,$0C,$00

;--------------------------------------------------------------------

CODE_009DFB:
	STZ.w $1996
	LDA.w $19AE
	CLC
	ADC.w #$0004
	STA.w $19B6
	LDA.w $19B0
	CLC
	ADC.w #$0003
	STA.w $19B8
	LDA.w $19B2
	SEC
	SBC.w #$0001
	STA.w $19BA
	LDA.w $19B4
	SEC
	SBC.w #$0002
	STA.w $19BC
	LDA.b $20
	BNE.b CODE_009E76
	LDA.w #$0026
	JSL.l CODE_01D368
	LDA.w #$0004
	STA.w $053B
	STZ.w $053D
	LDA.w #$0003
	STA.w $053F
	STZ.w $1998
	STZ.w $199A
	LDA.w $19C0
	BNE.b CODE_009E5B
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.b $22
	STA.b $26
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.b $24
	STA.b $28
	BRA.b CODE_009E91

CODE_009E5B:
	LDA.w $19B6
	STA.b $22
	LDA.w $19B8
	STA.b $26
	LDA.w $19BA
	INC
	STA.b $24
	LDA.w $19BC
	INC
	STA.b $28
	LDY.w #$0002
	BRA.b CODE_009E9D

CODE_009E76:
	CMP.w #$0002
	BCS.b CODE_009EA0
	STZ.w $1998
	LDA.w #$0001
	STA.w $199A
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.b $26
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.b $28
	JSR.w CODE_00ADFB
CODE_009E91:
	LDY.w #$0002
	LDA.w $04CA
	BIT.w #$0010
	BEQ.b CODE_009E9D
	DEY
CODE_009E9D:
	STY.b $20
	RTS

CODE_009EA0:
	CMP.w #$0003
	BEQ.b CODE_009EEB
	STZ.w $053B
	LDA.w #$0027
	JSL.l CODE_01D368
	LDA.b $22
	LDX.b $26
	CMP.b $26
	BCC.b CODE_009EBB
	STX.b $22
	STA.b $26
CODE_009EBB:
	LDA.b $24
	LDX.b $28
	CMP.b $28
	BCC.b CODE_009EC7
	STX.b $24
	STA.b $28
CODE_009EC7:
	JSL.l CODE_01D75B
	LDA.w $19C0
	BNE.b CODE_009EE8
	LDA.b $22
	CLC
	ADC.b $26
	LSR
	STA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w $099B
	LDA.b $24
	CLC
	ADC.b $28
	LSR
	STA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.w $099D
CODE_009EE8:
	INC.b $20
	RTS

CODE_009EEB:
	LDA.w $04CA
	BIT.w #$0020
	BNE.b CODE_009F50
	INC.w $1996
	LDA.w $19C0
	BEQ.b CODE_009EFC
	RTS

CODE_009EFC:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	SEC
	SBC.w $099B
	PHA
	CLC
	ADC.b $22
	STA.b $22
	PLA
	CLC
	ADC.b $26
	STA.b $26
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	SEC
	SBC.w $099D
	PHA
	CLC
	ADC.b $24
	STA.b $24
	PLA
	CLC
	ADC.b $28
	STA.b $28
	LDA.b $22
	PHA
	LDA.b $26
	PHA
	LDA.b $24
	PHA
	LDA.b $28
	PHA
	JSR.w CODE_009F87
	LDA.b $07,S
	CLC
	ADC.b $05,S
	LSR
	STA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w $099B
	LDA.b $03,S
	CLC
	ADC.b $01,S
	LSR
	STA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.w $099D
	PLA
	PLA
	PLA
	PLA
	JMP.w CODE_00ADFB

CODE_009F50:
	LDA.w $19C0
	BEQ.b CODE_009F60
	LDA.w $19B6
	STA.b $22
	LDA.w $19BA
	INC
	STA.b $24
CODE_009F60:
	JSR.w CODE_008B03
	LDA.w #$0028
	JSL.l CODE_01D368
	LDA.w #$0004
	STA.w $053B
	STZ.w $053D
	LDA.w #$0003
	STA.w $053F
	INC.w $09A7
	JSL.l CODE_01D810
	STZ.w $053B
	STZ.w $09A7
	RTS

;--------------------------------------------------------------------

CODE_009F87:
	LDA.w $19B6
	CMP.b $09,S
	BMI.b CODE_009F90
	STA.b $09,S
CODE_009F90:
	CMP.b $07,S
	BMI.b CODE_009F96
	STA.b $07,S
CODE_009F96:
	LDA.w $19B8
	CMP.b $09,S
	BPL.b CODE_009F9F
	STA.b $09,S
CODE_009F9F:
	CMP.b $07,S
	BPL.b CODE_009FA5
	STA.b $07,S
CODE_009FA5:
	LDA.w $19BA
	CMP.b $05,S
	BMI.b CODE_009FAE
	STA.b $05,S
CODE_009FAE:
	CMP.b $03,S
	BMI.b CODE_009FB4
	STA.b $03,S
CODE_009FB4:
	LDA.w $19BC
	CMP.b $05,S
	BPL.b CODE_009FBD
	STA.b $05,S
CODE_009FBD:
	CMP.b $03,S
	BPL.b CODE_009FC3
	STA.b $03,S
CODE_009FC3:
	RTS

;--------------------------------------------------------------------

CODE_009FC4:
	PHD
	TSC
	TCD
	LDA.w #$0001
	STA.w $0589
	LDA.w $00AA
	CMP.w $058F
	BEQ.b CODE_00A04A
	CMP.w #$0000
	BNE.b CODE_009FE4
	LDA.w $058F
	CMP.w #$0001
	BEQ.b CODE_00A035
	BRA.b CODE_00A04A

CODE_009FE4:
	CMP.w #$0007
	BNE.b CODE_009FF0
	LDA.w $058F
	BEQ.b CODE_00A04A
	BRA.b CODE_00A035

CODE_009FF0:
	CMP.w #$0002
	BNE.b CODE_009FFF
	LDA.w $058F
	CMP.w #$0007
	BEQ.b CODE_00A02D
	BRA.b CODE_00A01B

CODE_009FFF:
	CMP.w #$0003
	BNE.b CODE_00A00E
	LDA.w $058F
	CMP.w #$0001
	BEQ.b CODE_00A01B
	BRA.b CODE_00A02D

CODE_00A00E:
	CMP.w #$0004
	BNE.b CODE_00A02D
	LDA.w $058F
	CMP.w #$0003
	BEQ.b CODE_00A02D
CODE_00A01B:
	LDA.w #$FFFF
	STA.w $058D
	LDA.w #$0010
CODE_00A024:
	PHA
	JSL.l CODE_01E2CE
	PLA
	DEC
	BNE.b CODE_00A024
CODE_00A02D:
	LDA.w #$0001
	STA.w $058D
	BRA.b CODE_00A04A

CODE_00A035:
	LDA.w #$FFFF
	STA.w $058D
	LDA.w #$0010
CODE_00A03E:
	PHA
	JSL.l CODE_01E2CE
	PLA
	DEC
	BNE.b CODE_00A03E
	STZ.w $058D
CODE_00A04A:
	LDA.w $00AA
	STA.w $058F
	LDA.b $05
	ASL
	STA.b $05
	LDA.b $07
	JSR.w CODE_00A25B
	LDA.b $07
	JSR.w CODE_00A22D
	LDA.b $05
	BEQ.b CODE_00A07A
	LDA.b $07
	ASL
	TAX
	LDA.w DATA_00A0EB,x
	PHA
	LDX.w #$0000
CODE_00A06E:
	LDA.b $09,x
	JSR.w CODE_00A0B3
	INX
	INX
	CPX.b $05
	BNE.b CODE_00A06E
	PLA
CODE_00A07A:
	LDA.b $07
	JSR.w CODE_00A2CC
	STZ.w $016C
	LDA.b $07
	STA.w $09A9
	TSC
	CLC
	ADC.b $05
	CLC
	ADC.w #$0008
	PLD
	PLY
	TCS
	PHY
	STZ.w $0589
	RTS

;--------------------------------------------------------------------

CODE_00A097:
	PLA
	STA.w $0992
	SEP.b #$20
	PLA
	STA.w $0994
	REP.b #$20
	JSR.w CODE_009FC4
	SEP.b #$20
	LDA.w $0994
	PHA
	REP.b #$20
	LDA.w $0992
	PHA
	RTL

;--------------------------------------------------------------------

CODE_00A0B3:
	PHX
	ASL
	ASL
	TAY
	LDA.b ($05,S),y
	TAX
	INY
	INY
	LDA.b ($05,S),y
	PHA
	STA.l $7E2640,x
	CLC
	ADC.w #$0010
	STA.l $7E2680,x
	CLC
	ADC.w #$0010
	STA.l $7E26C0,x
	PLA
	INC
	STA.l $7E2642,x
	CLC
	ADC.w #$0010
	STA.l $7E2682,x
	CLC
	ADC.w #$0010
	STA.l $7E26C2,x
	PLX
	RTS

DATA_00A0EB:
	dw DATA_00A10D,DATA_00A135,DATA_00A169,DATA_00A169,DATA_00A18D,DATA_00A19D,DATA_00A19D,DATA_00A1A1
	dw DATA_00A1A5,DATA_00A1D1,DATA_00A1D5,DATA_00A1D9,DATA_00A1F5,DATA_00A1F5,DATA_00A1F5,DATA_00A1F5
	dw DATA_00A219

DATA_00A10D:
	dw $000A,$2578,$000E,$257A,$0012,$257C,$0016,$257E
	dw $001A,$25A0,$0026,$25A2,$002A,$35A4,$002E,$25A6
	dw $0034,$25A8,$003A,$25AA

DATA_00A135:
	dw $0008,$2578,$000C,$257A,$0010,$257C,$0014,$257E
	dw $0018,$25A0,$001C,$25A2,$0020,$25A4,$0024,$25A6
	dw $0028,$25A8,$002C,$25AA,$0030,$25AC,$0034,$25AE
	dw $0038,$24DE

DATA_00A169:
	dw $000E,$2574,$0012,$2576,$0016,$2578,$001A,$257A
	dw $001E,$257C,$002A,$257E,$002E,$25A0,$0034,$25A2
	dw $003A,$25A4

DATA_00A18D:
	dw $0016,$254C,$001C,$254E,$0034,$2570,$003A,$2572

DATA_00A19D:
	dw $0010,$2544

DATA_00A1A1:
	dw $003A,$2574

DATA_00A1A5:
	dw $0008,$2572,$000C,$2574,$001A,$2576,$001E,$25A6
	dw $0022,$2578,$0026,$257A,$002A,$257C,$0030,$257E
	dw $0034,$25A0,$0038,$25A2,$0014,$25A8

DATA_00A1D1:
	dw $0036,$2542

DATA_00A1D5:
	dw $0036,$2542

DATA_00A1D9:
	dw $000A,$254C,$0014,$2572,$0018,$2574,$0022,$2578
	dw $0028,$257A,$002E,$257E,$0036,$2576

DATA_00A1F5:
	dw $000A,$2570,$000E,$2572,$0012,$2574,$0016,$2576
	dw $001A,$2578,$001E,$257A,$0022,$257C,$0026,$257E
	dw $0036,$25A2

DATA_00A219:
	dw $000A,$2548,$0010,$254A,$0016,$254C,$001C,$254E
	dw $0036,$2572

;--------------------------------------------------------------------

CODE_00A22D:
	PHB
	PHP
	PHA
	ASL
	CLC
	ADC.b $01,S
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w #$00BE
	TAX
	PLA
	SEP.b #$20
	LDA.b #$7E2640>>16
	PHA
	PLB
	REP.b #$20
	LDY.w #$00BE
CODE_00A24B:
	LDA.l DATA_029600,x
	STA.w $7E2640,y
	DEX
	DEX
	DEY
	DEY
	BPL.b CODE_00A24B
	PLP
	PLB
	RTS

;--------------------------------------------------------------------

CODE_00A25B:
	PHB
	PHP
	ASL
	TAX
	LDA.l DATA_01DB31,x
	TAX
	SEP.b #$20
	LDA.b #$7F8000>>16
	PHA
	PLB
	REP.b #$20
	LDY.w #$0000
	LDA.w #$0000
CODE_00A272:
	PHA
	PHX
	LDA.l DATA_01DB53,x
	BMI.b CODE_00A2C7
	CMP.w #$5400
	BEQ.b CODE_00A284
	CMP.w #$5A00
	BNE.b CODE_00A295
CODE_00A284:
	PHA
	LDA.l $0000AA
	TAX
	PLA
	CPX.w #$000F
	BEQ.b CODE_00A295
	CLC
	ADC.l $000999
CODE_00A295:
	TAX
CODE_00A296:
	LDA.l DATA_038000,x
	STA.w $7F8000,y
	LDA.l DATA_038000+$0200,x
	STA.w $7F8000+$0200,y
	LDA.l DATA_038000+$0400,x
	STA.w $7F8000+$0400,y
	INX
	INX
	INY
	INY
	TYA
	BIT.w #$003F
	BNE.b CODE_00A296
	PLX
	INX
	INX
	PLA
	INC
	BIT.w #$0007
	BNE.b CODE_00A272
	TYA
	CLC
	ADC.w #$0400
	TAY
	BRA.b CODE_00A272

CODE_00A2C7:
	PLX
	PLA
	PLP
	PLB
	RTS

;--------------------------------------------------------------------

CODE_00A2CC:
	PHP
	SEP.b #$30
	PHA
	STZ.w $0202
	LDA.w $0204
	BEQ.b CODE_00A2DC
	JSL.l CODE_01E2CE
CODE_00A2DC:
	PLA
	CMP.w $09A9
	BEQ.b CODE_00A305
	CMP.b #$01
	BNE.b CODE_00A2F8
	LDX.b #$36
CODE_00A2E8:
	LDA.w DATA_00A32C,x
	STA.w $0182,x
	DEX
	BPL.b CODE_00A2E8
	INC.w $0202
	JSL.l CODE_01E2CE
CODE_00A2F8:
	LDX.b #$12
CODE_00A2FA:
	LDA.w DATA_00A319,x
	STA.w $0182,x
	DEX
	BPL.b CODE_00A2FA
	BRA.b CODE_00A310

CODE_00A305:
	LDX.b #$09
CODE_00A307:
	LDA.w DATA_00A322,x
	STA.w $0182,x
	DEX
	BPL.b CODE_00A307
CODE_00A310:
	INC.w $0202
	JSL.l CODE_01E2CE
	PLP
	RTS

DATA_00A319:
	db $02 : dl $7F8000 : dw $1200,$0080 : db $74

DATA_00A322:
	db $02 : dl $7E2640 : dw $00C0,$2080,$0033

DATA_00A32C:
	db $02 : dl DATA_038000+$4380 : dw $0040,$C080 : db $6D
	db $02 : dl DATA_038000+$4580 : dw $0040,$C080 : db $6E
	db $02 : dl DATA_038000+$4780 : dw $0040,$C080 : db $6F
	db $02 : dl DATA_038000+$1F00 : dw $0040,$E080 : db $6D
	db $02 : dl DATA_038000+$2100 : dw $0040,$E080 : db $6E
	db $02 : dl DATA_038000+$2300 : dw $0040,$E080,$006F

;--------------------------------------------------------------------

; Note: Routine that handles the top status bar display.

CODE_00A363:
	PHP
	STZ.w $0202
	LDX.w $0204
	PHX
	LDY.w #$0000
CODE_00A36E:
	LDA.w DATA_00A443,y
	STA.w $0182,x
	INX
	INX
	INY
	INY
	CPY.w #$000A
	BNE.b CODE_00A36E
	PLX
	LDA.w $09AB
	BEQ.b CODE_00A386
	JMP.w CODE_00A420

CODE_00A386:
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
	BNE.b CODE_00A3EA
	LDA.w $0EBE
	AND.w #$00F0
	LDY.w $0EB8
	BMI.b CODE_00A3A2
	BNE.b CODE_00A3F2
	LDA.w $09D6
	CMP.w #$001E
	BEQ.b CODE_00A3D9
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
CODE_00A3A2:
	CMP.w #$00F0
	BEQ.b CODE_00A3B7
	CMP.w #$0100
	BEQ.b CODE_00A3C8
	LSR
	XBA
	CLC
	ADC.w #DATA_058000
	STA.w $0183,x
	BRA.b CODE_00A40E

CODE_00A3B7:
	LDA.w #!RAM_MPAINT_Global_CustomStampDisplayGFXBuffer
	STA.w $0183,x
	SEP.b #$20
	LDA.b #!RAM_MPAINT_Global_CustomStampDisplayGFXBuffer>>16
	STA.w $0185,x
	REP.b #$20
	BRA.b CODE_00A40E

CODE_00A3C8:
	LDA.w #DATA_078000+$6800				; Note: Special Stamps palette HUD
	STA.w $0183,x
	SEP.b #$20
	LDA.b #(DATA_078000+$6800)>>16
	STA.w $0185,x
	REP.b #$20
	BRA.b CODE_00A40E

CODE_00A3D9:
	LDA.w #DATA_078000+$7000				; Note: Music Tool instrument HUD
	STA.w $0183,x
	SEP.b #$20
	LDA.b #(DATA_078000+$7000)>>16
	STA.w $0185,x
	REP.b #$20
	BRA.b CODE_00A40E

CODE_00A3EA:
	LDA.w #DATA_058000+$3000
	STA.w $0183,x
	BRA.b CODE_00A40E

CODE_00A3F2:
	LDA.w $0EBC
	AND.w #$00F0
	XBA
	LSR
	CLC
	ADC.w #DATA_068000
	STA.w $0183,x
	SEP.b #$20
	LDA.w $0EBA
	CLC
	ADC.b #DATA_068000>>16
	STA.w $0185,x
	REP.b #$20
CODE_00A40E:
	TXA
	CLC
	ADC.w #$0009
	STA.w $0204
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
	BNE.b CODE_00A437
	JSR.w CODE_00E64F
	PLP
	RTS

CODE_00A420:
	LDA.w #DATA_078000+$7800					; Note: Blank HUD
	STA.w $0183,x
	SEP.b #$20
	LDA.b #(DATA_078000+$7800)>>16
	STA.w $0185,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0009
	STA.w $0204
CODE_00A437:
	STZ.w $09AB
	INC.w $0202
	JSL.l CODE_01E2CE
	PLP
	RTS

DATA_00A443:
	db $02 : dl DATA_058000 : dw $0800,$0080,$0070

;--------------------------------------------------------------------

CODE_00A44D:
	JSR.w CODE_00A451
	RTL

CODE_00A451:
	LDA.w $0EB8
	BNE.b CODE_00A468
	STZ.w $0202
	LDX.w #$007E
CODE_00A45C:
	LDA.w $1C2A,x
	STA.w $0EC4,x
	DEX
	DEX
	BPL.b CODE_00A45C
	BRA.b CODE_00A478

CODE_00A468:
	LDX.w #$007E
CODE_00A46B:
	LDA.w $1CAA,x
	AND.w $1C2A,x
	STA.w $0EC4,x
	DEX
	DEX
	BPL.b CODE_00A46B
CODE_00A478:
	LDX.w $0204
	LDY.w #$0000
CODE_00A47E:
	LDA.w DATA_00A49A,y
	STA.w $0182,x
	INX
	INX
	INY
	INY
	CPY.w #$0014
	BNE.b CODE_00A47E
	DEX
	DEX
	STX.w $0204
	INC.w $0202
	JSL.l CODE_01E2CE
	RTS

DATA_00A49A:
	db $02 : dl $000EC4 : dw $0040,$C080 : db $46
	db $02 : dl $000F04 : dw $0040,$C080,$0047

;--------------------------------------------------------------------

CODE_00A4AD:
	JSR.w CODE_00A451
	JSR.w CODE_00A525
	RTL

;--------------------------------------------------------------------

CODE_00A4B4:
	LDA.w #$0007
	JSL.l CODE_01D368
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0007
	BEQ.b CODE_00A508
	CMP.w #$0006
	BEQ.b CODE_00A4D1
	LDA.w $04D0
	STA.w $1B10
CODE_00A4D1:
	LDA.w #$0001
	STA.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$000F
	JSR.w CODE_00B66C
	LDA.w !RAM_MPAINT_Canvas_EraseToolSize
	CLC
	ADC.w #$0008
	JSR.w CODE_00B6F4
	LDA.w #$0007
	STA.w $04D0
	JSR.w CODE_00A525
	STZ.b $AE
	LDA.w #$0007
	LDX.b $AA
	BEQ.b CODE_00A4FC
	LDA.w #$0006
CODE_00A4FC:
	PHA
	PHX
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	JMP.w CODE_00A363

CODE_00A508:
	RTS

;--------------------------------------------------------------------

CODE_00A509:
	LDA.b $A8
	CMP.w #$0006
	BCS.b CODE_00A524
	STA.w !RAM_MPAINT_Canvas_EraseToolSize
	CLC
	ADC.w #$0008
	JSR.w CODE_00B6F4
	JSR.w CODE_00A525
	LDA.w #$0004
	JSL.l CODE_01D368
CODE_00A524:
	RTS

;--------------------------------------------------------------------

CODE_00A525:
	LDA.w !RAM_MPAINT_Canvas_EraseToolSize
	AND.w #$FFF8
	ASL
	PHA
	LDA.w !RAM_MPAINT_Canvas_EraseToolSize
	AND.w #$0007
	CLC
	ADC.b $01,S
	XBA
	LSR
	LSR
	CLC
	ADC.w #$B000
	STA.b $01,S
	LDA.w #$000A
	PHA
	LDA.w #$46E0
	PHA
	LDA.w #$0002
	PHA
	LDA.w #$0002
	PHA
	JSL.l CODE_01E3AC
	INC.w $0202
	JSL.l CODE_01E2CE
	RTS

;--------------------------------------------------------------------

CODE_00A55B:
	PHP
	INC.w $09A7
	LDA.w #$0011
	JSL.l CODE_01D2BF
CODE_00A566:
	LDA.w $053A
	AND.w #$00FF
	BNE.b CODE_00A566
	JSR.w CODE_008B03
	LDX.w #$0000
CODE_00A574:
	PHX
	LDA.w DATA_00A5F3,x
	AND.w #$00FF
	CLC
	ADC.b $0A
	STA.b $0D
	LDX.w #$0000
CODE_00A583:
	SEP.b #$20
	LDA.w DATA_00A5F7,x
	STA.w $1944
	LDA.w DATA_00A5FF,x
	STA.w $1945
	LDA.w DATA_00A607,x
	STA.w $1946
	LDA.w DATA_00A60F,x
	STA.w $1947
	LDY.w #$0000
CODE_00A5A0:
	SEP.b #$20
	LDA.b [$0D],y
	AND.w $1944
	STA.b [$0D],y
	INY
	INY
	LDA.b [$0D],y
	AND.w $1945
	STA.b [$0D],y
	INY
	INY
	LDA.b [$0D],y
	AND.w $1946
	STA.b [$0D],y
	INY
	INY
	LDA.b [$0D],y
	AND.w $1947
	STA.b [$0D],y
	INY
	INY
	REP.b #$20
	TYA
	BIT.w #$000F
	BNE.b CODE_00A5D2
	CLC
	ADC.w #$0010
CODE_00A5D2:
	TAY
	CPY.w #$6000
	BCC.b CODE_00A5A0
	PHX
	JSL.l CODE_01E2CE
	PLX
	INX
	CPX.w #$0008
	BNE.b CODE_00A583
	PLX
	INX
	CPX.w #$0004
	BNE.b CODE_00A574
	JSR.w CODE_00AAC7
	STZ.w $09A7
	PLP
	RTS

DATA_00A5F3:
	db $11,$00,$01,$10

DATA_00A5F7:
	db $FE,$FC,$F8,$F0,$E0,$C0,$80,$00

DATA_00A5FF:
	db $FB,$F3,$E3,$C3,$83,$03,$02,$00

DATA_00A607:
	db $EF,$CF,$8F,$0F,$0E,$0C,$08,$00

DATA_00A60F:
	db $BF,$3F,$3E,$3C,$38,$30,$20,$00

;--------------------------------------------------------------------

CODE_00A617:
	INC.w $09A7
	LDA.w #$0012
	JSL.l CODE_01D2BF
CODE_00A621:
	LDA.w $053A
	AND.w #$00FF
	BNE.b CODE_00A621
	JSR.w CODE_008B03
	JSL.l CODE_01CFD5
	JSR.w CODE_00AAC7
	STZ.w $09A7
	RTS

;--------------------------------------------------------------------

CODE_00A637:
	PHP
	PHB
	INC.w $09A7
	LDA.w #$0013
	JSL.l CODE_01D2BF
CODE_00A643:
	LDA.w $053A
	AND.w #$00FF
	BNE.b CODE_00A643
	JSR.w CODE_008B03
	SEP.b #$20
	LDA.b #$7E2800>>16
	PHA
	PLB
	REP.b #$20
	LDA.w #$0200
CODE_00A659:
	PHA
	LSR
	LSR
	LSR
	LSR
	EOR.w #$FFFF
	CLC
	ADC.w #$0022
CODE_00A665:
	PHA
	JSL.l CODE_01E20C
	AND.w #$003E
	PHA
	JSL.l CODE_01E20C
	AND.w #$00F8
	ASL
	ASL
	ASL
	CLC
	ADC.b $01,S
	TAX
	PLA
	JSL.l CODE_01E20C
	AND.w #$003E
	PHA
	JSL.l CODE_01E20C
	AND.w #$00F8
	ASL
	ASL
	ASL
	CLC
	ADC.b $01,S
	TAY
	PLA
	CPX.w #$00C0
	BCC.b CODE_00A6BA
	CPX.w #$0640
	BCS.b CODE_00A6BA
	CPY.w #$00C0
	BCC.b CODE_00A6C2
	CPY.w #$0640
	BCS.b CODE_00A6C2
	LDA.l $7E2800,x
	PHA
	LDA.w $7E2800,y
	STA.l $7E2800,x
	PLA
	STA.w $2800,y
	BRA.b CODE_00A6C9

CODE_00A6BA:
	LDA.w #$1FFF
	STA.w $7E2800,y
	BRA.b CODE_00A6C9

CODE_00A6C2:
	LDA.w #$1FFF
	STA.l $7E2800,x
CODE_00A6C9:
	PLA
	DEC
	BNE.b CODE_00A665
	JSL.l CODE_01DEB2
	JSL.l CODE_01E2CE
	PLA
	DEC
	BNE.b CODE_00A659
	SEP.b #$20
	JSR.w CODE_00A982
	REP.b #$20
	LDA.w #$3FFF
	JSL.l CODE_01E033
	JSR.w CODE_008A16
	JSL.l CODE_01E2CE
	JSR.w CODE_00AAC7
	STZ.w $09A7
	PLB
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00A6F7:
	INC.w $09A7
	LDA.w #$0014
	JSL.l CODE_01D2BF
CODE_00A701:
	LDA.w $053A
	AND.w #$00FF
	BNE.b CODE_00A701
	JSR.w CODE_008B03
	LDA.b $0A
	CLC
	ADC.w #$0010
	STA.b $0D
	LDX.w #$01FE
	LDA.w #$0018
CODE_00A71A:
	STA.l $7F0000,x
	DEX
	DEX
	BPL.b CODE_00A71A
	LDA.w #$0001
	STA.l $7F0200
CODE_00A729:
	LDA.w #$7000
CODE_00A72C:
	PHA
	JSL.l CODE_01E20C
	AND.w #$00FE
	CLC
	ADC.l $7F0200
	STA.b $80
	ASL
	TAX
	LDA.l $7F0000,x
	STA.b $82
	INC
	CMP.w #$00C8
	BEQ.b CODE_00A74D
	STA.l $7F0000,x
CODE_00A74D:
	JSR.w CODE_00B305
	TXA
	AND.w #$000E
	TAX
	LDY.b $84
	LDA.b [$0A],y
	AND.w DATA_00A782,x
	STA.b [$0A],y
	LDA.b [$0D],y
	AND.w DATA_00A782,x
	STA.b [$0D],y
	PLA
	DEC
	BNE.b CODE_00A72C
	LDA.l $7F0200
	DEC
	STA.l $7F0200
	BPL.b CODE_00A729
	SEP.b #$20
	JSR.w CODE_00A982
	REP.b #$20
	JSR.w CODE_00AAC7
	STZ.w $09A7
	RTS

DATA_00A782:
	dw $7F7F,$BFBF,$DFDF,$EFEF,$F7F7,$FBFB,$FDFD,$FEFE

;--------------------------------------------------------------------

CODE_00A792:
	PHP
	INC.w $09A7
	LDA.w #$0015
	JSL.l CODE_01D2BF
CODE_00A79D:
	LDA.w $053A
	AND.w #$00FF
	BNE.b CODE_00A79D
	JSR.w CODE_008B03
	LDA.w #$3FFF
	JSL.l CODE_01E042
	JSL.l CODE_01DECD
	JSL.l CODE_01E2CE
	LDX.w #$007E
	LDA.w #$0000
CODE_00A7BD:
	STA.l $7E3000,x
	DEX
	DEX
	BPL.b CODE_00A7BD
	SEP.b #$20
	LDA.b #$0A
	STA.w $0108
	LDA.b #$35
	STA.w $010B
	LDA.b #$3C
	STA.w $010C
	REP.b #$20
	STZ.w $0178
	STZ.w $0176
	JSL.l CODE_00A87E
	JSL.l CODE_01E2CE
	LDA.w #$0000
	STA.l $7F0202
	STA.l $7F0204
	LDA.w #$0000
CODE_00A7F4:
	PHA
	LDX.w #$003C
CODE_00A7F8:
	LDA.l $7F0202
	AND.w #$03FF
	ORA.w #$4000
	STA.l $7E3000,x
	LDA.l $7F0204
	AND.w #$03FF
	ORA.w #$4000
	STA.l $7E3002,x
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_00A7F8
	JSL.l CODE_00A87E
	JSL.l CODE_01E2CE
	LDA.l $7F0202
	DEC
	STA.l $7F0202
	LDA.l $7F0204
	INC
	STA.l $7F0204
	PLA
	INC
	BIT.w #$003F
	BNE.b CODE_00A83E
	INC.w $0172
CODE_00A83E:
	CMP.w #$0100
	BEQ.b CODE_00A846
	JMP.w CODE_00A7F4

CODE_00A846:
	SEP.b #$20
	JSR.w CODE_00A982
	LDA.b #$09
	STA.w $0108
	LDA.b #$34
	STA.w $010B
	LDA.b #$38
	STA.w $010C
	REP.b #$20
	STZ.w $0172
	JSR.w CODE_008A39
	JSL.l CODE_01E2CE
	JSR.w CODE_00AAC7
	STZ.w $09A7
	PLP
	RTS

;--------------------------------------------------------------------

DATA_00A86E:
	dw $7F7F,$BFBF,$DFDF,$EFEF,$F7F7,$FBFB,$FDFD,$FEFE

;--------------------------------------------------------------------

CODE_00A87E:
	STZ.w $0202
	LDX.w $0204
	LDY.w #$0000
CODE_00A887:
	LDA.w DATA_00A89E,y
	STA.w $0182,x
	INX
	INX
	INY
	INY
	CPY.w #$000A
	BNE.b CODE_00A887
	DEX
	STX.w $0204
	INC.w $0202
	RTL

DATA_00A89E:
	db $02 : dl $7E3000 : dw $0080,$0080,$003C

;--------------------------------------------------------------------

CODE_00A8A8:
	PHP
	INC.w $09A7
	LDA.w #$0016
	JSL.l CODE_01D2BF
CODE_00A8B3:
	LDA.w $053A
	AND.w #$00FF
	BNE.b CODE_00A8B3
	JSR.w CODE_008B03
	SEP.b #$20
	LDA.b #$00
CODE_00A8C2:
	PHA
	PHA
	ASL
	ASL
	AND.b #$F0
	ORA.b #$02
	STA.w $0109
	PLA
	LSR
	LSR
	LSR
	AND.b #$0F
	STA.w $0172
	STZ.w $0173
	JSL.l CODE_01E2CE
	PLA
	INC
	CMP.b #$40
	BNE.b CODE_00A8C2
	JSR.w CODE_00A982
	LDA.b #$00
	STA.w $0109
	STZ.w $0172
	STZ.w $0173
	JSL.l CODE_01E2CE
	REP.b #$20
	JSR.w CODE_00AAC7
	STZ.w $09A7
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00A8FF:
	PHP
	INC.w $09A7
	LDA.w #$0017
	JSL.l CODE_01D2BF
CODE_00A90A:
	LDA.w $053A
	AND.w #$00FF
	BNE.b CODE_00A90A
	JSR.w CODE_008B03
	SEP.b #$20
	LDA.b #$00
	STA.w $011E
	LDA.b #$02
	STA.w $011F
	LDA.b #$E0
	STA.w $0120
	JSL.l CODE_01E2CE
	LDA.b #$00
CODE_00A92C:
	PHA
	LSR
	ORA.b #$E0
	STA.w $0120
	JSL.l CODE_01E2CE
	PLA
	INC
	CMP.b #$40
	BNE.b CODE_00A92C
	JSR.w CODE_00A982
	LDA.b #$30
	STA.w $011E
	LDA.b #$00
	STA.w $011F
	LDA.b #$E0
	STA.w $0120
	JSL.l CODE_01E2CE
	REP.b #$20
	JSR.w CODE_00AAC7
	STZ.w $09A7
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00A95D:
	PHP
	INC.w $09A7
	LDA.w #$0018
	JSL.l CODE_01D2BF
CODE_00A968:
	LDA.w $053A
	AND.w #$00FF
	BNE.b CODE_00A968
	JSR.w CODE_008B03
	SEP.b #$20
	JSR.w CODE_00A982
	REP.b #$20
	JSR.w CODE_00AAC7
	STZ.w $09A7
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00A982:
	PHP
	LDA.b #$11
	STA.w $011A
	JSL.l CODE_01E2CE
	REP.b #$20
	LDA.w #$0000
	LDY.w #$5FFE
CODE_00A994:
	STA.b [$0A],y
	DEY
	DEY
	BPL.b CODE_00A994
	JSL.l CODE_01E2CE
	JSL.l CODE_01E2CE
	JSL.l CODE_01E2CE
	JSL.l CODE_01E2CE
	JSL.l CODE_01E2CE
	JSL.l CODE_01E2CE
	LDA.w #$0013
	STA.w $011A
	JSL.l CODE_01E2CE
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00A9BE:
	PHP
	INC.w $09A7
	LDA.w #$0019
	JSL.l CODE_01D2BF
CODE_00A9C9:
	LDA.w $053A
	AND.w #$00FF
	BNE.b CODE_00A9C9
	JSR.w CODE_008B03
	LDY.w #$0010
CODE_00A9D7:
	PHY
	JSL.l CODE_01E2CE
	PLY
	DEY
	BNE.b CODE_00A9D7
	STZ.w $1B24
	STZ.w $0206
	LDA.w $19FA
	BEQ.b CODE_00A9EF
	LDA.w $19C2
	INC
CODE_00A9EF:
	ASL
	ASL
	TAX
	LDA.w MPAINT_Global_UpperOAMBuffer[$00].Slot
	AND.w #$0003
	ORA.w DATA_00AAB7,x
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot
	LDA.w MPAINT_Global_UpperOAMBuffer[$02].Slot
	AND.w #$FFC0
	ORA.w DATA_00AAB7+$02,x
	STA.w MPAINT_Global_UpperOAMBuffer[$02].Slot
	SEP.b #$30
	LDX.b #$00
	LDY.b #$00
CODE_00AA10:
	LDA.w DATA_00AAAD,x
	STA.w MPAINT_Global_OAMBuffer[$01].XDisp,y
	LDA.w DATA_00AAAD+$01,x
	STA.w MPAINT_Global_OAMBuffer[$02].XDisp,y
	TYA
	CLC
	ADC.b #$08
	TAY
	INX
	INX
	CPX.b #$0A
	BNE.b CODE_00AA10
	LDY.b #$C8
CODE_00AA29:
	PHY
	TYA
	STA.w MPAINT_Global_OAMBuffer[$01].YDisp
	STA.w MPAINT_Global_OAMBuffer[$03].YDisp
	STA.w MPAINT_Global_OAMBuffer[$05].YDisp
	STA.w MPAINT_Global_OAMBuffer[$07].YDisp
	STA.w MPAINT_Global_OAMBuffer[$09].YDisp
	CLC
	ADC.b #$10
	STA.w MPAINT_Global_OAMBuffer[$02].YDisp
	STA.w MPAINT_Global_OAMBuffer[$04].YDisp
	STA.w MPAINT_Global_OAMBuffer[$06].YDisp
	STA.w MPAINT_Global_OAMBuffer[$08].YDisp
	STA.w MPAINT_Global_OAMBuffer[$0A].YDisp
	INC.w $1B24
	LDA.w $1B24
	CMP.b #$06
	BNE.b CODE_00AA5B
	LDA.b #$00
	STA.w $1B24
CODE_00AA5B:
	AND.b #$FE
	ASL
	TAX
	REP.b #$20
	LDA.w DATA_00AAA1,x
	STA.w MPAINT_Global_OAMBuffer[$01].Tile
	STA.w MPAINT_Global_OAMBuffer[$03].Tile
	STA.w MPAINT_Global_OAMBuffer[$05].Tile
	STA.w MPAINT_Global_OAMBuffer[$07].Tile
	STA.w MPAINT_Global_OAMBuffer[$09].Tile
	LDA.w DATA_00AAA1+$02,x
	STA.w MPAINT_Global_OAMBuffer[$02].Tile
	STA.w MPAINT_Global_OAMBuffer[$04].Tile
	STA.w MPAINT_Global_OAMBuffer[$06].Tile
	STA.w MPAINT_Global_OAMBuffer[$08].Tile
	STA.w MPAINT_Global_OAMBuffer[$0A].Tile
	SEP.b #$20
	CPY.b #$B7
	BCS.b CODE_00AA90
	TYX
	INX
	JSR.w CODE_008A8E
CODE_00AA90:
	PLY
	DEY
	CPY.b #$07
	BNE.b CODE_00AA29
	INC.w $0206
	JSR.w CODE_00AAC7
	STZ.w $09A7
	PLP
	RTS

DATA_00AAA1:
	dw $2420,$241F,$2520,$242F,$2522,$243F

DATA_00AAAD:
	db $28,$2B,$38,$3B,$78,$7B,$B8,$BB
	db $C8,$CB

DATA_00AAB7:
	dw $4954,$0015,$9494,$0014,$4948,$0009,$4948,$0009

;--------------------------------------------------------------------

CODE_00AAC7:
	PHP
	REP.b #$20
	LDA.w #$007B
	JSL.l CODE_01D368
	LDA.w #$0010
CODE_00AAD4:
	PHA
	JSL.l CODE_01E2CE
	PLA
	DEC
	BNE.b CODE_00AAD4
	LDA.w $1012
	BEQ.b CODE_00AAE6
	INC
	INC
	BRA.b CODE_00AAE9

CODE_00AAE6:
	LDA.w #$001D
CODE_00AAE9:
	JSL.l CODE_01D308
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00AAEF:
	LDA.b $22
	STA.b $86
	LDA.b $24
	STA.b $88
	JSR.w CODE_00B051
	RTS

;--------------------------------------------------------------------

CODE_00AAFB:
	LDA.b $20
	BNE.b CODE_00AB0F
	SEP.b #$20
	LDA.b #$00
	STA.w $1B21
	DEC
	STA.w $1B1F
	STA.w $1B20
	REP.b #$20
CODE_00AB0F:
	LDA.b $22
	STA.b $3E
	LDA.b $24
	STA.b $40
	LDA.b $26
	STA.b $42
	LDA.b $28
	STA.b $44
	JSR.w CODE_00AF5A
	STZ.w $1B1F
	RTS

;--------------------------------------------------------------------

CODE_00AB26:
	LDA.b $20
	BNE.b CODE_00AB3A
	SEP.b #$20
	LDA.b #$00
	STA.w $1B21
	DEC
	STA.w $1B1F
	STA.w $1B20
	REP.b #$20
CODE_00AB3A:
	LDA.b $22
	STA.b $3E
	LDA.b $24
	STA.b $40
	LDA.b $26
	STA.b $42
	LDA.b $24
	STA.b $44
	JSR.w CODE_00AF5A
	LDA.b $26
	STA.b $3E
	LDA.b $24
	STA.b $40
	LDA.b $26
	STA.b $42
	LDA.b $28
	STA.b $44
	JSR.w CODE_00AF5A
	LDA.b $26
	STA.b $3E
	LDA.b $28
	STA.b $40
	LDA.b $22
	STA.b $42
	LDA.b $28
	STA.b $44
	JSR.w CODE_00AF5A
	LDA.b $22
	STA.b $3E
	LDA.b $28
	STA.b $40
	LDA.b $22
	STA.b $42
	LDA.b $24
	STA.b $44
	JSR.w CODE_00AF5A
	STZ.w $1B1F
	RTS

;--------------------------------------------------------------------

CODE_00AB8A:
	LDA.b $20
	BNE.b CODE_00AB9E
	SEP.b #$20
	LDA.b #$00
	STA.w $1B21
	DEC
	STA.w $1B1F
	STA.w $1B20
	REP.b #$20
CODE_00AB9E:
	LDA.b $22
	STA.b $52
	LDA.b $24
	STA.b $54
	LDA.b $26
	SEC
	SBC.b $52
	BPL.b CODE_00ABB1
	EOR.w #$FFFF
	INC
CODE_00ABB1:
	STA.b $56
	LDA.b $28
	SEC
	SBC.b $54
	BPL.b CODE_00ABBE
	EOR.w #$FFFF
	INC
CODE_00ABBE:
	STA.b $58
	LDA.b $56
	ORA.b $58
	BNE.b CODE_00ABCA
CODE_00ABC6:
	STZ.w $1B1F
	RTS

CODE_00ABCA:
	LDA.b $56
	CMP.b $58
	BCS.b CODE_00ABD3
	JMP.w CODE_00AC57

CODE_00ABD3:
	LDA.b $56
	STA.b $5E
	STA.b $5A
	STZ.b $5C
CODE_00ABDB:
	LDA.b $5A
	CMP.b $5C
	BCS.b CODE_00ABE3
	BRA.b CODE_00ABC6

CODE_00ABE3:
	SEP.b #$20
	LDA.b $5A
	STA.w !REGISTER_Multiplicand
	LDA.b $58
	STA.w !REGISTER_Multiplier
	NOP #4
	LDA.w !REGISTER_ProductOrRemainderLo
	STA.w !REGISTER_DividendLo
	LDA.w !REGISTER_ProductOrRemainderHi
	STA.w !REGISTER_DividendHi
	LDA.b $56
	STA.w !REGISTER_Divisor
	NOP #8
	LDA.w !REGISTER_QuotientLo
	STA.b $68
	LDA.w !REGISTER_QuotientHi
	STA.b $69
	LDA.b $5C
	STA.w !REGISTER_Multiplicand
	LDA.b $58
	STA.w !REGISTER_Multiplier
	NOP #4
	LDA.w !REGISTER_ProductOrRemainderLo
	STA.w !REGISTER_DividendLo
	LDA.w !REGISTER_ProductOrRemainderHi
	STA.w !REGISTER_DividendHi
	LDA.b $56
	STA.w !REGISTER_Divisor
	NOP #8
	LDA.w !REGISTER_QuotientLo
	STA.b $66
	LDA.w !REGISTER_QuotientHi
	STA.b $67
	REP.b #$20
	LDA.b $5A
	STA.b $64
	LDA.b $5C
	STA.b $6A
	JSR.w CODE_00ACDC
	JMP.w CODE_00ABDB

CODE_00AC57:
	LDA.b $58
	STA.b $5E
	STA.b $5A
	STZ.b $5C
CODE_00AC5F:
	LDA.b $5A
	CMP.b $5C
	BCS.b CODE_00AC68
	JMP.w CODE_00ABC6

CODE_00AC68:
	SEP.b #$20
	LDA.b $5A
	STA.w !REGISTER_Multiplicand
	LDA.b $56
	STA.w !REGISTER_Multiplier
	NOP #4
	LDA.w !REGISTER_ProductOrRemainderLo
	STA.w !REGISTER_DividendLo
	LDA.w !REGISTER_ProductOrRemainderHi
	STA.w !REGISTER_DividendHi
	LDA.b $58
	STA.w !REGISTER_Divisor
	NOP #8
	LDA.w !REGISTER_QuotientLo
	STA.b $64
	LDA.w !REGISTER_QuotientHi
	STA.b $65
	LDA.b $5C
	STA.w !REGISTER_Multiplicand
	LDA.b $56
	STA.w !REGISTER_Multiplier
	NOP #4
	LDA.w !REGISTER_ProductOrRemainderLo
	STA.w !REGISTER_DividendLo
	LDA.w !REGISTER_ProductOrRemainderHi
	STA.w !REGISTER_DividendHi
	LDA.b $58
	STA.w !REGISTER_Divisor
	NOP #8
	LDA.w !REGISTER_QuotientLo
	STA.b $6A
	LDA.w !REGISTER_QuotientHi
	STA.b $6B
	REP.b #$20
	LDA.b $5A
	STA.b $68
	LDA.b $5C
	STA.b $66
	JSR.w CODE_00ACDC
	JMP.w CODE_00AC5F

CODE_00ACDC:
	LDA.w $19AE
	SEC
	SBC.w #$0004
	STA.w $19B6
	LDA.w $19B0
	CLC
	ADC.w #$000C
	STA.w $19B8
	LDA.w $19B2
	SEC
	SBC.w #$0008
	STA.w $19BA
	LDA.w $19B4
	CLC
	ADC.w #$0008
	STA.w $19BC
	LDA.b $52
	CLC
	ADC.b $64
	CMP.w $19B8
	BPL.b CODE_00AD1F
	STA.b $86
	LDA.b $54
	CLC
	ADC.b $66
	CMP.w $19BC
	BPL.b CODE_00AD1F
	STA.b $88
	JSR.w CODE_00B051
CODE_00AD1F:
	LDA.b $52
	CLC
	ADC.b $64
	CMP.w $19B8
	BPL.b CODE_00AD3A
	STA.b $86
	LDA.b $54
	SEC
	SBC.b $66
	CMP.w $19BA
	BMI.b CODE_00AD3A
	STA.b $88
	JSR.w CODE_00B051
CODE_00AD3A:
	LDA.b $52
	SEC
	SBC.b $64
	CMP.w $19B6
	BMI.b CODE_00AD55
	STA.b $86
	LDA.b $54
	CLC
	ADC.b $66
	CMP.w $19BC
	BPL.b CODE_00AD55
	STA.b $88
	JSR.w CODE_00B051
CODE_00AD55:
	LDA.b $52
	SEC
	SBC.b $64
	CMP.w $19B6
	BMI.b CODE_00AD70
	STA.b $86
	LDA.b $54
	SEC
	SBC.b $66
	CMP.w $19BA
	BMI.b CODE_00AD70
	STA.b $88
	JSR.w CODE_00B051
CODE_00AD70:
	LDA.b $52
	CLC
	ADC.b $6A
	CMP.w $19B8
	BPL.b CODE_00AD8B
	STA.b $86
	LDA.b $54
	CLC
	ADC.b $68
	CMP.w $19BC
	BPL.b CODE_00AD8B
	STA.b $88
	JSR.w CODE_00B051
CODE_00AD8B:
	LDA.b $52
	CLC
	ADC.b $6A
	CMP.w $19B8
	BPL.b CODE_00ADA6
	STA.b $86
	LDA.b $54
	SEC
	SBC.b $68
	CMP.w $19BA
	BMI.b CODE_00ADA6
	STA.b $88
	JSR.w CODE_00B051
CODE_00ADA6:
	LDA.b $52
	SEC
	SBC.b $6A
	CMP.w $19B6
	BMI.b CODE_00ADC1
	STA.b $86
	LDA.b $54
	CLC
	ADC.b $68
	CMP.w $19BC
	BPL.b CODE_00ADC1
	STA.b $88
	JSR.w CODE_00B051
CODE_00ADC1:
	LDA.b $52
	SEC
	SBC.b $6A
	CMP.w $19B6
	BMI.b CODE_00ADDC
	STA.b $86
	LDA.b $54
	SEC
	SBC.b $68
	CMP.w $19BA
	BMI.b CODE_00ADDC
	STA.b $88
	JSR.w CODE_00B051
CODE_00ADDC:
	LDA.b $5E
	SEC
	SBC.b $5C
	SEC
	SBC.b $5C
	DEC
	STA.b $5E
	INC.b $5C
	CMP.w #$0000
	BPL.b CODE_00ADFA
	DEC.b $5A
	LDA.b $5E
	CLC
	ADC.b $5A
	CLC
	ADC.b $5A
	STA.b $5E
CODE_00ADFA:
	RTS

;--------------------------------------------------------------------

CODE_00ADFB:
	LDA.b $22
	LDX.b $26
	CMP.b $26
	BMI.b CODE_00AE06
	PHA
	TXA
	PLX
CODE_00AE06:
	STA.b $2A
	STX.b $2E
	LDA.b $24
	LDX.b $28
	CMP.b $28
	BMI.b CODE_00AE15
	PHA
	TXA
	PLX
CODE_00AE15:
	STA.b $2C
	STX.b $30
	DEC.b $2C
	DEC.b $30
	LDA.w $19B6
	CMP.b $2A
	BMI.b CODE_00AE26
	STA.b $2A
CODE_00AE26:
	CMP.b $2E
	BMI.b CODE_00AE2C
	STA.b $2E
CODE_00AE2C:
	LDA.w $19B8
	CMP.b $2A
	BPL.b CODE_00AE35
	STA.b $2A
CODE_00AE35:
	CMP.b $2E
	BPL.b CODE_00AE3B
	STA.b $2E
CODE_00AE3B:
	LDA.w $19BA
	CMP.b $2C
	BMI.b CODE_00AE44
	STA.b $2C
CODE_00AE44:
	CMP.b $30
	BMI.b CODE_00AE4A
	STA.b $30
CODE_00AE4A:
	LDA.w $19BC
	CMP.b $2C
	BPL.b CODE_00AE53
	STA.b $2C
CODE_00AE53:
	CMP.b $30
	BPL.b CODE_00AE59
	STA.b $30
CODE_00AE59:
	LDA.b $2E
	SEC
	SBC.b $2A
	INC
	STA.b $32
	LDA.b $30
	SEC
	SBC.b $2C
	INC
	STA.b $34
	LDA.b $2C
	XBA
	STA.b $2C
	LDA.b $30
	XBA
	STA.b $30
	LDA.b $2A
	STA.b $36
	LDA.w #$0008
	STA.b $38
	LDA.w #$A06B
	STA.b $3A
	LDA.w #$206B
	STA.b $3C
	LDX.w $0446
CODE_00AE89:
	LDA.b $32
	CMP.b $38
	BCC.b CODE_00AED1
	SEC
	SBC.b $38
	STA.b $32
	LDA.b $2C
	SEC
	SBC.w #$0700
	AND.w #$FF00
	ORA.b $36
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	LDA.b $3A
	STA.w MPAINT_Global_OAMBuffer[$00].Tile,x
	JSR.w CODE_00AF2C
	INX
	INX
	INX
	INX
	LDA.b $34
	CMP.w #$0001
	BEQ.b CODE_00AEC8
	LDA.b $30
	ORA.b $36
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	LDA.b $3C
	STA.w MPAINT_Global_OAMBuffer[$00].Tile,x
	JSR.w CODE_00AF2C
	INX
	INX
	INX
	INX
CODE_00AEC8:
	LDA.b $38
	CLC
	ADC.b $36
	STA.b $36
	BRA.b CODE_00AE89

CODE_00AED1:
	DEC.b $3C
	DEC.b $3A
	LSR.b $38
	BNE.b CODE_00AE89
	LDA.b $2C
	STA.b $36
	LDA.w #$0008
	STA.b $38
	LDA.w #$207B
	STA.b $3A
CODE_00AEE7:
	LDA.b $34
	CMP.b $38
	BCC.b CODE_00AF22
	SEC
	SBC.b $38
	STA.b $34
	LDA.b $36
	ORA.b $2A
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	LDA.b $3A
	STA.w MPAINT_Global_OAMBuffer[$00].Tile,x
	JSR.w CODE_00AF2C
	INX
	INX
	INX
	INX
	LDA.b $36
	ORA.b $2E
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	LDA.b $3A
	STA.w MPAINT_Global_OAMBuffer[$00].Tile,x
	JSR.w CODE_00AF2C
	INX
	INX
	INX
	INX
	LDA.b $38
	XBA
	CLC
	ADC.b $36
	STA.b $36
	BRA.b CODE_00AEE7

CODE_00AF22:
	DEC.b $3A
	LSR.b $38
	BNE.b CODE_00AEE7
	STX.w $0446
	RTS

;--------------------------------------------------------------------

CODE_00AF2C:
	PHX
	TXA
	LSR
	LSR
	PHA
	LSR
	LSR
	AND.w #$FFFE
	TAX
	LDA.b $01,S
	AND.w #$0007
	ASL
	TAY
	LDA.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	AND.w DATA_00AF4A,y
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	PLA
	PLX
	RTS

DATA_00AF4A:
	dw $FFFC,$FFF3,$FFCF,$FF3F,$FCFF,$F3FF,$CFFF,$3FFF

;--------------------------------------------------------------------

CODE_00AF5A:
	LDX.w #$0001
	LDY.w #$FFFF
	LDA.b $3E
	CMP.b $42
	BPL.b CODE_00AF69
	PHX
	TYX
	PLY
CODE_00AF69:
	LDA.b $40
	CMP.b $44
	BPL.b CODE_00AF72
	PHX
	TYX
	PLY
CODE_00AF72:
	STX.b $46
	LDA.w #$0001
	STA.b $48
	LDA.b $42
	SEC
	SBC.b $3E
	BPL.b CODE_00AF84
	EOR.w #$FFFF
	INC
CODE_00AF84:
	STA.b $4A
	LDA.b $44
	SEC
	SBC.b $40
	BPL.b CODE_00AF91
	EOR.w #$FFFF
	INC
CODE_00AF91:
	STA.b $4C
	LDA.b $4A
	CMP.b $4C
	BMI.b CODE_00AFF0
	LDA.b $3E
	CMP.b $42
	BMI.b CODE_00AFAC
	LDA.b $46
	EOR.w #$FFFF
	INC
	STA.b $46
	LDA.w #$FFFF
	STA.b $48
CODE_00AFAC:
	LDA.b $3E
	STA.b $86
	LDA.b $40
	STA.b $88
	JSR.w CODE_00B051
	LDA.b $4A
	LSR
	STA.b $4E
	LDX.w #$0001
CODE_00AFBF:
	CPX.b $4A
	BEQ.b CODE_00AFC5
	BCS.b CODE_00AFEF
CODE_00AFC5:
	LDA.b $4E
	SEC
	SBC.b $4C
	STA.b $4E
	BPL.b CODE_00AFDC
	LDA.b $4E
	CLC
	ADC.b $4A
	STA.b $4E
	LDA.b $40
	CLC
	ADC.b $46
	STA.b $40
CODE_00AFDC:
	LDA.b $3E
	CLC
	ADC.b $48
	STA.b $3E
	STA.b $86
	LDA.b $40
	STA.b $88
	JSR.w CODE_00B051
	INX
	BRA.b CODE_00AFBF

CODE_00AFEF:
	RTS

CODE_00AFF0:
	LDA.b $40
	CMP.b $44
	BMI.b CODE_00B003
	LDA.b $46
	EOR.w #$FFFF
	INC
	STA.b $46
	LDA.w #$FFFF
	STA.b $48
CODE_00B003:
	LDA.b $3E
	STA.b $86
	LDA.b $40
	STA.b $88
	JSR.w CODE_00B051
	LDA.b $4C
	LSR
	STA.b $4E
	LDX.w #$0001
CODE_00B016:
	CPX.b $4C
	BEQ.b CODE_00B01C
	BCS.b CODE_00AFEF
CODE_00B01C:
	LDA.b $4E
	SEC
	SBC.b $4A
	STA.b $4E
	BPL.b CODE_00B033
	LDA.b $4E
	CLC
	ADC.b $4C
	STA.b $4E
	LDA.b $3E
	CLC
	ADC.b $46
	STA.b $3E
CODE_00B033:
	LDA.b $40
	CLC
	ADC.b $48
	STA.b $40
	STA.b $88
	LDA.b $3E
	STA.b $86
	JSR.w CODE_00B051
	INX
	BRA.b CODE_00B016

;--------------------------------------------------------------------

CODE_00B046:
	PHB
	PEA.w $0000
	PLB
	PLB
	JSR.w CODE_00B05A
	PLB
	RTL

CODE_00B051:
	LDA.b $20
	AND.b $50
	BEQ.b CODE_00B05A
	JMP.w CODE_00B32D

CODE_00B05A:				; Note: Something related to drawing
	PHX
	PHY
	PHP
	LDA.b $B8
	BEQ.b CODE_00B06C
	LDA.w $04D0
	CMP.w #$0007
	BEQ.b CODE_00B06C
	JSR.w CODE_00B7D6
CODE_00B06C:
	LDA.b $86
	SEC
	SBC.w #$0008
	STA.b $86
	STA.b $80
	PHP
	LDA.b $88
	PLP
	BPL.b CODE_00B080
	SEC
	SBC.w #$0008
CODE_00B080:
	SEC
	SBC.w #$0008
	STA.b $82
	LDA.b $88
	SEC
	SBC.w #$0008
	STA.b $88
	JSR.w CODE_00B305
	LDA.b $84
	PHA
	LDY.w #$0000
CODE_00B097:
	LDA.b $88
	CMP.w $19B2
	BMI.b CODE_00B0A6
	CMP.w $19B4
	BPL.b CODE_00B0A6
	JSR.w CODE_00B0D3
CODE_00B0A6:
	INC.b $88
	INY
	INY
	TYA
	CLC
	ADC.b $84
	AND.w #$000F
	BNE.b CODE_00B0BB
	LDA.b $84
	CLC
	ADC.w #$03F0
	STA.b $84
CODE_00B0BB:
	CPY.w #$0410
	BEQ.b CODE_00B0CE
	CPY.w #$0010
	BNE.b CODE_00B097
	LDY.w #$0400
	LDA.b $01,S
	STA.b $84
	BRA.b CODE_00B097

CODE_00B0CE:
	PLA
	PLP
	PLY
	PLX
	RTS

CODE_00B0D3:
	PHY
	LDA.b $86
	AND.w #$0007
	TAX
	PHX
	JSR.w CODE_00B25E
	JSR.w CODE_00B23C
	LDA.b $01,S
	ASL
	TAX
	LDA.w DATA_00B1A2,x
	STA.b $96
	LDX.w #$0F0F
	LDA.b $86
	AND.w #$FFF8
	CMP.w $19AE
	BEQ.b CODE_00B106
	BMI.b CODE_00B10C
	LDX.w #$F0F0
	CMP.w $19B0
	BEQ.b CODE_00B106
	BPL.b CODE_00B10C
	LDX.w #$FFFF
CODE_00B106:
	STX.w $19BE
	JSR.w CODE_00B1C2
CODE_00B10C:
	LDA.b $8A
	STA.b $8E
	LDA.b $8C
	STA.b $90
	PLX
	PHX
	TYA
	CLC
	ADC.w #$0020
	TAY
	JSR.w CODE_00B25E
	LDA.b $8E
	ORA.b $92
	STA.b $92
	LDA.b $90
	ORA.b $94
	STA.b $94
	JSR.w CODE_00B23C
	LDA.w #$FFFF
	STA.b $96
	LDX.w #$0F0F
	LDA.b $86
	CLC
	ADC.w #$0008
	AND.w #$FFF8
	CMP.w $19AE
	BEQ.b CODE_00B153
	BMI.b CODE_00B159
	LDX.w #$F0F0
	CMP.w $19B0
	BEQ.b CODE_00B153
	BPL.b CODE_00B159
	LDX.w #$FFFF
CODE_00B153:
	STX.w $19BE
	JSR.w CODE_00B1C2
CODE_00B159:
	LDA.b $8A
	ORA.b $8C
	BEQ.b CODE_00B19F
	LDA.b $8A
	STA.b $92
	LDA.b $8C
	STA.b $94
	TYA
	CLC
	ADC.w #$0020
	TAY
	JSR.w CODE_00B23C
	LDA.b $01,S
	ASL
	TAX
	LDA.w DATA_00B1B2,x
	STA.b $96
	LDX.w #$0F0F
	LDA.b $86
	CLC
	ADC.w #$0010
	AND.w #$FFF8
	CMP.w $19AE
	BEQ.b CODE_00B199
	BMI.b CODE_00B19F
	LDX.w #$F0F0
	CMP.w $19B0
	BEQ.b CODE_00B199
	BPL.b CODE_00B19F
	LDX.w #$FFFF
CODE_00B199:
	STX.w $19BE
	JSR.w CODE_00B1C2
CODE_00B19F:
	PLX
	PLY
	RTS

DATA_00B1A2:
	dw $FFFF,$7F7F,$3F3F,$1F1F,$0F0F,$0707,$0303,$0101

DATA_00B1B2:
	dw $0000,$8080,$C0C0,$E0E0,$F0F0,$F8F8,$FCFC,$FEFE

;--------------------------------------------------------------------

CODE_00B1C2:
	PHY
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
	BNE.b CODE_00B210
	LDA.w $0EB8
	BEQ.b CODE_00B1D2
	LDA.w $0EBC
	BRA.b CODE_00B1FD

CODE_00B1D2:
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CMP.w #$0070
	BCC.b CODE_00B1FD
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0003
	BNE.b CODE_00B1FD
	LDA.b $92
	STA.b $9A
	LDA.b $94
	STA.b $9C
	LDA.b $92
	ORA.b $94
	PHA
	XBA
	ORA.b $01,S
	AND.b $96
	STA.b $92
	STA.b $94
	PLA
	BRA.b CODE_00B210

CODE_00B1FD:
	LDA.b $9A
	ORA.b $9C
	PHA
	XBA
	ORA.b $01,S
	STA.b $01,S
	AND.b $92
	STA.b $92
	PLA
	AND.b $94
	STA.b $94
CODE_00B210:
	TYA
	CLC
	ADC.b $84
	CMP.w #$6000
	BCS.b CODE_00B23A
	TAY
	LDA.b $9A
	EOR.b [$0A],y
	AND.b $92
	AND.w $19BE
	EOR.b [$0A],y
	STA.b [$0A],y
	TYA
	CLC
	ADC.w #$0010
	TAY
	LDA.b $9C
	EOR.b [$0A],y
	AND.b $94
	AND.w $19BE
	EOR.b [$0A],y
	STA.b [$0A],y
CODE_00B23A:
	PLY
	RTS

;--------------------------------------------------------------------

CODE_00B23C:
	TYA
	CLC
	ADC.b $84
	AND.w #$0400
	LSR
	LSR
	LSR
	LSR
	PHA
	TYA
	CLC
	ADC.b $84
	AND.w #$003F
	ORA.b $01,S
	TAX
	LDA.w $1CAA,x
	STA.b $9A
	LDA.w $1CBA,x
	STA.b $9C
	PLA
	RTS

;--------------------------------------------------------------------

; Note: Something related to drawing.

CODE_00B25E:
	PHY
	PHX
	STZ.b $92
	STZ.b $94
	STZ.b $8A
	STZ.b $8C
	TYA
	AND.w #$0400
	LSR
	LSR
	LSR
	LSR
	PHA
	TYA
	AND.w #$003F
	ORA.b $01,S
	TAY
	PLA
	LDA.b $01,S
	BEQ.b CODE_00B2F8
	LDA.w $1C2A,y
	PHA
	AND.w #$00FF
	BEQ.b CODE_00B29C
	ASL
	ASL
	ASL
	ORA.b $03,S
	TAX
	SEP.b #$20
	LDA.l DATA_02E000,x
	STA.b $92
	LDA.l DATA_02E800,x
	STA.b $8A
	REP.b #$20
CODE_00B29C:
	PLA
	XBA
	AND.w #$00FF
	BEQ.b CODE_00B2B9
	ASL
	ASL
	ASL
	ORA.b $01,S
	TAX
	SEP.b #$20
	LDA.l DATA_02E000,x
	STA.b $93
	LDA.l DATA_02E800,x
	STA.b $8B
	REP.b #$20
CODE_00B2B9:
	LDA.w $1C3A,y
	PHA
	AND.w #$00FF
	BEQ.b CODE_00B2D8
	ASL
	ASL
	ASL
	ORA.b $03,S
	TAX
	SEP.b #$20
	LDA.l DATA_02E000,x
	STA.b $94
	LDA.l DATA_02E800,x
	STA.b $8C
	REP.b #$20
CODE_00B2D8:
	PLA
	XBA
	AND.w #$00FF
	BEQ.b CODE_00B2F5
	ASL
	ASL
	ASL
	ORA.b $01,S
	TAX
	SEP.b #$20
	LDA.l DATA_02E000,x
	STA.b $95
	LDA.l DATA_02E800,x
	STA.b $8D
	REP.b #$20
CODE_00B2F5:
	PLX
	PLY
	RTS

;--------------------------------------------------------------------

CODE_00B2F8:
	LDA.w $1C2A,y
	STA.b $92
	LDA.w $1C3A,y
	STA.b $94
	PLX
	PLY
	RTS

;--------------------------------------------------------------------

CODE_00B305:
	PHP
	REP.b #$20
	LDA.b $80
	AND.w #$00F8
	ASL
	ASL
	STA.b $84
	LDA.b $82
	AND.w #$00F8
	XBA
	LSR
	CLC
	ADC.b $84
	STA.b $84
	LDA.b $82
	AND.w #$0007
	ASL
	ADC.b $84
	SEC
	SBC.w #$0800
	STA.b $84
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00B32D:
	PHX
	PHY
	PHP
	REP.b #$20
	LDA.b $86
	STA.b $80
	LDA.b $88
	STA.b $82
	JSR.w CODE_00B305
	LDA.b $86
	AND.w #$0007
	ASL
	TAY
	LDA.w DATA_00B600,y
	PHA
	STA.b $92
	STA.b $94
	LDY.w #$0000
	JSR.w CODE_00B23C
	LDA.w #$FFFF
	STA.w $19BE
	LDA.b $9A
	ORA.b $9C
	PHA
	XBA
	ORA.b $01,S
	STA.b $01,S
	AND.b $92
	STA.b $92
	PLA
	AND.b $94
	STA.b $94
	LDA.b $84
	TAY
	LDA.b $9A
	EOR.b [$0A],y
	AND.b $92
	AND.w $19BE
	EOR.b [$0A],y
	STA.b [$0A],y
	TYA
	CLC
	ADC.w #$0010
	TAY
	LDA.b $9C
	EOR.b [$0A],y
	AND.b $94
	AND.w $19BE
	EOR.b [$0A],y
	STA.b [$0A],y
	PLA
	PLP
	PLY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_00B393:
	PHP
	REP.b #$20
	LDA.b $86
	AND.w #$0007
	ASL
	TAY
	LDA.w DATA_00B600,y
	PHA
	STA.b $92
	STA.b $94
	LDY.w #$0000
	JSR.w CODE_00B23C
	LDA.w #$FFFF
	STA.w $19BE
	LDA.b $9A
	ORA.b $9C
	PHA
	XBA
	ORA.b $01,S
	STA.b $01,S
	AND.b $92
	STA.b $92
	PLA
	AND.b $94
	STA.b $94
	LDY.b $84
	LDA.b $9A
	EOR.b [$0A],y
	AND.b $92
	AND.w $19BE
	EOR.b [$0A],y
	STA.b [$0A],y
	TYA
	CLC
	ADC.w #$0010
	TAY
	LDA.b $9C
	EOR.b [$0A],y
	AND.b $94
	AND.w $19BE
	EOR.b [$0A],y
	STA.b [$0A],y
	PLA
	LDX.b $84
	LDA.b $86
	AND.w #$0007
	ASL
	TAY
	LDA.w DATA_00B600,y
	SEP.b #$20
	ORA.l $7F0000,x
	STA.l $7F0000,x
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00B3FF:
	PHP
	TSX
	STX.b $B0
	REP.b #$20
	LDA.w $19AE
	CLC
	ADC.w #$0005
	STA.w $19B6
	LDA.w $19B0
	CLC
	ADC.w #$0004
	STA.w $19B8
	LDA.w $19B2
	INC
	STA.w $19BA
	LDA.w $19B4
	DEC
	STA.w $19BC
	STZ.w $04CA
	STZ.w $1A0C
	SEP.b #$20
	LDA.b #$00
	STA.w $1B1E
	DEC
	STA.w $1B1C
	STA.w $1B1D
	JSR.w CODE_008B29
	LDA.b $86
	STA.b $80
	LDA.b $88
	STA.b $82
	JSR.w CODE_00B305
	REP.b #$20
	LDY.b $84
	LDA.b $86
	AND.w #$0007
	ASL
	TAX
	JSR.w CODE_00B5CB
	STA.b $6C
	STZ.b $7C
	STZ.b $7E
	SEP.b #$20
	LDA.b $86
	PHA
	LDA.b $88
	PHA
	REP.b #$20
	LDA.b $84
	PHA
	JSR.w CODE_00B610
	PLA
	PLA
CODE_00B46F:
	REP.b #$20
	PHA
	PHA
	JSR.w CODE_00B637
	BCC.b CODE_00B481
	PLA
	PLA
	SEP.b #$20
	STZ.w $1B1C
	PLP
	RTS

CODE_00B481:
	PLA
	STA.b $84
	SEP.b #$20
	PLA
	STA.b $88
	PLA
	STA.b $86
	REP.b #$20
	LDX.b $84
	LDA.b $86
	AND.w #$0007
	ASL
	TAY
	LDA.w DATA_00B600,y
	SEP.b #$20
	AND.l $7F0000,x
	BNE.b CODE_00B46F
	LDY.b $84
CODE_00B4A4:
	LDA.b $86
	CMP.w $19B6
	BCC.b CODE_00B4CB
	REP.b #$20
	DEC
	AND.w #$0007
	ASL
	TAX
	CMP.w #$000E
	BNE.b CODE_00B4BE
	TYA
	SEC
	SBC.w #$0020
	TAY
CODE_00B4BE:
	JSR.w CODE_00B5CB
	CMP.b $6C
	BNE.b CODE_00B4CB
	STY.b $84
	DEC.b $86
	BRA.b CODE_00B4A4

CODE_00B4CB:
	SEP.b #$20
	STZ.b $70
	STZ.b $72
	STZ.w $1A0C
CODE_00B4D4:
	SEP.b #$20
	LDA.b $86
	CMP.w $19B8
	BCS.b CODE_00B46F
	LDA.w $04CA
	ORA.w $1A0C
	STA.w $1A0C
	JSR.w CODE_00B393
	LDA.b $88
	CMP.w $19BA
	BCC.b CODE_00B549
	STZ.b $74
	LDA.b $88
	REP.b #$20
	LDY.b $84
	DEC
	AND.w #$0007
	CMP.w #$0007
	BNE.b CODE_00B507
	TYA
	SEC
	SBC.w #$03F0
	TAY
CODE_00B507:
	DEY
	DEY
	LDA.b $86
	AND.w #$0007
	ASL
	TAX
	JSR.w CODE_00B5CB
	CMP.b $6C
	BNE.b CODE_00B519
	INC.b $74
CODE_00B519:
	TYX
	LDA.b $86
	AND.w #$0007
	ASL
	TAY
	LDA.w DATA_00B600,y
	SEP.b #$20
	AND.l $7F0000,x
	BNE.b CODE_00B545
	LDA.b $70
	BNE.b CODE_00B545
	LDA.b $74
	BEQ.b CODE_00B545
	LDA.b $86
	PHA
	LDA.b $88
	DEC
	PHA
	REP.b #$20
	PHX
	JSR.w CODE_00B610
	PLX
	PLA
	SEP.b #$20
CODE_00B545:
	LDA.b $74
	STA.b $70
CODE_00B549:
	LDA.b $88
	CMP.w $19BC
	BCS.b CODE_00B5A6
	STZ.b $74
	LDA.b $88
	REP.b #$20
	LDY.b $84
	INC
	AND.w #$0007
	BNE.b CODE_00B564
	TYA
	CLC
	ADC.w #$03F0
	TAY
CODE_00B564:
	INY
	INY
	LDA.b $86
	AND.w #$0007
	ASL
	TAX
	JSR.w CODE_00B5CB
	CMP.b $6C
	BNE.b CODE_00B576
	INC.b $74
CODE_00B576:
	TYX
	LDA.b $86
	AND.w #$0007
	ASL
	TAY
	LDA.w DATA_00B600,y
	SEP.b #$20
	AND.l $7F0000,x
	BNE.b CODE_00B5A2
	LDA.b $72
	BNE.b CODE_00B5A2
	LDA.b $74
	BEQ.b CODE_00B5A2
	LDA.b $86
	PHA
	LDA.b $88
	INC
	PHA
	REP.b #$20
	PHX
	JSR.w CODE_00B610
	PLX
	PLA
	SEP.b #$20
CODE_00B5A2:
	LDA.b $74
	STA.b $72
CODE_00B5A6:
	LDY.b $84
	LDA.b $86
	REP.b #$20
	INC
	AND.w #$0007
	ASL
	TAX
	BNE.b CODE_00B5BA
	TYA
	CLC
	ADC.w #$0020
	TAY
CODE_00B5BA:
	JSR.w CODE_00B5CB
	CMP.b $6C
	BEQ.b CODE_00B5C4
	JMP.w CODE_00B46F

CODE_00B5C4:
	STY.b $84
	INC.b $86
	JMP.w CODE_00B4D4

;--------------------------------------------------------------------

CODE_00B5CB:
	PHY
	PHP
	LDA.b [$0A],y
	AND.w DATA_00B600,x
	STA.b $76
	TYA
	CLC
	ADC.w #$0010
	TAY
	LDA.b [$0A],y
	AND.w DATA_00B600,x
	STA.b $78
	LDA.w #$0000
	SEP.b #$30
	LDY.b $79
	BEQ.b CODE_00B5EB
	INC
CODE_00B5EB:
	ASL
	LDY.b $78
	BEQ.b CODE_00B5F1
	INC
CODE_00B5F1:
	ASL
	LDY.b $77
	BEQ.b CODE_00B5F7
	INC
CODE_00B5F7:
	ASL
	LDY.b $76
	BEQ.b CODE_00B5FD
	INC
CODE_00B5FD:
	PLP
	PLY
	RTS

DATA_00B600:
	dw $8080,$4040,$2020,$1010,$0808,$0404,$0202,$0101

;--------------------------------------------------------------------

CODE_00B610:
	LDX.b $7E
	LDA.b $05,S
	STA.l $7F6000,x
	LDA.b $03,S
	STA.l $7F6002,x
	LDA.b $7C
	SEC
	SBC.w #$0004
	AND.w #$1FFF
	CMP.b $7E
	BEQ.b CODE_00B636
	LDA.b $7E
	CLC
	ADC.w #$0004
	AND.w #$1FFF
	STA.b $7E
CODE_00B636:
	RTS

;--------------------------------------------------------------------

CODE_00B637:
	LDA.w $1A0C
	AND.w #$0020
	BEQ.b CODE_00B649
	LDX.b $B0
	TXS
	SEP.b #$20
	STZ.w $1B1C
	PLP
	RTS

CODE_00B649:
	LDA.b $7C
	CMP.b $7E
	BNE.b CODE_00B651
	SEC
	RTS

CODE_00B651:
	LDX.b $7C
	LDA.l $7F6000,x
	STA.b $05,S
	LDA.l $7F6002,x
	STA.b $03,S
	LDA.b $7C
	CLC
	ADC.w #$0004
	AND.w #$1FFF
	STA.b $7C
	CLC
	RTS

;--------------------------------------------------------------------

CODE_00B66C:
	PHA
	AND.w #$FFF8
	ASL
	PHA
	LDA.b $03,S
	AND.w #$0007
	CLC
	ADC.b $01,S
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL
	STA.b $03,S
	PLA
	PLA
	CMP.w #$7800
	BCS.b CODE_00B6C1
	CMP.w #$3800
	BCC.b CODE_00B692
	CLC
	ADC.w #$0800
CODE_00B692:
	TAX
	LDY.w #$0000
CODE_00B696:
	LDA.l DATA_0A8000,x
	STA.w $1BAA,y
	INX
	INX
	INY
	INY
	CPY.w #$0040
	BNE.b CODE_00B696
	TXA
	CLC
	ADC.w #$01C0
	TAX
CODE_00B6AC:
	LDA.l DATA_0A8000,x
	STA.w $1BAA,y
	INX
	INX
	INY
	INY
	CPY.w #$0080
	BNE.b CODE_00B6AC
	JSL.l CODE_01D56D
	RTS

CODE_00B6C1:
	SEC
	SBC.w #$7800
	TAX
	LDY.w #$0000
CODE_00B6C9:
	LDA.l !SRAM_MPAINT_Global_SavedSpecialStampsGFX,x
	STA.w $1BAA,y
	INX
	INX
	INY
	INY
	CPY.w #$0040
	BNE.b CODE_00B6C9
	TXA
	CLC
	ADC.w #$01C0
	TAX
CODE_00B6DF:
	LDA.l !SRAM_MPAINT_Global_SavedSpecialStampsGFX,x
	STA.w $1BAA,y
	INX
	INX
	INY
	INY
	CPY.w #$0080
	BNE.b CODE_00B6DF
	JSL.l CODE_01D56D
	RTS

;--------------------------------------------------------------------

CODE_00B6F4:
	PHA
	AND.w #$FFF8
	ASL
	PHA
	LDA.b $03,S
	AND.w #$0007
	CLC
	ADC.b $01,S
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL
	STA.b $03,S
	PLA
	PLA
	CMP.w #$7800
	BCS.b CODE_00B74D
	CMP.w #$0800
	BCS.b CODE_00B71A
	CLC
	ADC.w #$3000
CODE_00B71A:
	CLC
	ADC.w #$0800
	TAX
	LDY.w #$0000
CODE_00B722:
	LDA.l DATA_0A8000,x
	STA.w $1B2A,y
	INX
	INX
	INY
	INY
	CPY.w #$0040
	BNE.b CODE_00B722
	TXA
	CLC
	ADC.w #$01C0
	TAX
CODE_00B738:
	LDA.l DATA_0A8000,x
	STA.w $1B2A,y
	INX
	INX
	INY
	INY
	CPY.w #$0080
	BNE.b CODE_00B738
	JSL.l CODE_01D597
	RTS

CODE_00B74D:
	SEC
	SBC.w #$7800
	TAX
	LDY.w #$0000
CODE_00B755:
	LDA.l $700000,x
	STA.w $1B2A,y
	INX
	INX
	INY
	INY
	CPY.w #$0040
	BNE.b CODE_00B755
	TXA
	CLC
	ADC.w #$01C0
	TAX
CODE_00B76B:
	LDA.l $700000,x
	STA.w $1B2A,y
	INX
	INX
	INY
	INY
	CPY.w #$0080
	BNE.b CODE_00B76B
	JSL.l CODE_01D597
	RTS

;--------------------------------------------------------------------

CODE_00B780:
	PHP
	PHB
	PHA
	AND.w #$FFF8
	ASL
	PHA
	LDA.b $03,S
	AND.w #$0007
	CLC
	ADC.b $01,S
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL
	STA.b $03,S
	PLA
	PLY
	SEP.b #$20
	LDA.w $0EBA
	CLC
	ADC.b #DATA_0B8000>>16
	PHA
	PLB
	REP.b #$20
	LDX.w #$0000
CODE_00B7A9:
	LDA.w DATA_0B8000,y
	STA.l $001B2A,x
	INY
	INY
	INX
	INX
	CPX.w #$0040
	BNE.b CODE_00B7A9
	TYA
	CLC
	ADC.w #$01C0
	TAY
CODE_00B7BF:
	LDA.w DATA_0B8000,y
	STA.l $001B2A,x
	INY
	INY
	INX
	INX
	CPX.w #$0080
	BNE.b CODE_00B7BF
	PLB
	PLP
	JSL.l CODE_01D597
	RTS

;--------------------------------------------------------------------

; Note: Related to drawing with the spray tool.

CODE_00B7D6:
	DEC.b $BA
	BEQ.b CODE_00B7E8
	LDA.w !RAM_MPAINT_Global_MouseXDisplacementLo
	ORA.w !RAM_MPAINT_Global_MouseYDisplacementLo
	AND.w #$00FF
	ORA.b $50
	BNE.b CODE_00B7E8
	RTS

CODE_00B7E8:
	LDA.w #$0002
	STA.b $BA
	LDX.w #$001E
CODE_00B7F0:
	STZ.w $1C2A,x
	STZ.w $1C4A,x
	STZ.w $1C6A,x
	STZ.w $1C8A,x
	DEX
	DEX
	BPL.b CODE_00B7F0
	LDY.w #$0000
CODE_00B803:
	INY
	CPY.w #$0008
	BNE.b CODE_00B80A
	RTS

CODE_00B80A:
	PHY
	LDA.b $BC
	INC.b $BC
	BNE.b CODE_00B816
	LDX.w #$0001
	STX.b $BE
CODE_00B816:
	LDY.w #DATA_00B8E0
	LDX.b $BE
	BNE.b CODE_00B82D
	CMP.w #$0010
	BCS.b CODE_00B82D
	LDY.w #DATA_00B8F0
	AND.w #$0001
	BEQ.b CODE_00B82D
	LDY.w #DATA_00B900
CODE_00B82D:
	PHY
	LDA.b $03,S
	DEC
	ASL
	TAY
	LDA.b ($01,S),y
	TAX
	PLY
	PLY
CODE_00B838:
	DEX
	BMI.b CODE_00B803
	PHX
	JSL.l CODE_01E20C
	PHA
	SEP.b #$30
	JSR.w CODE_00B926
	STA.w !REGISTER_Multiplicand
	STY.w !REGISTER_Multiplier
	NOP #4
	REP.b #$30
	LDA.w !REGISTER_ProductOrRemainderLo
	LDX.w $0102
	BEQ.b CODE_00B85E
	EOR.w #$FFFF
	INC
CODE_00B85E:
	AND.w #$FF00
	BPL.b CODE_00B866
	ORA.w #$00FF
CODE_00B866:
	XBA
	CLC
	ADC.w #$0008
	STA.b $B2
	PLA
	SEP.b #$30
	JSR.w CODE_00B910
	STA.w !REGISTER_Multiplicand
	STY.w !REGISTER_Multiplier
	NOP #4
	REP.b #$30
	LDA.w !REGISTER_ProductOrRemainderLo
	LDX.w $0102
	BEQ.b CODE_00B88B
	EOR.w #$FFFF
	INC
CODE_00B88B:
	AND.w #$FF00
	BPL.b CODE_00B893
	ORA.w #$00FF
CODE_00B893:
	XBA
	CLC
	ADC.w #$0008
	STA.b $B4
	LDA.b $B2
	AND.w #$FFF8
	ASL
	ASL
	STA.b $B6
	LDA.b $B4
	AND.w #$FFF8
	ASL
	ASL
	ASL
	CLC
	ADC.b $B6
	STA.b $B6
	LDA.b $B4
	AND.w #$0007
	ASL
	CLC
	ADC.b $B6
	STA.b $B6
	LDA.b $B2
	AND.w #$0007
	ASL
	TAX
	LDA.w DATA_00B600,x
	LDX.b $B6
	CPX.w #$0070
	BCS.b CODE_00B8DE
	PHA
	ORA.w $1C2A,x
	STA.w $1C2A,x
	PLA
	ORA.w $1C3A,x
	STA.w $1C3A,x
	PLX
	JMP.w CODE_00B838

CODE_00B8DE:						; Note: Infinite loop.
	BRA.b CODE_00B8DE

DATA_00B8E0:
	dw $0003,$0001,$0002,$0001,$0001,$0001,$0001,$0001

DATA_00B8F0:
	dw $0000,$0001,$0000,$0001,$0000,$0000,$0000,$0000

DATA_00B900:
	dw $0001,$0000,$0001,$0000,$0001,$0000,$0000,$0000

;--------------------------------------------------------------------

CODE_00B910:
	PHX
	STZ.w $0102
	CMP.b #$80
	BCC.b CODE_00B91B
	INC.w $0102
CODE_00B91B:
	BIT.b #$40
CODE_00B91D:
	BEQ.b CODE_00B922
	EOR.b #$FF
	INC
CODE_00B922:
	AND.b #$7F
	BRA.b CODE_00B940

CODE_00B926:
	PHX
	STZ.w $0102
	CMP.b #$40
	BCC.b CODE_00B935
	CMP.b #$C0
	BCS.b CODE_00B935
	INC.w $0102
CODE_00B935:
	BIT.b #$40
	BNE.b CODE_00B93C
	EOR.b #$FF
	INC
CODE_00B93C:
	EOR.b #$40
	AND.b #$7F
CODE_00B940:
	TAX
	LDA.l DATA_00B947,x
	PLX
	RTS

DATA_00B947:
	db $00,$06,$0C,$12,$19,$1F,$25,$2B
	db $31,$38,$3E,$44,$4A,$50,$56,$5C
	db $61,$67,$6D,$73,$78,$7E,$83,$88
	db $8E,$93,$98,$9D,$A2,$A7,$AB,$B0
	db $B5,$B9,$BD,$C1,$C5,$C9,$CD,$D1
	db $D4,$D8,$DB,$DE,$E1,$E4,$E7,$EA
	db $EC,$EE,$F1,$F3,$F4,$F6,$F8,$F9
	db $FB,$FC,$FD,$FE,$FE,$FF,$FF,$FF
	db $FF

;--------------------------------------------------------------------

CODE_00B988:
	JSR.w CODE_00B98C
	RTL

CODE_00B98C:
	JSR.w CODE_008B03
	PHP
	LDA.w $19C2
	ASL
	TAX
	LDA.w DATA_00B9EF,x
	PHA
	PHA
	PHA
	LDY.w #$0000
	BRA.b CODE_00B9DA

CODE_00B9A0:
	PHY
	PHB
	LDA.b ($08,S),y
	TAX
	INY
	INY
	LDA.b ($08,S),y
	TAY
	SEP.b #$20
	LDA.b #$7F0000>>16
	PHA
	PLB
	REP.b #$20
CODE_00B9B2:
	LDA.b $04,S
CODE_00B9B4:
	PHA
	LDA.w $7FA000,x
	STA.w $7F0000,y
	INX
	INX
	INY
	INY
	PLA
	DEC
	DEC
	BNE.b CODE_00B9B4
	TXA
	CLC
	ADC.w #$0400
	SEC
	SBC.b $04,S
	TAX
	LDA.b $06,S
	DEC
	STA.b $06,S
	BNE.b CODE_00B9B2
	PLB
	PLY
	INY
	INY
	INY
	INY
CODE_00B9DA:
	LDA.b ($05,S),y
	BEQ.b CODE_00B9EA
	STA.b $03,S
	INY
	INY
	LDA.b ($05,S),y
	STA.b $01,S
	INY
	INY
	BRA.b CODE_00B9A0

CODE_00B9EA:
	PLA
	PLA
	PLA
	PLP
	RTS

DATA_00B9EF:
	dw DATA_00B9F5,DATA_00B9F5,DATA_00BA1F

DATA_00B9F5:
	dw $000B,$0200,$0400,$0C00
	dw $000B,$0200,$0600,$2200
	dw $000B,$0200,$3000,$3800
	dw $0006,$0200,$3200,$0000
	dw $0005,$0200,$4A00,$4E00
	dw $0000

DATA_00BA1F:
	dw $0007,$0140,$0420,$0000
	dw $0007,$0140,$0560,$08C0
	dw $0007,$0140,$06A0,$1180
	dw $0007,$0140,$2020,$1A40
	dw $0007,$0140,$2160,$2300
	dw $0007,$0140,$22A0,$2BC0
	dw $0007,$0140,$3C20,$3800
	dw $0007,$0140,$3D60,$40C0
	dw $0007,$0140,$3EA0,$4980
	dw $0000

;--------------------------------------------------------------------

CODE_00BA69:
	LDA.w #DATA_01CEB2
	JSL.l CODE_01CDE1
	LDA.w #DATA_01CF16
	JSL.l CODE_01CDE1
	RTS

;--------------------------------------------------------------------

CODE_00BA78:
	LDX.w #$07F8
CODE_00BA7B:
	LDA.w #$0000
	STA.l $7E3800,x
	DEX
	DEX
	BPL.b CODE_00BA7B
	LDA.w #$0000
	STA.l $7E3800
	LDA.w #$8080
	STA.l $7E3802
	LDA.w #$FFFE
	STA.w $19EA
	LDA.w #$0004
	STA.w $19EC
	STA.l $7E3FFA
	STZ.w $19EE
	STZ.w $19F2
	RTS

;--------------------------------------------------------------------

CODE_00BAAB:
	STZ.w $1A06
	INC.w $09D1
	LDA.w #$000C
	STA.w $04D0
	JSL.l CODE_01E06F
	JSR.w CODE_00C414
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$0006
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	LDA.w $19FA
	STA.w $19FC
	STZ.w $19FA
	LDA.w #!RAM_MPAINT_Canvas_AnimationCellGFXBuffer
	STA.b $0A
	JSR.w CODE_00B98C
	STZ.w $0206
	STZ.w $0216
	INC.w $0214
CODE_00BAED:
	JSL.l CODE_01E2CE
	LDA.w $0214
	BNE.b CODE_00BAED
	INC.w $0206
	LDA.w $1A08
	ASL
	TAX
	LDA.w DATA_00BE17,x
	STA.w $1A02
	STZ.w $0EAC
	STZ.w $19FE
	LDA.w #$0005
	STA.w $09D6
	STZ.w $1A0A
	LDA.w #$FFFE
	STA.w $19EA
	STZ.w $19EE
	STZ.w $19F2
	LDX.w #$007E
CODE_00BB22:
	LDA.l $7E2040,x
	AND.w #$E3FF
	ORA.w #$1000
	STA.l $7E2040,x
	DEX
	DEX
	BPL.b CODE_00BB22
	LDA.w #DATA_01CF2B
	JSL.l CODE_01CDE1
	SEP.b #$20
	JSL.l CODE_01D388
	JSL.l CODE_01E30E
	LDA.b #DATA_1C8000
	STA.b $CC
	LDA.b #DATA_1C8000>>8
	STA.b $CD
	LDA.b #DATA_1C8000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
CODE_00BB5A:
	LDA.b #$01
	STA.w !REGISTER_APUPort0
	LDA.w !REGISTER_APUPort0
	CMP.b #$01
	BNE.b CODE_00BB5A
	REP.b #$20
	JSL.l CODE_01E2F3
	RTS

;--------------------------------------------------------------------

CODE_00BB6D:
	PHP
	JSL.l CODE_01E2CE
	JSL.l CODE_01E06F
	JSR.w CODE_00BA69
	LDA.w $19FC
	STA.w $19FA
	BEQ.b CODE_00BB8B
	JSR.w CODE_00C3DE
	LDA.w #!RAM_MPAINT_Canvas_AnimationCellGFXBuffer
	STA.b $0A
	BRA.b CODE_00BB93

CODE_00BB8B:
	JSR.w CODE_00C414
	LDA.w #!RAM_MPAINT_Canvas_CanvasGFXBuffer
	STA.b $0A
CODE_00BB93:
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$0004
	STA.w $09D6
	SEP.b #$20
	LDA.b #$02
	STA.w $0105
	REP.b #$20
	JSR.w CODE_0089C3
	PLP
	JSL.l CODE_01DE97
	STZ.w $0202
	INC.w $09AB
	JSR.w CODE_00A363
	STZ.w $09D1
	LDA.w #$0009
	STA.w $04D0
	LDA.w #$0002
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	JMP.w CODE_00C460

;--------------------------------------------------------------------

CODE_00BBD4:
	JSR.w CODE_00BBD8
	RTL

CODE_00BBD8:
	PHP
	SEP.b #$10
	LDA.w $19C2
	ASL
	TAY
	LDX.b #$02
	LDA.w $19FE
	CMP.w DATA_00BE31,y
	BCC.b CODE_00BBEC
	LDX.b #$0A
CODE_00BBEC:
	STX.w $0105
	REP.b #$10
	LDX.w #$0028
	LDY.w #$0007
	LDA.w $1A08
	CLC
	ADC.w #$0096
	JSL.l CODE_01F91E
	LDA.w $1A0A
	INC.w $1A0A
	BIT.w #$0008
	BNE.b CODE_00BC27
	LDA.w $1A08
	ASL
	ASL
	ASL
	ASL
	SEC
	SBC.w $1A08
	CLC
	ADC.w #$0038
	TAX
	LDY.w #$0007
	LDA.w #$00A3
	JSL.l CODE_01F91E
CODE_00BC27:
	LDA.w $19C2
	ASL
	TAX
	LDA.w DATA_00BE3D,x
	CLC
	ADC.w $19FE
	PHA
	LDX.w $19EA
	LDA.w $19F2
	BEQ.b CODE_00BC41
	DEC.w $19F2
	BRA.b CODE_00BC88

CODE_00BC41:
	INX
	INX
	CPX.w $19EC
	BNE.b CODE_00BC4E
	STZ.w $19EE
	LDX.w #$0000
CODE_00BC4E:
	LSR.w $19F6
	LSR.w $19EE
	LDA.w $19EE
	BIT.w #$0100
	BNE.b CODE_00BC72
	LDA.l $7E3800,x
	INX
	AND.w #$00FF
	ORA.w #$FF00
	STA.w $19EE
	LDA.l $7E3800,x
	INX
	STA.w $19F6
CODE_00BC72:
	LDA.w $19EE
	BIT.w #$0001
	BEQ.b CODE_00BC85
	LDA.l $7E3800,x
	INX
	AND.w #$00FF
	STA.w $19F2
CODE_00BC85:
	STX.w $19EA
CODE_00BC88:
	LDY.w #$0000
	LDA.w $19F6
	BIT.w #$0001
	BEQ.b CODE_00BC96
	LDY.w #$FF00
CODE_00BC96:
	PHY
	LDA.l $7E3800,x
	AND.w #$00FF
	TAY
	LDA.l $7E3800+$01,x
	AND.w #$00FF
	ORA.b $01,S
	TAX
	PLA
	PLA
	JSL.l CODE_01F9BB
	LDA.w $1A02
	BEQ.b CODE_00BCBD
	CLC
	ADC.w $1A00
	STA.w $1A00
	BCC.b CODE_00BCD3
CODE_00BCBD:
	LDA.w $19C2
	ASL
	TAX
	INC.w $19FE
	LDA.w $19FE
	CMP.w DATA_00BE37,x
	BNE.b CODE_00BCD3
	LDA.w #$0000
	STA.w $19FE
CODE_00BCD3:
	LDA.w $0EAC
	BEQ.b CODE_00BCDB
	JSR.w CODE_00C7DB
CODE_00BCDB:
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00BD4C
	LDA.w $1A06
	BEQ.b CODE_00BCFD
	LDA.w #$000E
	JSL.l CODE_01D368
	STZ.w $1A06
	SEP.b #$20
	LDA.b #$13
	STA.w $011A
	REP.b #$20
	BRA.b CODE_00BD4C

CODE_00BCFD:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0014
	BCS.b CODE_00BD44
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0038
	BCC.b CODE_00BD44
	CMP.w #$0100
	BCS.b CODE_00BD44
	SEC
	SBC.w #$0038
	LDY.w #$0000
CODE_00BD19:
	CMP.w #$000F
	BCC.b CODE_00BD24
	SBC.w #$000F
	INY
	BRA.b CODE_00BD19

CODE_00BD24:
	CPY.w #$000D
	BCS.b CODE_00BD44
	STY.w $1A08
	TYA
	STA.l $7E3FFE
	ASL
	TAX
	LDA.w DATA_00BE17,x
	STA.w $1A02
	LDA.w $1A08
	CLC
	ADC.w #$0011
	JSL.l CODE_01D368
CODE_00BD44:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCS.b CODE_00BD56
CODE_00BD4C:
	LDA.w $1A06
	BEQ.b CODE_00BD54
	JMP.w CODE_00BE10

CODE_00BD54:
	PLP
	RTS

CODE_00BD56:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00BD4C
	CMP.w #$0017
	BCC.b CODE_00BD7C
	CMP.w #$0028
	BCC.b CODE_00BD4C
	CMP.w #$0037
	BCS.b CODE_00BD70
	JMP.w CODE_00BDF5

CODE_00BD70:
	CMP.w #$0040
	BCC.b CODE_00BD4C
	CMP.w #$004F
	BCC.b CODE_00BDC1
	BRA.b CODE_00BD4C

CODE_00BD7C:
	PLP
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	LDA.w #$0020
	JSL.l CODE_009C1B
	LDA.w #$000C
	JSL.l CODE_01D368
	SEP.b #$20
	JSL.l CODE_01D39F
	JSL.l CODE_01E30E
	LDA.b #DATA_1A8000
	STA.b $CC
	LDA.b #DATA_1A8000>>8
	STA.b $CD
	LDA.b #DATA_1A8000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
	REP.b #$20
	JSL.l CODE_01E2F3
	JSL.l CODE_01D3AB
	JMP.w CODE_00BB6D

CODE_00BDC1:
	LDA.w #$000D
	JSL.l CODE_01D368
	LDA.w $0EAC
	BNE.b CODE_00BDE5
	INC.w $0EAC
	JSL.l CODE_00C7AF
	LDA.w #$0000
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	JMP.w CODE_00BD4C

CODE_00BDE5:
	STZ.w $0EAC
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	JMP.w CODE_00BD4C

CODE_00BDF5:
	LDA.w #$000E
	JSL.l CODE_01D368
	INC.w $1A06
	SEP.b #$20
	LDA.b #$16
	STA.w $011A
	LDA.w MPAINT_Global_UpperOAMBuffer[$00].Slot
	AND.b #$FC
	ORA.b #$01
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot
CODE_00BE10:
	PLP
	PLA
	INC
	INC
	INC
	PHA
	RTS

DATA_00BE17:
	dw $0469,$0555,$0690,$0842,$0AAA,$0E38,$13B1,$1999
	dw $2492,$3333,$5555,$8000,$0000

DATA_00BE31:
	dw $0002,$0003,$0006

DATA_00BE37:
	dw $0004,$0006,$0009

DATA_00BE3D:
	dw $0020,$0024,$002A

;--------------------------------------------------------------------

CODE_00BE43:
	PHP
	INC.w $09D1
	JSL.l CODE_01E06F
	LDA.w #$000A
	STA.w $04D0
	JSR.w CODE_00C414
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$0005
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	LDA.w $19FA
	STA.w $19FC
	STZ.w $19FA
	LDA.w #!RAM_MPAINT_Canvas_AnimationCellGFXBuffer
	STA.b $0A
	JSR.w CODE_00B98C
	STZ.w $0206
	STZ.w $0216
	INC.w $0214
CODE_00BE83:
	JSL.l CODE_01E2CE
	LDA.w $0214
	BNE.b CODE_00BE83
	INC.w $0206
	LDA.w $1A08
	ASL
	TAX
	LDA.w DATA_00BE17,x
	STA.w $1A02
	STZ.w $19FE
	STZ.w $1A0A
	STZ.w $19EA
	STZ.w $19EC
	STZ.w $19F4
	STZ.w $19F8
	STZ.w $19F0
	LDX.w #$007E
CODE_00BEB2:
	TXA
	AND.w #$003F
	CMP.w #$0030
	BCC.b CODE_00BED0
	CMP.w #$003E
	BCS.b CODE_00BED0
	LDA.l $7E2040,x
	AND.w #$E3FF
	ORA.w #$1400
	STA.l $7E2040,x
	BRA.b CODE_00BEDE

CODE_00BED0:
	LDA.l $7E2040,x
	AND.w #$E3FF
	ORA.w #$0C00
	STA.l $7E2040,x
CODE_00BEDE:
	DEX
	DEX
	BPL.b CODE_00BEB2
	LDA.w #DATA_01CF48
	JSL.l CODE_01CDE1
	LDA.w #!RAM_MPAINT_Canvas_CanvasGFXBuffer
	STA.b $0A
	JSR.w CODE_008B03
	LDA.w #$03FF
	STA.w $04D6
	JSR.w CODE_00BF5F
	LDA.w #$0110
	STA.w $04D6
	JSR.w CODE_008B18
	LDA.w $19EC
	BEQ.b CODE_00BF44
	INC.w $19EC
	INC.w $19EC
	SEP.b #$20
CODE_00BF10:
	LSR.w $19F0
	BCS.b CODE_00BF1D
	LSR.w $19F1
	LSR.w $19F9
	BRA.b CODE_00BF10

CODE_00BF1D:
	LDA.w $19F1
	STA.w $19CE
	LDA.w $19F9
	STA.w $19CF
	LDY.w #$0000
	LDX.w $19EA
CODE_00BF2F:
	LDA.w $19CE,y
	STA.l $7E3800,x
	INY
	INX
	CPY.w $19EC
	BNE.b CODE_00BF2F
	STX.w $19EC
	REP.b #$20
	BRA.b CODE_00BF47

CODE_00BF44:
	JSR.w CODE_00BA78
CODE_00BF47:
	LDA.w #$0009
	STA.w $04D0
	LDA.w $19EC
	STA.l $7E3FFA
	PLP
	LDA.w #$0041
	JSL.l CODE_01D368
	JMP.w CODE_00BB6D

;--------------------------------------------------------------------

CODE_00BF5F:
	LDA.w #$0001
	STA.b $20
	JSR.w CODE_008B48
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	AND.w #$01FF
	STA.w !RAM_MPAINT_Global_CursorXPosLo
	JSR.w CODE_009378
	LDA.w #$0004
	STA.w $0446
	SEP.b #$10
	LDA.w $19C2
	ASL
	TAY
	LDX.b #$02
	LDA.w $19FE
	CMP.w DATA_00BE31,y
	BCC.b CODE_00BF8C
	LDX.b #$0A
CODE_00BF8C:
	STX.w $0105
	REP.b #$10
	JSR.w CODE_00C04A
	LDA.w $19C2
	ASL
	TAX
	LDA.w DATA_00BE3D,x
	CLC
	ADC.w $19FE
	LDX.w !RAM_MPAINT_Global_CursorXPosLo
	LDY.w !RAM_MPAINT_Global_CursorYPosLo
	JSL.l CODE_01F9BB
	LDA.w $1A02
	BEQ.b CODE_00BFB8
	CLC
	ADC.w $1A00
	STA.w $1A00
	BCC.b CODE_00BFCE
CODE_00BFB8:
	LDA.w $19C2
	ASL
	TAX
	INC.w $19FE
	LDA.w $19FE
	CMP.w DATA_00BE37,x
	BNE.b CODE_00BFCE
	LDA.w #$0000
	STA.w $19FE
CODE_00BFCE:
	JSL.l CODE_01E09B
	JSL.l CODE_01E2CE
	STZ.w $1996
	LDA.w $04CA
	BIT.w #$0010
	BEQ.b CODE_00C040
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCC.b CODE_00BFFE
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00BFFE
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00BFFE
	CMP.w #$0017
	BCC.b CODE_00C049
CODE_00BFFE:
	LDA.w $1970
	CMP.w #$0100
	BEQ.b CODE_00C00E
	INC.w $1996
	JSR.w CODE_00C225
	BRA.b CODE_00C01D

CODE_00C00E:
	LDA.w $016C
	AND.w #$0007
	BNE.b CODE_00C01D
	LDA.w #$0013
	JSL.l CODE_01D368
CODE_00C01D:
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00C03D
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0018
	BCS.b CODE_00C03D
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$00C8
	BCC.b CODE_00C03D
	CMP.w #$00F4
	BCS.b CODE_00C03D
	JSR.w CODE_00C386
CODE_00C03D:
	JMP.w CODE_00BF5F

CODE_00C040:
	STZ.w $1998
	STZ.w $199A
	JMP.w CODE_00BF5F

CODE_00C049:
	RTS

CODE_00C04A:
	LDA.w $19EA
	CLC
	ADC.w $19EC
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w #$0100
	LDY.w #$0064
	CPX.w #$007F
	BCS.b CODE_00C06A
	LDA.w DATA_00C127,x
	AND.w #$00FF
	LDY.w DATA_00C1A6,x
CODE_00C06A:
	STA.w $1970
	TYA
	AND.w #$00FF
	STA.w $1968
	LDA.w #$0008
	STA.w $196A
	LDA.w #$0048
	STA.w $196C
	LDA.w #$3E11
	STA.w $196E
	STZ.w $1972
	LDA.w $1970
	AND.w #$0F00
	XBA
	BEQ.b CODE_00C0A3
	CLC
	ADC.w #$00B8
	LDX.w #$0018
	LDY.w #$0007
	JSL.l CODE_01F91E
	INC.w $1972
CODE_00C0A3:
	LDA.w $1970
	AND.w #$00F0
	LSR
	LSR
	LSR
	LSR
	BNE.b CODE_00C0B4
	LDX.w $1972
	BEQ.b CODE_00C0C2
CODE_00C0B4:
	CLC
	ADC.w #$00B8
	LDX.w #$0020
	LDY.w #$0007
	JSL.l CODE_01F91E
CODE_00C0C2:
	LDA.w $1970
	AND.w #$000F
	CLC
	ADC.w #$00B8
	LDX.w #$0028
	LDY.w #$0007
	JSL.l CODE_01F91E
	LDX.w $0446
CODE_00C0D9:
	LDA.w $1968
	CMP.w $196A
	BCC.b CODE_00C10A
	SEC
	SBC.w $196A
	STA.w $1968
	LDA.w $196C
	ORA.w #$0F00
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	LDA.w $196E
	STA.w MPAINT_Global_OAMBuffer[$00].Tile,x
	JSR.w CODE_00AF2C
	INX
	INX
	INX
	INX
	LDA.w $196A
	CLC
	ADC.w $196C
	STA.w $196C
	BRA.b CODE_00C0D9

CODE_00C10A:
	DEC.w $196E
	LDA.w $196E
	AND.w #$000F
	CMP.w #$000F
	BNE.b CODE_00C11E
	LDA.w #$3E01
	STA.w $196E
CODE_00C11E:
	LSR.w $196A
	BNE.b CODE_00C0D9
	STX.w $0446
	RTS

DATA_00C127:
	db $00,$01,$02,$03,$03,$04,$05,$06
	db $07,$07,$08,$09,$10,$10,$11,$12
	db $13,$14,$14,$15,$16,$17,$17,$18
	db $19,$20,$21,$21,$22,$23,$24,$24
	db $25,$26,$27,$28,$28,$29,$30,$31
	db $32,$32,$33,$34,$35,$35,$36,$37
	db $38,$39,$39,$40,$41,$42,$42,$43
	db $44,$45,$46,$46,$47,$48,$49,$49
	db $50,$51,$52,$53,$53,$54,$55,$56
	db $57,$57,$58,$59,$60,$60,$61,$62
	db $63,$64,$64,$65,$66,$67,$67,$68
	db $69,$70,$71,$71,$72,$73,$74,$74
	db $75,$76,$77,$78,$78,$79,$80,$81
	db $82,$82,$83,$84,$85,$85,$86,$87
	db $88,$89,$89,$90,$91,$92,$92,$93
	db $94,$95,$96,$96,$97,$98,$99

DATA_00C1A6:
	db $00,$01,$02,$03,$03,$04,$05,$06
	db $07,$07,$08,$09,$0A,$0A,$0B,$0C
	db $0D,$0E,$0E,$0F,$10,$11,$11,$12
	db $13,$14,$15,$15,$16,$17,$18,$18
	db $19,$1A,$1B,$1C,$1C,$1D,$1E,$1F
	db $20,$20,$21,$22,$23,$23,$24,$25
	db $26,$27,$27,$28,$29,$2A,$2A,$2B
	db $2C,$2D,$2E,$2E,$2F,$30,$31,$31
	db $32,$33,$34,$35,$35,$36,$37,$38
	db $39,$39,$3A,$3B,$3C,$3C,$3D,$3E
	db $3F,$40,$40,$41,$42,$43,$43,$44
	db $45,$46,$47,$47,$48,$49,$4A,$4A
	db $4B,$4C,$4D,$4E,$4E,$4F,$50,$51
	db $52,$52,$53,$54,$55,$55,$56,$57
	db $58,$59,$59,$5A,$5B,$5C,$5C,$5D
	db $5E,$5F,$60,$60,$61,$62,$63

;--------------------------------------------------------------------

CODE_00C225:
	PHP
	LDA.w $016C
	AND.w #$000F
	BNE.b CODE_00C235
	LDA.w #$0026
	JSL.l CODE_01D368
CODE_00C235:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	AND.w #$00FF
	PHA
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	AND.w #$00FF
	XBA
	ORA.b $01,S
	STA.b $01,S
	LDX.w $19EC
	BEQ.b CODE_00C25F
	CMP.w $19CE,x
	BNE.b CODE_00C25F
	INC.w $19F4
	LDA.w $19F4
	CMP.w #$00FF
	BEQ.b CODE_00C25F
	JMP.w CODE_00C2F8

CODE_00C25F:
	JSR.w CODE_00C2FB
	LDA.w $19F4
	BEQ.b CODE_00C282
	LDA.w $19CE,x
	PHA
	LDA.w $19F4
	STA.w $19CE,x
	INX
	PLA
	STA.w $19CE,x
	LDA.w $19F0
	ORA.w #$8000
	STA.w $19F0
	STZ.w $19F4
CODE_00C282:
	INX
	INX
	LDA.b $01,S
	STA.w $19CE,x
	STX.w $19EC
	LDA.w $19F0
	LSR
	BCS.b CODE_00C2AC
	ORA.w #$0080
	STA.w $19F0
	LDA.w $19F8
	LSR
	LDY.w !RAM_MPAINT_Global_CursorXPosLo
	CPY.w #$0100
	BCC.b CODE_00C2A7
	ORA.w #$8000
CODE_00C2A7:
	STA.w $19F8
	BRA.b CODE_00C2F8

CODE_00C2AC:
	SEP.b #$20
	LDA.w $19F1
	STA.w $19CE
	LDA.w $19F9
	STA.w $19CF
	LDY.w #$0000
	LDX.w $19EA
CODE_00C2C0:
	LDA.w $19CE,y
	STA.l $7E3800,x
	INY
	INX
	CPY.w $19EC
	BNE.b CODE_00C2C0
	REP.b #$20
	STX.w $19EA
	LDA.b $01,S
	STA.w $19D0
	LDA.w #$0002
	STA.w $19EC
	LDA.w #$0080
	STA.w $19F0
	STZ.w $19F4
	STZ.w $19F8
	LDY.w !RAM_MPAINT_Global_CursorXPosLo
CODE_00C2EC:
	CPY.w #$0100
	BCC.b CODE_00C2F8
	LDA.w #$8000
	STA.w $19F8
CODE_00C2F8:
	PLA
	PLP
	RTS

CODE_00C2FB:
	PHX
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0004
	BCC.b CODE_00C368
	CMP.w #$00FC
	BCS.b CODE_00C368
	STA.b $80
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$001C
	BCC.b CODE_00C368
	CMP.w #$00C4
	BCS.b CODE_00C368
	STA.b $82
	JSR.w CODE_00B305
	LDY.b $84
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	AND.w #$0007
	ASL
	TAX
	LDA.w DATA_00C36A,x
	PHA
	LDX.w #$0008
	LDA.w $19EA
	CLC
	ADC.w $19EC
	BEQ.b CODE_00C343
	INC.w $1974
	LDA.w $1974
	AND.w #$0001
	ASL
	ASL
	TAX
CODE_00C343:
	LDA.w DATA_00C37A,x
	PHA
	LDA.w DATA_00C37A+$02,x
	PHA
	LDA.b $01,S
	EOR.b [$0A],y
	AND.b $05,S
	EOR.b [$0A],y
	STA.b [$0A],y
	TYA
	CLC
	ADC.w #$0010
	TAY
	LDA.b $03,S
	EOR.b [$0A],y
	AND.b $05,S
	EOR.b [$0A],y
	STA.b [$0A],y
	PLA
	PLA
	PLA
CODE_00C368:
	PLX
	RTS

DATA_00C36A:
	dw $8080,$4040,$2020,$1010,$0808,$0404,$0202,$0101

DATA_00C37A:
	dw $0000,$00FF,$0000,$FF00,$00FF,$FFFF

;--------------------------------------------------------------------

CODE_00C386:
	LDA.w #$000F
	JSL.l CODE_01D368
	JSR.w CODE_008B18
	STZ.w $19EA
	STZ.w $19EC
	STZ.w $19F4
	STZ.w $19F8
	STZ.w $19F0
	LDX.w #$000E
CODE_00C3A2:
	PHX
	LDA.w #$0004
	STA.w $0446
	LDA.w DATA_00C3CE,x
	BMI.b CODE_00C3B8
	LDX.w #$00C0
	LDY.w #$0007
	JSL.l CODE_01F91E
CODE_00C3B8:
	JSL.l CODE_01E09B
	LDX.w #$0005
CODE_00C3BF:
	PHX
	JSL.l CODE_01E2CE
	PLX
	DEX
	BNE.b CODE_00C3BF
	PLX
	DEX
	DEX
	BPL.b CODE_00C3A2
	RTS

DATA_00C3CE:
	dw $FFFF,$00B6,$00B7,$00B7,$00B7,$00B7,$00B6,$FFFF

;--------------------------------------------------------------------

CODE_00C3DE:
	PHP
	LDA.w $19C2
	ASL
	TAX
	LDA.w DATA_00C40A,x
	PHA
	PHB
	SEP.b #$20
	LDA.b #DATA_028580>>16
	PHA
	PLB
	REP.b #$20
	LDY.w #$057E
	LDX.w #$057E
CODE_00C3F7:
	LDA.b ($02,S),y
	STA.l $7E20C0,x
	DEY
	DEY
	DEX
	DEX
	BPL.b CODE_00C3F7
	PLB
	STZ.w $19AC
	PLA
	PLP
	RTS

DATA_00C40A:
	dw DATA_028580,DATA_028B00,DATA_029080

;--------------------------------------------------------------------

CODE_00C410:
	JSR.w CODE_00C414
	RTL

CODE_00C414:
	LDX.w #$057E
CODE_00C417:
	LDA.l DATA_028000,x
	STA.l $7E20C0,x
	DEX
	DEX
	BPL.b CODE_00C417
	LDA.w #$FFFF
	STZ.w $19AC
	RTS

;--------------------------------------------------------------------

CODE_00C42A:
	LDA.b $AC
	BEQ.b CODE_00C433
	LDA.w #$0008
	BRA.b CODE_00C436

CODE_00C433:
	LDA.w #$0041
CODE_00C436:
	JSL.l CODE_01D368
	LDA.w $04D0
	STA.w $1A04
	LDA.w #$0009
	STA.w $04D0
	LDA.w #$0002
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	INC.w $09AB
	JSR.w CODE_00A363
	LDA.w #$0003
	STA.w $09D6
	RTS

;--------------------------------------------------------------------

CODE_00C460:
	JSR.w CODE_00BA69
	LDA.w #$7E2100
	PHA
	LDA.w #DATA_02A2C0
	PHA
	LDA.w #$0014
	PHA
	JSR.w CODE_00C490
	LDA.w #$0022
CODE_00C475:
	PHA
	JSL.l CODE_01F825
	PLA
	DEC
	CMP.w #$001B
	BPL.b CODE_00C475
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$0004
	STA.w $09D6
	RTS

;--------------------------------------------------------------------

CODE_00C490:
	PHD
	TSC
	SEC
	SBC.w #$0010
	TCS
	TCD
	LDA.b $15
	AND.w #$001F
	XBA
	LSR
	LSR
	STA.b $15
	LDA.b $17
	STA.b $01
	LDA.w #DATA_02A2C0>>16
	STA.b $03
	LDA.b $19
	STA.b $05
	LDA.w #$7E2100>>16
	STA.b $07
	LDY.w #$0000
CODE_00C4B7:
	LDA.b [$01],y
	CMP.w #$01FF
	BEQ.b CODE_00C4C0
	STA.b [$05],y
CODE_00C4C0:
	INY
	INY
	CPY.b $15
	BNE.b CODE_00C4B7
	TSC
	CLC
	ADC.w #$0010
	TCS
	PLD
	PLY
	TSC
	CLC
	ADC.w #$0006
	TCS
	PHY
CODE_00C4D5:
	RTS

;--------------------------------------------------------------------

CODE_00C4D6:
	LDA.w #$0022
CODE_00C4D9:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$001B
	BPL.b CODE_00C4D9
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00C4D5
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0040
	BCC.b CODE_00C553
	CMP.w #$00B0
	BCS.b CODE_00C553
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0028
	BCC.b CODE_00C553
	LDY.w #$0000
	CMP.w #$0048
	BCC.b CODE_00C516
	INY
	CMP.w #$0068
	BCC.b CODE_00C516
	INY
	CMP.w #$0088
	BCS.b CODE_00C553
CODE_00C516:
	CPY.w #$0000
	BNE.b CODE_00C520
	LDA.w #$0010
	BRA.b CODE_00C525

CODE_00C520:
	TYA
	CLC
	ADC.w #$0042
CODE_00C525:
	JSL.l CODE_01D368
	LDA.w #$0001
	STA.w $19FA
	LDA.w #!RAM_MPAINT_Canvas_AnimationCellGFXBuffer
	STA.b $0A
	STY.w $19C2
	TYA
	STA.l $7E3FFC
	CLC
	ADC.w #$001B
	ASL
	ASL
	ASL
	TAX
	LDA.w #$FFFF
	STA.w $1A15,x
	LDA.w #$0020
	JSR.w CODE_00C6C6
	JMP.w CODE_00C626

CODE_00C553:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00C5A6
	CMP.w #$00B0
	BCS.b CODE_00C5A6
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0098
	BCC.b CODE_00C5A6
	CMP.w #$00C0
	BCS.b CODE_00C5A6
	AND.w #$FFF8
	ASL
	ASL
	ASL
	PHA
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	AND.w #$FFF8
	LSR
	LSR
	CLC
	ADC.b $01,S
	TAX
	PLA
	LDA.l $7E2000,x
	CMP.w #$01FF
	BEQ.b CODE_00C5A6
	LDA.w #$0012
	JSL.l CODE_01D368
	LDA.w #$FFFF
	STA.w $1A1D
	LDA.w #$FFFF
	STA.w $1A25
	LDA.w #$0030
	JSR.w CODE_00C6C6
	JMP.w CODE_00BAAB

CODE_00C5A6:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$00C0
	BCC.b CODE_00C5FF
	CMP.w #$00F0
	BCS.b CODE_00C5FF
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0028
	BCC.b CODE_00C5FF
	CMP.w #$00B8
	BCS.b CODE_00C5FF
	AND.w #$FFF8
	ASL
	ASL
	ASL
	PHA
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	AND.w #$FFF8
	LSR
	LSR
	CLC
	ADC.b $01,S
	TAX
	PLA
	LDA.l $7E2000,x
	CMP.w #$01FF
	BEQ.b CODE_00C5FF
	LDA.w #$0011
	JSL.l CODE_01D368
	LDA.w #$FFFF
	STA.w $1B05
	LDA.w #$FFFF
	STA.w $1B0D
	LDA.w #$FFFF
	STA.w $1A15
	LDA.w #$00E0
	JSR.w CODE_00C6C6
	JMP.w CODE_00BE43

CODE_00C5FF:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCC.b CODE_00C625
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00C625
	CMP.w #$0017
	BCS.b CODE_00C625
	LDA.w #$0041
	JSL.l CODE_01D368
	STZ.w $19FA
	LDA.w #!RAM_MPAINT_Canvas_CanvasGFXBuffer
	STA.b $0A
	BRA.b CODE_00C626

CODE_00C625:
	RTS

CODE_00C626:
	STZ.b $20
	LDA.w $19FA
	BNE.b CODE_00C636
	LDA.w #$0007
	PHA
	JSR.w CODE_00C414
	BRA.b CODE_00C63D

CODE_00C636:
	LDA.w #$0003
	PHA
	JSR.w CODE_00C3DE
CODE_00C63D:
	JSL.l CODE_01DE97
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_01E09B
	LDA.w #DATA_01CE4B
	JSL.l CODE_01CDE1
	LDA.w $1A04
	STA.w $04D0
	SEP.b #$10
	LDX.b #$02
	STX.w $0105
	REP.b #$10
	STZ.w $09D6
	JSR.w CODE_00A451
	JSR.w CODE_00A525
	PLA
	STA.b $AA
	LDA.w $19FA
	BEQ.b CODE_00C69C
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BEQ.b CODE_00C690
	CMP.w #$0007
	BNE.b CODE_00C683
	DEC
CODE_00C683:
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	BRA.b CODE_00C69A

CODE_00C690:
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
CODE_00C69A:
	BRA.b CODE_00C6A9

CODE_00C69C:
	STZ.w $19C0
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
CODE_00C6A9:
	STZ.w $04CA
	LDA.w #$0004
	STA.w $0446
	LDA.w $04D0
	CMP.w #$0006
	BNE.b CODE_00C6BD
	INC.w $09AB
CODE_00C6BD:
	JSR.w CODE_00A363
	JSR.w CODE_00C873
	JMP.w CODE_008B03

CODE_00C6C6:
	PHA
	JSR.w CODE_008B48
	JSR.w CODE_009378
	LDA.w #$0004
	STA.w $0446
	LDA.w #$0022
CODE_00C6D6:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$001B
	BPL.b CODE_00C6D6
	JSL.l CODE_01E09B
	JSL.l CODE_01E2CE
	PLA
	DEC
	BNE.b CODE_00C6C6
	RTS

;--------------------------------------------------------------------

CODE_00C6EF:
	LDA.w #$0003
	JSL.l CODE_01D368
	LDA.b $AA
	EOR.w #$0007
	STA.b $AA
	CMP.w #$0004
	BEQ.b CODE_00C735
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BEQ.b CODE_00C76F
	CMP.w #$0007
	BNE.b CODE_00C713
	DEC
CODE_00C713:
	PHA
	PHA
	LDA.w #$0008
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	LDA.w #$0010
	JSL.l CODE_009C1B
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	RTS

CODE_00C735:
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BEQ.b CODE_00C74A
	CMP.w #$0010
	BNE.b CODE_00C78F
	LDA.w #$0001
	BRA.b CODE_00C74D

CODE_00C74A:
	LDA.w $19C0
CODE_00C74D:
	PHA
	PHA
	LDA.w #$0003
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	LDA.w #$0010
	JSL.l CODE_009C1B
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	RTS

CODE_00C76F:
	LDA.w #$0008
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	LDA.w #$0010
	JSL.l CODE_009C1B
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	RTS

CODE_00C78F:
	LDA.w #$0003
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	LDA.w #$0010
	JSL.l CODE_009C1B
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	RTS

;--------------------------------------------------------------------

CODE_00C7AF:
	LDA.w $0C24
	SEC
	SBC.w #$0010
	LSR
	PHA
	LSR
	CLC
	ADC.b $01,S
	STA.w $0EAE
	PLA
	LDA.w #$0000
	JSL.l CODE_01D328
	LDA.w #$0000
	JSL.l CODE_01D348
	STZ.w $0C2E
	STZ.w $0C30
	STZ.w $0E92
	STZ.w $0E90
	RTL

;--------------------------------------------------------------------

CODE_00C7DB:
	LDA.w $0E92
	BEQ.b CODE_00C84B
	LDA.w $0E90
	CMP.w $0EAE
	BNE.b CODE_00C7F3
	LDA.w $0C26
	BEQ.b CODE_00C865
	STZ.w $0E90
	LDA.w #$0000
CODE_00C7F3:
	TAX
	LDA.w $09E4,x
	BMI.b CODE_00C80E
	PHA
	PHX
	CLC
	ADC.w #$0100
	LSR
	LSR
	LSR
	LSR
	ORA.b $03,S
	AND.w #$00FF
	JSL.l CODE_01D328
	PLX
	PLA
CODE_00C80E:
	INX
	INX
	LDA.w $09E4,x
	BMI.b CODE_00C82A
	PHA
	PHX
	CLC
	ADC.w #$0100
	LSR
	LSR
	LSR
	LSR
	ORA.b $03,S
	AND.w #$00FF
	JSL.l CODE_01D348
	PLX
	PLA
CODE_00C82A:
	INX
	INX
	LDA.w $09E4,x
	BMI.b CODE_00C846
	PHA
	PHX
	CLC
	ADC.w #$0100
	LSR
	LSR
	LSR
	LSR
	ORA.b $03,S
	AND.w #$00FF
	JSL.l CODE_01D368
	PLX
	PLA
CODE_00C846:
	INX
	INX
	STX.w $0E90
CODE_00C84B:
	STZ.w $0E92
	LDA.w $0C2A
	CLC
	ADC.w $0C2E
	STA.w $0C2E
	LDA.w $0C2C
	ADC.w $0C30
	STA.w $0C30
	ROL.w $0E92
	RTS

CODE_00C865:
	STZ.w $0EAC
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	RTS

;--------------------------------------------------------------------

CODE_00C873:
	LDA.w $19FA
	BEQ.b CODE_00C8C1
	LDA.w $19C2
	ASL
	TAX
	LDA.w DATA_00C8C2,x
	TAY
	LDA.w DATA_00C8C8,x
	CLC
	ADC.w #DATA_00C8CE
	PHA
	LDX.w #$0000
CODE_00C88C:
	LDA.b ($01,S),y
	STA.w MPAINT_Global_OAMBuffer[$40].XDisp,x
	TYA
	LSR
	CLC
	ADC.w #$30B1
	STA.w MPAINT_Global_OAMBuffer[$40].Tile,x
	INX
	INX
	INX
	INX
	DEY
	DEY
	BPL.b CODE_00C88C
	PLA
CODE_00C8A3:
	LDA.w $19C2
	ASL
	ASL
	TAX
	LDA.w DATA_00C8F4,x
	AND.w MPAINT_Global_UpperOAMBuffer[$10].Slot
	STA.w MPAINT_Global_UpperOAMBuffer[$10].Slot
	LDA.w DATA_00C8F4+$02,x
	AND.w MPAINT_Global_UpperOAMBuffer[$12].Slot
	STA.w MPAINT_Global_UpperOAMBuffer[$12].Slot
	LDA.w #$0078
	STA.w $0545
CODE_00C8C1:
	RTS

DATA_00C8C2:
	dw $0006,$000A,$0010

DATA_00C8C8:
	dw $0000,$0008,$0014

DATA_00C8CE:
	dw $2008,$2088,$7808,$7888,$2010,$2060,$20B0,$7810
	dw $7860,$78B0,$2010,$2060,$20B0,$5810,$5860,$58B0
	dw $9010,$9060,$90B0

DATA_00C8F4:
	dw $FF00,$FFFF,$F000,$FFFF,$0000,$FFFC

;--------------------------------------------------------------------

CODE_00C900:
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00C92F
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	SEC
	SBC.w #$0030
	BCC.b CODE_00C92F
	LSR
	LSR
	LSR
	LSR
	LSR
	CMP.w #$0004
	BCC.b CODE_00C926
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCC.b CODE_00C92F
	LDA.w #$0004
CODE_00C926:
	STA.w $1B1A
	DEC.w $1B1A
	JSR.w CODE_00C93C
CODE_00C92F:
	LDA.w #$0009
CODE_00C932:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	BPL.b CODE_00C932
	RTS

CODE_00C93C:
	ASL
	TAX
	JMP.w (DATA_00C941,x)

DATA_00C941:
	dw CODE_00CA76
	dw CODE_00C94B
	dw CODE_00C94B
	dw CODE_00C94B
	dw CODE_00CA76

;--------------------------------------------------------------------

CODE_00C94B:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0040
	BCS.b CODE_00C956
	JMP.w CODE_00C9E2

CODE_00C956:
	CMP.w #$00C0
	BCC.b CODE_00C95E
	JMP.w CODE_00C9E2

CODE_00C95E:
	LDA.w $1B1A
	CMP.w $04C4
	BEQ.b CODE_00C9E2
	LDA.w $1B1A
	BNE.b CODE_00C970
	LDA.w #$0017
	BRA.b CODE_00C974

CODE_00C970:
	CLC
	ADC.w #$0044
CODE_00C974:
	JSL.l CODE_01D368
	LDA.w $04C4
	CLC
	ADC.w #$0001
	ASL
	ASL
	ASL
	TAX
	LDA.l DATA_0DEB27,x
	STA.w $1A15,x
	LDA.w $04C4
	CLC
	ADC.w #$0004
	ASL
	ASL
	ASL
	TAX
	LDA.w #$06FF
	STA.w $1A15,x
	LDA.w $04C4
	CLC
	ADC.w #$0007
	ASL
	ASL
	ASL
	TAX
	LDA.w #$05FF
	STA.w $1A15,x
	LDA.w $1B1A
	STA.w $04C4
	CLC
	ADC.w #$0001
	ASL
	ASL
	ASL
	TAX
	LDA.w #$FFFF
	STA.w $1A15,x
	LDA.w $1B1A
	CLC
	ADC.w #$0004
	ASL
	ASL
	ASL
	TAX
	LDA.w #$FFFF
	STA.w $1A15,x
	LDA.w $1B1A
	CLC
	ADC.w #$0007
	ASL
	ASL
	ASL
	TAX
	LDA.w #$FFFF
	STA.w $1A15,x
CODE_00C9E2:
	RTS

;--------------------------------------------------------------------

CODE_00C9E3:
	LDA.w #$0006
	JSL.l CODE_01D368
	LDA.w #DATA_01CFA9
	JSL.l CODE_01CDE1
	LDA.w #$7E2100
	PHA
	LDA.w #DATA_02A7C0
	PHA
	LDA.w #$0013
	PHA
	JSR.w CODE_00C490
	LDA.w #$0009
CODE_00CA03:
	PHA
	JSL.l CODE_01F825
	PLA
	DEC
	BPL.b CODE_00CA03
	LDA.w $04C4
	CLC
	ADC.w #$0001
	ASL
	ASL
	ASL
	TAX
	LDA.w #$FFFF
	STA.w $1A15,x
	LDA.w $04C4
	CLC
	ADC.w #$0004
	ASL
	ASL
	ASL
	TAX
	LDA.w #$01FF
	STA.w $1A15,x
	LDA.w $04C4
	CLC
	ADC.w #$0007
	ASL
	ASL
	ASL
	TAX
	LDA.w #$FFFF
	STA.w $1A15,x
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	INC.w $1B18
	LDA.w #$000D
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	INC.w $09AB
	JSR.w CODE_00A363
	LDA.w $04D0
	STA.w $1B12
	LDA.w #$0009
	STA.w $04D0
	LDA.w $09D6
	STA.w $09D8
	LDA.w #$0001
	STA.w $09D6
	RTS

;--------------------------------------------------------------------

CODE_00CA76:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCC.b CODE_00CAD6
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00CAD6
	CMP.w #$0017
	BCS.b CODE_00CAD6
	LDA.w #$0041
	JSL.l CODE_01D368
	LDA.w $19FA
	BNE.b CODE_00CA9C
	JSR.w CODE_00C414
	BRA.b CODE_00CA9F

CODE_00CA9C:
	JSR.w CODE_00C3DE
CODE_00CA9F:
	JSL.l CODE_01DE97
	JSL.l CODE_01E06F
	JSL.l CODE_01E2CE
	LDA.w $1B12
	STA.w $04D0
	LDA.w #$0007
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	LDA.w $04D0
	CMP.w #$0006
	BNE.b CODE_00CAC9
	INC.w $09AB
CODE_00CAC9:
	JSR.w CODE_00A363
	STZ.w $1B18
	LDA.w $09D8
	STA.w $09D6
	PLA
CODE_00CAD6:
	RTS

;--------------------------------------------------------------------

CODE_00CAD7:
	LDA.w #$0002
	JSL.l CODE_01D368
	LDA.w $09D6
	STA.w $09D8
	LDA.w #$0002
	STA.w $09D6
	LDA.w $04D0
	STA.w $1990
	LDA.w #$0009
	STA.w $04D0
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	STA.w $1B14
	LDA.w #$0009
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w $04D0
	AND.w #$FF00
	XBA
	STA.b $A8
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CMP.w #$0070
	BCS.b CODE_00CB24
	LDA.b $A8
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B66C
	BRA.b CODE_00CB2B

CODE_00CB24:
	LDA.b $A8
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B6F4
CODE_00CB2B:
	JMP.w CODE_00A363

CODE_00CB2E:
	LDA.w $04CA
	BIT.w #$0020
	BNE.b CODE_00CB37
	RTS

CODE_00CB37:
	LDA.w #$0041
	JSL.l CODE_01D368
	LDY.w $19FA
	BEQ.b CODE_00CB62
	LDA.w $1990
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_00CB5D
	LDA.w $19C0
	PHA
	LDA.w #$0004
	STA.b $AA
	PHA
	LDA.w #$0001
	BRA.b CODE_00CB6B

CODE_00CB5D:
	LDA.w #$0004
	BRA.b CODE_00CB65

CODE_00CB62:
	LDA.w #$0007
CODE_00CB65:
	STA.b $AA
	PHA
	LDA.w #$0000
CODE_00CB6B:
	PHA
	JSR.w CODE_009FC4
	LDA.w $09D8
	STA.w $09D6
	LDA.w $1B14
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	LDA.w $1990
	STA.w $04D0
	AND.w #$00FF
	CMP.w #$0005
	BEQ.b CODE_00CB99
	CMP.w #$0007
	BEQ.b CODE_00CBE1
	CMP.w #$0003
	BNE.b CODE_00CB99
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CMP.w #$0070
	BCS.b CODE_00CBC9
CODE_00CB99:
	LDA.w $04D0
	AND.w #$FF00
	XBA
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B66C
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0008
	BEQ.b CODE_00CBB5
	JSR.w CODE_00B6F4
	BRA.b CODE_00CBBB

CODE_00CBB5:
	LDA.w $198A
	JSR.w CODE_00B6F4
CODE_00CBBB:
	LDA.w $04D0
	CMP.w #$0006
	BNE.b CODE_00CBC6
	INC.w $09AB
CODE_00CBC6:
	JMP.w CODE_00A363

CODE_00CBC9:
	LDA.w $04D0
	AND.w #$FF00
	XBA
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B6F4
	LDA.w #$000D
	JSR.w CODE_00B66C
	JSR.w CODE_00A363
	JMP.w CODE_00A451

CODE_00CBE1:
	LDA.w #$0001
	STA.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$000F
	JSR.w CODE_00B66C
	LDA.w !RAM_MPAINT_Canvas_EraseToolSize
	CLC
	ADC.w #$0008
	JSR.w CODE_00B6F4
	LDA.w #$0007
	STA.w $04D0
	JSR.w CODE_00A525
	STZ.b $AE
	LDA.w $04D0
	CMP.w #$0006
	BNE.b CODE_00CC0D
	INC.w $09AB
CODE_00CC0D:
	JMP.w CODE_00A363

CODE_00CC10:
	LDA.w $04CA
	BIT.w #$0011
	BEQ.b CODE_00CC5A
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0018
	BCC.b CODE_00CC4A
	CMP.w #$00C8
	BCC.b CODE_00CC5A
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00CC5A
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00CC5A
	CMP.w #$0017
	BCC.b CODE_00CC47
	CMP.w #$00D8
	BCC.b CODE_00CC5A
	CMP.w #$00E7
	BCS.b CODE_00CC5A
	JMP.w CODE_009760

CODE_00CC47:
	JMP.w CODE_00CB2E

CODE_00CC4A:
	JSR.w CODE_008D2C
	CPX.w #$0001
	BEQ.b CODE_00CC5B
	CPX.w #$0002
	BNE.b CODE_00CC5A
	JSR.w CODE_00CDCC
CODE_00CC5A:
	RTS

CODE_00CC5B:
	STA.b $A8
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00CC5A
	LDA.w #$0004
	JSL.l CODE_01D368
	JSR.w CODE_008B03
	INC.w $09A7
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CMP.w #$0070
	BCS.b CODE_00CC88
	LDA.b $A8
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B66C
	JSR.w CODE_00E64F
	LDA.w #$1CAA
	BRA.b CODE_00CC95

CODE_00CC88:
	LDA.b $A8
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B6F4
	JSR.w CODE_00E64F
	LDA.w #$1C2A
CODE_00CC95:
	PHA
	STZ.w $0206
	LDY.w #$5FFE
	LDX.w #$003E
CODE_00CC9F:
	JSR.w CODE_00CCE1
	BCS.b CODE_00CCBB
	PHA
	PHY
	PHX
	TYA
	AND.w #$0400
	LSR
	LSR
	LSR
	LSR
	ORA.b $01,S
	TAY
	LDA.b ($07,S),y
	PLX
	PLY
	AND.b $01,S
	STA.b [$0A],y
	PLA
CODE_00CCBB:
	DEX
	DEX
	TXA
	AND.w #$003F
	TAX
	DEY
	DEY
	BPL.b CODE_00CC9F
	PLA
	LDA.w #$0072
	JSL.l CODE_01D368
	STZ.w $0208
	INC.w $0206
CODE_00CCD4:
	JSL.l CODE_01E2CE
	LDA.w $0208
	BNE.b CODE_00CCD4
	STZ.w $09A7
	RTS

CODE_00CCE1:
	PHX
	PHY
	LDA.w $19FA
	BEQ.b CODE_00CCEC
	LDA.w $19C2
	INC
CODE_00CCEC:
	ASL
	PHA
	ASL
	CLC
	ADC.b $01,S
	TAX
	PLA
	LDA.w DATA_00CD3C,x
	PHA
	LDY.w DATA_00CD3C+$02,x
	LDA.b $03,S
	AND.w #$FC0F
CODE_00CD00:
	CMP.b ($01,S),y
	DEY
	DEY
	BCS.b CODE_00CD0A
	CMP.b ($01,S),y
	BCS.b CODE_00CD10
CODE_00CD0A:
	DEY
	DEY
	BPL.b CODE_00CD00
	BRA.b CODE_00CD2E

CODE_00CD10:
	LDY.w DATA_00CD3C+$04,x
CODE_00CD13:
	LDA.b $03,S
	AND.w #$03E0
	CMP.b ($01,S),y
	BEQ.b CODE_00CD33
	DEY
	DEY
	DEY
	DEY
	TYA
	CMP.w DATA_00CD3C+$02,x
	BPL.b CODE_00CD13
	PLA
	PLY
	PLX
	LDA.w #$FFFF
	CLC
	RTS

CODE_00CD2E:
	PLA
	PLY
	PLX
	SEC
	RTS

CODE_00CD33:
	INY
	INY
	LDA.b ($01,S),y
	PLY
	PLY
	PLX
	CLC
	RTS

DATA_00CD3C:
	dw DATA_00CD54,$0002,$0008
	dw DATA_00CD60,$0006,$0014
	dw DATA_00CD78,$0006,$0024
	dw DATA_00CDA0,$000A,$0028

DATA_00CD54:
	dw $0408,$5808,$0000,$0F0F,$03E0,$F0F0

DATA_00CD60:
	dw $0408,$2C08,$3008,$5808,$0000,$0F0F,$01E0,$F0F0
	dw $0200,$0F0F,$03E0,$F0F0

DATA_00CD78:
	dw $0408,$2C08,$3008,$5808,$0000,$0000,$0020,$0F0F
	dw $0140,$F0F0,$0160,$0F0F,$0280,$F0F0,$02A0,$0F0F
	dw $03C0,$F0F0,$03E0,$0000

DATA_00CDA0:
	dw $0408,$1C08,$2008,$3808,$3C08,$5408,$0000,$0000
	dw $0020,$0F0F,$0140,$F0F0,$0160,$0F0F,$0280,$F0F0
	dw $02A0,$0F0F,$03C0,$F0F0,$03E0,$0000

;--------------------------------------------------------------------

CODE_00CDCC:
	LDY.w #$0010
	LDA.w $04CA
	AND.w #$0044
	BNE.b CODE_00CDD8
	RTS

CODE_00CDD8:
	BIT.w #$0040
	BNE.b CODE_00CDE0
	LDY.w #$FFF0
CODE_00CDE0:
	PHY
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CLC
	ADC.b $01,S
	CMP.w #$0060
	BNE.b CODE_00CDEE
	CLC
	ADC.b $01,S
CODE_00CDEE:
	AND.w #$00F0
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	LSR
	LSR
	LSR
	LSR
	CMP.w #$0006
	BCC.b CODE_00CDFD
	DEC
CODE_00CDFD:
	CLC
	ADC.w #$0062
	JSL.l CODE_01D368
	PLY
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CMP.w #$0070
	BCS.b CODE_00CE16
	LDA.b $A8
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B66C
	BRA.b CODE_00CE1D

CODE_00CE16:
	LDA.b $A8
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B6F4
CODE_00CE1D:
	JSR.w CODE_00A363
	PLA
	RTS

CODE_00CE22:
	LDA.w #$0006
	JSL.l CODE_01D368
	LDA.w $04D0
	STA.w $1976
	LDA.w #$0011
	STA.w $04D0
	JSR.w CODE_009378
	LDA.w $09D6
	STA.w $09D8
	JSL.l CODE_00D6D3
	LDA.w #$0018
	JSL.l CODE_01F825
	LDA.w $1982
	BEQ.b CODE_00CE5A
	LDA.w #$FFFF
	STA.w $1AD5
	STZ.w $1984
	STZ.w $1986
CODE_00CE5A:
	LDA.w $1012
	STA.w $09AD
CODE_00CE60:
	JSR.w CODE_00C414
	LDA.w #DATA_01CF16
	JSL.l CODE_01CDE1
	LDA.w #DATA_01CE74
	JSL.l CODE_01CDE1
	LDA.w #$7E2100
	PHA
	LDA.w #DATA_02B700
	PHA
	LDA.w #$0014
	PHA
	JSR.w CODE_00C490
	LDX.w #$007E
CODE_00CE83:
	LDA.w DATA_00CEC0,x
	STA.l $7E2040,x
	DEX
	DEX
	BPL.b CODE_00CE83
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$000C
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	LDA.w #$000D
CODE_00CEA6:
	PHA
	JSL.l CODE_01F825
	PLA
	DEC
	CMP.w #$000A
	BPL.b CODE_00CEA6
	LDA.w #$0030
	JSL.l CODE_01F825
	LDA.w #$0006
	STA.w $09D6
	RTS

DATA_00CEC0:
	dw $21EE,$21EE,$21EE,$21EE,$21EE,$21EE,$21EE,$21EE
	dw $21EE,$21EE,$201F,$2054,$2055,$2056,$2057,$2055
	dw $2060,$2061,$207E,$201F,$201F,$201F,$201F,$21EE
	dw $21EE,$21EE,$21EE,$21EE,$21EE,$21EE,$21EE,$21EE
	dw $21EE,$21EE,$21EE,$21EE,$21EE,$21EE,$21EE,$21EE
	dw $21EE,$21EE,$201F,$2064,$2065,$2066,$2067,$2065
	dw $2062,$2063,$207F,$201F,$201F,$201F,$201F,$21EE
	dw $21EE,$21EE,$21EE,$21EE,$21EE,$21EE,$21EE,$21EE

;--------------------------------------------------------------------

DATA_00CF40:
	dw $2844,$2845,$2846,$2847

DATA_00CF48:
	dw $3448,$3449,$344A,$344B

;--------------------------------------------------------------------

CODE_00CF50:
	LDA.w #$0041
	JSL.l CODE_01D368
	LDA.w $055F
	BNE.b CODE_00CF5C			;\ Optimization: Redundant branch.
CODE_00CF5C:					;/
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_01E09B
	LDA.w #DATA_01CE4B
	JSL.l CODE_01CDE1
	LDA.w $1976
	STA.w $04D0
	JSR.w CODE_00A451
	JSR.w CODE_00A525
	JSR.w CODE_0089C3
	JSR.w CODE_00C414
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$0007
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	LDA.w $09D8
	STA.w $09D6
	RTS

;--------------------------------------------------------------------

CODE_00CF9B:
	LDA.w $04CA
	BIT.w #$0020
	BNE.b CODE_00CFA6
	JMP.w CODE_00D03A

CODE_00CFA6:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0048
	BCC.b CODE_00CFD9
	CMP.w #$00B0
	BCS.b CODE_00CFD9
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0048
	BCC.b CODE_00CFD9
	CMP.w #$0068
	BCC.b CODE_00CFF1
	LDY.w $1982
	BEQ.b CODE_00CFCF
	CMP.w #$0070
	BCC.b CODE_00CFD9
	CMP.w #$0090
	BCC.b CODE_00D009
CODE_00CFCF:
	CMP.w #$0098
	BCC.b CODE_00CFD9
	CMP.w #$00B8
	BCC.b CODE_00D021
CODE_00CFD9:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCC.b CODE_00D03A
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00D03A
	CMP.w #$0017
	BCS.b CODE_00D03A
	JMP.w CODE_00CF50

CODE_00CFF1:
	LDA.w #$FFFF
	STA.w $1A65
	STA.w $1A75
	LDA.w #$0007
	STA.w $09D6
	LDA.w #$000D
	JSL.l CODE_01D368
	BRA.b CODE_00D03A

CODE_00D009:
	LDA.w #$FFFF
	STA.w $1A6D
	STA.w $1A7D
	LDA.w #$0009
	STA.w $09D6
	LDA.w #$000E
	JSL.l CODE_01D368
	BRA.b CODE_00D03A

CODE_00D021:
	LDA.w #$FFFF
	STA.w $1A95
	LDA.w #$0040
	STA.w $0563
	LDA.w #$000B
	STA.w $09D6
	LDA.w #$000E
	JSL.l CODE_01D368
CODE_00D03A:
	JMP.w CODE_00D824

;--------------------------------------------------------------------

CODE_00D03D:
	RTS

;--------------------------------------------------------------------

CODE_00D03E:
	JSR.w CODE_00D824
	LDA.w $1A76
	AND.w #$00FF
	CMP.w #$0008
	BNE.b CODE_00D068
	LDX.w #$0006
CODE_00D04F:
	LDA.w DATA_00CF40,x
	STA.l $7E208A,x
	DEX
	DEX
	BPL.b CODE_00D04F
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$0008
	STA.w $09D6
CODE_00D068:
	RTS

;--------------------------------------------------------------------

CODE_00D069:
	STZ.w $0206
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_01E09B
	JSR.w CODE_00C414
	JSL.l CODE_01DE97
	LDA.w #$0018
	JSL.l CODE_01F84F
	JSL.l CODE_01E2CE
	LDA.w #$00D0
	STA.w !RAM_MPAINT_Global_CursorYPosLo
	SEP.b #$20
	LDA.w $0105
	ORA.b #$20
	STA.w $0105
	REP.b #$20
	LDA.w #$0000
	STA.w $055F
	LDA.w #$F86A
	STA.w $0555
	STZ.w $0557
	JSR.w CODE_00D842
	LDA.w #$0090
	STA.w $1980
	LDA.w #$0004
	STA.w $0446
	JSR.w CODE_00D590
	JSL.l CODE_01E09B
	LDA.w #$0001
	STA.w $0220
	SEP.b #$20
	LDA.b #$22
	STA.w $0111
	REP.b #$20
	JSR.w CODE_00D73C
CODE_00D0D1:
	JSL.l CODE_01E2CE
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_00D5F5
	JSL.l CODE_01E09B
	JSR.w CODE_008B48
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCS.b CODE_00D0F4
	LDA.w #$00C8
	STA.w !RAM_MPAINT_Global_CursorYPosLo
CODE_00D0F4:
	JSR.w CODE_009378
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00D0D1
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCC.b CODE_00D0D1
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00D0D1
	CMP.w #$0017
	BCS.b CODE_00D126
	LDA.w $055F
	BEQ.b CODE_00D11C
	JMP.w CODE_00D2A4

CODE_00D11C:
	LDA.w #$0041
	JSL.l CODE_01D368
	JMP.w CODE_00D2A4

CODE_00D126:
	CMP.w #$0070
	BCC.b CODE_00D0D1
	CMP.w #$0090
	BCS.b CODE_00D0D1
	LDA.l $00055F
	BNE.b CODE_00D0D1
	LDA.w #$0012
	JSL.l CODE_01D368
	LDA.w #$0007
	STA.w $09AD
	JSL.l CODE_01D2BF
	LDA.w #DATA_00D559
	JSR.w CODE_00D52C
	LDA.w #$0091
	STA.w $1980
	LDA.w #$03FF
	STA.w $1AD5
	JSR.w CODE_00C414
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDX.w #$07FE
CODE_00D167:
	LDA.l $7E3800,x
	STA.l $7E9C00,x
	DEX
	DEX
	BPL.b CODE_00D167
	LDX.w #$024E
CODE_00D176:
	LDA.l $0009E4,x
	STA.l $7EFC00,x
	DEX
	DEX
	BPL.b CODE_00D176
	LDA.w #$D5F4
	STA.w $0549
	LDA.w #$0000
	STA.w $054B
	LDA.w #$0002
	STA.w $054D
	JSL.l CODE_01EDDB
	STA.w $055F
	CMP.w #$0000
	BNE.b CODE_00D1E2
	STZ.w $0557
	LDA.l $7F0002
	PHA
	ASL
	ROL.w $0557
	CLC
	ADC.w #$0200
	STA.w $0555
	LDA.w $0557
	ADC.w #$0000
	STA.w $0557
	JSR.w CODE_00D842
	ASL.w $0559
	ROL.w $055B
	ASL.w $0559
	ROL.w $055B
	JSL.l CODE_01F03A
	STA.w $055F
	PLA
	STA.l $7F0002
	CMP.w #$7800
	BCC.b CODE_00D1E2
	LDA.w #$FFFF
	STA.w $055F
CODE_00D1E2:
	LDA.w $055F
	BEQ.b CODE_00D1F2
	LDA.w #$0000
	STA.w $055D
	JSR.w CODE_00D75B
	BRA.b CODE_00D263

CODE_00D1F2:
	LDA.w #$7003
	STA.w $197C
	LDA.w #$2122
	STA.w $197E
	LDX.w #$77FE
	CLC
CODE_00D202:
	LDA.l $7F2000,x
	PHA
	ADC.w $197C
	STA.w $197C
	LDA.b $01,S
	EOR.w $197E
	STA.w $197E
	PLA
	STA.l $700800,x
	DEX
	DEX
	BPL.b CODE_00D202
	LDA.l $7F0002
	STA.l $7007FE
	PHA
	LDA.w $197C
	ADC.b $01,S
	STA.l $7007C2
	LDA.w $197E
	EOR.b $01,S
	STA.l $7007C4
	PLA
	LDA.w #$0001
	STA.w $1982
	JSL.l CODE_01E2CE
CODE_00D244:
	LDA.w $1ACE
	AND.w #$00FF
	CMP.w #$002B
	BEQ.b CODE_00D263
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_00D5F5
	JSL.l CODE_01E09B
	JSL.l CODE_01E2CE
	BRA.b CODE_00D244

CODE_00D263:
	LDA.w $055F
	BNE.b CODE_00D26E
	LDA.w #DATA_00D564
	JSR.w CODE_00D52C
CODE_00D26E:
	LDA.w #$0090
	STA.w $1980
	LDA.w #$0080
	JSR.w CODE_00D514
	LDA.w $055F
	BNE.b CODE_00D28B
	LDA.w #$06FF
	STA.w $1A8D
	LDA.w #$FFFF
	STA.w $1AD5
CODE_00D28B:
	LDA.w $1012
	CMP.w $09AD
	BEQ.b CODE_00D29C
	JSL.l CODE_01D3AB
CODE_00D297:
	LDA.w $053A
	BNE.b CODE_00D297
CODE_00D29C:
	LDA.w $055F
	BEQ.b CODE_00D2A4
	JMP.w CODE_00D0D1

CODE_00D2A4:
	LDA.w $055F
	BNE.b CODE_00D2BC
	LDA.w #$0041
	JSL.l CODE_01D368
	LDA.w #$FFFF
	STA.w $058D
	LDA.w #$0040
	JSR.w CODE_00D514
CODE_00D2BC:
	LDA.w #$FFFF
	STA.w $0220
	LDA.w #$0004
	STA.w $0446
	LDA.w #$0018
	JSL.l CODE_01F84F
	JSL.l CODE_01E09B
	SEP.b #$20
	LDA.w $0105
	AND.b #$DF
	STA.w $0105
	REP.b #$20
	INC.w $0206
	LDA.w #$0001
	STA.w $058D
	JSR.w CODE_008B03
	LDA.w $055F
	BNE.b CODE_00D2F3
	JMP.w CODE_00CE60

CODE_00D2F3:
	JMP.w CODE_00CF50

;--------------------------------------------------------------------

CODE_00D2F6:
	JSR.w CODE_00D824
	LDA.w $1A7E
	AND.w #$00FF
	CMP.w #$0008
	BNE.b CODE_00D320
	LDX.w #$0006
CODE_00D307:
	LDA.w DATA_00CF48,x
	STA.l $7E208A,x
	DEX
	DEX
	BPL.b CODE_00D307
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$000A
	STA.w $09D6
CODE_00D320:
	RTS

;--------------------------------------------------------------------

CODE_00D321:
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_01E09B
	JSR.w CODE_00C414
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$00D0
	STA.w !RAM_MPAINT_Global_CursorYPosLo
	SEP.b #$20
	LDA.w $0105
	ORA.b #$20
	STA.w $0105
	REP.b #$20
	LDA.l $7007FE
	SEC
	SBC.w #$0800
	LSR
	CLC
	ADC.w #$BA50
	STA.w $0555
	STZ.w $0557
	JSR.w CODE_00D842
	LDA.w #$0090
	STA.w $1980
	LDA.w #$0004
	STA.w $0446
	JSR.w CODE_00D590
	JSL.l CODE_01E09B
	LDA.w #$0001
	STA.w $0220
	SEP.b #$20
	LDA.b #$22
	STA.w $0111
	REP.b #$20
	JSR.w CODE_00D73C
CODE_00D383:
	JSL.l CODE_01E2CE
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_00D5F5
	JSL.l CODE_01E09B
	JSR.w CODE_008B48
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCS.b CODE_00D3A6
	LDA.w #$00C8
	STA.w !RAM_MPAINT_Global_CursorYPosLo
CODE_00D3A6:
	JSR.w CODE_009378
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00D383
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCC.b CODE_00D383
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00D383
	CMP.w #$0017
	BCS.b CODE_00D3D0
	LDA.w #$0041
	JSL.l CODE_01D368
	JMP.w CODE_00D4C3

CODE_00D3D0:
	CMP.w #$0070
	BCC.b CODE_00D383
	CMP.w #$0090
	BCS.b CODE_00D383
	LDA.w $1982
	BEQ.b CODE_00D383
	LDA.w #$0012
	JSL.l CODE_01D368
	LDA.w #$0007
	STA.w $09AD
	JSL.l CODE_01D2BF
	LDA.w #DATA_00D57A
	JSR.w CODE_00D52C
	LDA.w #$0091
	STA.w $1980
	LDA.w #$09FF
	STA.w $1A8D
	LDX.w #$77FE
CODE_00D405:
	LDA.l $700800,x
	STA.l $7F2000,x
	DEX
	DEX
	BPL.b CODE_00D405
	LDA.w #$D5F4
	STA.w $0549
	LDA.w #$0000
	STA.w $054B
	LDA.w #$0002
	STA.w $054D
	LDA.l $7007FE
	PHA
	JSL.l CODE_01F21D
	JSL.l CODE_01EF36
	PLA
	LDX.w #$07FE
CODE_00D434:
	LDA.l $7E9C00,x
	STA.l $7E3800,x
	DEX
	DEX
	BPL.b CODE_00D434
	LDX.w #$024E
CODE_00D443:
	LDA.l $7EFC00,x
	STA.l $0009E4,x
	DEX
	DEX
	BPL.b CODE_00D443
	LDA.l $7E3FFA
	STA.w $19EC
	LDA.l $7E3FFC
	STA.w $19C2
	LDA.l $7E3FFE
	STA.w $1A08
	JSL.l CODE_01E2CE
CODE_00D468:
	LDA.w $1ABE
	AND.w #$00FF
	CMP.w #$000E
	BEQ.b CODE_00D487
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_00D5F5
	JSL.l CODE_01E09B
	JSL.l CODE_01E2CE
	BRA.b CODE_00D468

CODE_00D487:
	LDA.w #DATA_00D585
	JSR.w CODE_00D52C
	LDA.w #$0090
	STA.w $1980
CODE_00D493:
	LDA.w $1AB6
	AND.w #$00FF
	CMP.w #$000B
	BEQ.b CODE_00D4B2
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_00D5F5
	JSL.l CODE_01E09B
	JSL.l CODE_01E2CE
	BRA.b CODE_00D493

CODE_00D4B2:
	LDA.w $1012
	CMP.w $09AD
	BEQ.b CODE_00D4C3
	JSL.l CODE_01D3AB
CODE_00D4BE:
	LDA.w $053A
	BNE.b CODE_00D4BE
CODE_00D4C3:
	LDA.w #$0041
	JSL.l CODE_01D368
	LDA.w #$FFFF
	STA.w $058D
	LDA.w #$0040
	JSR.w CODE_00D514
	LDA.w #$FFFF
	STA.w $0220
	LDA.w #$0004
	STA.w $0446
	LDA.w #$0018
	JSL.l CODE_01F84F
	JSL.l CODE_01E09B
	SEP.b #$20
	LDA.w $0105
	AND.b #$DF
	STA.w $0105
	REP.b #$20
	LDA.w #$0001
	STA.w $058D
	JSR.w CODE_008B03
	JMP.w CODE_00CE60

;--------------------------------------------------------------------

CODE_00D505:
	JSR.w CODE_00D824
	JSL.l CODE_01EB81
	RTS

;--------------------------------------------------------------------

CODE_00D50D:
	JSL.l CODE_01EBB5
	JMP.w CODE_00CE60

;--------------------------------------------------------------------

CODE_00D514:
	PHA
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_00D5F5
	JSL.l CODE_01E09B
	JSL.l CODE_01E2CE
	PLA
	DEC
	BNE.b CODE_00D514
	RTS

;--------------------------------------------------------------------

CODE_00D52C:
	PHA
	LDY.w #$0009
	LDX.w #$0048
CODE_00D533:
	LDA.b ($01,S),y
	AND.w #$00FF
	ORA.w #$FF00
	XBA
	STA.w $1A85,x
	TXA
	SEC
	SBC.w #$0008
	TAX
	DEY
	BPL.b CODE_00D533
	LDY.w #$000A
	LDA.b ($01,S),y
	AND.w #$00FF
	ORA.w #$FF00
	XBA
	STA.w $1ADD
	PLA
	RTS


DATA_00D559:
	db $FF,$FF,$FF,$FF,$FF,$FF,$04,$0F
	db $FF,$FF,$07

DATA_00D564:
	db $09,$09,$05,$06,$03,$05,$04,$0F
	db $0C,$2C,$07

DATA_00D56F:
	db $0C,$0D,$05,$09,$06,$05,$04,$0F
	db $0C,$2C,$FF

DATA_00D57A:
	db $FF,$06,$FF,$FF,$FF,$FF,$FF,$FF
	db $0C,$2C,$07

DATA_00D585:
	db $09,$06,$05,$06,$03,$05,$07,$0F
	db $0C,$2C,$07

;--------------------------------------------------------------------

CODE_00D590:
	JSR.w CODE_00D659
	LDA.w $1980
	BMI.b CODE_00D5A2
	LDX.w #$0070
	LDY.w #$00CC
	JSL.l CODE_01F91E
CODE_00D5A2:
	LDX.w #$0049
	LDY.w #$00AE
	LDA.w #$008C
	JSL.l CODE_01F91E
	LDA.w #$0016
CODE_00D5B2:
	PHA
	JSL.l CODE_01F825
	PLA
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$000E
	BPL.b CODE_00D5B2
	LDA.w #$0019
	JSL.l CODE_01F825
	LDA.w #$0019
	JSL.l CODE_01F84F
	LDX.w #$0080
	LDY.w #$007A
	LDA.w #$0045
	JSL.l CODE_01F91E
	LDA.w #$0017
	JSL.l CODE_01F825
	LDA.w #$0017
	JSL.l CODE_01F84F
	LDA.w #$0018
	JSL.l CODE_01F84F
	RTS

;--------------------------------------------------------------------

CODE_00D5F5:
	PHB
	PHK
	PLB
	JSR.w CODE_00D659
	LDA.w $1980
	BMI.b CODE_00D60A
	LDX.w #$0070
	LDY.w #$00CC
	JSL.l CODE_01F91E
CODE_00D60A:
	LDX.w #$0049
	LDY.w #$00AE
	LDA.w #$008C
	JSL.l CODE_01F91E
	LDA.w #$0016
CODE_00D61A:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$000E
	BPL.b CODE_00D61A
	LDA.w $1ADD
	CMP.w #$0100
	BNE.b CODE_00D635
	LDA.w #$007C
	JSL.l CODE_01D368
CODE_00D635:
	LDA.w #$0019
	JSL.l CODE_01F84F
	LDX.w #$0080
	LDY.w #$007A
	LDA.w #$0045
	JSL.l CODE_01F91E
	LDA.w #$0017
	JSL.l CODE_01F84F
	LDA.w #$0018
	JSL.l CODE_01F84F
	PLB
	RTL

;--------------------------------------------------------------------

CODE_00D659:
	LDA.w $055D
	BEQ.b CODE_00D6D2
	LDA.w $0557
	BPL.b CODE_00D66B
	PEA.w $0000
	PEA.w $0000
	BRA.b CODE_00D670

CODE_00D66B:
	PHA
	LDA.w $0555
	PHA
CODE_00D670:
	LDA.w $055B
	PHA
	LDA.w $0559
	PHA
	JSL.l CODE_01DD79
	PLA
	PLY
	LDY.w #$0000
CODE_00D681:
	CMP.w #$000A
	BCC.b CODE_00D68C
	SBC.w #$000A
	INY
	BRA.b CODE_00D681

CODE_00D68C:
	PHA
	CPY.w #$000A
	BCC.b CODE_00D6B2
	LDX.w #$0078
	LDY.w #$0062
	LDA.w #$00C3
	JSL.l CODE_01F91E
	LDX.w #$0080
	LDY.w #$0062
	LDA.w #$00C2
	JSL.l CODE_01F91E
	PLA
	PEA.w $0000
	BRA.b CODE_00D6C3

CODE_00D6B2:
	TYA
	BEQ.b CODE_00D6C3
	LDX.w #$0080
	LDY.w #$0062
	CLC
	ADC.w #$00C2
	JSL.l CODE_01F91E
CODE_00D6C3:
	PLA
	LDX.w #$0088
	LDY.w #$0062
	CLC
	ADC.w #$00C2
	JSL.l CODE_01F91E
CODE_00D6D2:
	RTS

;--------------------------------------------------------------------

CODE_00D6D3:
	LDA.w #$0000
	STA.l $001982
	LDA.w #$7003
	STA.l $00197C
	LDA.w #$2122
	STA.l $00197E
	LDX.w #$77FE
	CLC
CODE_00D6EC:
	LDA.l $700800,x
	ADC.l $00197C
	STA.l $00197C
	LDA.l $700800,x
	EOR.l $00197E
	STA.l $00197E
	DEX
	DEX
	BPL.b CODE_00D6EC
	LDA.l $00197C
	ADC.l $7007FE
	STA.l $00197C
	LDA.l $00197E
	EOR.l $7007FE
	STA.l $00197E
	LDA.l $7007C2
	CMP.l $00197C
	BNE.b CODE_00D73B
	LDA.l $7007C4
	CMP.l $00197E
	BNE.b CODE_00D73B
	LDA.w #$0001
	STA.l $001982
CODE_00D73B:
	RTL

;--------------------------------------------------------------------

CODE_00D73C:
	PHP
	SEP.b #$20
	LDX.w #$000C
CODE_00D742:
	LDA.w DATA_00D74E,x
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	DEX
	BPL.b CODE_00D742
	PLP
	RTS

DATA_00D74E:
	db $3A,$01,$00,$40,$40,$BF,$40,$40
	db $BF,$36,$01,$00,$00

;--------------------------------------------------------------------

CODE_00D75B:
	LDX.w #$00A4
	LDY.w #$006C
CODE_00D761:
	LDA.w DATA_00D798-$02,y
	STA.l $7E210C,x
	DEY
	DEY
	DEX
	DEX
	TXA
	BIT.w #$003F
	BNE.b CODE_00D761
	SEC
	SBC.w #$001C
	TAX
	BPL.b CODE_00D761
	LDX.w #$0020
CODE_00D77C:
	LDA.w DATA_00D802,x
	STA.l $7E214E,x
	DEX
	DEX
	BNE.b CODE_00D77C
	JSL.l CODE_01DE97
	LDA.w #DATA_00D56F
	JSR.w CODE_00D52C
	LDA.w #$0080
	JSR.w CODE_00D514
	RTS

DATA_00D798:
	dw $2C00,$2C01,$2C01,$2C01,$2C01,$2C01,$2C01,$2C01
	dw $2C01,$2C01,$2C01,$2C01,$2C01,$2C01,$2C01,$2C01
	dw $2C01,$2C03,$2C10,$201F,$201F,$200F,$201F,$201F
	dw $201F,$201F,$201F,$201F,$201F,$201F,$201F,$201F
	dw $201F,$201F,$201F,$2C13,$2C30,$2C31,$2C31,$2C31
	dw $2C31,$2C31,$2C31,$2C31,$2C31,$2C31,$2C31,$2C31
	dw $2C31,$2C31,$2C31,$2C31,$2C31

DATA_00D802:
	dw $2C33,$201F,$201C,$200D,$2019,$200D,$201F,$201A
	dw $203B,$200C,$2029,$201F,$203C,$201E,$201A,$208C
	dw $201F

;--------------------------------------------------------------------

CODE_00D824:
	LDA.w #$000D
CODE_00D827:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$000A
	BPL.b CODE_00D827
	LDA.w #$0018
	JSL.l CODE_01F84F
	LDA.w #$0030
	JSL.l CODE_01F84F
	RTS

;--------------------------------------------------------------------

CODE_00D842:
	LDA.w $0557
	PHA
	LDA.w $0555
	PHA
	PEA.w $0000
	PEA.w $0064
	JSL.l CODE_01DD79
	PLA
	STA.w $0559
	PLA
	STA.w $055B
	LDA.w #$FFFF
	STA.w $0551
	STA.w $0553
	STA.w $055D
	RTS

;--------------------------------------------------------------------

CODE_00D869:
	PHP
	LDA.w #$0006
	JSL.l CODE_01D2BF
	LDA.w #$0002
	JSL.l CODE_01D368
	JSL.l CODE_01E06F
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w $04D0
	STA.w $101A
	LDA.w #$000B
	STA.w $04D0
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	STA.w $1126
	LDA.w #$0100
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	STZ.w $1124
	LDA.w #$0001
	STA.b $20
	STZ.w $1996
	LDA.w #DATA_01CF16
	JSL.l CODE_01CDE1
	JSR.w CODE_00C414
	JSL.l CODE_01DE97
	JSR.w CODE_00E2CC
	JSR.w CODE_00A363
	LDA.w #$000A
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	SEP.b #$20
	LDA.b #$66
	STA.w $010E
	REP.b #$20
	LDA.w #$3DFF
	JSL.l CODE_01E033
	JSR.w CODE_00DE46
	LDA.w #$003E
CODE_00D8D7:
	PHA
	JSL.l CODE_01F825
	PLA
	DEC
	CMP.w #$003C
	BPL.b CODE_00D8D7
	LDA.w $09D6
	STA.w $09D8
	LDA.w #$0015
	STA.w $09D6
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00D8F1:
	STZ.w $1996
	LDA.w #$003E
CODE_00D8F7:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$003C
	BPL.b CODE_00D8F7
	LDA.w $04CA
	LDY.w $099F
	BEQ.b CODE_00D913
	BIT.w #$0002
	BEQ.b CODE_00D913
	JMP.w CODE_00E335

CODE_00D913:
	BIT.w #$0010
	BNE.b CODE_00D91C
CODE_00D918:
	STZ.w $053B
	RTS

CODE_00D91C:
	BIT.w #$0020
	BEQ.b CODE_00D983
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCC.b CODE_00D958
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00D918
	CMP.w #$0017
	BCC.b CODE_00D94D
	CMP.w #$0020
	BCC.b CODE_00D918
	CMP.w #$00CF
	BCC.b CODE_00D950
	CMP.w #$00D8
	BCC.b CODE_00D918
	CMP.w #$00E7
	BCS.b CODE_00D918
	JMP.w CODE_00E27C

CODE_00D94D:
	JMP.w CODE_00DD97

CODE_00D950:
	LDA.w $099F
	BEQ.b CODE_00D918
	JMP.w CODE_00E388

CODE_00D958:
	CMP.w #$0018
	BCS.b CODE_00D980
	JSR.w CODE_008D2C
	CPX.w #$0000
	BEQ.b CODE_00D97F
	STA.w $1124
	AND.w #$00FF
	XBA
	ORA.w #$000B
	STA.w $04D0
	JSR.w CODE_00E2CC
	JSR.w CODE_00E64F
	LDA.w #$0004
	JSL.l CODE_01D368
CODE_00D97F:
	RTS

CODE_00D980:
	JSR.w CODE_00DA49
CODE_00D983:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0030
	BCC.b CODE_00D99D
	CMP.w #$00B0
	BCS.b CODE_00D99D
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0030
	BCC.b CODE_00D99D
	CMP.w #$00B0
	BCC.b CODE_00D99E
CODE_00D99D:
	RTS

CODE_00D99E:
	PHA
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00D9AA
	JSR.w CODE_00E2A3
CODE_00D9AA:
	PLA
	INC.w $1996
	AND.w #$FFF8
	LSR
	LSR
	PHA
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	AND.w #$FFF8
	ASL
	ASL
	ASL
	CLC
	ADC.b $01,S
	TAX
	PLA
	LDA.w $1124
	CLC
	ADC.w #$00D0
	CMP.l $7E2800,x
	BEQ.b CODE_00D9D8
	PHA
	LDA.w #$002B
	JSL.l CODE_01D368
	PLA
CODE_00D9D8:
	STA.l $7E2800,x
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	SEC
	SBC.w #$0030
	AND.w #$FF40
	LSR
	PHA
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	SEC
	SBC.w #$0030
	AND.w #$FF40
	CLC
	ADC.b $01,S
	STA.b $01,S
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	SEC
	SBC.w #$0030
	AND.w #$0038
	LSR
	LSR
	CLC
	ADC.b $01,S
	TAY
	PLA
	LDA.w $1124
	ASL
	TAX
	LDA.w DATA_00DB09,x
	STA.w $1128
	LDA.w DATA_00DB29,x
	STA.w $112A
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	SEC
	SBC.w #$0030
	LSR
	LSR
	LSR
	AND.w #$0007
	ASL
	TAX
	LDA.w $1128
	EOR.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,y
	AND.w DATA_00DB49,x
	EOR.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,y
	STA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,y
	LDA.w $112A
	EOR.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$10,y
	AND.w DATA_00DB49,x
	EOR.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$10,y
	STA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$10,y
	JMP.w CODE_00DE67

CODE_00DA49:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0004
	BCC.b CODE_00DA7A
	CMP.w #$0024
	BCS.b CODE_00DA7B
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0088
	BCC.b CODE_00DA7A
	CMP.w #$009C
	BCS.b CODE_00DA7A
	JSR.w CODE_00E2A3
	LDA.w #$000F
	JSL.l CODE_01D368
	LDA.w #$FFFF
	STA.w $1AF5
	LDA.w #$0016
	STA.w $09D6
	PLA
CODE_00DA7A:
	RTS

CODE_00DA7B:
	CMP.w #$00C0
	BCC.b CODE_00DA7A
	CMP.w #$00E8
	BCS.b CODE_00DA7A
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0030
	BCC.b CODE_00DA7A
	CMP.w #$0070
	BCS.b CODE_00DAC7
	AND.w #$FFF8
	ASL
	ASL
	ASL
	PHA
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	AND.w #$FFF8
	LSR
	LSR
	CLC
	ADC.b $01,S
	TAX
	PLA
	LDA.l $7E2800,x
	CMP.w #$0CA7
	BEQ.b CODE_00DA7A
	CMP.w #$0CC6
	BEQ.b CODE_00DA7A
	CMP.w #$0CC7
	BEQ.b CODE_00DA7A
	LDA.w #$FFFF
	STA.w $1AFD
	LDA.w #$0017
	STA.w $09D6
	PLA
	RTS

CODE_00DAC7:
	CMP.w #$0078
	BCC.b CODE_00DA7A
	CMP.w #$00B0
	BCS.b CODE_00DA7A
	AND.w #$FFF8
	ASL
	ASL
	ASL
	PHA
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	AND.w #$FFF8
	LSR
	LSR
	CLC
	ADC.b $01,S
	TAX
	PLA
	LDA.l $7E2800,x
	CMP.w #$0CA7
	BEQ.b CODE_00DA7A
	CMP.w #$0CC6
	BEQ.b CODE_00DA7A
	CMP.w #$0CC7
	BEQ.b CODE_00DA7A
	JSR.w CODE_00E2A3
	LDA.w #$FFFF
	STA.w $1B05
	LDA.w #$001A
	STA.w $09D6
	PLA
	RTS

DATA_00DB09:
	dw $00FF,$FF00,$FFFF,$0000,$00FF,$FF00,$FFFF,$0000
	dw $00FF,$FF00,$FFFF,$00FF,$FF00,$FFFF,$0000,$0000

DATA_00DB29:
	dw $0000,$0000,$0000,$00FF,$00FF,$00FF,$00FF,$FF00
	dw $FF00,$FF00,$FF00,$FFFF,$FFFF,$FFFF,$FFFF,$0000

DATA_00DB49:
	dw $8080,$4040,$2020,$1010,$0808,$0404,$0202,$0101

;--------------------------------------------------------------------

CODE_00DB59:
	LDA.w $1AF6
	AND.w #$00FF
	CMP.w #$0001
	BNE.b CODE_00DB69
	JSR.w CODE_00DE46
	BRA.b CODE_00DB74

CODE_00DB69:
	CMP.w #$0005
	BNE.b CODE_00DB74
	LDA.w #$0015
	STA.w $09D6
CODE_00DB74:
	LDA.w #$003E
CODE_00DB77:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$003C
	BPL.b CODE_00DB77
	RTS

;--------------------------------------------------------------------

CODE_00DB84:
	LDA.w #$000D
	JSL.l CODE_01D368
	LDA.w #$0010
	STA.w !RAM_MPAINT_Global_CursorYPosLo
	LDA.w #$003E
CODE_00DB94:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$003C
	BPL.b CODE_00DB94
	LDA.w #$21EE
	STA.l $7E2040
	STA.l $7E2042
	STA.l $7E2044
	STA.l $7E2080
	STA.l $7E2082
	STA.l $7E2084
	STA.l $7E207C
	STA.l $7E20BC
	LDA.w #$20B1
	STA.l $7E207A
	LDA.w #$A0B1
	STA.l $7E20BA
	JSL.l CODE_01DE97
	LDA.w #$00F0
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00A363
	LDA.w #$0018
	STA.w $09D6
	RTS

;--------------------------------------------------------------------

CODE_00DBE4:
	LDA.w #$003E
CODE_00DBE7:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$003C
	BPL.b CODE_00DBE7
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0018
	BCS.b CODE_00DC22
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00DC21
	JSR.w CODE_008D2C
	CPX.w #$0001
	BNE.b CODE_00DC21
	STA.w $112C
	JSR.w CODE_00DEB3
	JSR.w CODE_00DF1C
	JSR.w CODE_00E233
	JSR.w CODE_00A363
	LDA.w #$0004
	JSL.l CODE_01D368
CODE_00DC21:
	RTS

;--------------------------------------------------------------------

CODE_00DC22:
	LDA.w #$0019
	STA.w $09D6
	RTS

;--------------------------------------------------------------------

CODE_00DC29:
	LDA.w #$06FF
	STA.w $1AFD
	LDA.w #$003E
CODE_00DC32:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$003C
	BPL.b CODE_00DC32
	LDA.w #$0100
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00A363
	LDA.w #$2100
	STA.l $7E2040
	INC
	STA.l $7E2042
	INC
	STA.l $7E2044
	LDA.w #$2110
	STA.l $7E2080
	INC
	STA.l $7E2082
	INC
	STA.l $7E2084
	LDA.w #$212D
	STA.l $7E207A
	INC
	STA.l $7E207C
	LDA.w #$213D
	STA.l $7E20BA
	INC
	STA.l $7E20BC
	JSL.l CODE_01DE97
	LDA.w #$0015
	STA.w $09D6
	RTS

;--------------------------------------------------------------------

CODE_00DC8B:
	LDA.w #$000E
	JSL.l CODE_01D368
	LDA.w #$0010
	STA.w !RAM_MPAINT_Global_CursorYPosLo
	LDA.w #$003E
CODE_00DC9B:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$003C
	BPL.b CODE_00DC9B
	LDA.w #$00F0
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00A363
	LDA.w #$00F0
	JSR.w CODE_00B66C
	LDA.w #$000D
	JSR.w CODE_00B6F4
	JSR.w CODE_00E64F
	LDA.w #$001B
	STA.w $09D6
	RTS

;--------------------------------------------------------------------

CODE_00DCC5:
	LDA.w #$003E
CODE_00DCC8:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$003C
	BPL.b CODE_00DCC8
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0018
	BCC.b CODE_00DCDF
	JMP.w CODE_00DD66

CODE_00DCDF:
	LDA.w $04CA
	BIT.w #$0011
	BEQ.b CODE_00DD65
	JSR.w CODE_008D2C
	CPX.w #$0001
	BEQ.b CODE_00DD31
	CPX.w #$0002
	BNE.b CODE_00DD65
	LDA.w $04CA
	AND.w #$0044
	BEQ.b CODE_00DD65
	LDY.w #$0010
	BIT.w #$0040
	BNE.b CODE_00DD07
	LDY.w #$FFF0
CODE_00DD07:
	PHY
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CLC
	ADC.b $01,S
	CMP.w #$0060
	BNE.b CODE_00DD15
	CLC
	ADC.b $01,S
CODE_00DD15:
	AND.w #$00F0
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	LSR
	LSR
	LSR
	LSR
	CMP.w #$0006
	BCC.b CODE_00DD24
	DEC
CODE_00DD24:
	CLC
	ADC.w #$0062
	JSL.l CODE_01D368
	PLY
	JSR.w CODE_00A363
	RTS

CODE_00DD31:
	STA.w $112C
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00DD65
	LDA.w $112C
	ORA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00B66C
	LDA.w #$000D
	JSR.w CODE_00B6F4
	JSR.w CODE_00E64F
	JSR.w CODE_00E0D4
	JSR.w CODE_00E176
	JSL.l CODE_01DEB2
	JSL.l CODE_01E2CE
	JSR.w CODE_00DE67
	LDA.w #$0004
	JSL.l CODE_01D368
CODE_00DD65:
	RTS

CODE_00DD66:
	LDA.w #$001C
	STA.w $09D6
	RTS

;--------------------------------------------------------------------

CODE_00DD6D:
	LDA.w #$06FF
	STA.w $1B05
	LDA.w #$003E
CODE_00DD76:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$003C
	BPL.b CODE_00DD76
	LDA.w #$0100
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	JSR.w CODE_00A363
	JSR.w CODE_00E2CC
	JSR.w CODE_00E64F
	LDA.w #$0015
	STA.w $09D6
	RTS

;--------------------------------------------------------------------

CODE_00DD97:
	PHP
	JSL.l CODE_01D3AB
CODE_00DD9C:
	LDA.w $053A
	BNE.b CODE_00DD9C
	LDA.w #$0041
	JSL.l CODE_01D368
	SEP.b #$20
	LDA.b #$06
	STA.w $010E
	REP.b #$20
	LDA.w #$3FFF
	JSL.l CODE_01E033
	JSR.w CODE_008A16
	JSL.l CODE_01E2CE
	JSL.l CODE_01E06F
	LDA.w $101A
	STA.w $04D0
	AND.w #$00FF
	CMP.w #$0007
	BNE.b CODE_00DDD4
	INC.w !RAM_MPAINT_Canvas_EraseToolSelected
CODE_00DDD4:
	LDA.w $1126
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	STZ.b $20
	LDA.w $19FA
	BNE.b CODE_00DDE5
	JSR.w CODE_00C414
	BRA.b CODE_00DDE8

CODE_00DDE5:
	JSR.w CODE_00C3DE
CODE_00DDE8:
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	JSR.w CODE_00A451
	JSR.w CODE_00A525
	LDA.w #$0007
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	LDA.w $09D8
	STA.w $09D6
	JSL.l CODE_01E895
	JSL.l CODE_01E8F6
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
CODE_00DE13:
	BEQ.b CODE_00DE2B
	LDA.w #$000F
	JSR.w CODE_00B66C
	LDA.w !RAM_MPAINT_Canvas_EraseToolSize
	CLC
	ADC.w #$0008
	JSR.w CODE_00B6F4
	JSR.w CODE_00A363
	PLP
	RTS

CODE_00DE2B:
	LDA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	LDA.w $04D0
	CMP.w #$0006
	BNE.b CODE_00DE41
	INC.w $09AB
CODE_00DE41:
	JSR.w CODE_00A363
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00DE46:
	LDX.w #$057E
CODE_00DE49:
	LDA.l DATA_02B180,x
	STA.l $7E28C0,x
	DEX
	DEX
	BPL.b CODE_00DE49
	LDX.w #$007E
CODE_00DE58:
	STZ.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,x
	DEX
	DEX
	BPL.b CODE_00DE58
	JSL.l CODE_01DEB2
	JSL.l CODE_01E2CE
CODE_00DE67:
	STZ.w $0202
	LDX.w #$0012
CODE_00DE6D:
	LDA.w DATA_00DE7B,x
	STA.w $0182,x
	DEX
	DEX
	BPL.b CODE_00DE6D
	INC.w $0202
	RTS

DATA_00DE7B:
	db $02 : dl $00101C : dw $0080,$9080 : db $6C
	db $02 : dl $7E2800 : dw $0800,$0080,$0034

;--------------------------------------------------------------------

CODE_00DE8E:
	LDX.w #$07FE
CODE_00DE91:
	LDA.l DATA_058000+$7800,x
	STA.w !RAM_MPAINT_Global_CustomStampDisplayGFXBuffer,x
	DEX
	DEX
	BPL.b CODE_00DE91
	LDA.w #$00F0
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	LDA.w #$000F
CODE_00DEA4:
	PHA
	STA.w $112C
	JSR.w CODE_00E0D4
	JSR.w CODE_00DF1C
	PLA
	DEC
	BPL.b CODE_00DEA4
	RTS

;--------------------------------------------------------------------

CODE_00DEB3:
	LDA.w $112C
	AND.w #$0008
	XBA
	LSR
	PHA
	LDA.w $112C
	AND.w #$0007
	XBA
	LSR
	LSR
	CLC
	ADC.b $01,S
	TAX
	PLA
	LDY.w #$0000
CODE_00DECD:
	JSR.w CODE_00DF09
	CPY.w #$0010
	BNE.b CODE_00DECD
	TXA
	CLC
	ADC.w #$0010
	TAX
	LDY.w #$0020
CODE_00DEDE:
	JSR.w CODE_00DF09
	CPY.w #$0030
	BNE.b CODE_00DEDE
	TXA
	CLC
	ADC.w #$01D0
	TAX
	LDY.w #$0040
CODE_00DEEF:
	JSR.w CODE_00DF09
	CPY.w #$0050
	BNE.b CODE_00DEEF
	TXA
	CLC
	ADC.w #$0010
	TAX
	LDY.w #$0060
CODE_00DF00:
	JSR.w CODE_00DF09
	CPY.w #$0070
	BNE.b CODE_00DF00
	RTS

CODE_00DF09:
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,y
	STA.l !SRAM_MPAINT_Global_SavedSpecialStampsGFX,x
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$10,y
	STA.l !SRAM_MPAINT_Global_SavedSpecialStampsGFX+$10,x
	INX
	INX
	INY
	INY
	RTS

;--------------------------------------------------------------------

CODE_00DF1C:
	LDX.w #$0001
CODE_00DF1F:
	JSR.w CODE_00DF2C
	JSR.w CODE_00DFC4
	INX
	CPX.w #$000D
	BNE.b CODE_00DF1F
	RTS

CODE_00DF2C:
	PHX
	DEX
	LDA.w DATA_00DF89,x
	AND.w #$00FF
	TAX
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,x
	STA.w $111C
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$10,x
	STA.w $111E
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$20,x
	STA.w $1120
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$30,x
	STA.w $1122
	LDX.w #$0003
CODE_00DF50:
	JSR.w CODE_00DF95
	DEX
	BPL.b CODE_00DF50
	LDA.w $1138
	ORA.w $113A
	PHA
	XBA
	ORA.b $01,S
	EOR.w #$FFFF
	ORA.w $113A
	STA.w $113A
	PLA
	LDA.w $113C
	ORA.w $113E
	PHA
	XBA
	ORA.b $01,S
	EOR.w #$FFFF
	ORA.w $113E
	AND.w #$E0E0
	STA.w $113E
	PLA
	STZ.w $1140
	STZ.w $1142
	PLX
	RTS

DATA_00DF89:
	db $04,$06,$08,$0A,$0C,$0E,$40,$42
	db $44,$46,$48,$4A

CODE_00DF95:
	PHP
	SEP.b #$20
	ASL.w $1120,x
	ROL.w $111C,x
	ASL.w $1120,x
	ROL.w $111C,x
	LDA.b #$02
CODE_00DFA6:
	ASL.w $1120,x
	ROL.w $111C,x
	ROL.w $113C,x
	ROL.w $1138,x
	INC
	CMP.b #$0D
	BNE.b CODE_00DFA6
	LDA.b #$05
CODE_00DFB9:
	ASL.w $113C,x
	ROL.w $1138,x
	DEC
	BNE.b CODE_00DFB9
	PLP
	RTS

CODE_00DFC4:
	PHX
	PHP
	LDA.w $112C
	AND.w #$0003
	TAX
	SEP.b #$20
	LDA.w DATA_00E05E,x
CODE_00DFD2:
	LSR.w $1138
	ROR.w $113C
	ROR.w $1140
	LSR.w $1139
	ROR.w $113D
	ROR.w $1141
	LSR.w $113A
	ROR.w $113E
	ROR.w $1142
	LSR.w $113B
	ROR.w $113F
	ROR.w $1143
	DEC
	BNE.b CODE_00DFD2
	REP.b #$20
	LDA.w $112C
	AND.w #$0003
	ASL
	TAX
	LDA.w DATA_00E062,x
	STA.w $112E
	LDA.w DATA_00E06A,x
	STA.w $1132
	LDA.w DATA_00E072,x
	STA.w $1136
	LDA.w $112C
	ASL
	CLC
	ADC.w $112C
	ASL
	TAX
	LDY.w #$0000
CODE_00E022:
	PHX
	LDA.b $04,S
	INC
	CMP.w #$0008
	BCC.b CODE_00E02F
	CLC
	ADC.w #$00F8
CODE_00E02F:
	ASL
	CLC
	ADC.w DATA_00E07A,x
	BMI.b CODE_00E04F
	TAX
	LDA.w !RAM_MPAINT_Global_CustomStampDisplayGFXBuffer,x
	AND.w $112E,y
	ORA.w $1138,y
	STA.w !RAM_MPAINT_Global_CustomStampDisplayGFXBuffer,x
	LDA.w !RAM_MPAINT_Global_CustomStampDisplayGFXBuffer+$10,x
	AND.w $112E,y
	ORA.w $113A,y
	STA.w !RAM_MPAINT_Global_CustomStampDisplayGFXBuffer+$10,x
CODE_00E04F:
	PLX
	INX
	INX
	INY
	INY
	INY
	INY
	CPY.w #$000C
	BNE.b CODE_00E022
	PLP
	PLX
	RTS

DATA_00E05E:
	db $01,$07,$05,$03

DATA_00E062:
	dw $8080,$FEFE,$F8F8,$E0E0

DATA_00E06A:
	dw $0F0F,$0000,$0000,$0303

DATA_00E072:
	dw $FFFF,$3F3F,$FFFF,$FFFF

DATA_00E07A:
	dw $0060,$0080,$8000,$0080,$00A0,$00C0,$00C0,$00E0
	dw $8000,$0100,$0120,$8000,$0140,$0160,$8000,$0160
	dw $0180,$01A0,$01A0,$01C0,$8000,$01E0,$0400,$8000
	dw $0420,$0440,$8000,$0440,$0460,$0480,$0480,$04A0
	dw $8000,$04C0,$04E0,$8000,$0500,$0520,$8000,$0520
	dw $0540,$0560,$0560,$0580,$8000

;--------------------------------------------------------------------

; Note: Routine that loads a special stamp texture.

CODE_00E0D4:
	PHD
	TSC
	SEC
	SBC.w #$0010
	TCS
	TCD
	LDA.w !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CMP.w #$00F0
	BNE.b CODE_00E0EC
	LDA.w #!SRAM_MPAINT_Global_SavedSpecialStampsGFX
	LDX.w #!SRAM_MPAINT_Global_SavedSpecialStampsGFX>>16
	BRA.b CODE_00E0FE

CODE_00E0EC:
	CMP.w #$0070
	BCC.b CODE_00E0F5
	CLC
	ADC.w #$0010
CODE_00E0F5:
	XBA
	LSR
	CLC
	ADC.w #DATA_0A8000
	LDX.w #DATA_0A8000>>16
CODE_00E0FE:
	STA.b $01
	CLC
	ADC.w #$0010
	STA.b $05
	STX.b $03
	STX.b $07
	LDA.w $112C
	AND.w #$0008
	XBA
	LSR
	PHA
	LDA.w $112C
	AND.w #$0007
	XBA
	LSR
	LSR
	CLC
	ADC.b $01,S
	TAY
	PLA
	LDX.w #$0000
CODE_00E124:
	JSR.w CODE_00E167
	CPX.w #$0010
	BNE.b CODE_00E124
	TYA
	CLC
	ADC.w #$0010
	TAY
	LDX.w #$0020
CODE_00E135:
	JSR.w CODE_00E167
	CPX.w #$0030
	BNE.b CODE_00E135
	TYA
	CLC
	ADC.w #$01D0
	TAY
	LDX.w #$0040
CODE_00E146:
	JSR.w CODE_00E167
	CPX.w #$0050
	BNE.b CODE_00E146
	TYA
	CLC
	ADC.w #$0010
	TAY
	LDX.w #$0060
CODE_00E157:
	JSR.w CODE_00E167
	CPX.w #$0070
	BNE.b CODE_00E157
	TSC
	CLC
	ADC.w #$0010
	TCS
	PLD
	RTS

CODE_00E167:
	LDA.b [$01],y
	STA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,x
	LDA.b [$05],y
	STA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$10,x
	INY
	INY
	INX
	INX
	RTS

;--------------------------------------------------------------------

CODE_00E176:
	LDX.w #$0000
	LDY.w #$0000
CODE_00E17C:
	JSR.w CODE_00E19B
	STA.l $7E298C,x
	TYA
	AND.w #$000F
	CMP.w #$000F
	BNE.b CODE_00E192
	TXA
	CLC
	ADC.w #$0020
	TAX
CODE_00E192:
	INX
	INX
	INY
	CPY.w #$0100
	BNE.b CODE_00E17C
	RTS

;--------------------------------------------------------------------

CODE_00E19B:
	PHX
	PHY
	TYA
	AND.w #$0008
	ASL
	ASL
	PHA
	TYA
	AND.w #$0070
	LSR
	LSR
	LSR
	PHA
	TYA
	AND.w #$0080
	LSR
	CLC
	ADC.b $01,S
	CLC
	ADC.b $03,S
	TAX
	PLA
	PLA
	TYA
	AND.w #$0007
	ASL
	TAY
	STZ.w $1134
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$10,x
	AND.w DATA_00E203,y
	BIT.w #$FF00
	BEQ.b CODE_00E1D1
	INC.w $1134
CODE_00E1D1:
	ASL.w $1134
	BIT.w #$00FF
	BEQ.b CODE_00E1DC
	INC.w $1134
CODE_00E1DC:
	ASL.w $1134
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,x
	AND.w DATA_00E203,y
	BIT.w #$FF00
	BEQ.b CODE_00E1ED
	INC.w $1134
CODE_00E1ED:
	ASL.w $1134
	BIT.w #$00FF
	BEQ.b CODE_00E1F8
	INC.w $1134
CODE_00E1F8:
	LDA.w $1134
	ASL
	TAX
	LDA.w DATA_00E213,x
	PLY
	PLX
	RTS

DATA_00E203:
	dw $8080,$4040,$2020,$1010,$0808,$0404,$0202,$0101

DATA_00E213:
	dw $00DF,$00D0,$00D1,$00D2,$00D3,$00D4,$00D5,$00D6
	dw $00D7,$00D8,$00D9,$00DA,$00DE,$00DB,$00DC,$00DD

;--------------------------------------------------------------------

CODE_00E233:
	PHA
	PHP
	LDA.w #$0000
	PHA
	SEP.b #$20
	LDX.w #$07BF
CODE_00E23E:
	LDA.l $700000,x
	CLC
	ADC.b $01,S
	STA.b $01,S
	LDA.l $700000,x
	EOR.b $02,S
	STA.b $02,S
	DEX
	BPL.b CODE_00E23E
	REP.b #$20
	PLA
	STA.l $7007C0
	PLP
	PLA
	RTS

;--------------------------------------------------------------------

CODE_00E25C:
	PHP
	LDA.l $7007C0
	JSR.w CODE_00E233
	CMP.l $7007C0
	BNE.b CODE_00E26C
	PLP
	RTS

CODE_00E26C:
	LDX.w #$07BE
	LDA.w #$0000
CODE_00E272:
	STA.l $700000,x
	DEX
	DEX
	BPL.b CODE_00E272
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00E27C:
	LDA.w #$0009
	JSL.l CODE_01D368
	LDA.w #$0000
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	JSR.w CODE_00E2B1
	JSL.l CODE_01E2CE
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	RTS

;--------------------------------------------------------------------

CODE_00E2A3:
	LDX.w #$007E
CODE_00E2A6:
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,x
	STA.w $109C,x
	DEX
	DEX
	BPL.b CODE_00E2A6
	RTS

;--------------------------------------------------------------------

CODE_00E2B1:
	LDX.w #$007E
CODE_00E2B4:
	LDA.w $109C,x
	STA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,x
	DEX
	DEX
	BPL.b CODE_00E2B4
	JSR.w CODE_00E176
	JSL.l CODE_01DEB2
	JSL.l CODE_01E2CE
	JMP.w CODE_00DE67

;--------------------------------------------------------------------

CODE_00E2CC:
	LDA.w $04D0
	AND.w #$FF00
	XBA
	ASL
	ASL
	TAX
	LDY.w #$006E
CODE_00E2D9:
	LDA.w DATA_00E2F5,x
	STA.w $1CAA,y
	LDA.w DATA_00E2F5+$02,x
	STA.w $1CBA,y
	DEY
	DEY
	TYA
	BIT.w #$0010
	BEQ.b CODE_00E2F1
	SEC
	SBC.w #$0010
CODE_00E2F1:
	TAY
	BNE.b CODE_00E2D9
	RTS

DATA_00E2F5:
	dw $00FF,$0000,$FF00,$0000,$FFFF,$0000,$0000,$00FF
	dw $00FF,$00FF,$FF00,$00FF,$FFFF,$00FF,$0000,$FF00
	dw $00FF,$FF00,$FF00,$FF00,$FFFF,$FF00,$00FF,$FFFF
	dw $FF00,$FFFF,$FFFF,$FFFF,$0000,$FFFF,$0000,$0000

;--------------------------------------------------------------------

CODE_00E335:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0030
	BCC.b CODE_00E387
	CMP.w #$00B0
	BCS.b CODE_00E387
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0030
	BCC.b CODE_00E387
	CMP.w #$00B0
	BCS.b CODE_00E387
	SEC
	SBC.w #$0030
	AND.w #$FFF8
	ASL
	PHA
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	SEC
	SBC.w #$0030
	LSR
	LSR
	LSR
	CLC
	ADC.b $01,S
	TAY
	PLA
	JSR.w CODE_00E19B
	AND.w #$000F
	STA.w $1124
	AND.w #$00FF
	XBA
	ORA.w #$000B
	STA.w $04D0
	JSR.w CODE_00E2CC
	JSR.w CODE_00E64F
	LDA.w #$0004
	JSL.l CODE_01D368
CODE_00E387:
	RTS

;--------------------------------------------------------------------

CODE_00E388:
	JSR.w CODE_00E2A3
	LDX.w #$0000
	JSR.w CODE_00E3D6
	LDX.w #$0002
	JSR.w CODE_00E3D6
	LDX.w #$0010
	JSR.w CODE_00E3D6
	LDX.w #$0012
	JSR.w CODE_00E3D6
	LDX.w #$0000
CODE_00E3A6:
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,x
	STA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$04,x
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$10,x
	STA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$14,x
	INX
	INX
	TXA
	AND.w #$000F
	CMP.w #$000C
	BNE.b CODE_00E3C3
	TXA
	CLC
	ADC.w #$0014
	TAX
CODE_00E3C3:
	CPX.w #$0080
	BNE.b CODE_00E3A6
	JSR.w CODE_00E176
	JSL.l CODE_01DEB2
	JSL.l CODE_01E2CE
	JMP.w CODE_00DE67

CODE_00E3D6:
	LDA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,x
	AND.w #$C0C0
	PHA
	LSR
	LSR
	ORA.b $01,S
	LSR
	LSR
	ORA.b $01,S
	LSR
	LSR
	ORA.b $01,S
	STA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer,x
	STA.w !RAM_MPAINT_SpecialStamps_StampGFXBuffer+$20,x
	STA.w $105C,x
	STA.w $107C,x
	PLA
	RTS

;--------------------------------------------------------------------

CODE_00E3F7:
	LDA.w #$0006
	JSL.l CODE_01D368
	JSL.l CODE_01E06F
	LDA.w $04D0
	STA.w $1010
	LDA.w #$0009
	STA.w $04D0
	JSR.w CODE_009378
	LDA.w #DATA_01CE9D
	JSL.l CODE_01CDE1
	LDA.w #$7E2100
	PHA
	LDA.w #DATA_02AC80
	PHA
	LDA.w #$0014
	PHA
	JSR.w CODE_00C490
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$004C
CODE_00E432:
	PHA
	JSL.l CODE_01F825
	PLA
	DEC
	CMP.w #$003F
	BPL.b CODE_00E432
	LDA.w $1012
	CLC
	ADC.w #$003F
	ASL
	ASL
	ASL
	AND.w #$00FF
	TAX
	LDA.w #$01FF
	STA.w $1A15,x
	LDX.w $1012
	LDA.w DATA_00E4B5,x
	AND.w #$00FF
	TAX
	LDA.w #$FFFF
	STA.w $1A15,x
	STA.w $1A3D
	CPX.w #$0048
	BNE.b CODE_00E47F
	LDA.w #$00FF
	STA.w $1A65
	STA.w $1A6D
	LDA.w #$000A
	STA.w $1A66
	LDA.w #$0014
	STA.w $1A6E
CODE_00E47F:
	LDA.w $1012
	BEQ.b CODE_00E490
	LDA.w #$02FF
	STA.w $1A45
	STA.w $1A4D
	STA.w $1A55
CODE_00E490:
	LDA.w #$0020
	STA.w $1014
	LDA.w $09D6
	STA.w $09D8
	LDA.w #$001D
	STA.w $09D6
	LDA.w #$000E
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	INC.w $09AB
	JMP.w CODE_00A363

DATA_00E4B5:
	db $60,$20,$48,$18

;--------------------------------------------------------------------

CODE_00E4B9:
	LDA.w #$004C
CODE_00E4BC:
	PHA
	JSL.l CODE_01F84F
	PLA
	DEC
	CMP.w #$003F
	BPL.b CODE_00E4BC
	LDA.w $1012
	BEQ.b CODE_00E4FE
	LDX.w #$0018
CODE_00E4D0:
	LDA.w $1A3A,x
	CLC
	ADC.w $1014
	STA.w $1A3A,x
	TXA
	SEC
	SBC.w #$0008
	TAX
	BPL.b CODE_00E4D0
	LDA.w $1A3A
	CMP.w #$9900
	BNE.b CODE_00E4F0
	LDA.w #$FFE0
	STA.w $1014
CODE_00E4F0:
	LDA.w $1A3A
	CMP.w #$3000
	BNE.b CODE_00E4FE
	LDA.w #$0020
	STA.w $1014
CODE_00E4FE:
	LDA.w $04CA
	BIT.w #$0020
	BNE.b CODE_00E507
CODE_00E506:
	RTS

CODE_00E507:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0058
	BCC.b CODE_00E538
	CMP.w #$00D0
	BCS.b CODE_00E538
	LDY.w #$0001
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$003C
	BCC.b CODE_00E506
	CMP.w #$005C
	BCC.b CODE_00E550
	INY
	CMP.w #$007C
	BCC.b CODE_00E550
	INY
	CMP.w #$009C
	BCC.b CODE_00E550
	LDY.w #$0000
	CMP.w #$00BC
	BCC.b CODE_00E550
CODE_00E538:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00CC
	BCC.b CODE_00E506
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_00E506
	CMP.w #$0017
	BCS.b CODE_00E506
	JMP.w CODE_00E5F4

CODE_00E550:
	CPY.w $1012
	BEQ.b CODE_00E506
	STY.w $1012
	JSL.l CODE_01D3AB
	LDA.w #$07FF
	STA.w $1B0D
	STA.w $1A15
	STA.w $1A1D
	STA.w $1A25
	LDA.w #$03FF
	STA.w $1A2D
	STA.w $1A35
	LDA.w #$04FF
	STA.w $1A3D
	LDA.w #$FFFF
	STA.w $1A45
	STA.w $1A4D
	STA.w $1A55
	LDA.w #$21FF
	STA.w $1A5D
	LDA.w #$24FF
	STA.w $1A65
	LDA.w #$27FF
	STA.w $1A6D
	LDA.w #$04FF
	STA.w $1A75
	LDA.w $1012
	CLC
	ADC.w #$003F
	ASL
	ASL
	ASL
	AND.w #$00FF
	TAX
	LDA.w #$FFFF
	STA.w $1A15,x
	LDX.w $1012
	LDA.w DATA_00E4B5,x
	AND.w #$00FF
	TAX
	LDA.w #$FFFF
	STA.w $1A15,x
	CPX.w #$0048
	BNE.b CODE_00E5DC
	LDA.w #$00FF
	STA.w $1A65
	STA.w $1A6D
	LDA.w #$000A
	STA.w $1A66
	LDA.w #$0014
	STA.w $1A6E
CODE_00E5DC:
	LDA.w $1012
	BEQ.b CODE_00E5F3
	LDA.w #$02FF
	STA.w $1A45
	STA.w $1A4D
	STA.w $1A55
	LDA.w #$FFFF
	STA.w $1A3D
CODE_00E5F3:
	RTS

CODE_00E5F4:
	LDA.w #$0041
	JSL.l CODE_01D368
	JSL.l CODE_01E06F
	LDA.w $1010
	STA.w $04D0
	JSR.w CODE_009378
	LDA.w #DATA_01CE4B
	JSL.l CODE_01CDE1
	LDA.w $19FA
	BNE.b CODE_00E619
	JSR.w CODE_00C414
	BRA.b CODE_00E61C

CODE_00E619:
	JSR.w CODE_00C3DE
CODE_00E61C:
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w $09D8
	STA.w $09D6
	JSR.w CODE_00A451
	JSR.w CODE_00A525
	LDA.w #$0007
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	LDA.w $04D0
	CMP.w #$0006
	BNE.b CODE_00E648
	INC.w $09AB
CODE_00E648:
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_00E64B:
	JSR.w CODE_00E64F
	RTL

CODE_00E64F:
	PHP
	LDX.w #$0000
	LDY.w #$0000
CODE_00E656:
	CPX.w #$0000
	BEQ.b CODE_00E660
	CPX.w #$004E
	BNE.b CODE_00E663
CODE_00E660:
	JMP.w CODE_00E706

CODE_00E663:
	LDA.w $0EB8
	BNE.b CODE_00E6B6
	LDA.w $09D6
	CMP.w #$0002
	BEQ.b CODE_00E67B
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0003
	BNE.b CODE_00E682
CODE_00E67B:
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CMP.w #$0070
	BCS.b CODE_00E69C
CODE_00E682:
	LDA.w $1CAA,x
	STA.w $1004
	LDA.w $1CCA,x
	STA.w $1006
	LDA.w $1CBA,x
	STA.w $100A
	LDA.w $1CDA,x
	STA.w $100C
	BRA.b CODE_00E6CE

CODE_00E69C:
	LDA.w $1C2A,x
	STA.w $1004
	LDA.w $1C4A,x
	STA.w $1006
	LDA.w $1C3A,x
	STA.w $100A
	LDA.w $1C5A,x
	STA.w $100C
	BRA.b CODE_00E6CE

CODE_00E6B6:
	LDA.w $0EC4,x
	STA.w $1004
	LDA.w $0EE4,x
	STA.w $1006
	LDA.w $0ED4,x
	STA.w $100A
	LDA.w $0EF4,x
	STA.w $100C
CODE_00E6CE:
	STZ.w $1008
	STZ.w $100E
	SEP.b #$20
	PHY
	LDY.w #$0004
CODE_00E6DA:
	LSR.w $1004
	ROR.w $1006
	ROR.w $1008
	LSR.w $1005
	ROR.w $1007
	ROR.w $1009
	LSR.w $100A
	ROR.w $100C
	ROR.w $100E
	LSR.w $100B
	ROR.w $100D
	ROR.w $100F
	DEY
	BNE.b CODE_00E6DA
	PLY
	REP.b #$20
	BRA.b CODE_00E72A

CODE_00E706:
	LDA.w #$000F
	STA.w $1004
	LDA.w #$00FF
	STA.w $1006
	LDA.w #$00F0
	STA.w $1008
	LDA.w #$0F0F
	STA.w $100A
	LDA.w #$FFFF
	STA.w $100C
	LDA.w #$F0F0
	STA.w $100E
CODE_00E72A:
	TXA
	CMP.w #$0002
	BEQ.b CODE_00E75E
	CMP.w #$0008
	BEQ.b CODE_00E75E
	CMP.w #$000E
	BEQ.b CODE_00E75E
	CMP.w #$0044
	BEQ.b CODE_00E75E
	CMP.w #$004A
	BEQ.b CODE_00E75E
	LDA.w $1004
	ORA.w #$80F0
	STA.w !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top,y
	LDA.w $1006
	STA.w !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top+$20,y
	LDA.w $1008
	ORA.w #$010F
	STA.w !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top+$40,y
	BRA.b CODE_00E776

CODE_00E75E:
	LDA.w $1004
	ORA.w #$80D0
	STA.w !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top,y
	LDA.w $1006
	STA.w !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top+$20,y
	LDA.w $1008
	ORA.w #$010B
	STA.w !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top+$40,y
CODE_00E776:
	LDA.w $100A
	ORA.w #$F0F0
	STA.w !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top+$10,y
	LDA.w $100C
	STA.w !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top+$30,y
	LDA.w $100E
	ORA.w #$0F0F
	STA.w !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top+$50,y
	INY
	INY
	INX
	INX
	CPX.w #$0050
	BEQ.b CODE_00E7A5
	CPX.w #$0010
	BNE.b CODE_00E7A2
	LDX.w #$0040
	LDY.w #!RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Bottom-!RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top
CODE_00E7A2:
	JMP.w CODE_00E656

CODE_00E7A5:
	STZ.w $0202
	LDX.w $0204
	LDY.w #$0000
CODE_00E7AE:
	LDA.w DATA_00E7C6,y
	STA.w $0182,x
	INX
	INX
	INY
	INY
	CPY.w #$0014
	BNE.b CODE_00E7AE
	INC.w $0202
	JSL.l CODE_01E2CE
	PLP
	RTS

DATA_00E7C6:
	db $02 : dl !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top : dw $0060,$0080 : db $70
	db $02 : dl !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Bottom : dw $0060,$0080,$0071

;--------------------------------------------------------------------

CODE_00E7D9:
	LDA.w #$0002
	JSL.l CODE_01D368
	LDA.w #$0001
	STA.w $0EB8
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.b $B8
	STA.w $0EC2
	STZ.b $B8
	LDA.w $04D0
	STA.w $0EC0
	LDA.w #$0003
	STA.w $04D0
	JSR.w CODE_00EB3B
	PHA
	LDA.w $0EBA
	PHA
	LDA.w #$0008
	STA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_00E817:
	LDA.w #$0004
	JSL.l CODE_01D368
	LDA.b $A8
	AND.w #$000F
	PHA
	LDA.w $0EB8
	BMI.b CODE_00E836
	LDA.w $0EBC
	AND.w #$FFF0
	ORA.b $01,S
	STA.w $0EBC
	BRA.b CODE_00E841

CODE_00E836:
	LDA.w $0EBE
	AND.w #$FFF0
	ORA.b $01,S
	STA.w $0EBE
CODE_00E841:
	PLA
	JSR.w CODE_0096E1
	JMP.w CODE_00E64F

;--------------------------------------------------------------------

CODE_00E848:
	LDA.w #$000C
	JSL.l CODE_01D368
	LDA.w #$0003
	STA.w $04D0
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$FFFF
	STA.w $0EB8
	JSR.w CODE_00EB3B
	PHA
	LDA.w #$0007
	PHA
	LDA.w $0EBA
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0003
	PHA
	JSR.w CODE_009FC4
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_00E87A:
	LDY.w #$0010
	LDA.w $04CA
	AND.w #$0044
	BNE.b CODE_00E886
	RTS

CODE_00E886:
	BIT.w #$0040
	BNE.b CODE_00E88E
	LDY.w #$FFF0
CODE_00E88E:
	PHY
	LDA.w $0EB8
	BMI.b CODE_00E8D9
	LDA.w $0EBC
	AND.w #$00F0
	LSR
	LSR
	LSR
	LSR
	TAX
	LDY.w $0EBA
	BNE.b CODE_00E8A9
	LDA.w DATA_00E934,x
	BRA.b CODE_00E8AC

CODE_00E8A9:
	LDA.w DATA_00E944,x
CODE_00E8AC:
	AND.w #$00FF
	TAX
	LDA.b $01,S
	BPL.b CODE_00E8BA
	TXA
	CLC
	ADC.w #$0028
	TAX
CODE_00E8BA:
	LDA.w $0EBC
	AND.w #$000F
	PHA
	LDA.w $0EBC
	AND.w #$FFF0
	CLC
	ADC.b $03,S
	CMP.w DATA_00E951,x
	BNE.b CODE_00E8D2
	LDA.w DATA_00E951+$02,x
CODE_00E8D2:
	ORA.b $01,S
	STA.w $0EBC
	BRA.b CODE_00E903

CODE_00E8D9:
	LDA.w $0EBE
	AND.w #$00F0
	CLC
	ADC.b $01,S
	CMP.w #$0060
	BEQ.b CODE_00E8F1
	CMP.w #$00E0
	BNE.b CODE_00E8F4
	LDA.w #$0050
	BRA.b CODE_00E8F4

CODE_00E8F1:
	LDA.w #$00F0
CODE_00E8F4:
	AND.w #$00FF
	PHA
	LDA.w $0EBE
	AND.w #$000F
	ORA.b $01,S
	STA.w $0EBE
CODE_00E903:
	LSR
	LSR
	LSR
	LSR
	CMP.w #$0006
	BCC.b CODE_00E90D
	DEC
CODE_00E90D:
	CLC
	ADC.w #$0062
	TAY
	LDA.w $0EB8
	BMI.b CODE_00E927
	LDA.w $0EBA
	BEQ.b CODE_00E927
	LDA.w $0EBC
	AND.w #$00F0
	CMP.w #$0040
	BEQ.b CODE_00E92C
CODE_00E927:
	TYA
	JSL.l CODE_01D368
CODE_00E92C:
	PLA
	PLY
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

DATA_00E934:
	db $00,$00,$04,$04,$08,$08,$08,$08
	db $0C,$0C,$0C,$0C,$10,$10,$10,$10

DATA_00E944:
	db $14,$14,$18,$18,$1C,$20,$20,$20
	db $20,$24,$24,$24,$24

DATA_00E951:
	db $20,$00,$00,$00,$40,$00,$20,$00
	db $80,$00,$40,$00,$C0,$00,$80,$00
	db $00,$01,$C0,$00,$20,$00,$00,$00
	db $40,$00,$20,$00,$50,$00,$40,$00
	db $90,$00,$50,$00,$D0,$00,$90,$00
	db $F0,$FF,$10,$00,$10,$00,$30,$00
	db $30,$00,$70,$00,$70,$00,$B0,$00
	db $B0,$00,$F0,$00,$F0,$FF,$10,$00
	db $10,$00,$30,$00,$30,$00,$40,$00
	db $40,$00,$80,$00,$80,$00,$C0,$00

;--------------------------------------------------------------------

CODE_00E9A1:
	LDA.b $AC
CODE_00E9A2:
	DEC
	BNE.b CODE_00E9AB
	LDA.w #$0042
	BRA.b CODE_00E9AE

CODE_00E9AB:
	LDA.w #$000A
CODE_00E9AE:
	JSL.l CODE_01D368
	LDA.w #$0003
	STA.w $04D0
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$0001
	STA.w $0EB8
	LDA.b $AC
	DEC
	CMP.w $0EBA
	BEQ.b CODE_00E9EA
	JSR.w CODE_00EB3B
	LDA.w $0EBA
	BNE.b CODE_00E9D7
	TXA
	CLC
	ADC.w #$0005
	TAX
CODE_00E9D7:
	LDA.w DATA_00EA08-$02,x
	AND.w #$00FF
	PHA
	LDA.w $0EBC
	AND.w #$000F
	ORA.b $01,S
	STA.w $0EBC
	PLA
CODE_00E9EA:
	LDA.b $AC
	DEC
	STA.w $0EBA
	JSR.w CODE_00EB3B
	PHA
	LDA.w $0EBA
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

DATA_00EA08:
	db $00,$20,$40,$80,$C0,$00,$20,$40
	db $50,$90

;--------------------------------------------------------------------

CODE_00EA12:
	LDA.w #$0003
	STA.w $04D0
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$0001
	STA.w $0EB8
	LDA.w #$000C
	JSL.l CODE_01D368
	LDA.b $AC
	LDY.w $0EBA
	BEQ.b CODE_00EA33
	CLC
	ADC.w #$0005
CODE_00EA33:
	TAX
	LDA.w DATA_00EA5F-$03,x
	AND.w #$00FF
	PHA
	LDA.w $0EBC
	AND.w #$000F
	ORA.b $01,S
	STA.w $0EBC
	PLA
	JSR.w CODE_00EB3B
	PHA
	LDA.w $0EBA
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	JSR.w CODE_0096E1
	JMP.w CODE_00A363

DATA_00EA5F:
	db $00,$20,$40,$80,$C0,$00,$20,$40
	db $50,$90

;--------------------------------------------------------------------

CODE_00EA69:
	LDA.w #$0007
	JSL.l CODE_01D368
	LDA.w #$0001
	STA.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$000F
	JSR.w CODE_00B66C
	LDA.w !RAM_MPAINT_Canvas_EraseToolSize
	CLC
	ADC.w #$0008
	JSR.w CODE_00B6F4
	LDA.w #$0007
	STA.w $04D0
	JSR.w CODE_00A525
	LDA.w #$0008
	PHA
	LDA.w $0EBA
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	JMP.w CODE_00A363

CODE_00EAA4:
	LDA.w #$0041
	JSL.l CODE_01D368
	STZ.w $0EB8
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w $0EC2
	STA.b $B8
	LDA.w $0EC0
	STA.w $04D0
	AND.w #$00FF
	CMP.w #$0007
	BNE.b CODE_00EAD9
	INC.w !RAM_MPAINT_Canvas_EraseToolSelected
	LDA.w #$000F
	JSR.w CODE_00B66C
	LDA.w !RAM_MPAINT_Canvas_EraseToolSize
	CLC
	ADC.w #$0008
	JSR.w CODE_00B6F4
	BRA.b CODE_00EAE4

CODE_00EAD9:
	LDA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
CODE_00EAE4:
	LDY.w $19FA
	BEQ.b CODE_00EB16
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_00EB07
	LDA.w $19C0
	PHA
	LDA.w #$0004
	STA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	BRA.b CODE_00EB23

CODE_00EB07:
	LDA.w #$0004
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	BRA.b CODE_00EB23

CODE_00EB16:
	LDA.w #$0007
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
CODE_00EB23:
	JSR.w CODE_00A451
	JSR.w CODE_00A525
	LDA.w $04D0
	CMP.w #$0006
	BNE.b CODE_00EB34
	INC.w $09AB
CODE_00EB34:
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_00EB37:
	JSR.w CODE_00EB3B
	RTL

CODE_00EB3B:
	LDX.w #$0002
	LDA.w $0EBC
	LDY.w $0EBA
	BNE.b CODE_00EB60
	CMP.w #$0020
	BCC.b CODE_00EB78
	INX
	CMP.w #$0040
	BCC.b CODE_00EB78
	INX
	CMP.w #$0080
	BCC.b CODE_00EB78
	INX
	CMP.w #$00C0
	BCC.b CODE_00EB78
	INX
	BRA.b CODE_00EB78

CODE_00EB60:
	CMP.w #$0020
	BCC.b CODE_00EB78
	INX
	CMP.w #$0040
	BCC.b CODE_00EB78
	INX
	CMP.w #$0050
	BCC.b CODE_00EB78
	INX
	CMP.w #$0090
	BCC.b CODE_00EB78
	INX
CODE_00EB78:
	TXA
	RTS

;--------------------------------------------------------------------

CODE_00EB7A:
	PHP
	LDA.w #$0006
	JSL.l CODE_01D368
	SEP.b #$20
	JSL.l CODE_01D388
	JSL.l CODE_01E30E
	LDA.b #DATA_1C8000
	STA.b $CC
	LDA.b #DATA_1C8000>>8
	STA.b $CD
	LDA.b #DATA_1C8000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
CODE_00EBA1:
	LDA.b #$01
	STA.w !REGISTER_APUPort0
	LDA.w !REGISTER_APUPort0
	CMP.b #$01
	BNE.b CODE_00EBA1
	REP.b #$20
	JSL.l CODE_01E2F3
	STZ.w $0206
	JSL.l CODE_01E06F
	STZ.w !RAM_MPAINT_Canvas_EraseToolSelected
	STZ.w $0EB6
	STZ.w $09E0
	LDA.w $04D0
	STA.w $09DC
	LDA.w #$0003
	STA.w $04D0
	LDA.w #$0003
	STA.w $0E8C
	STA.w $0EB4
	LDA.w $0997
	STA.w $0EB0
	STZ.w $0997
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	STA.w $09DE
	LDA.w #$0070
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	STZ.w $0EB2
	JSR.w CODE_00C414
	LDA.w #DATA_01CF65
	JSL.l CODE_01CDE1
	SEP.b #$20
	LDA.b #$66
	STA.w $010E
	REP.b #$20
	LDA.w #$0004
	STA.w $0EA2
	JSR.w CODE_00FE9E
	LDA.w #$0004
	STA.w $0446
	JSR.w CODE_00FD18
	JSR.w CODE_00FB5C
	JSR.w CODE_00FCF4
	JSR.w CODE_00FE54
	LDA.w #$7E2100
	PHA
	LDA.w #DATA_02BC00
	PHA
	LDA.w #$0014
	PHA
	JSR.w CODE_00C490
	LDA.w $0C26
	BEQ.b CODE_00EC3C
	LDA.w #$0C36
	LDX.w #$0554
	LDY.w #$0003
	JSR.w CODE_00FB47
CODE_00EC3C:
	LDA.w #$0C30
	LDX.w #$0544
	LDY.w #$0003
	JSR.w CODE_00FB47
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w $09D6
	STA.w $09D8
	LDA.w #$001E
	STA.w $09D6
	STZ.b $A8
	JSR.w CODE_0096E1
	JSR.w CODE_00A363
	LDA.w #$000D
	STA.w $04D0
	LDA.w #$004D
	JSL.l CODE_01F825
	INC.w $0E8E
	LDA.w $0C32
	INC
	PHA
	LDA.w #$000B
	STA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00EC88:
	JSL.l CODE_01E30E
	SEP.b #$20
	LDA.w !REGISTER_PPUStatusFlag1
	BIT.b #$C0
	BEQ.b CODE_00ECA9
	INC.w $0561
	LDA.w $0561
	AND.b #$07
	TAX
	LDA.b #$80
	STA.w !REGISTER_OAMAddressHi
	LDA.w DATA_00ED6E,x
	STA.w !REGISTER_OAMAddressLo
CODE_00ECA9:
	REP.b #$20
	LDA.w #$000D
	STA.w $04D0
	LDA.w $0E94
	ORA.w $0E96
	BNE.b CODE_00ECC7
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0098
	BCS.b CODE_00ECC7
	LDA.w $0E8C
	STA.w $04D0
CODE_00ECC7:
	LDA.w $04CA
	BIT.w #$0011
	BNE.b CODE_00ECDD
CODE_00ECCF:
	STZ.w $0E94
	STZ.w $0E96
CODE_00ECD5:
	JSR.w CODE_00ED76
	JSL.l CODE_01E2F3
	RTS

CODE_00ECDD:
	LDA.w $0E94
	BEQ.b CODE_00ECE7
	JSR.w CODE_00F346
	BRA.b CODE_00ECD5

CODE_00ECE7:
	LDA.w $0E96
	BEQ.b CODE_00ECF1
	JSR.w CODE_00F8CC
	BRA.b CODE_00ECD5

CODE_00ECF1:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0018
	BCS.b CODE_00ECFE
	JSR.w CODE_00F054
	BRA.b CODE_00ECD5

CODE_00ECFE:
	CMP.w #$00C8
	BCC.b CODE_00ED0F
	JSR.w CODE_008E0B
	STX.b $A4
	STA.b $AC
	JSR.w CODE_0095E7
	BRA.b CODE_00ECCF

CODE_00ED0F:
	CMP.w #$002C
	BCC.b CODE_00ECD5
	CMP.w #$0098
	BCS.b CODE_00ED1E
	JSR.w CODE_00F0A4
	BRA.b CODE_00ECD5

CODE_00ED1E:
	CMP.w #$00A0
	BCC.b CODE_00ECD5
	CMP.w #$00A8
	BCS.b CODE_00ED2D
	JSR.w CODE_00F289
	BRA.b CODE_00ECD5

CODE_00ED2D:
	CMP.w #$00BC
	BCS.b CODE_00ECD5
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0030
	BCC.b CODE_00ECD5
	CMP.w #$0048
	BCS.b CODE_00ED44
	JSR.w CODE_00F3DE
	BRA.b CODE_00ECD5

CODE_00ED44:
	CMP.w #$0050
	BCC.b CODE_00ECD5
	CMP.w #$0068
	BCS.b CODE_00ED53
	JSR.w CODE_00F7D4
	BRA.b CODE_00ECD5

CODE_00ED53:
	CMP.w #$00A8
	BCS.b CODE_00ED5E
	JSR.w CODE_00F827
	JMP.w CODE_00ECD5

CODE_00ED5E:
	CMP.w #$00C8
	BCC.b CODE_00ED6B
	CMP.w #$00E8
	BCS.b CODE_00ED6B
	JSR.w CODE_00FAB5
CODE_00ED6B:
	JMP.w CODE_00ECD5

DATA_00ED6E:
	db $0C,$18,$24,$30,$12,$1E,$2A,$36

;--------------------------------------------------------------------

CODE_00ED76:
	JSR.w CODE_00F1FD
	LDA.w $1A7E
	AND.w #$00FF
	CMP.w #$0005
	BEQ.b CODE_00ED8D
	LDA.w #$004D
	JSL.l CODE_01F84F
	BRA.b CODE_00EDB1

CODE_00ED8D:
	LDA.w #$B0C8
	STA.w MPAINT_Global_OAMBuffer[$01].XDisp
	LDA.w #$3DE8
	STA.w MPAINT_Global_OAMBuffer[$01].Tile
	LDA.w #$B0D8
	STA.w MPAINT_Global_OAMBuffer[$02].XDisp
	LDA.w #$3DEA
	STA.w MPAINT_Global_OAMBuffer[$02].Tile
	LDA.w #$B8E8
	STA.w MPAINT_Global_OAMBuffer[$03].XDisp
	LDA.w #$3DFC
	STA.w MPAINT_Global_OAMBuffer[$03].Tile
CODE_00EDB1:
	LDA.w $0C28
	LSR
	LSR
	CLC
	ADC.w #$0071
	ORA.w #$AC00
	STA.w MPAINT_Global_OAMBuffer[$04].XDisp
	LDA.w #$3BDF
	STA.w MPAINT_Global_OAMBuffer[$04].Tile
	LDA.w $09E0
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC.w #$00BF
	ORA.w #$9F00
	STA.w MPAINT_Global_OAMBuffer[$05].XDisp
	LDA.w #$37EC
	STA.w MPAINT_Global_OAMBuffer[$05].Tile
	LDA.w MPAINT_Global_UpperOAMBuffer[$00].Slot
	AND.w #$F003
	ORA.w #$0028
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot
	LDA.w #$0018
	STA.w $0446
	JSR.w CODE_00FB5C
	JSR.w CODE_00FE54
	JSL.l CODE_01E998
	LDA.w $0EB2
	BEQ.b CODE_00EE01
	RTS

CODE_00EE01:
	LDA.w $0C32
	BNE.b CODE_00EE34
	LDX.w #$0BF0
	LDY.w #$001F
CODE_00EE0C:
	PHX
	PHY
	TXA
	SEC
	SBC.w $09E0
	BCC.b CODE_00EE27
	CMP.w #$00F8
	BCS.b CODE_00EE27
	TAX
	TYA
	CLC
	ADC.w #$01A0
	LDY.w #$0020
	JSL.l CODE_01F91E
CODE_00EE27:
	PLY
	PLX
	TXA
	SEC
	SBC.w #$0060
	TAX
	DEY
	BPL.b CODE_00EE0C
	BRA.b CODE_00EE60

CODE_00EE34:
	LDX.w #$0BD0
	LDY.w #$0017
CODE_00EE3A:
	PHX
	PHY
	TXA
	SEC
	SBC.w $09E0
	BCC.b CODE_00EE55
	CMP.w #$00F8
	BCS.b CODE_00EE55
	TAX
	TYA
	CLC
	ADC.w #$01A0
	LDY.w #$0020
	JSL.l CODE_01F91E
CODE_00EE55:
	PLY
	PLX
	TXA
	SEC
	SBC.w #$0080
	TAX
	DEY
	BPL.b CODE_00EE3A
CODE_00EE60:
	LDA.w $04D0
	CMP.w #$000E
	BEQ.b CODE_00EEC8
	CMP.w #$000F
	BEQ.b CODE_00EEC8
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$0085
	BCC.b CODE_00EEC8
	CMP.w #$0093
	BCS.b CODE_00EEC8
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	BMI.b CODE_00EEC8
	CMP.w #$0100
	BCS.b CODE_00EEC8
	LDA.w $09E0
	CLC
	ADC.w !RAM_MPAINT_Global_CursorXPosLo
	SEC
	SBC.w #$0040
	BMI.b CODE_00EEC8
	LSR
	LSR
	AND.w #$FFF8
	CLC
	ADC.w #$0010
	CMP.w $0C24
	BCS.b CODE_00EEC8
	INC
	INC
	PHA
	LDA.w $09E0
	AND.w #$001F
	PHA
	CLC
	ADC.w !RAM_MPAINT_Global_CursorXPosLo
	AND.w #$FFE0
	SEC
	SBC.b $01,S
	CLC
	ADC.w #$0007
	AND.w #$FFF8
	LSR
	LSR
	TAX
	PLA
	LDA.l $7E2C00,x
	CMP.w #$0C74
	BNE.b CODE_00EEC9
	PLA
CODE_00EEC8:
	RTS

CODE_00EEC9:
	PHX
	LDA.b $03,S
	TAX
	JSR.w CODE_00FDFE
	PLX
	PLA
	BCC.b CODE_00EF21
	CPX.w #$0040
	BCS.b CODE_00EF20
	LDA.w #$0C74
	STA.l $7E2C00,x
	LDA.w #$8C74
	STA.l $7E2C40,x
	CPX.w #$003E
	BCS.b CODE_00EF20
	LDA.w #$0C6D
	STA.l $7E2C02,x
	LDA.w #$8C6D
	STA.l $7E2C42,x
	CPX.w #$003C
	BCS.b CODE_00EF20
	LDA.w #$0C76
	STA.l $7E2C04,x
	LDA.w #$0C77
	STA.l $7E2C44,x
	CPX.w #$003A
	BCS.b CODE_00EF20
	LDA.w #$4C74
	STA.l $7E2C06,x
	LDA.w #$CC74
	STA.l $7E2C46,x
CODE_00EF20:
	RTS

CODE_00EF21:
	CPX.w #$0040
	BCS.b CODE_00EF6D
	LDA.w #$0C74
	STA.l $7E2C00,x
	LDA.w #$8C74
	STA.l $7E2C40,x
	CPX.w #$003E
	BCS.b CODE_00EF6D
	LDA.w #$0C6D
	STA.l $7E2C02,x
	LDA.w #$8C6D
	STA.l $7E2C42,x
	CPX.w #$003C
	BCS.b CODE_00EF6D
	LDA.w #$0C70
	STA.l $7E2C04,x
	LDA.w #$0C71
	STA.l $7E2C44,x
	CPX.w #$003A
	BCS.b CODE_00EF6D
	LDA.w #$4C74
	STA.l $7E2C06,x
	LDA.w #$CC74
	STA.l $7E2C46,x
CODE_00EF6D:
	RTS

;--------------------------------------------------------------------

CODE_00EF6E:
	JSL.l CODE_01E2F3
	LDA.w $04CA
	BIT.w #$0020
	BNE.b CODE_00EF7B
	RTS

CODE_00EF7B:
	LDA.w #$0001
	JSL.l CODE_01D368
	SEP.b #$20
	JSL.l CODE_01D39F
	JSL.l CODE_01E30E
	LDA.b #DATA_1A8000
	STA.b $CC
	LDA.b #DATA_1A8000>>8
	STA.b $CD
	LDA.b #DATA_1A8000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
	REP.b #$20
	JSL.l CODE_01E2F3
	JSL.l CODE_01D3AB
	PLA
	PHP
	JSL.l CODE_01E06F
	LDA.w $0EB0
	STA.w $0997
	LDA.w $09DC
	STA.w $04D0
	CMP.w #$0007
	BNE.b CODE_00EFC5
	INC.w !RAM_MPAINT_Canvas_EraseToolSelected
CODE_00EFC5:
	LDA.w $09DE
	STA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	LDA.w $19FA
	BNE.b CODE_00EFD4
	JSR.w CODE_00C414
	BRA.b CODE_00EFD7

CODE_00EFD4:
	JSR.w CODE_00C3DE
CODE_00EFD7:
	SEP.b #$20
	LDA.b #$06
	STA.w $010E
	REP.b #$20
	LDA.w #$3FFF
	JSL.l CODE_01E033
	STZ.w $0172
	JSR.w CODE_008A16
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	STZ.w $0E8E
	LDA.w #$0007
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSR.w CODE_009FC4
	LDA.w #DATA_01CF16
	JSL.l CODE_01CDE1
	LDA.w #DATA_01CE4B
	JSL.l CODE_01CDE1
	JSR.w CODE_00A451
	JSR.w CODE_00A525
	LDA.w $09D8
	STA.w $09D6
	INC.w $0206
	PLP
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
	BEQ.b CODE_00F03B
	LDA.w #$000F
	JSR.w CODE_00B66C
	LDA.w !RAM_MPAINT_Canvas_EraseToolSize
	CLC
	ADC.w #$0008
	JSR.w CODE_00B6F4
	JMP.w CODE_00A363

CODE_00F03B:
	LDA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	LDA.w $04D0
	CMP.w #$0006
	BNE.b CODE_00F051
	INC.w $09AB
CODE_00F051:
	JMP.w CODE_00A363

;--------------------------------------------------------------------

CODE_00F054:
	JSL.l CODE_01E2F3
	STZ.w $0E94
	STZ.w $0E96
	JSR.w CODE_008D2C
	CPX.w #$0000
	BEQ.b CODE_00F0A3
	CPX.w #$0002
	BNE.b CODE_00F06E
	JMP.w CODE_00F954

CODE_00F06E:
	TAY
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00F0A3
	TYA
	INC
	ASL
	ASL
	ASL
	ASL
	ORA.w #$0005
	JSL.l CODE_01D328
	TYA
	XBA
	AND.w #$FF00
	ORA.w #$0003
	STA.w $0E8C
	STA.w $0EB4
	STA.w $04D0
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	JSR.w CODE_00E64F
	JSR.w CODE_00FF36
CODE_00F0A3:
	RTS

;--------------------------------------------------------------------

CODE_00F0A4:
	STZ.w $0E94
	STZ.w $0E96
	STZ.w $0EB6
	LDA.w $099F
	BEQ.b CODE_00F0C3
	LDA.w $04CA
	BIT.w #$0002
	BEQ.b CODE_00F0C3
	LDA.w #$0020
	STA.w $04CA
	JMP.w CODE_00FA65

CODE_00F0C3:
	LDA.w $04CA
	BIT.w #$0040
	BNE.b CODE_00F0CC
CODE_00F0CB:
	RTS

CODE_00F0CC:
	LDA.w $04D0
	CMP.w #$000E
	BNE.b CODE_00F0FE
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CLC
	ADC.w $09E0
	SEC
	SBC.w #$0008
	LSR
	LSR
	AND.w #$FFF8
	CMP.w #$0018
	BMI.b CODE_00F0CB
	CMP.w #$0311
	BPL.b CODE_00F0CB
	JSR.w CODE_00FCF4
	STA.w $0C24
	LDA.w #$000F
	JSL.l CODE_01D368
	JMP.w CODE_00FD18

CODE_00F0FE:
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CLC
	ADC.w $09E0
	SEC
	SBC.w #$0040
	BMI.b CODE_00F0CB
	LSR
	LSR
	LSR
	LSR
	LSR
	PHA
	ASL
	CLC
	ADC.b $01,S
	ASL
	TAX
	PLA
	PHX
	LDA.w $0C24
	SEC
	SBC.w #$0010
	LSR
	PHA
	LSR
	CLC
	ADC.b $01,S
	CMP.b $03,S
	BEQ.b CODE_00F12F
	BCS.b CODE_00F14C
CODE_00F12C:
	PLA
	PLX
	RTS

CODE_00F12F:
	LDA.w $04D0
	CMP.w #$000F
	BNE.b CODE_00F12C
	JSR.w CODE_00FCF4
	LDA.w #$000B
	JSL.l CODE_01D368
	LDA.w #$0310
	STA.w $0C24
	JSR.w CODE_00FD18
	BRA.b CODE_00F12C

CODE_00F14C:
	PLA
	PLX
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	SEC
	SBC.w #$002C
	LSR
	LSR
	LSR
	CMP.w #$000D
	BCS.b CODE_00F1B8
	EOR.w #$FFFF
	CLC
	ADC.w #$000E
	PHA
	LDA.w $04D0
	CMP.w #$000F
	BEQ.b CODE_00F1B9
	AND.w #$FF00
	ORA.b $01,S
	PHA
	PHX
	CLC
	ADC.w #$0100
	LSR
	LSR
	LSR
	LSR
	ORA.b $03,S
	AND.w #$00FF
	JSL.l CODE_01D328
	PLX
	PLA
	TXA
	CLC
	ADC.w #$0004
	TAX
	LDY.w #$0003
CODE_00F190:
	LDA.w $09E4,x
	AND.w #$00FF
	CMP.b $01,S
	BEQ.b CODE_00F1A6
	CMP.w #$00FF
	BEQ.b CODE_00F1A6
	DEX
	DEX
	DEY
	BNE.b CODE_00F190
	BRA.b CODE_00F1B7

CODE_00F1A6:
	LDA.w $04D0
	AND.w #$FF00
	ORA.b $01,S
	JSR.w CODE_00FCF4
	STA.w $09E4,x
	JSR.w CODE_00FD18
CODE_00F1B7:
	PLA
CODE_00F1B8:
	RTS

CODE_00F1B9:
	LDY.w #$0003
CODE_00F1BC:
	LDA.w $09E4,x
	AND.w #$00FF
	CMP.b $01,S
	BEQ.b CODE_00F1CD
	INX
	INX
	DEY
	BNE.b CODE_00F1BC
	BRA.b CODE_00F1FB

CODE_00F1CD:
	JSR.w CODE_00FCF4
	CPY.w #$0001
	BNE.b CODE_00F1DE
	DEX
	DEX
	INY
	LDA.w $09E4,x
	STA.w $09E6,x
CODE_00F1DE:
	CPY.w #$0002
	BNE.b CODE_00F1EB
	DEX
	DEX
	LDA.w $09E4,x
	STA.w $09E6,x
CODE_00F1EB:
	LDA.w #$FFFF
	STA.w $09E4,x
	LDA.w #$000B
	JSL.l CODE_01D368
	JSR.w CODE_00FD18
CODE_00F1FB:
	PLA
	RTS

;--------------------------------------------------------------------

CODE_00F1FD:
	SEP.b #$20
	LDX.w #$023E
CODE_00F202:
	LDA.w $09E5,x
	AND.b #$DF
	STA.w $09E5,x
	DEX
	DEX
	BPL.b CODE_00F202
	REP.b #$20
	LDA.w $04D0
	CMP.w #$000F
	BNE.b CODE_00F250
	LDA.w $016C
	BIT.w #$0008
	BNE.b CODE_00F250
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CLC
	ADC.w $09E0
	SEC
	SBC.w #$0040
	BMI.b CODE_00F250
	LSR
	LSR
	LSR
	LSR
	LSR
	PHA
	ASL
	CLC
	ADC.b $01,S
	ASL
	TAX
	PLA
	PHX
	LDA.w $0C24
	SEC
	SBC.w #$0010
	LSR
	PHA
	LSR
	CLC
	ADC.b $01,S
	CMP.b $03,S
	BEQ.b CODE_00F24E
	BCS.b CODE_00F251
CODE_00F24E:
	PLA
	PLX
CODE_00F250:
	RTS

CODE_00F251:
	PLA
	PLX
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	SEC
	SBC.w #$002C
	LSR
	LSR
	LSR
	CMP.w #$000D
	BCS.b CODE_00F250
	EOR.w #$FFFF
	CLC
	ADC.w #$000E
	PHA
	LDY.w #$0003
CODE_00F26D:
	LDA.w $09E4,x
	AND.w #$00FF
	CMP.b $01,S
	BEQ.b CODE_00F27E
	INX
	INX
	DEY
	BNE.b CODE_00F26D
	BRA.b CODE_00F287

CODE_00F27E:
	LDA.w $09E4,x
	ORA.w #$2000
	STA.w $09E4,x
CODE_00F287:
	PLA
	RTS

;--------------------------------------------------------------------

CODE_00F289:
	JSL.l CODE_01E2F3
	STZ.w $0E96
	LDA.w $04CA
	BIT.w #$0010
	BEQ.b CODE_00F2AF
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$00B8
	BCC.b CODE_00F2AF
	CMP.w #$00BF
	BCC.b CODE_00F2B0
	CMP.w #$00F1
	BCC.b CODE_00F2F9
	CMP.w #$00F8
	BCC.b CODE_00F2B0
CODE_00F2AF:
	RTS

CODE_00F2B0:
	LDA.w #$FFFC
	LDX.w !RAM_MPAINT_Global_CursorXPosLo
	CPX.w #$00C0
	BCC.b CODE_00F2BE
	LDA.w #$0004
CODE_00F2BE:
	LDY.w #$0008
CODE_00F2C1:
	PHA
	PHY
	CLC
	ADC.w $09E0
	BPL.b CODE_00F2CC
	LDA.w #$0000
CODE_00F2CC:
	CMP.w #$0B5F
	BMI.b CODE_00F2D4
	LDA.w #$0B5F
CODE_00F2D4:
	STA.w $09E0
	CPY.w #$0001
	BEQ.b CODE_00F2ED
	LDA.w #$0004
	STA.w $0446
	JSR.w CODE_00ED76
	JSL.l CODE_01E09B
	JSL.l CODE_01E2CE
CODE_00F2ED:
	PLY
	PLA
	DEY
	BNE.b CODE_00F2C1
	LDA.w #$0004
	STA.w $0446
	RTS

CODE_00F2F9:
	LDA.w $04CA
	BIT.w #$0040
	BEQ.b CODE_00F2AF
	LDA.w $09E0
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC.w #$00BF
	CMP.w !RAM_MPAINT_Global_CursorXPosLo
	BCS.b CODE_00F329
	CLC
	ADC.w #$0005
	CMP.w !RAM_MPAINT_Global_CursorXPosLo
	BCC.b CODE_00F32E
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w $0E94
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.w $0E98
	RTS

CODE_00F329:
	LDA.w #$FF20
	BRA.b CODE_00F331

CODE_00F32E:
	LDA.w #$00E0
CODE_00F331:
	CLC
	ADC.w $09E0
	BPL.b CODE_00F33A
	LDA.w #$0000
CODE_00F33A:
	CMP.w #$0B5F
	BMI.b CODE_00F342
	LDA.w #$0B5F
CODE_00F342:
	STA.w $09E0
	RTS

;--------------------------------------------------------------------

CODE_00F346:
	LDA.w $0E94
	SEC
	SBC.w !RAM_MPAINT_Global_CursorXPosLo
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL
	EOR.w #$FFFF
	INC
	CLC
	ADC.w $09E0
	BPL.b CODE_00F371
	EOR.w #$FFFF
	INC
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w !RAM_MPAINT_Global_CursorXPosLo
	LDA.w #$0000
CODE_00F371:
	CMP.w #$0B5F
	BMI.b CODE_00F38E
	SEC
	SBC.w #$0B5F
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	EOR.w #$FFFF
	INC
	CLC
	ADC.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w !RAM_MPAINT_Global_CursorXPosLo
	LDA.w #$0B5F
CODE_00F38E:
	STA.w $09E0
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w $0E94
	LDA.w $0E98
	STA.w !RAM_MPAINT_Global_CursorYPosLo
	RTS

;--------------------------------------------------------------------

CODE_00F39E:
	PHP
	LDA.w #$FFFF
	LDX.w #$023E
CODE_00F3A5:
	STA.w $09E4,x
	DEX
	DEX
	BPL.b CODE_00F3A5
	LDA.w #$0050
	STA.w $0C28
	JSR.w CODE_00F921
	LDA.w #$0001
	STA.w $0C32
	STZ.w $09E0
	STZ.w $0C26
	LDA.w #$0310
	STA.w $0C24
	PLP
	RTS

;--------------------------------------------------------------------

CODE_00F3C9:
	STZ.w $0E94
	STZ.w $0E96
	LDA.w #$0000
	JSL.l CODE_01D328
	LDA.w #$0000
	JSL.l CODE_01D348
	RTS

;--------------------------------------------------------------------

CODE_00F3DE:
	JSL.l CODE_01E2F3
	STZ.w $0E94
	STZ.w $0E96
	LDA.w $04CA
	BIT.w #$0020
	BNE.b CODE_00F3F1
	RTS

CODE_00F3F1:
	JSR.w CODE_00FEB1
	JSR.w CODE_00FF5F
	INC.w $0EB2
	LDA.w #$0006
	JSL.l CODE_01D368
	LDA.w #$0C10
	LDX.w #$0544
	LDY.w #$0003
	JSR.w CODE_00FB47
	LDA.w #$0C33
	LDX.w #$054C
	LDY.w #$0003
	JSR.w CODE_00FB47
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w $0C24
	SEC
	SBC.w #$0010
	LSR
	PHA
	LSR
	CLC
	ADC.b $01,S
	STA.w $0EAE
	PLA
	LDA.w #$0000
	JSL.l CODE_01D328
	LDA.w #$0000
	JSL.l CODE_01D348
	STZ.w $0C2E
	STZ.w $0C30
	STZ.w $0E92
	STZ.w $0E90
	LDA.w #$FFF0
	STA.w $0E9E
	STA.w $0EA6
	STZ.w $0EA0
	STZ.w $0EA2
	STZ.w $09E0
	STZ.w $09E2
CODE_00F461:
	JSR.w CODE_00F623
	BCC.b CODE_00F469
	JMP.w CODE_00F5AE

CODE_00F469:
	LDA.w $0EA0
	INC
	CMP.w #$0009
	BCC.b CODE_00F475
	LDA.w #$0000
CODE_00F475:
	STA.w $0EA0
	INC.w $0E9E
	INC.w $0E9E
	LDX.w $0E9E
	CPX.w #$0030
	BMI.b CODE_00F461
	LDA.w $09E4
	AND.w $09E6
	AND.w $09E8
	BMI.b CODE_00F497
	LDA.w #$0001
	STA.w $0EAA
CODE_00F497:
	LDA.w $0E92
	BNE.b CODE_00F49F
	JMP.w CODE_00F53B

CODE_00F49F:
	LDA.w $0E90
	CMP.w $0EAE
	BNE.b CODE_00F4C4
	LDA.w $0C26
	BNE.b CODE_00F4AF
	JMP.w CODE_00F5AE

CODE_00F4AF:
	STZ.w $0E90
	STZ.w $09E0
	STZ.w $09E2
	STZ.w $0EA2
	LDA.w #$0050
	STA.w $0E9E
	LDA.w #$0000
CODE_00F4C4:
	TAX
	LDA.w $09E4,x
	BMI.b CODE_00F4DF
	PHA
	PHX
	CLC
	ADC.w #$0100
	LSR
	LSR
	LSR
	LSR
	ORA.b $03,S
	AND.w #$00FF
	JSL.l CODE_01D328
	PLX
	PLA
CODE_00F4DF:
	INX
	INX
	LDA.w $09E4,x
	BMI.b CODE_00F4FB
	PHA
	PHX
	CLC
	ADC.w #$0100
	LSR
	LSR
	LSR
	LSR
	ORA.b $03,S
	AND.w #$00FF
	JSL.l CODE_01D348
	PLX
	PLA
CODE_00F4FB:
	INX
	INX
	LDA.w $09E4,x
	BMI.b CODE_00F517
	PHA
	PHX
	CLC
	ADC.w #$0100
	LSR
	LSR
	LSR
	LSR
	ORA.b $03,S
	AND.w #$00FF
	JSL.l CODE_01D368
	PLX
	PLA
CODE_00F517:
	INX
	INX
	STX.w $0E90
	TXA
	CMP.w $0EAE
	BNE.b CODE_00F52A
	LDA.w $0C26
	BEQ.b CODE_00F53B
	LDX.w #$0000
CODE_00F52A:
	LDA.w $09E4,x
	AND.w $09E6,x
	AND.w $09E8,x
	BMI.b CODE_00F53B
	LDA.w #$0001
	STA.w $0EAA
CODE_00F53B:
	STZ.w $0E92
	LDA.w $0C2A
	CLC
	ADC.w $0C2E
	STA.w $0C2E
	LDA.w $0C2C
	ADC.w $0C30
	STA.w $0C30
	ROL.w $0E92
	LDA.w $0EA2
	BNE.b CODE_00F57F
	LDA.w $0C30
	AND.w #$FF00
	XBA
	LSR
	LSR
	LSR
	CLC
	ADC.w $0E9E
	CMP.w #$0080
	BCC.b CODE_00F5A6
	STA.w $0E9E
	SEC
	SBC.w #$0070
	EOR.w #$FFFF
	INC
	STA.w $09E2
	INC.w $0EA2
	BRA.b CODE_00F5A6

CODE_00F57F:
	LDA.w $0EA2
	CMP.w #$0002
	BEQ.b CODE_00F5A6
	LDA.w $09E0
	CLC
	ADC.w #$00E2
	LSR
	LSR
	CMP.w $0C24
	BCC.b CODE_00F5A6
	LDA.w $0E9E
	SEC
	SBC.w #$0080
	CLC
	ADC.w #$0070
	STA.w $0E9E
	INC.w $0EA2
CODE_00F5A6:
	JSR.w CODE_00F623
	BCS.b CODE_00F5AE
	JMP.w CODE_00F497

CODE_00F5AE:
	LDA.w #$0C30
	LDX.w #$0544
	LDY.w #$0003
	JSR.w CODE_00FB47
	LDA.w #$0C13
	LDX.w #$054C
	LDY.w #$0003
	JSR.w CODE_00FB47
	JSL.l CODE_01DE97
	LDA.w $0EA2
	CMP.w #$0001
	BEQ.b CODE_00F5E3
	LDA.w $0C30
	AND.w #$FF00
	XBA
	LSR
	LSR
	LSR
	CLC
	ADC.w $0E9E
	STA.w $0E9E
CODE_00F5E3:
	STZ.w $0C2E
	STZ.w $0C30
	STZ.w $0E92
	LDA.w #$0004
	STA.w $0EA2
CODE_00F5F2:
	JSR.w CODE_00F623
	LDA.w $0EA0
	INC
	CMP.w #$0009
	BCC.b CODE_00F601
	LDA.w #$0000
CODE_00F601:
	STA.w $0EA0
	LDA.w $0E9E
	CLC
	ADC.w #$0004
	STA.w $0E9E
	LDX.w $0E9E
	CPX.w #$0110
	BMI.b CODE_00F5F2
	LDA.w #$0004
	STA.w $0446
	JSR.w CODE_00F3C9
	STZ.w $0EB2
	RTS

;--------------------------------------------------------------------

CODE_00F623:
	LDA.w #$0004
	STA.w $0446
	JSR.w CODE_008B48
	LDA.w $04CA
	BIT.w #$0010
	BEQ.b CODE_00F696
	LDA.w $0E96
	BEQ.b CODE_00F63E
	JSR.w CODE_00F8CC
	BRA.b CODE_00F699

CODE_00F63E:
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00A8
	BCC.b CODE_00F699
	CMP.w #$00BC
	BCS.b CODE_00F699
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0010
	BCC.b CODE_00F699
	CMP.w #$0028
	BCS.b CODE_00F67D
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00F699
	LDA.w #$0006
	JSL.l CODE_01D368
	STZ.w $0E96
	JSR.w CODE_009378
	JSR.w CODE_00ED76
	JSR.w CODE_00F6AC
	JSL.l CODE_01E09B
	JSL.l CODE_01E2CE
	SEC
	RTS

CODE_00F67D:
	CMP.w #$0050
	BCC.b CODE_00F699
	CMP.w #$0068
	BCS.b CODE_00F68C
	JSR.w CODE_00F7D4
	BRA.b CODE_00F699

CODE_00F68C:
	CMP.w #$00A8
	BCS.b CODE_00F699
	JSR.w CODE_00F827
	BRA.b CODE_00F699

CODE_00F696:
	STZ.w $0E96
CODE_00F699:
	JSR.w CODE_009378
	JSR.w CODE_00ED76
	JSR.w CODE_00F6AC
	JSL.l CODE_01E09B
	JSL.l CODE_01E2CE
	CLC
	RTS

CODE_00F6AC:
	LDX.w $0446
	PHX
	LDX.w $0E9E
	LDA.w $0EA2
	AND.w #$0001
	BNE.b CODE_00F6DB
	LDA.w $0E92
	BEQ.b CODE_00F6CA
	LDA.w $0E9E
	CLC
	ADC.w #$0020
	STA.w $0E9E
CODE_00F6CA:
	LDA.w $0C30
	AND.w #$FF00
	XBA
	LSR
	LSR
	LSR
	CLC
	ADC.w $0E9E
	TAX
	BRA.b CODE_00F6FB

CODE_00F6DB:
	LDA.w $0E92
	BEQ.b CODE_00F6EA
	LDA.w $09E2
	CLC
	ADC.w #$0020
	STA.w $09E2
CODE_00F6EA:
	LDA.w $0C30
	AND.w #$FF00
	XBA
	LSR
	LSR
	LSR
	CLC
	ADC.w $09E2
	STA.w $09E0
CODE_00F6FB:
	TXA
	SEC
	SBC.w #$0008
	STA.w $0EA6
	TXA
	CLC
	ADC.w $09E0
	SEC
	SBC.w #$0068
	STA.w $0EA4
	LDY.w #$0028
	LDA.w $0EAA
	BEQ.b CODE_00F74C
	CMP.w #$0002
	BEQ.b CODE_00F72D
	LDA.w #$0002
	STA.w $0EAA
	LDA.w $0EA4
	STA.w $0EA8
	LDA.w #$0000
	BRA.b CODE_00F73F

CODE_00F72D:
	LDA.w $0EA4
	SEC
	SBC.w $0EA8
	CMP.w #$001F
	BCC.b CODE_00F73F
	STZ.w $0EAA
	LDA.w #$001F
CODE_00F73F:
	TAY
	LDA.w DATA_00F7B4,y
	AND.w #$00FF
	TAY
	LDA.w #$014D
	BRA.b CODE_00F785

CODE_00F74C:
	LDA.w $0C30
	BIT.w #$1000
	BEQ.b CODE_00F763
	LDA.w $0EA0
	INC
	CMP.w #$0009
	BCC.b CODE_00F760
	LDA.w #$0000
CODE_00F760:
	STA.w $0EA0
CODE_00F763:
	LDA.w $0EA0
	CMP.w #$0004
	BCS.b CODE_00F770
	LDA.w #$014A
	BRA.b CODE_00F773

CODE_00F770:
	LDA.w #$014B
CODE_00F773:
	PHA
	LDA.w $0EA2
	CMP.w #$0004
	BNE.b CODE_00F784
	LDA.b $01,S
	CLC
	ADC.w #$002D
	STA.b $01,S
CODE_00F784:
	PLA
CODE_00F785:
	JSL.l CODE_01F91E
	PLX
	LDA.w #$7000
	ORA.w MPAINT_Global_OAMBuffer[$00].Tile,x
	STA.w MPAINT_Global_OAMBuffer[$00].Tile,x
	LDA.w #$7000
	ORA.w MPAINT_Global_OAMBuffer[$01].Tile,x
	STA.w MPAINT_Global_OAMBuffer[$01].Tile,x
	LDA.w #$7000
	ORA.w MPAINT_Global_OAMBuffer[$02].Tile,x
	STA.w MPAINT_Global_OAMBuffer[$02].Tile,x
	LDA.w MPAINT_Global_OAMBuffer[$00].Tile,x
	PHA
	LDA.w MPAINT_Global_OAMBuffer[$01].Tile,x
	STA.w MPAINT_Global_OAMBuffer[$00].Tile,x
	PLA
	STA.w MPAINT_Global_OAMBuffer[$01].Tile,x
	RTS

DATA_00F7B4:
	db $28,$26,$25,$24,$22,$21,$20,$1F
	db $1E,$1D,$1C,$1B,$1A,$1A,$19,$19
	db $18,$18,$18,$17,$17,$18,$18,$18
	db $19,$1A,$1A,$1C,$1D,$1F,$21,$24

;--------------------------------------------------------------------

CODE_00F7D4:
	STZ.w $0E94
	STZ.w $0E96
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00F826
	JSR.w CODE_00FCF4
	JSR.w CODE_00FEB1
	JSR.w CODE_00FF5F
	LDA.w #$0006
	JSL.l CODE_01D368
	JSR.w CODE_00FCF4
	LDA.w $0C26
	EOR.w #$0001
	STA.w $0C26
	BNE.b CODE_00F80B
	LDA.w #$0C16
	LDX.w #$0554
	LDY.w #$0003
	BRA.b CODE_00F814

CODE_00F80B:
	LDA.w #$0C36
	LDX.w #$0554
	LDY.w #$0003
CODE_00F814:
	JSR.w CODE_00FB47
	JSL.l CODE_01DE97
	JSR.w CODE_00FD18
	JSL.l CODE_01E2F3
	JSL.l CODE_01E2CE
CODE_00F826:
	RTS

;--------------------------------------------------------------------

CODE_00F827:
	STZ.w $0E94
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0068
	BCC.b CODE_00F841
	CMP.w #$0070
	BCC.b CODE_00F845
	CMP.w #$00A0
	BCC.b CODE_00F872
	CMP.w #$00A8
	BCC.b CODE_00F845
CODE_00F841:
	STZ.w $0E96
	RTS

CODE_00F845:
	LDA.w $04CA
	BIT.w #$0040
	BEQ.b CODE_00F841
	JSR.w CODE_00FCF4
	JSR.w CODE_00FEB1
	JSR.w CODE_00FF5F
	LDA.w #$000A
	LDX.w !RAM_MPAINT_Global_CursorXPosLo
	CPX.w #$0070
	BCC.b CODE_00F862
	DEC
CODE_00F862:
	LDA.w #$FFFF
	LDX.w !RAM_MPAINT_Global_CursorXPosLo
	CPX.w #$0070
	BCC.b CODE_00F870
	LDA.w #$0001
CODE_00F870:
	BRA.b CODE_00F8B5

CODE_00F872:
	LDA.w $04CA
	BIT.w #$0040
	BEQ.b CODE_00F841
	JSR.w CODE_00FCF4
	JSR.w CODE_00FEB1
	JSR.w CODE_00FF5F
	LDA.w $0C28
	LSR
	LSR
	CLC
	ADC.w #$0071
	CMP.w !RAM_MPAINT_Global_CursorXPosLo
	BCS.b CODE_00F8A7
	CLC
	ADC.w #$0005
	CMP.w !RAM_MPAINT_Global_CursorXPosLo
	BCC.b CODE_00F8AF
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w $0E96
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.w $0E9A
	RTS

CODE_00F8A7:
	STZ.w $0E96
	LDA.w #$FFF0
	BRA.b CODE_00F8B5

CODE_00F8AF:
	STZ.w $0E96
	LDA.w #$0010
CODE_00F8B5:
	CLC
	ADC.w $0C28
	BPL.b CODE_00F8BE
	LDA.w #$0000
CODE_00F8BE:
	CMP.w #$009F
	BMI.b CODE_00F8C6
	LDA.w #$009F
CODE_00F8C6:
	STA.w $0C28
	JMP.w CODE_00F921

;--------------------------------------------------------------------

CODE_00F8CC:
	LDA.w $0E96
	SEC
	SBC.w !RAM_MPAINT_Global_CursorXPosLo
	ASL
	ASL
	EOR.w #$FFFF
	INC
	LDX.w !RAM_MPAINT_Global_CursorXPosLo
	STX.w $0E96
	CLC
	ADC.w $0C28
	BPL.b CODE_00F8F5
	EOR.w #$FFFF
	INC
	LSR
	LSR
	CLC
	ADC.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w !RAM_MPAINT_Global_CursorXPosLo
	LDA.w #$0000
CODE_00F8F5:
	CMP.w #$009F
	BMI.b CODE_00F90E
	SEC
	SBC.w #$009F
	LSR
	LSR
	EOR.w #$FFFF
	INC
	CLC
	ADC.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w !RAM_MPAINT_Global_CursorXPosLo
	LDA.w #$009F
CODE_00F90E:
	STA.w $0C28
	JSR.w CODE_00F921
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w $0E96
	LDA.w $0E9A
	STA.w !RAM_MPAINT_Global_CursorYPosLo
	RTS

;--------------------------------------------------------------------

CODE_00F921:
	CLC
	ADC.w #$000E
	XBA
	STA.w $0E9C
	STZ.w $0C2A
	STZ.w $0C2C
	LDY.w #$0008
CODE_00F932:
	ASL.w $0C2A
	ROL.w $0C2C
	ASL.w $0E9C
	BCC.b CODE_00F950
	LDA.w #$3819
	CLC
	ADC.w $0C2A
	STA.w $0C2A
	LDA.w #$0032
	ADC.w $0C2C
	STA.w $0C2C
CODE_00F950:
	DEY
	BNE.b CODE_00F932
	RTS

;--------------------------------------------------------------------

CODE_00F954:
	JSL.l CODE_01E2F3
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00F9A6
	LDA.w #$0003
	JSL.l CODE_01D368
	LDA.w #$000E
	STA.w $0E8C
	STA.w $0EB4
	LDY.w #$0000
	TYX
CODE_00F974:
	LDA.l DATA_089C00,x
	STA.w $1C2A,y
	STA.w $1CAA,y
	INX
	INX
	INY
	INY
	CPY.w #$0040
	BNE.b CODE_00F974
	TXA
	CLC
	ADC.w #$01C0
	TAX
CODE_00F98D:
	LDA.l DATA_089C00,x
	STA.w $1C2A,y
	STA.w $1CAA,y
	INX
	INX
	INY
	INY
	CPY.w #$0080
	BNE.b CODE_00F98D
	JSR.w CODE_00E64F
	JSR.w CODE_00FF36
CODE_00F9A6:
	RTS

;--------------------------------------------------------------------

CODE_00F9A7:
	JSL.l CODE_01E2F3
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00FA07
	LDA.w #$0002
	JSL.l CODE_01D368
	LDA.w $0E8C
	CMP.w #$000F
	BEQ.b CODE_00FA07
	STA.w $0EB4
	LDA.w #$000F
	STA.w $0E8C
	LDX.w #$00FE
CODE_00F9CE:
	STZ.w $1C2A,x
	DEX
	DEX
	BPL.b CODE_00F9CE
	JSR.w CODE_00E64F
	LDA.w $0EB6
	BNE.b CODE_00F9F1
	LDA.w $0C32
	INC
	PHA
	LDA.w #$0000
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	RTS

CODE_00F9F1:
	INC
	INC
	PHA
	LDA.w $0C32
	INC
	PHA
	LDA.w #$0000
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0003
	PHA
	JSR.w CODE_009FC4
CODE_00FA07:
	RTS

;--------------------------------------------------------------------

CODE_00FA08:
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00FA34
	STZ.w $0EB6
	LDA.b $AC
	SEC
	SBC.w #$0002
	STA.w $0C32
	BNE.b CODE_00FA27
	LDA.w #$0007
	JSL.l CODE_01D368
	BRA.b CODE_00FA2E

CODE_00FA27:
	LDA.w #$0008
	JSL.l CODE_01D368
CODE_00FA2E:
	JSR.w CODE_00FA35
	JSR.w CODE_00FD18
CODE_00FA34:
	RTS

;--------------------------------------------------------------------

CODE_00FA35:
	JSL.l CODE_01E2F3
	LDA.w $0E8C
	CMP.w #$000F
	BEQ.b CODE_00FA51
	LDA.w $0C32
	INC
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	RTS

CODE_00FA51:
	LDA.w #$0000
	PHA
	LDA.w $0C32
	INC
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	JSR.w CODE_009FC4
	RTS

;--------------------------------------------------------------------

CODE_00FA65:
	JSL.l CODE_01E2F3
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_00FAB4
	STZ.w $0EB6
	LDA.w #$0004
	JSL.l CODE_01D368
	LDA.w #$0006
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	JSR.w CODE_00FD06
	JSR.w CODE_00FD18
	JSL.l CODE_01E2CE
	LDA.w $0C26
	BNE.b CODE_00FA9D
	LDA.w #$0C16
	BRA.b CODE_00FAA0

CODE_00FA9D:
	LDA.w #$0C36
CODE_00FAA0:
	LDX.w #$0554
	LDY.w #$0003
	JSR.w CODE_00FB47
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	JSR.w CODE_00FA35
CODE_00FAB4:
	RTS

;--------------------------------------------------------------------

CODE_00FAB5:
	LDA.w $04CA
	BIT.w #$0020
	BNE.b CODE_00FAC0
	JMP.w CODE_00FB46

CODE_00FAC0:
	JSL.l CODE_01E2F3
	STZ.w $0EB6
	STZ.w $0E94
	STZ.w $0E96
	LDA.w $0EB4
	STA.w $0E8C
	LDA.w #$0005
	JSL.l CODE_01D368
	JSR.w CODE_00FCF4
	LDA.w #$FFFF
	LDX.w #$023E
CODE_00FAE3:
	STA.w $09E4,x
	DEX
	DEX
	BPL.b CODE_00FAE3
	LDA.w #$0050
	STA.w $0C28
	JSR.w CODE_00F921
	STZ.w $09E0
	STZ.w $0C26
	LDA.w #$0310
	STA.w $0C24
	LDA.w #$0C30
	LDX.w #$0544
	LDY.w #$0003
	JSR.w CODE_00FB47
	LDA.w #$0C13
	LDX.w #$054C
	LDY.w #$0003
	JSR.w CODE_00FB47
	LDA.w #$0C16
	LDX.w #$0554
	LDY.w #$0003
	JSR.w CODE_00FB47
	LDA.w #$FFFF
	STA.w $1A7D
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w $0C32
	INC
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSR.w CODE_009FC4
	JSR.w CODE_00FF5F
	JSR.w CODE_00FD18
CODE_00FB46:
	RTS

;--------------------------------------------------------------------

CODE_00FB47:
	PHA
	STA.l $7E2000,x
	CLC
	ADC.w #$0010
	STA.l $7E2040,x
	PLA
	INX
	INX
	INC
	DEY
	BNE.b CODE_00FB47
	RTS

;--------------------------------------------------------------------

CODE_00FB5C:
	LDA.w $09E0
	SEC
	SBC.w #$0040
	AND.w #$FFE0
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	PHA
	CMP.w #$8000
	ROR
	CLC
	ADC.b $01,S
	TAY
	PLA
	LDX.w #$0100
	LDA.w $0C24
	ASL
	ASL
	SEC
	SBC.w $09E0
	CMP.w #$0100
	BPL.b CODE_00FB8F
	INC
	TAX
CODE_00FB8F:
	STX.w $0E8A
	LDA.w $09E0
	AND.w #$001F
	EOR.w #$FFFF
	CLC
	ADC.w #$0009
	TAX
	JMP.w CODE_00FC6A

;--------------------------------------------------------------------

CODE_00FBA3:
	STZ.w $0C3A
	LDA.w #$0003
CODE_00FBA9:
	PHA
	PHX
	PHY
	CPY.w #$0000
	BPL.b CODE_00FBB4
	JMP.w CODE_00FC59

CODE_00FBB4:
	CPX.w #$FFF0
	BPL.b CODE_00FBBC
	JMP.w CODE_00FC59

CODE_00FBBC:
	LDA.w $09E5,y
	AND.w #$00FF
	PHA
	LDA.w $09E4,y
	AND.w #$00FF
	EOR.w #$FFFF
	CLC
	ADC.w #$000E
	ASL
	ASL
	ASL
	CLC
	ADC.w #$0028
	PHA
	PHX
	INC.w $0C3A
	LDA.w $0C3A
	CMP.w #$0003
	BEQ.b CODE_00FC08
	CMP.w #$0002
	BEQ.b CODE_00FBF6
	LDA.b $03,S
	STA.w $0C34
	STZ.w $0C36
	STZ.w $0C38
	BRA.b CODE_00FC23

CODE_00FBF6:
	LDA.b $03,S
	STA.w $0C36
	CMP.w $0C34
	BNE.b CODE_00FC23
	LDA.w #$0002
	STA.w $0C38
	BRA.b CODE_00FC23

CODE_00FC08:
	LDA.b $03,S
	CMP.w $0C34
	BEQ.b CODE_00FC14
	CMP.w $0C36
	BNE.b CODE_00FC20
CODE_00FC14:
	LDA.w $0C38
	CLC
	ADC.w #$0002
	STA.w $0C38
	BRA.b CODE_00FC23

CODE_00FC20:
	STZ.w $0C38
CODE_00FC23:
	LDA.w $0EA2
	CMP.w #$0004
	BEQ.b CODE_00FC45
	LDA.w $0EA6
	SEC
	SBC.b $01,S
	BMI.b CODE_00FC45
	CMP.w #$0020
	BCS.b CODE_00FC45
	TAX
	LDA.l DATA_00FC73,x
	AND.w #$00FF
	CLC
	ADC.b $03,S
	STA.b $03,S
CODE_00FC45:
	PLA
	CLC
	ADC.w $0C38
	CLC
	ADC.w $0C38
	TAX
	PLA
	SEC
	SBC.w $0C38
	TAY
	PLA
	JSR.w CODE_00FC93
CODE_00FC59:
	PLY
	PLX
	INY
	INY
	PLA
	DEC
	BEQ.b CODE_00FC64
	JMP.w CODE_00FBA9

CODE_00FC64:
	TXA
	CLC
	ADC.w #$0020
	TAX
CODE_00FC6A:
	CPX.w $0E8A
	BPL.b CODE_00FC72
	JMP.w CODE_00FBA3

CODE_00FC72:
	RTS

DATA_00FC73:
	db $00,$00,$01,$02,$03,$03,$04,$05
	db $05,$06,$06,$07,$07,$07,$07,$07
	db $07,$07,$07,$07,$07,$07,$06,$06
	db $05,$05,$04,$03,$03,$02,$01,$00

;--------------------------------------------------------------------

CODE_00FC93:
	CMP.w #$0020
	BCS.b CODE_00FCEF
	PHP
	PHA
	PHX
	PHY
	SEP.b #$20
	TXA
	LDX.w $0446
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	TYA
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	REP.b #$20
	LDA.b $05,S
	AND.w #$FFF8
	CLC
	ADC.b $05,S
	ASL
	CLC
	ADC.w #$2080
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	LDA.w $0446
	STX.w $0446
	LSR
	LSR
	PHA
	AND.w #$0003
	TAX
	PLA
	LSR
	LSR
	TAY
	SEP.b #$20
	LDA.b $04,S
	BNE.b CODE_00FCDA
	LDA.b #$AA
	BRA.b CODE_00FCDC

CODE_00FCDA:
	LDA.b #$FF
CODE_00FCDC:
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot,y
	AND.l DATA_00FCF0,x
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot,y
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot,y
	REP.b #$20
	PLY
	PLX
	PLA
	PLP
CODE_00FCEF:
	RTS

DATA_00FCF0:
	db $03,$0C,$30,$C0

;--------------------------------------------------------------------

CODE_00FCF4:
	PHA
	PHX
	LDX.w #$024C
CODE_00FCF9:
	LDA.w $09E4,x
	STA.w $0C3C,x
	DEX
	DEX
	BPL.b CODE_00FCF9
	PLX
	PLA
	RTS

;--------------------------------------------------------------------

CODE_00FD06:
	PHA
	PHX
	LDX.w #$024C
CODE_00FD0B:
	LDA.w $0C3C,x
	STA.w $09E4,x
	DEX
	DEX
	BPL.b CODE_00FD0B
	PLX
	PLA
	RTS

;--------------------------------------------------------------------

CODE_00FD18:
	PHB
	PEA.w $7F7F
	PLB
	PLB
	LDA.w #$018D
	LDX.w #$0000
	LDY.w #$0020
CODE_00FD27:
	PHA
	JSR.w CODE_00FD83
	TXA
	INC
	INC
	CMP.l $000C24
	BCS.b CODE_00FD75
	TYA
	SEC
	SBC.w #$0100
	BCC.b CODE_00FD75
	PHX
	AND.w #$FF80
	LSR
	LSR
	LSR
	LSR
	LSR
	PHA
	LSR
	CLC
	ADC.b $01,S
	TAX
	PLA
	LDA.l $0009E4,x
	AND.w #$00FF
	CMP.w #$0003
	BCC.b CODE_00FD6F
	LDA.l $0009E6,x
	AND.w #$00FF
	CMP.w #$0003
	BCC.b CODE_00FD6F
	LDA.l $0009E8,x
	AND.w #$00FF
	CMP.w #$0003
	BCS.b CODE_00FD74
CODE_00FD6F:
	PLX
	PHX
	JSR.w CODE_00FE21
CODE_00FD74:
	PLX
CODE_00FD75:
	TYA
	CLC
	ADC.w #$0020
	TAY
	INX
	INX
	PLA
	DEC
	BNE.b CODE_00FD27
	PLB
	RTS

CODE_00FD83:
	PHX
	PHY
	CPX.w #$0006
	BCC.b CODE_00FDE1
	BEQ.b CODE_00FDDE
	CPX.w #$000C
	BCS.b CODE_00FD9B
	LDA.l $000C26
	BEQ.b CODE_00FDDE
	DEX
	DEX
	BRA.b CODE_00FDE1

CODE_00FD9B:
	TXA
	AND.w #$FFFC
	CMP.l $000C24
	BNE.b CODE_00FDC7
	TXA
	AND.w #$0002
	TAY
	LDA.l $000C26
	BEQ.b CODE_00FDB6
	TYA
	CLC
	ADC.w #$0004
	TAY
CODE_00FDB6:
	TYA
	JSR.w CODE_00FDFE
	BCC.b CODE_00FDC0
	CLC
	ADC.w #$0008
CODE_00FDC0:
	CLC
	ADC.w #$0010
	TAX
	BRA.b CODE_00FDE1

CODE_00FDC7:
	TXA
	SEC
	SBC.w #$000A
	AND.w #$0007
	BNE.b CODE_00FDDE
	LDA.w #$000C
	JSR.w CODE_00FDFE
	BCC.b CODE_00FDDB
	INC
	INC
CODE_00FDDB:
	TAX
	BRA.b CODE_00FDE1

CODE_00FDDE:
	LDX.w #$000A
CODE_00FDE1:
	PLY
	PHY
CODE_00FDE3:
	LDA.l DATA_02C100,x
	STA.w $7F0000,y
	TXA
	CLC
	ADC.w #$0040
	TAX
	INY
	INY
	TYA
	AND.w #$001F
	CMP.w #$001C
	BNE.b CODE_00FDE3
	PLY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_00FDFE:
	PHA
	LDA.l $000C32
	CLC
	ADC.w #$0003
	PHA
	TXA
	SEC
	SBC.w #$000A
	LSR
	LSR
	LSR
	DEC
	CLC
	ADC.b $01,S
CODE_00FE14:
	CMP.b $01,S
	BCC.b CODE_00FE1E
	BEQ.b CODE_00FE1E
	SBC.b $01,S
	BRA.b CODE_00FE14

CODE_00FE1E:
	PLA
	PLA
	RTS

;--------------------------------------------------------------------

CODE_00FE21:
	PHX
	PHY
	JSR.w CODE_00FDFE
	BCC.b CODE_00FE2D
	PEA.w $0008
	BRA.b CODE_00FE30

CODE_00FE2D:
	PEA.w $0000
CODE_00FE30:
	TYA
	SEC
	SBC.w #$0100
	BCC.b CODE_00FE50
	AND.w #$0060
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC.b $01,S
	TAX
	LDA.l DATA_02C100+$02E0,x
	STA.w $0016,y
	LDA.l DATA_02C100+$0320,x
	STA.w $0018,y
CODE_00FE50:
	PLA
	PLY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_00FE54:
	PHB
	PEA.w $7F7F
	PLB
	PLB
	LDA.l $0009E0
	AND.w #$0007
	STA.l $000172
	LDA.l $0009E0
	AND.w #$FFF8
	ASL
	ASL
	TAY
	LDX.w #$0000
CODE_00FE72:
	LDA.w $7F0000,y
	STA.l $7E2940,x
	INY
	INY
	TXA
	CLC
	ADC.w #$0040
	TAX
	AND.w #$07C0
	CMP.w #$0380
	BNE.b CODE_00FE72
	TXA
	SEC
	SBC.w #$037E
	TAX
	INY
	INY
	INY
	INY
	CPX.w #$0040
	BNE.b CODE_00FE72
	PLB
	JSL.l CODE_01DEB2
	RTS

;--------------------------------------------------------------------

CODE_00FE9E:
	LDA.w #$3DFF
	JSL.l CODE_01E033
	LDX.w #$3FFE
CODE_00FEA8:
	STA.l $7F0000,x
	DEX
	DEX
	BPL.b CODE_00FEA8
	RTS

;--------------------------------------------------------------------

CODE_00FEB1:
	LDA.w $0E8C
	CMP.w #$000F
	BNE.b CODE_00FEF8
	LDA.w $0EB4
	STA.w $0E8C
	LDA.w $0122
	AND.w #$0080
	PHA
	BNE.b CODE_00FECC
	JSL.l CODE_01E2F3
CODE_00FECC:
	LDA.w $0EB6
	BEQ.b CODE_00FEE2
	INC
	INC
	PHA
	LDA.w $0C32
	INC
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0002
	PHA
	BRA.b CODE_00FEEE

CODE_00FEE2:
	LDA.w $0C32
	INC
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
CODE_00FEEE:
	JSR.w CODE_009FC4
	PLA
	BNE.b CODE_00FEF8
	JSL.l CODE_01E30E
CODE_00FEF8:
	RTS

;--------------------------------------------------------------------

CODE_00FEF9:
	LDA.w $04CA
	BIT.w #$0020
	BNE.b CODE_00FF02
	RTS

CODE_00FF02:
	LDA.w #$000D
	JSL.l CODE_01D368
	JSR.w CODE_00FCF4
	LDA.b $AC
	SEC
	SBC.w #$0003
	STA.w $0EB6
	JSL.l CODE_01E93A
	LDA.w $0C26
	BNE.b CODE_00FF23
	LDA.w #$0C16
	BRA.b CODE_00FF26

CODE_00FF23:
	LDA.w #$0C36
CODE_00FF26:
	LDX.w #$0554
	LDY.w #$0003
	JSR.w CODE_00FB47
	JSL.l CODE_01DE97
	JMP.w CODE_00FD18

;--------------------------------------------------------------------

CODE_00FF36:
	LDA.w #$2540
	STA.l $7E264A
	INC
	STA.l $7E264C
	LDA.w #$2550
	STA.l $7E268A
	INC
	STA.l $7E268C
	LDA.w #$2560
	STA.l $7E26CA
	INC
	STA.l $7E26CC
	JSL.l CODE_01DE97
	RTS

;--------------------------------------------------------------------

CODE_00FF5F:
	LDA.w $0122
	AND.w #$0080
	PHA
	BNE.b CODE_00FF6C
	JSL.l CODE_01E2F3
CODE_00FF6C:
	LDA.w $0E8C
	CMP.w #$000E
	BEQ.b CODE_00FF7E
	AND.w #$FF00
	STA.b $A8
	JSR.w CODE_0096E1
	BRA.b CODE_00FFAE

CODE_00FF7E:
	LDY.w #$0000
	TYX
CODE_00FF82:
	LDA.l DATA_089C00,x
	STA.w $1C2A,y
	STA.w $1CAA,y
	INX
	INX
	INY
	INY
	CPY.w #$0040
	BNE.b CODE_00FF82
	TXA
	CLC
	ADC.w #$01C0
	TAX
CODE_00FF9B:
	LDA.l DATA_089C00,x
	STA.w $1C2A,y
	STA.w $1CAA,y
	INX
	INX
	INY
	INY
	CPY.w #$0080
	BNE.b CODE_00FF9B
CODE_00FFAE:
	JSR.w CODE_00E64F
	PLA
	BNE.b CODE_00FFB8
	JSL.l CODE_01E30E
CODE_00FFB8:
	RTS

;--------------------------------------------------------------------

%FREE_BYTES(NULLROM, 7, $00)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank01Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

CODE_018000:
	PHP
	PHB
	JSL.l CODE_00D6D3
	SEP.b #$20
	JSL.l CODE_01E30E
	JSL.l CODE_01E87B
	JSL.l CODE_01E88A
	SEI
	LDA.b #$00
CODE_018017:
	DEC
	BNE.b CODE_018017
	STZ.w !REGISTER_CGRAMAddress
	LDA.b #$00
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToCGRAMPort
	STA.w DMA[$00].Destination
	LDA.b #DATA_02FC00
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_02FC00>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_02FC00>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$02
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$40
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_09C000
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_09C000>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_09C000>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$40
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	CLI
	JSL.l CODE_01E2F3
	LDA.b #$13
	STA.w $011A
	STA.w !REGISTER_MainScreenLayers
	STA.w $011C
	STA.w !REGISTER_MainScreenWindowMask
	LDA.b #$04
	STA.w !REGISTER_BG1And2TileDataDesignation
	STA.w $010E
	LDA.b #$44
	STA.w !REGISTER_BG3And4TileDataDesignation
	STA.w $010F
	REP.b #$20
	LDA.w #$0045
	JSL.l CODE_01E024
	JSL.l CODE_01DE97
	LDA.w #$0000
	JSL.l CODE_01E033
	JSL.l CODE_008A12
	LDA.w #$0000
	STA.w $0170
	STA.w $016E
	STA.w $0174
	STA.w $0172
	JSL.l CODE_01DFD3
	PEA.w $7F7F
	PLB
	PLB
	STZ.w $7F021B
	JSL.l CODE_01E06F
	LDA.w #$FFFF
	JSR.w CODE_018C43
	JSL.l CODE_01E794
	STZ.w $7F0001
	LDA.w #$00EF
	STA.w $7F0005
	PHP
	TSC
	DEC
	DEC
	STA.w $7F0003
	STZ.w !RAM_MPAINT_TitleScreen_WaitBeforeStartingDemo
	JSR.w CODE_018260
	JSL.l CODE_008A75
	PLP
	LDA.w #$0000
	JSL.l CODE_01D2BF
	JSL.l CODE_01E7C9
	LDA.w #$0000
	STA.l $000172
	STA.l $000174
	JSL.l CODE_01E06F
	LDA.w #$FFFF
	STA.l $000220
	PLB
	LDA.w !RAM_MPAINT_Global_DemoActiveFlag
	BEQ.b CODE_018124
	PLP
	RTL

CODE_018124:
	LDA.w $0565
	BEQ.b CODE_01812D
	PLP
	JMP.w CODE_019372

CODE_01812D:
	SEP.b #$20
	JSL.l CODE_01E30E
	JSL.l CODE_01E87B
	JSL.l CODE_01E88A
	SEI
	LDA.b #$00
CODE_01813E:
	DEC
	BNE.b CODE_01813E
	STZ.w !REGISTER_CGRAMAddress
	LDA.b #$00
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToCGRAMPort
	STA.w DMA[$00].Destination
	LDA.b #DATA_02FC00
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_02FC00>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_02FC00>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$02
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$47
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_04EA00
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_04EA00>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_04EA00>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$0E
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	REP.b #$20
	LDA.w #$0000
	STA.w $0547
	JSL.l CODE_01E20C
	CMP.w #$00C0
	ROL.w $0547
	BNE.b CODE_0181E3
	CLI
	JSL.l CODE_01E2F3
	SEP.b #$20
	JSL.l CODE_01D388
	JSL.l CODE_01E30E
	LDA.b #DATA_179000
	STA.b $CC
	LDA.b #DATA_179000>>8
	STA.b $CD
	LDA.b #DATA_179000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
	REP.b #$20
	JSL.l CODE_01E2F3
	BRA.b CODE_01820D

CODE_0181E3:
	CLI
	JSL.l CODE_01E2F3
	SEP.b #$20
	JSL.l CODE_01D388
	JSL.l CODE_01E30E
	LDA.b #DATA_168000
	STA.b $CC
	LDA.b #DATA_168000>>8
	STA.b $CD
	LDA.b #DATA_168000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
	REP.b #$20
	JSL.l CODE_01E2F3
CODE_01820D:
	SEP.b #$20
	LDA.b #$04
	STA.w !REGISTER_BG1And2TileDataDesignation
	STA.w $010E
	LDA.b #$44
	STA.w !REGISTER_BG3And4TileDataDesignation
	STA.w $010F
	REP.b #$20
	LDA.w #$0045
	JSL.l CODE_01E024
	JSL.l CODE_01DE97
	LDA.w #$0000
	JSL.l CODE_01E033
	JSL.l CODE_008A12
	PHB
	PEA.w $7F7F
	PLB
	PLB
	LDA.l $000547
	BNE.b CODE_01824C
	LDA.w #$0021
	JSL.l CODE_01D308
	BRA.b CODE_018253

CODE_01824C:
	LDA.w #$0022
	JSL.l CODE_01D308
CODE_018253:
	JSR.w CODE_018F52
	LDA.w #$FFFF
	STA.l $000220
	PLB
	PLP
	RTL

;--------------------------------------------------------------------

CODE_018260:
	JSL.l CODE_01E06F
	JSR.w CODE_0182B1
	JSR.w CODE_0182F6
	JSR.w CODE_018308
	JSR.w CODE_018CBF
	LDA.l $0004C6
	ORA.l $0004C8
	ORA.l $0004CA
	BEQ.b CODE_018283
	STZ.w !RAM_MPAINT_TitleScreen_WaitBeforeStartingDemo
	BRA.b CODE_018260

CODE_018283:
	INC.w !RAM_MPAINT_TitleScreen_WaitBeforeStartingDemo
	LDA.w !RAM_MPAINT_TitleScreen_WaitBeforeStartingDemo
	CMP.w #$0800
	BNE.b CODE_018260
	LDA.w #$0080
	STA.l $0004DC
	STA.l $0004DE
	JSL.l CODE_0FC00E
	LDA.w #$0100
	STA.l $000448
	LDA.l $000002
	JSL.l CODE_01E238
	LDA.w $0003
	TCS
	RTS

;--------------------------------------------------------------------

CODE_0182B1:
	LDA.l $0004C6
	AND.w #$00FF
	BIT.w #$0080
	BEQ.b CODE_0182C0
	ORA.w #$FF00
CODE_0182C0:
	CLC
	ADC.l $0004DC
	CMP.w #$00E8
	BPL.b CODE_0182D3
	CMP.w #$0018
	BMI.b CODE_0182D3
	STA.l $0004DC
CODE_0182D3:
	LDA.l $0004C8
	AND.w #$00FF
	BIT.w #$0080
	BEQ.b CODE_0182E2
	ORA.w #$FF00
CODE_0182E2:
	CLC
	ADC.l $0004DE
	CMP.w #$00C0
	BPL.b CODE_0182F5
	CMP.w #$0020
	BMI.b CODE_0182F5
	STA.l $0004DE
CODE_0182F5:
	RTS

;--------------------------------------------------------------------

CODE_0182F6:
	LDA.l $0004DC
	TAX
	LDA.l $0004DE
	TAY
	LDA.w $0005
	JSL.l CODE_01F91E
	RTS

CODE_018308:
	LDA.w $0001
	ASL
	TAX
	JMP.w (DATA_018310,x)

DATA_018310:
	dw CODE_018328
	dw CODE_01833F
	dw CODE_01834B
	dw CODE_0183B6
	dw CODE_0184E2
	dw CODE_018521
	dw CODE_0185A3
	dw CODE_018641
	dw CODE_0187F9
	dw CODE_01885F
	dw CODE_0188E3
	dw CODE_018AAF

;--------------------------------------------------------------------

CODE_018328:
	LDA.w #$00EF
	STA.w $0005
	LDA.w #$0000
	JSL.l CODE_019DFE
	LDA.w #$FFFF
	JSR.w CODE_018C43
	INC.w $0001
	RTS

;--------------------------------------------------------------------

CODE_01833F:
	LDA.w #$FFFF
	JSR.w CODE_018C43
	JSR.w CODE_018CB7
	JMP.w CODE_018D35

;--------------------------------------------------------------------

CODE_01834B:
	LDA.w #$FFFF
	JSR.w CODE_018C43
	LDX.w #$00D0
	LDY.w #$0004
	JSR.w CODE_0191FE
	JSR.w CODE_018CB7
	LDA.l $000593
	AND.w #$00FF
	BNE.b CODE_018389
	LDA.l $000797
	AND.w #$00FF
	CMP.w #$00F0
	BEQ.b CODE_018378
	CMP.w #$00FB
	BEQ.b CODE_0183AF
CODE_018377:
	RTS

CODE_018378:
	LDA.l $000796
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_018377
	LDA.w #$004D
	BRA.b CODE_0183AA

CODE_018389:
	LDA.l $000797
	AND.w #$00FF
	CMP.w #$0083
	BEQ.b CODE_01839B
	CMP.w #$008E
	BEQ.b CODE_0183AF
	RTS

CODE_01839B:
	LDA.l $000796
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_018377
	LDA.w #$004E
CODE_0183AA:
	JSL.l CODE_01D368
	RTS

CODE_0183AF:
	LDA.w #$0001
	STA.w $0001
	RTS

;--------------------------------------------------------------------

CODE_0183B6:
	LDA.w #$FFFF
	JSR.w CODE_018C43
	JSR.w CODE_018CB7
	JSR.w CODE_018CBF
	STZ.w $0213
CODE_0183C5:
	LDA.w #$0000
	STA.l $000446
	JSR.w CODE_0182B1
	JSR.w CODE_0182F6
	LDA.w $0213
	BNE.b CODE_01842E
	LDA.l $00079F
	AND.w #$00FF
	CMP.w #$000A
	BEQ.b CODE_0183E6
	JMP.w CODE_0184AB

CODE_0183E6:
	LDA.l $000792
	SEC
	SBC.l $00079A
	CLC
	ADC.w #$0010
	CMP.w #$0020
	BCC.b CODE_0183FB
	JMP.w CODE_0184AB

CODE_0183FB:
	LDA.w #$0006
	JSL.l CODE_01D348
	INC.w $0213
	LDA.l $00079C
	STA.w $0215
	LDA.l $000794
	STA.w $0219
	LDA.l $000797
	AND.w #$00FF
	ASL
	ASL
	TAX
	LDA.l DATA_0F8060+$03,x
	AND.w #$007F
	CLC
	ADC.l $000798
	STA.w $0217
	BRA.b CODE_0184AB

CODE_01842E:
	LDA.w $0213
	CMP.w #$0002
	BCS.b CODE_01845F
	LDA.l $00079C
	CMP.w #$01E2
	BEQ.b CODE_018453
	PHA
	SEC
	SBC.w $0215
	CLC
	ADC.l $000794
	STA.l $000794
	PLA
	STA.w $0215
	BRA.b CODE_018489

CODE_018453:
	INC.w $0213
	LDA.w #$0000
	STA.l $000794
	BRA.b CODE_018489

CODE_01845F:
	CMP.w #$00C0
	BEQ.b CODE_01846A
	INC
	STA.w $0213
	BRA.b CODE_018489

CODE_01846A:
	LDA.l $000794
	INC
	INC
	AND.w #$01FE
	CMP.w $0219
	BEQ.b CODE_018482
	INC
	INC
	AND.w #$01FE
	CMP.w $0219
	BNE.b CODE_018485
CODE_018482:
	STZ.w $0213
CODE_018485:
	STA.l $000794
CODE_018489:
	LDA.w #$0001
	JSL.l CODE_01962C
	LDA.w #$0001
	JSR.w CODE_018C43
	LDA.l $000792
	LSR
	TAX
	LDA.l $000794
	LSR
	TAY
	LDA.w $0217
	JSL.l CODE_01FA68
	BRA.b CODE_0184BB

CODE_0184AB:
	LDA.w #$0001
	JSL.l CODE_01962C
	LDA.w #$0001
	JSR.w CODE_018C43
	JSR.w CODE_018CB7
CODE_0184BB:
	LDA.l $00079C
	BNE.b CODE_0184C8
	LDA.w #$0050
	JSL.l CODE_01D368
CODE_0184C8:
	LDA.l $000595
	AND.w #$00FF
	BEQ.b CODE_0184D8
	LDA.w #$0001
	STA.w $0001
	RTS

CODE_0184D8:
	JSL.l CODE_01E09B
	JSR.w CODE_018CBF
	JMP.w CODE_0183C5

;--------------------------------------------------------------------

CODE_0184E2:
	LDA.w #$0002
	JSL.l CODE_01962C
	LDA.w #$0002
	JSR.w CODE_018C43
	JSR.w CODE_018CB7
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_01850A
	LDX.w #$0002
	JSR.w CODE_019244
	BCS.b CODE_01850A
	LDA.w #$0051
	JSL.l CODE_01D368
CODE_01850A:
	LDA.l $000596
	AND.w #$00FF
	BEQ.b CODE_018520
	LDA.w #$0052
	JSL.l CODE_01D368
	LDA.w #$0001
	STA.w $0001
CODE_018520:
	RTS

;--------------------------------------------------------------------

CODE_018521:
	LDA.w #$FFFF
	JSR.w CODE_018C43
	JSR.w CODE_018CB7
	LDA.w $0207
	DEC.w $0207
	CMP.w #$007F
	BCC.b CODE_01853E
	EOR.w #$FFFF
	CLC
	ADC.w #$009E
	BRA.b CODE_018546

CODE_01853E:
	CMP.w #$001F
	BCC.b CODE_018546
	LDA.w #$001E
CODE_018546:
	PHA
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.b $01,S
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.b $01,S
	STA.w $0121
	EOR.w #$FFFF
	CLC
	ADC.w #$7BDF
	STA.w $0007
	PLA
	LDA.w #$0000
	STA.l $000202
	LDX.w #$0007
CODE_01856F:
	LDA.l DATA_01859B,x
	STA.l $000182,x
	DEX
	BPL.b CODE_01856F
	LDA.w #$0007
	STA.l $000204
	LDA.w #$0001
	STA.l $000202
	LDA.w $0207
	BPL.b CODE_01859A
	LDA.w #$0054
	JSL.l CODE_01D368
	LDA.w #$0001
	STA.w $0001
CODE_01859A:
	RTS

DATA_01859B:
	db $01 : dl $7F0007 : dw $0200,$0000

;--------------------------------------------------------------------

CODE_0185A3:
	LDA.w #$0003
	JSL.l CODE_01962C
	LDA.w #$0004
	JSR.w CODE_018C43
	LDA.l $000446
	STA.w $0209
	JSR.w CODE_018CB7
	LDA.l $000597
	AND.w #$00FF
	BEQ.b CODE_018630
	JSR.w CODE_018CBF
	LDA.w #$0056
	JSL.l CODE_01D368
	LDA.w #$0040
CODE_0185D0:
	PHA
	LDX.w #$00C8
CODE_0185D4:
	PHX
	TXA
	AND.w #$001C
	LSR
	TAX
	LDA.l DATA_018631,x
	PLX
	PHA
	SEP.b #$20
	LDA.l $00023A,x
	CLC
	ADC.b $01,S
	STA.l $00023A,x
	LDA.l $00023B,x
	CLC
	ADC.b $02,S
	STA.l $00023B,x
	REP.b #$20
	PLA
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_0185D4
	LDA.w $0209
	STA.l $000446
	JSR.w CODE_018CB7
	JSL.l CODE_01E09B
	JSR.w CODE_018CBF
	LDA.b $01,S
	CMP.w #$003F
	BNE.b CODE_018626
	JSR.w CODE_018CBF
	JSR.w CODE_018CBF
	JSR.w CODE_018CBF
	JSR.w CODE_018CBF
CODE_018626:
	PLA
	DEC
	BNE.b CODE_0185D0
	LDA.w #$0001
	STA.w $0001
CODE_018630:
	RTS

DATA_018631:
	dw $FCFC,$FC04,$0404,$04FC,$FC00,$0004,$0400,$00FC

;--------------------------------------------------------------------

CODE_018641:
	LDA.w #$FFFF
	JSR.w CODE_018C43
	LDX.w #$0088
	LDY.w #$0004
	JSR.w CODE_0191FE
	JSR.w CODE_018CB7
	JSR.w CODE_018CBF
CODE_018656:
	LDA.w #$0000
	STA.l $000446
	JSR.w CODE_0182B1
	JSR.w CODE_0182F6
	LDA.w $020B
	CMP.w #$0009
	BNE.b CODE_018674
	LDA.w #$0100
	STA.l $000446
	BRA.b CODE_0186A8

CODE_018674:
	LDA.w #$FFFF
	JSR.w CODE_018C43
	LDX.w $020B
	BEQ.b CODE_01869C
CODE_01867F:
	PHX
	LDA.l DATA_0187E1-$01,x
	AND.w #$00FF
	PHA
	LDA.l DATA_0187E9-$01,x
	AND.w #$00FF
	TAY
	LDA.w #$30ED
	PLX
	JSL.l CODE_01FA68
	PLX
	DEX
	BNE.b CODE_01867F
CODE_01869C:
	JSL.l CODE_01E20C
	CMP.w #$0008
	BCS.b CODE_0186A8
	INC.w $020B
CODE_0186A8:
	LDA.w #$000C
CODE_0186AB:
	PHA
	CMP.w #$0004
	BNE.b CODE_0186BB
	LDA.w $020B
	CMP.w #$0009
	BNE.b CODE_0186CC
	LDA.b $01,S
CODE_0186BB:
	JSL.l CODE_01962C
	LDA.b $01,S
	CMP.w #$000B
	BNE.b CODE_0186CC
	LDA.w #$FFFF
	JSR.w CODE_018CB7
CODE_0186CC:
	PLA
	DEC
	CMP.w #$0004
	BPL.b CODE_0186AB
	LDX.w #$0088
	LDY.w #$0004
	JSR.w CODE_0191FE
	LDA.l $0004CA
	BIT.w #$0020
	BNE.b CODE_0186E8
	JMP.w CODE_0187CC

CODE_0186E8:
	LDX.w #$000C
CODE_0186EB:
	JSR.w CODE_019244
	BCS.b CODE_018714
	CPX.w #$0004
	BNE.b CODE_01870C
	LDA.w $020B
	CMP.w #$0009
	BNE.b CODE_01870C
	INC.w $021B
	JSR.w CODE_019270
	LDA.w #$0020
	JSL.l CODE_01D308
	BRA.b CODE_018714

CODE_01870C:
	LDA.l DATA_0187ED-$01,x
	JSL.l CODE_01D368
CODE_018714:
	DEX
	CPX.w #$0004
	BPL.b CODE_0186EB
	LDX.w $020B
	BEQ.b CODE_018759
	CPX.w #$0009
	BNE.b CODE_018725
	DEX
CODE_018725:
	LDA.l DATA_0187E9-$01,x
	AND.w #$00FF
	SEC
	SBC.l $0004DE
	CLC
	ADC.w #$0008
	CMP.w #$0010
	BCS.b CODE_018756
	LDA.l DATA_0187E1-$01,x
	AND.w #$00FF
	SEC
	SBC.l $0004DC
	CLC
	ADC.w #$0008
	CMP.w #$0010
	BCS.b CODE_018756
	LDA.w #$0078
	JSL.l CODE_01D368
CODE_018756:
	DEX
	BNE.b CODE_018725
CODE_018759:
	LDA.l $0004DE
	CMP.w #$0040
	BCC.b CODE_0187CC
	CMP.w #$0050
	BCS.b CODE_0187CC
	LDA.l $0004DC
	SEC
	SBC.w #$0080
	CMP.w #$0010
	BCS.b CODE_0187CC
	JSR.w CODE_018CBF
	LDA.w #$0058
	JSL.l CODE_01D368
	SEP.b #$20
	LDA.b #$03
	STA.l $000111
	REP.b #$20
	LDA.w #$0000
CODE_01878B:
	PHA
	JSR.w CODE_018F1C
	LDA.w #$0001
	STA.l $000220
	JSL.l CODE_01E06F
	JSR.w CODE_0182B1
	JSR.w CODE_0182F6
	LDA.w #$FFFF
	JSR.w CODE_018C43
	JSR.w CODE_018CB7
	JSR.w CODE_018CBF
	PLA
	INC
	CMP.w #$007F
	BNE.b CODE_01878B
	LDA.w #$0045
	JSL.l CODE_01E024
	JSL.l CODE_01DE97
	LDA.w #$FFFF
	STA.l $000220
	LDA.w #$0001
	STA.w $0001
	RTS

CODE_0187CC:
	LDA.w $021B
	BEQ.b CODE_0187D7
	JSR.w CODE_0192D1
	JSR.w CODE_019329
CODE_0187D7:
	JSL.l CODE_01E09B
	JSR.w CODE_018CBF
	JMP.w CODE_018656

DATA_0187E1:
	db $B8,$30,$A0,$60,$E0,$50,$20,$D0

DATA_0187E9:
	db $B8,$D8,$D8,$B8

DATA_0187ED:
	db $C8,$D8,$B8,$D8,$75,$79,$77,$77
	db $77,$77,$76,$74

;--------------------------------------------------------------------

CODE_0187F9:
	LDA.w #$FFFF
	JSR.w CODE_018C43
	LDX.w #$0078
	LDY.w #$0004
	JSR.w CODE_0191FE
	LDA.w #$000D
	JSL.l CODE_01962C
	JSR.w CODE_018CB7
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_018848
	LDA.l $0004DC
	ASL
	SEC
	SBC.l $0007FA
	CLC
	ADC.w #$0020
	CMP.w #$0040
	BCS.b CODE_018848
	LDA.l $0004DE
	ASL
	SEC
	SBC.l $0007FC
	CLC
	ADC.w #$0040
	CMP.w #$0040
	BCS.b CODE_018848
	LDA.w #$007A
	JSL.l CODE_01D368
CODE_018848:
	LDA.l $0005A0
	AND.w #$00FF
	BEQ.b CODE_01885E
	LDA.w #$005A
	JSL.l CODE_01D368
	LDA.w #$0001
	STA.w $0001
CODE_01885E:
	RTS

;--------------------------------------------------------------------

CODE_01885F:
	LDA.w #$FFFF
	JSR.w CODE_018C43
	LDX.w #$0070
	LDY.w #$0002
	JSR.w CODE_0191FE
	JSR.w CODE_018CB7
	JSR.w CODE_018CBF
CODE_018874:
	JSL.l CODE_01E30E
	LDA.w #$0000
	STA.l $000446
	JSR.w CODE_0182B1
	JSR.w CODE_0182F6
	LDA.w #$0025
CODE_018888:
	PHA
	JSL.l CODE_01962C
	PLA
	DEC
	CMP.w #$000E
	BPL.b CODE_018888
	JSR.w CODE_018CB7
	LDX.w #$0070
	LDY.w #$0002
	JSR.w CODE_0191FE
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_0188D6
	LDA.l $0004DE
	CMP.w #$0040
	BCC.b CODE_0188D6
	CMP.w #$0050
	BCS.b CODE_0188D6
	LDA.l $0004DC
	SEC
	SBC.w #$00A0
	CMP.w #$0008
	BCS.b CODE_0188D6
	LDA.w #$005C
	JSL.l CODE_01D368
	LDA.w #$0001
	STA.w $0001
	JSL.l CODE_01E2F3
	RTS

CODE_0188D6:
	JSL.l CODE_01E09B
	JSL.l CODE_01E2F3
	JSR.w CODE_018CBF
	BRA.b CODE_018874

;--------------------------------------------------------------------

CODE_0188E3:
	LDA.w #$FFFF
	JSR.w CODE_018C43
	LDX.w #$0060
	LDY.w #$0004
	JSR.w CODE_0191FE
	JSR.w CODE_018CB7
	JSR.w CODE_018CBF
	STZ.w !RAM_MPAINT_TitleScreen_CreditsLineIndex
	LDA.w #$0001
	STA.w !RAM_MPAINT_TitleScreen_WaitBeforeDisplayingNextCreditsLine
CODE_018901:
	JSL.l CODE_01E30E
	LDA.w #$0000
	STA.l $000446
	JSR.w CODE_0182B1
	JSR.w CODE_0182F6
	LDA.w #$00E0
	STA.l $000446
	LDA.l $000798
	ORA.w #$3000
	STA.l $000798
	JSR.w CODE_018CB7
	DEC.w !RAM_MPAINT_TitleScreen_WaitBeforeDisplayingNextCreditsLine
	BNE.b CODE_01894B
CODE_01892C:
	LDA.w !RAM_MPAINT_TitleScreen_CreditsLineIndex
	INC.w !RAM_MPAINT_TitleScreen_CreditsLineIndex
	ASL
	TAX
	LDA.l DATA_018A09,x
	BEQ.b CODE_01899A
	BMI.b CODE_018941
	JSR.w CODE_018C19
	BRA.b CODE_01892C

CODE_018941:
	LDA.w #$00FF
	STA.w !RAM_MPAINT_TitleScreen_WaitBeforeDisplayingNextCreditsLine
	JSL.l CODE_01DE97
CODE_01894B:
	LDX.w #$0060
	LDY.w #$0004
	JSR.w CODE_0191FE
	LDA.w #$0000
	STA.l $00099F
	LDA.w !RAM_MPAINT_TitleScreen_CreditsLineIndex
	CMP.w #$0009
	BNE.b CODE_018976
	LDA.l $0004CA
	AND.w #$0021
	CMP.w #$0021
	BNE.b CODE_018976
	LDA.w #$0001
	STA.l $00099F
CODE_018976:
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_0189E2
	LDA.l $0004DE
	CMP.w #$0040
	BCC.b CODE_0189E2
	CMP.w #$0050
	BCS.b CODE_0189E2
	LDA.l $0004DC
	SEC
	SBC.w #$00A8
	CMP.w #$0010
	BCS.b CODE_0189E2
CODE_01899A:
	LDA.w #$0000
	STA.l $000172
	STA.l $000174
	SEP.b #$20
	LDA.b #$04
	STA.l $00010E
	REP.b #$20
	LDA.w #$0045
	JSL.l CODE_01E024
	JSL.l CODE_01DE97
	LDA.w #$0000
	JSL.l CODE_01E033
	JSL.l CODE_008A12
	LDA.l $000798
	AND.w #$EFFF
	STA.l $000798
	LDA.w #$005E
	JSL.l CODE_01D368
	LDA.w #$0001
	STA.w $0001
	JSL.l CODE_01E2F3
	RTS

CODE_0189E2:
	LDA.w !RAM_MPAINT_TitleScreen_WaitBeforeDisplayingNextCreditsLine
	CMP.w #$00FF
	BEQ.b CODE_0189F1
	JSR.w CODE_018B6E
	JSL.l CODE_01DE97
CODE_0189F1:
	LDA.w !RAM_MPAINT_TitleScreen_WaitBeforeDisplayingNextCreditsLine
	JSR.w CODE_018BB5
	JSL.l CODE_01DEB2
	JSL.l CODE_01E09B
	JSL.l CODE_01E2F3
	JSR.w CODE_018CBF
	JMP.w CODE_018901

DATA_018A09:
	dw $0D00,$0F01,$FFFF,$0D02,$0F03,$FFFF,$0D04,$0F05
	dw $FFFF,$0D2F,$0F2F,$0C04,$0E06,$0F07,$1008,$FFFF
	dw $0C09,$0E0A,$0F0C,$100B,$FFFF,$0C2F,$0E2F,$0F2F
	dw $102F,$0D0D,$0F0E,$FFFF,$0D0F,$0F10,$FFFF,$0D2F
	dw $0F2F,$0E11,$FFFF,$0E2F,$0D12,$0E13,$0F14,$FFFF
	dw $0D2F,$0E2F,$0F2F,$0D15,$0F16,$FFFF,$0D2F,$0F2F
	dw $0E17,$FFFF,$0E2F,$0D18,$0E19,$0F1A,$FFFF,$0D1B
	dw $0E1C,$0F1D,$FFFF,$0D1E,$0E1F,$0F20,$1021,$FFFF
	dw $102F,$0D22,$0E23,$0F24,$FFFF,$0D25,$0E26,$0F27
	dw $FFFF,$0D28,$0E29,$0F2A,$FFFF,$0D2B,$0E2C,$0F2D
	dw $102E,$FFFF,$0000

;--------------------------------------------------------------------

CODE_018AAF:
	LDA.w #$FFFF
	JSR.w CODE_018C43
	LDX.w #$0040
	LDY.w #$0004
	JSR.w CODE_0191FE
	JSR.w CODE_018CB7
	JSR.w CODE_018CBF
	LDA.w #$0000
	STA.l $000020
CODE_018ACB:
	JSL.l CODE_01E30E
	LDA.w #$0000
	STA.l $000446
	JSR.w CODE_0182B1
	JSR.w CODE_0182F6
	LDA.w #$00D0
	STA.l $000446
	JSR.w CODE_018CB7
	JSL.l CODE_01E09B
	JSL.l CODE_01E2F3
	LDA.l $000020
	BNE.b CODE_018AFD
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_018B5F
CODE_018AFD:
	LDA.l $0004DC
	STA.l $000086
	LDA.l $0004DE
	STA.l $000088
	JSL.l CODE_00B046
	LDY.w #$0000
	LDA.l $0004CA
	BIT.w #$0010
	BEQ.b CODE_018B1E
	INY
CODE_018B1E:
	TYA
	STA.l $000020
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_018B5F
	LDA.l $0004DE
	CMP.w #$0040
	BCC.b CODE_018B5F
	CMP.w #$0050
	BCS.b CODE_018B5F
	LDA.l $0004DC
	SEC
	SBC.w #$00B8
	CMP.w #$0010
	BCS.b CODE_018B5F
	LDA.w #$00EF
	STA.w $0005
	LDA.w #$0060
	JSL.l CODE_01D368
	LDA.w #$0001
	STA.w $0001
	JSL.l CODE_008A75
	RTS

CODE_018B5F:
	LDX.w #$0040
	LDY.w #$0004
	JSR.w CODE_0191FE
	JSR.w CODE_018CBF
	JMP.w CODE_018ACB

;--------------------------------------------------------------------

CODE_018B6E:
	CMP.w #$0010
	BCC.b CODE_018B82
	CMP.w #$0050
	BCC.b CODE_018B92
	CMP.w #$0090
	BCC.b CODE_018B87
	CMP.w #$00D0
	BCC.b CODE_018B8C
CODE_018B82:
	LDA.w #$003F
	BRA.b CODE_018B99

CODE_018B87:
	LDA.w #$0000
	BRA.b CODE_018B99

CODE_018B8C:
	SEC
	SBC.w #$0090
	BRA.b CODE_018B99

CODE_018B92:
	EOR.w #$FFFF
	CLC
	ADC.w #$0050
CODE_018B99:
	AND.w #$0038
	XBA
	LSR
	PHA
	LDX.w #$017E
CODE_018BA2:
	LDA.l $7E22C0,x
	AND.w #$E3FF
	ORA.b $01,S
	STA.l $7E22C0,x
	DEX
	DEX
	BPL.b CODE_018BA2
	PLA
	RTS

;--------------------------------------------------------------------

CODE_018BB5:
	CMP.w #$0040
	BCC.b CODE_018BDF
	CMP.w #$0040
	BCC.b CODE_018BD3
	CMP.w #$00A0
	BCC.b CODE_018BFA
	CMP.w #$00A0
	BCC.b CODE_018BD3
	CMP.w #$00E0
	BCC.b CODE_018BD8
	LDA.w #$0000
	BRA.b CODE_018BDF

CODE_018BD3:
	LDA.w #$3C45
	BRA.b CODE_018BE3

CODE_018BD8:
	EOR.w #$FFFF
	CLC
	ADC.w #$00E0
CODE_018BDF:
	CLC
	ADC.w #$3CE0
CODE_018BE3:
	LDX.w #$017E
CODE_018BE6:
	STA.l $7E2AC0,x
	DEX
	DEX
	BPL.b CODE_018BE6
	LDA.w #$0000
	STA.l $000172
	STA.l $000174
	RTS

CODE_018BFA:
	LDX.w #$017E
CODE_018BFD:
	LDA.l $7E22C0,x
	CLC
	ADC.w #$1800
	STA.l $7E2AC0,x
	DEX
	DEX
	BPL.b CODE_018BFD
	LDA.w #$FFFE
	STA.l $000172
	STA.l $000174
	RTS

;--------------------------------------------------------------------

CODE_018C19:
	PHB
	PHA
	AND.w #$00FF
	XBA
	LSR
	LSR
	TAX
	PLA
	AND.w #$FF00
	LSR
	LSR
	TAY
	PEA.w $7E7E
	PLB
	PLB
	LDA.w #$0020
CODE_018C31:
	PHA
	LDA.l DATA_02C700,x
	STA.w $7E2000,y
	INX
	INX
	INY
	INY
	PLA
	DEC
	BNE.b CODE_018C31
	PLB
	RTS

;--------------------------------------------------------------------

CODE_018C43:
	PHA
	LDX.w #$0017
CODE_018C47:
	TXA
	CMP.b $01,S
	BEQ.b CODE_018C6A
	PHX
	LDA.l DATA_018C6F,x
	AND.w #$00FF
	PHA
	LDA.l DATA_018C87,x
	AND.w #$00FF
	TAY
	LDA.l DATA_018C9F,x
	AND.w #$00FF
	PLX
	JSL.l CODE_01F91E
	PLX
CODE_018C6A:
	DEX
	BPL.b CODE_018C47
	PLA
	RTS

DATA_018C6F:
	db $40,$50,$60,$68,$78,$88,$98,$A0
	db $B0,$C0,$4D,$55,$5C,$64,$6C,$84
	db $89,$8E,$93,$98,$9F,$A6,$AD,$C8

DATA_018C87:
	db $48,$48,$48,$48,$48,$48,$48,$48
	db $48,$48,$C4,$C4,$C4,$C4,$C4,$C4
	db $C4,$C4,$C4,$C4,$C4,$C4,$C4,$48

DATA_018C9F:
	db $CC,$CD,$CE,$CF,$D0,$D1,$CD,$CF
	db $D2,$D3,$D4,$D5,$D6,$D6,$D7,$F0
	db $D9,$D8,$DA,$DB,$D8,$DC,$DD,$F1

;--------------------------------------------------------------------

CODE_018CB7:
	LDA.w #$0000
	JSL.l CODE_01962C
	RTS

;--------------------------------------------------------------------

CODE_018CBF:
	LDA.l $00013C
	BIT.w #$9080
	BEQ.b CODE_018CD1
	LDA.l $000134
	CMP.w #$9080
	BEQ.b CODE_018D1B
CODE_018CD1:
	LDA.l $00013C
	BIT.w #$A080
	BEQ.b CODE_018CE3
	LDA.l $000134
	CMP.w #$A080
	BEQ.b CODE_018D24
CODE_018CE3:
	LDA.l $000134
	CMP.w #$FFFF
	BEQ.b CODE_018D24
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_018D30
	LDA.l $0004DE
	ASL
	SEC
	SBC.l $000794
	CLC
	ADC.w #$0040
	CMP.w #$0048
	BCS.b CODE_018D30
	LDA.l $0004DC
	ASL
	SEC
	SBC.l $000792
	CLC
	ADC.w #$0030
	CMP.w #$0060
	BCS.b CODE_018D30
CODE_018D1B:
	LDA.w #$0000
	STA.l $000565
	BRA.b CODE_018D2B

CODE_018D24:
	LDA.w #$0001
	STA.l $000565
CODE_018D2B:
	LDA.w $0003
	TCS
	RTS

CODE_018D30:
	JSL.l CODE_01E2CE
	RTS

;--------------------------------------------------------------------

CODE_018D35:
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_018D4C
	LDA.l $0004DE
	CMP.w #$0040
	BCC.b CODE_018D4C
	CMP.w #$0050
	BCC.b CODE_018D4D
CODE_018D4C:
	RTS

CODE_018D4D:
	SEP.b #$20
	LDX.w #$0012
CODE_018D52:
	LDA.l $0004DC
	SEC
	SBC.l DATA_018D85,x
	CMP.l DATA_018D85+$01,x
	BCC.b CODE_018D68
	DEX
	DEX
	BPL.b CODE_018D52
	REP.b #$20
	RTS

CODE_018D68:
	REP.b #$20
	TXA
	LSR
	ASL
	TAX
	JMP.w (DATA_018D71,x)

DATA_018D71:
	dw CODE_018D99
	dw CODE_018DAE
	dw CODE_018DC3
	dw CODE_018DD8
	dw CODE_018DFA
	dw CODE_018E0F
	dw CODE_018E8E
	dw CODE_018EA3
	dw CODE_018EC0
	dw CODE_018F04

DATA_018D85:
	db $38,$10,$48,$10,$58,$10,$68,$08
	db $70,$10,$80,$10,$90,$10,$A0,$08
	db $A8,$10,$B8,$10

;--------------------------------------------------------------------

CODE_018D99:
	SEP.b #$20
	LDA.l $000593
	EOR.b #$01
	STA.l $000593
	REP.b #$20
	LDA.w #$0002
	STA.w $0001
	RTS

;--------------------------------------------------------------------

CODE_018DAE:
	LDA.w #$004F
	JSL.l CODE_01D368
	LDA.w #$0001
	JSL.l CODE_019DFE
	LDA.w #$0003
	STA.w $0001
	RTS

;--------------------------------------------------------------------

CODE_018DC3:
	LDA.w #$0051
	JSL.l CODE_01D368
	LDA.w #$0002
	JSL.l CODE_019DFE
	LDA.w #$0004
	STA.w $0001
	RTS

;--------------------------------------------------------------------

CODE_018DD8:
	LDA.w #$0053
	JSL.l CODE_01D368
	LDX.w #$01FE
CODE_018DE2:
	LDA.l DATA_02FC00,x
	STA.w $0007,x
	DEX
	DEX
	BPL.b CODE_018DE2
	LDA.w #$009D
	STA.w $0207
	LDA.w #$0005
	STA.w $0001
	RTS

;--------------------------------------------------------------------

CODE_018DFA:
	LDA.w #$0055
	JSL.l CODE_01D368
	LDA.w #$0003
	JSL.l CODE_019DFE
	LDA.w #$0006
	STA.w $0001
	RTS

;--------------------------------------------------------------------

CODE_018E0F:
	LDA.w #$0057
	JSL.l CODE_01D368
	LDA.w #$000C
CODE_018E19:
	PHA
	JSL.l CODE_019DFE
	PLA
	DEC
	CMP.w #$0004
	BPL.b CODE_018E19
	STZ.w $020B
	LDX.w #$027E
CODE_018E2B:
	LDA.l DATA_02C480,x
	STA.l $7E24C0,x
	DEX
	DEX
	BPL.b CODE_018E2B
	JSL.l CODE_01DE97
	LDA.w #$0080
	JSR.w CODE_018F1C
	LDA.w #$0001
	STA.l $000220
	SEP.b #$20
	LDA.b #$03
	STA.l $000111
	REP.b #$20
	JSR.w CODE_018CBF
	LDA.w #$007F
CODE_018E58:
	PHA
	JSR.w CODE_018F1C
	LDA.w #$0001
	STA.l $000220
	JSL.l CODE_01E06F
	JSR.w CODE_0182B1
	JSR.w CODE_0182F6
	LDA.w #$FFFF
	JSR.w CODE_018C43
	JSR.w CODE_018CB7
	JSR.w CODE_018CBF
	PLA
	DEC
	BNE.b CODE_018E58
	LDA.w #$FFFF
	STA.l $000220
	STZ.w $021B
	LDA.w #$0007
	STA.w $0001
	RTS

;--------------------------------------------------------------------

CODE_018E8E:
	LDA.w #$0059
	JSL.l CODE_01D368
	LDA.w #$000D
	JSL.l CODE_019DFE
	LDA.w #$0008
	STA.w $0001
	RTS

;--------------------------------------------------------------------

CODE_018EA3:
	LDA.w #$005B
	JSL.l CODE_01D368
	LDA.w #$0025
CODE_018EAD:
	PHA
	JSL.l CODE_019DFE
	PLA
	DEC
	CMP.w #$000E
	BPL.b CODE_018EAD
	LDA.w #$0009
	STA.w $0001
	RTS

;--------------------------------------------------------------------

CODE_018EC0:
	LDA.w #$005D
	JSL.l CODE_01D368
	JSL.l CODE_01E30E
	SEP.b #$20
	LDA.b #$44
	STA.l $00010E
	REP.b #$20
	LDA.w #$0045
	JSL.l CODE_01E024
	JSL.l CODE_01DE97
	LDA.w #$1CE0
	JSL.l CODE_01E033
	LDA.w #$3CE0
	LDX.w #$017E
CODE_018EED:
	STA.l $7E2AC0,x
	DEX
	DEX
	BPL.b CODE_018EED
	JSL.l CODE_01DEB2
	LDA.w #$000A
	STA.w $0001
	JSL.l CODE_01E2F3
	RTS

;--------------------------------------------------------------------

CODE_018F04:
	LDA.w #$005F
	JSL.l CODE_01D368
	JSL.l CODE_0096CD
	LDA.w #$00EE
	STA.w $0005
	LDA.w #$000B
	STA.w $0001
	RTS

;--------------------------------------------------------------------

CODE_018F1C:
	PHA
	EOR.w #$FFFF
	PHA
	SEP.b #$20
	LDA.b #$70
	STA.l $7E4000
	LDA.b $03,S
	STA.l $7E4001
	LDA.b $01,S
	STA.l $7E4002
	LDA.b #$70
	STA.l $7E4003
	LDA.b $03,S
	STA.l $7E4004
	LDA.b $01,S
	STA.l $7E4005
	LDA.b #$00
	STA.l $7E4006
	REP.b #$20
	PLA
	PLA
	RTS

;--------------------------------------------------------------------

CODE_018F52:
	LDA.w #$24E0
	LDX.w #$07FE
CODE_018F58:
	STA.l $7E2000,x
	DEX
	DEX
	BPL.b CODE_018F58
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$0028
	JSL.l CODE_019DFE
	LDA.w #$0028
	JSL.l CODE_01962C
	SEP.b #$20
	LDA.b #$0F
	STA.l $000104
	REP.b #$20
	JSL.l CODE_01E2CE
	LDA.w #$0001
	STA.w $0211
	SEP.b #$20
	LDA.b #$02
	STA.l $000111
	REP.b #$20
	LDX.w #$0047
CODE_018F97:
	PHX
	LDA.w #$0080
	PHA
	LDA.w #$0070
	PHA
	TXA
	EOR.w #$FFFF
	CLC
	ADC.w #$0049
	PHA
	LDA.w $0211
	EOR.w #$0003
	STA.w $0211
	JSR.w CODE_01904A
	LDA.w $0211
	STA.l $000220
	JSL.l CODE_01E2CE
	PLX
	JSR.w CODE_01934F
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_018FD8
	TXA
	EOR.w #$FFFF
	CLC
	ADC.w #$0049
	TAX
	BRA.b CODE_019002

CODE_018FD8:
	DEX
	BNE.b CODE_018F97
CODE_018FDB:
	JSL.l CODE_01E06F
	LDA.w #$0028
	JSL.l CODE_01962C
	JSL.l CODE_01E2CE
	JSR.w CODE_01934F
	LDA.l $0004CA
	BIT.w #$0020
	BNE.b CODE_018FFF
	LDA.l $0005A9
	AND.w #$00FF
	BEQ.b CODE_018FDB
CODE_018FFF:
	LDX.w #$0048
CODE_019002:
	PHX
	LDA.w #$0080
	PHA
	LDA.w #$0070
	PHA
	TXA
	DEC
	PHA
	LDA.w $0211
	EOR.w #$0003
	STA.w $0211
	JSR.w CODE_01904A
	LDA.w $0211
	STA.l $000220
	LDA.b $01,S
	DEC
	LSR
	LSR
	BNE.b CODE_01902D
	LDA.w #$0080
	BRA.b CODE_019035

CODE_01902D:
	CMP.w #$000F
	BCC.b CODE_019035
	LDA.w #$000F
CODE_019035:
	SEP.b #$20
	STA.l $000104
	REP.b #$20
	JSL.l CODE_01E2CE
	PLX
	DEX
	BNE.b CODE_019002
	JSL.l CODE_01E06F
	RTS

CODE_01904A:
	JSR.w CODE_0191AC
	LDA.b $03,S
	PHA
	PEA.w $0000
	PEA.w $0000
	PEA.w $0000
CODE_019059:
	LDA.b $07,S
	CMP.b $05,S
	BCS.b CODE_019062
	JMP.w CODE_019125

CODE_019062:
	LDA.b $07,S
	ASL
	CLC
	ADC.b $07,S
	LSR
	LSR
	LSR
	LSR
	EOR.w #$FFFF
	INC
	CLC
	ADC.b $07,S
	STA.b $03,S
	LDA.b $05,S
	ASL
	CLC
	ADC.b $05,S
	LSR
	LSR
	LSR
	LSR
	EOR.w #$FFFF
	INC
	CLC
	ADC.b $05,S
	STA.b $01,S
	LDA.b $0F,S
	CLC
	ADC.b $03,S
	TAX
	LDA.b $0D,S
	CLC
	ADC.b $05,S
	TAY
	JSR.w CODE_01916E
	LDA.b $0F,S
	CLC
	ADC.b $03,S
	TAX
	LDA.b $0D,S
	SEC
	SBC.b $05,S
	TAY
	JSR.w CODE_01916E
	LDA.b $0F,S
	SEC
	SBC.b $03,S
	TAX
	LDA.b $0D,S
	CLC
	ADC.b $05,S
	TAY
	JSR.w CODE_019130
	LDA.b $0F,S
	SEC
	SBC.b $03,S
	TAX
	LDA.b $0D,S
	SEC
	SBC.b $05,S
	TAY
	JSR.w CODE_019130
	LDA.b $0F,S
	CLC
	ADC.b $01,S
	TAX
	LDA.b $0D,S
	CLC
	ADC.b $07,S
	TAY
	JSR.w CODE_01916E
	LDA.b $0F,S
	CLC
	ADC.b $01,S
	TAX
	LDA.b $0D,S
	SEC
	SBC.b $07,S
	TAY
	JSR.w CODE_01916E
	LDA.b $0F,S
	SEC
	SBC.b $01,S
	TAX
	LDA.b $0D,S
	CLC
	ADC.b $07,S
	TAY
	JSR.w CODE_019130
	LDA.b $0F,S
	SEC
	SBC.b $01,S
	TAX
	LDA.b $0D,S
	SEC
	SBC.b $07,S
	TAY
	JSR.w CODE_019130
	LDA.b $05,S
	TAX
	INC
	STA.b $05,S
	TXA
	ASL
	DEC
	EOR.w #$FFFF
	INC
	CLC
	ADC.b $0B,S
	STA.b $0B,S
	BMI.b CODE_019117
	JMP.w CODE_019059

CODE_019117:
	LDA.b $07,S
	DEC
	STA.b $07,S
	ASL
	CLC
	ADC.b $0B,S
	STA.b $0B,S
	JMP.w CODE_019059

CODE_019125:
	LDA.b $09,S
	STA.b $0F,S
	TSC
	CLC
	ADC.w #$000E
	TCS
	RTS

CODE_019130:
	CPY.w #$0000
	BMI.b CODE_019163
	CPY.w #$00E0
	BPL.b CODE_019163
	CPX.w #$0000
	BPL.b CODE_019142
	LDX.w #$0000
CODE_019142:
	TYA
	CMP.w #$0070
	BCS.b CODE_01914C
	ASL
	INC
	BRA.b CODE_01914E

CODE_01914C:
	INC
	ASL
CODE_01914E:
	TAY
	TXA
	TYX
	PHA
	LDA.w $0211
	CMP.w #$0001
	BNE.b CODE_019164
	PLA
	SEP.b #$20
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	REP.b #$20
CODE_019163:
	RTS

CODE_019164:
	PLA
	SEP.b #$20
	STA.l $7E4200,x
	REP.b #$20
	RTS

CODE_01916E:
	CPY.w #$0000
	BMI.b CODE_0191A1
	CPY.w #$00E0
	BPL.b CODE_0191A1
	CPX.w #$00FF
	BMI.b CODE_019180
	LDX.w #$00FF
CODE_019180:
	TYA
	CMP.w #$0070
	BCS.b CODE_01918A
	ASL
	INC
	BRA.b CODE_01918C

CODE_01918A:
	INC
	ASL
CODE_01918C:
	TAY
	TXA
	TYX
	PHA
	LDA.w $0211
	CMP.w #$0001
	BNE.b CODE_0191A2
	PLA
	SEP.b #$20
	STA.l $7E4001,x
	REP.b #$20
CODE_0191A1:
	RTS

CODE_0191A2:
	PLA
	SEP.b #$20
	STA.l $7E4201,x
	REP.b #$20
	RTS

CODE_0191AC:
	LDA.w $0211
	CMP.w #$0001
	BNE.b CODE_0191D9
	LDA.w #$00F0
	STA.l $7E4000
	STA.l $7E40E1
	LDA.w #$0000
	STA.l $7E41C2
	LDA.w #$0001
	LDX.w #$00DE
CODE_0191CC:
	STA.l $7E4001,x
	STA.l $7E40E2,x
	DEX
	DEX
	BPL.b CODE_0191CC
	RTS

CODE_0191D9:
	LDA.w #$00F0
	STA.l $7E4200
	STA.l $7E42E1
	LDA.w #$0000
	STA.l $7E43C2
	LDA.w #$0001
	LDX.w #$00DE
CODE_0191F1:
	STA.l $7E4201,x
	STA.l $7E42E2,x
	DEX
	DEX
	BPL.b CODE_0191F1
	RTS

;--------------------------------------------------------------------

CODE_0191FE:
	LDA.l $00016C
	AND.w #$0038
	XBA
	LSR
	LSR
	PHA
	LDA.l $000228,x
	AND.w #$F1FF
	ORA.b $01,S
	STA.l $000228,x
	LDA.l $00022C,x
	AND.w #$F1FF
	ORA.b $01,S
	STA.l $00022C,x
	CPY.w #$0002
	BEQ.b CODE_019242
	LDA.l $000230,x
	AND.w #$F1FF
	ORA.b $01,S
	STA.l $000230,x
	LDA.l $000234,x
	AND.w #$F1FF
	ORA.b $01,S
	STA.l $000234,x
CODE_019242:
	PLA
	RTS

;--------------------------------------------------------------------

CODE_019244:
	PHX
	TXA
	ASL
	ASL
	ASL
	TAX
	LDA.l $0004DE
	ASL
	SEC
	SBC.l $000794,x
	CLC
	ADC.w #$0010
	CMP.w #$0020
	BCS.b CODE_01926E
	LDA.l $0004DC
	ASL
	SEC
	SBC.l $000792,x
	CLC
	ADC.w #$0010
	CMP.w #$0020
CODE_01926E:
	PLX
	RTS

;--------------------------------------------------------------------

CODE_019270:
	PHX
	LDA.w #$0005
CODE_019274:
	PHA
	JSL.l CODE_01E2CE
	PLA
	DEC
	BNE.b CODE_019274
	LDX.w #$0040
CODE_019280:
	JSR.w CODE_019294
	JSL.l CODE_01E20C
	STA.w $03AD,x
	DEX
	DEX
	BPL.b CODE_019280
	JSL.l CODE_01E2CE
	PLX
	RTS

;--------------------------------------------------------------------

CODE_019294:
	JSL.l CODE_01E20C
	AND.w #$00FF
	XBA
	LSR
	STA.w $021D,x
	LDA.w #$F000
	STA.w $0281,x
	JSL.l CODE_01E20C
	AND.w #$001F
	BNE.b CODE_0192B2
	LDA.w #$0005
CODE_0192B2:
	CLC
	ADC.w #$00E5
	CMP.w #$00EE
	BCC.b CODE_0192BF
	CLC
	ADC.w #$00D2
CODE_0192BF:
	STA.w $02E5,x
	JSL.l CODE_01E20C
	AND.w #$003F
	CLC
	ADC.w #$0020
	STA.w $0349,x
	RTS

;--------------------------------------------------------------------

CODE_0192D1:
	LDX.w #$0040
CODE_0192D4:
	LDA.w $03AD,x
	BEQ.b CODE_0192DE
	DEC.w $03AD,x
	BRA.b CODE_019324

CODE_0192DE:
	LDA.w $0349,x
	SEP.b #$20
	JSR.w CODE_01CAAE
	REP.b #$20
	AND.w #$00FF
	PHA
	LDA.w $0000
	AND.w #$00FF
	BEQ.b CODE_0192FA
	LDA.b $01,S
	EOR.w #$FFFF
	INC
CODE_0192FA:
	CLC
	ADC.w $021D,x
	STA.w $021D,x
	PLA
	LDA.w $0349,x
	SEP.b #$20
	JSR.w CODE_01CA98
	REP.b #$20
	AND.w #$00FF
	ASL
	CLC
	ADC.w $0281,x
	STA.w $0281,x
	CMP.w #$B000
	BCC.b CODE_019324
	CMP.w #$F000
	BCS.b CODE_019324
	JSR.w CODE_019294
CODE_019324:
	DEX
	DEX
	BPL.b CODE_0192D4
	RTS

;--------------------------------------------------------------------

CODE_019329:
	LDX.w #$0040
CODE_01932C:
	PHX
	LDA.w $021D,x
	CMP.w #$8000
	ROL
	XBA
	AND.w #$01FF
	PHA
	LDA.w $0281,x
	XBA
	AND.w #$00FF
	TAY
	LDA.w $02E5,x
	PLX
	JSL.l CODE_01F91E
	PLX
	DEX
	DEX
	BPL.b CODE_01932C
	RTS

;--------------------------------------------------------------------

CODE_01934F:
	PHX
	LDA.l $00013C
	BIT.w #$A0A0
	BEQ.b CODE_019370
	LDA.l $000134
	CMP.w #$A0A0
	BNE.b CODE_019370
	LDA.w #$0000
	LDX.w #$7FFE
CODE_019368:
	STA.l $700000,x
	DEX
	DEX
	BPL.b CODE_019368
CODE_019370:
	PLX
	RTS

;--------------------------------------------------------------------

CODE_019372:
	LDA.l $001982
	BNE.b CODE_0193C4
	LDA.w #DATA_01CFBF
	JSL.l CODE_01CDE1
	LDX.w #$0000
CODE_019382:
	LDA.l DATA_0195CC,x
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	CPX.w #$0028
	BNE.b CODE_019382
	LDA.w #$AAAA
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot
	LDA.w #$555A
	STA.w MPAINT_Global_UpperOAMBuffer[$02].Slot
	SEP.b #$20
	LDA.b #$10
	STA.w $011A
	STA.w $011B
	STA.w $011C
	STA.w $011D
	STA.w !REGISTER_MainScreenLayers
	STA.w !REGISTER_SubScreenLayers
	STA.w !REGISTER_MainScreenWindowMask
	STA.w !REGISTER_SubScreenWindowMask
	REP.b #$20
	JSL.l CODE_01E794
CODE_0193BE:
	JSL.l CODE_01E2CE
	BRA.b CODE_0193BE

CODE_0193C4:
	JSL.l CODE_008994
	JSL.l CODE_01E30E
	LDA.w #$7FE0
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$20
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDX.w #$0010
	LDA.w #$FF00
CODE_0193E1:
	STA.w !REGISTER_WriteToVRAMPortLo
	DEX
	BNE.b CODE_0193E1
	LDX.w #$07FE
CODE_0193EA:
	LDA.l $7E3000,x
	CMP.w #$2FFC
	BNE.b CODE_0193FA
	EOR.w #$1400
	STA.l $7E3000,x
CODE_0193FA:
	DEX
	DEX
	BPL.b CODE_0193EA
	JSL.l CODE_01DECD
	SEP.b #$20
	LDA.b #$00
	STA.w !REGISTER_CGRAMAddress
	LDA.b #$FF
	STA.w !REGISTER_WriteToCGRAMPort
	LDA.b #$7F
	STA.w !REGISTER_WriteToCGRAMPort
	REP.b #$20
	JSL.l CODE_01E2F3
	LDA.w #$0000
	STA.w $0172
	STA.w $0174
	JSL.l CODE_01E06F
	LDA.w #$FFFF
	STA.w $0220
	STZ.w $0208
	LDA.w #$0001
	STA.w $0206
CODE_019435:
	JSL.l CODE_01E2CE
	LDA.w $0208
	BNE.b CODE_019435
	SEP.b #$20
	LDA.b #$06
	STA.w !REGISTER_BG1And2TileDataDesignation
	STA.w $010E
	LDA.b #$66
	STA.w !REGISTER_BG3And4TileDataDesignation
	STA.w $010F
	LDA.b #$04
	STA.w $011A
	STA.w !REGISTER_MainScreenLayers
	STA.w $011C
	STA.w !REGISTER_MainScreenWindowMask
	REP.b #$20
	JSL.l CODE_01E794
	LDA.w #DATA_01CFCA
	JSL.l CODE_01CDE1
	LDX.w #$001A
CODE_01946E:
	LDA.l DATA_0195F4,x
	STA.l $7E3396,x
	LDA.l DATA_019610,x
	STA.l $7E33D6,x
	DEX
	DEX
	BPL.b CODE_01946E
	JSL.l CODE_01DECD
	JSL.l CODE_01E2CE
	LDX.w #$77FE
CODE_01948D:
	LDA.l $700800,x
	STA.l $7F2000,x
	DEX
	DEX
	BPL.b CODE_01948D
	LDA.w #$D657
	STA.l $000549
	LDA.w #$0000
	STA.l $00054B
	LDA.w #$FFFF
	STA.l $00054D
	LDA.l $7007FE
	PHA
	JSL.l CODE_01F21D
	JSL.l CODE_01EF36
	PLA
	LDX.w #$07FE
CODE_0194BF:
	LDA.l $7E9C00,x
	STA.l $7E3800,x
	DEX
	DEX
	BPL.b CODE_0194BF
	LDX.w #$024E
CODE_0194CE:
	LDA.l $7EFC00,x
	STA.l $0009E4,x
	DEX
	DEX
	BPL.b CODE_0194CE
	LDA.l $7E3FFA
	STA.w $19EC
	LDA.l $7E3FFC
	STA.w $19C2
	LDA.l $7E3FFE
	STA.w $1A08
	STZ.w $19FA
	LDA.w #!RAM_MPAINT_Canvas_AnimationCellGFXBuffer
	STA.b $0A
	JSL.l CODE_00B988
	STZ.w $0206
	STZ.w $0216
	INC.w $0214
CODE_019504:
	JSL.l CODE_01E2CE
	LDA.w $0214
	BNE.b CODE_019504
	INC.w $0206
	LDA.w $1A08
	ASL
	TAX
	LDA.w DATA_00BE17,x
	STA.w $1A02
	LDA.w #$0001
	STA.w $0EAC
	STZ.w $19FE
	STZ.w $1A0A
	LDA.w #$FFFE
	STA.w $19EA
	STZ.w $19EE
	STZ.w $19F2
	SEP.b #$20
	JSL.l CODE_01D388
	JSL.l CODE_01E30E
	LDA.b #DATA_1A8000
	STA.b $CC
	LDA.b #DATA_1A8000>>8
	STA.b $CD
	LDA.b #DATA_1A8000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
	JSL.l CODE_01E2F3
	JSL.l CODE_01D388
	JSL.l CODE_01E30E
	LDA.b #DATA_1C8000
	STA.b $CC
	LDA.b #DATA_1C8000>>8
	STA.b $CD
	LDA.b #DATA_1C8000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
CODE_019573:
	LDA.b #$01
	STA.w !REGISTER_APUPort0
	LDA.w !REGISTER_APUPort0
	CMP.b #$01
	BNE.b CODE_019573
	REP.b #$20
	JSL.l CODE_01E2F3
	STZ.w $0446
	JSL.l CODE_00C7AF
	SEP.b #$20
	LDA.b #$16
	STA.w $011A
	STA.w $011C
	REP.b #$20
	LDX.w #$001A
	LDA.w #$03FE
CODE_01959E:
	STA.l $7E3396,x
	STA.l $7E33D6,x
	DEX
	DEX
	BPL.b CODE_01959E
	JSL.l CODE_01DECD
	JSL.l CODE_01E2CE
CODE_0195B2:
	LDA.w #$0000
	STA.w !RAM_MPAINT_Global_CursorXPosLo
	STA.w !RAM_MPAINT_Global_CursorYPosLo
	STA.w $04CA
	JSL.l CODE_00BBD4
	JSL.l CODE_01E09B
	JSL.l CODE_01E2CE
	BRA.b CODE_0195B2

DATA_0195CC:
	dw $6828,$3000,$6838,$3002,$6850,$3004,$6860,$3006
	dw $6870,$3008,$6880,$300A,$6898,$300C,$68A8,$3006
	dw $68B8,$300E,$68C8,$3006

DATA_0195F4:
	dw $2E00,$2E02,$2E04,$2E06,$2E08,$2E0A,$2E0C,$2E0E
	dw $2E10,$2E12,$2E14,$2E16,$2E18,$2E1A

DATA_019610:
	dw $2E20,$2E22,$2E24,$2E26,$2E28,$2E2A,$2E2C,$2E2E
	dw $2E30,$2E32,$2E34,$2E36,$2E38,$2E3A

;--------------------------------------------------------------------

CODE_01962C:
	PHP
	REP.b #$30
	PHD
	PHA
	TSC
	SEC
	SBC.w #$0010
	TCS
	TCD
	PHB
	PHK
	PLB
	LDA.b $11
	ASL
	TAX
	LDA.l DATA_0F8000,x
	STA.b $01
	INC
	STA.b $05
	INC
	STA.b $09
	INC
	STA.b $0D
	LDA.w #DATA_0F8000>>16
	STA.b $03
	STA.b $07
	STA.b $0B
	STA.b $0F
	LDA.b $11
	ASL
	ASL
	ASL
	TAX
	SEP.b #$20
	DEC.w $0796,x
	BPL.b CODE_0196B7
	INC.w $0797,x
	REP.b #$20
CODE_01966B:
	LDA.w $0797,x
	AND.w #$00FF
	ASL
	ASL
	TAY
	LDA.b [$01],y
	BIT.w #$0080
	BNE.b CODE_0196B2
	SEP.b #$20
	STA.w $0796,x
	REP.b #$20
	LDA.b [$0D],y
	BIT.w #$0080
	BNE.b CODE_0196E3
	PHA
	LDA.b [$05],y
	AND.w #$00FF
	BIT.w #$0080
	BEQ.b CODE_019697
	ORA.w #$0100
CODE_019697:
	ASL
	CLC
	ADC.w $0792,x
	AND.w #$03FF
	STA.w $0792,x
	LDA.b [$09],y
	ASL
	CLC
	ADC.w $0794,x
	AND.w #$01FF
	STA.w $0794,x
	PLA
	BRA.b CODE_0196C9

CODE_0196B2:
	JSR.w CODE_01972D
	BRA.b CODE_01966B

CODE_0196B7:
	REP.b #$20
	LDA.w $0797,x
	AND.w #$00FF
	ASL
	ASL
	TAY
	LDA.b [$0D],y
	BIT.w #$0080
	BNE.b CODE_0196E3
CODE_0196C9:
	AND.w #$007F
	CLC
	ADC.w $0798,x
	PHA
	LDA.w $0792,x
	LSR
	PHA
	LDA.w $0794,x
	LSR
	TAY
	PLX
	PLA
	JSL.l CODE_01FA68
	BRA.b CODE_019723

CODE_0196E3:
	AND.w #$007F
	CLC
	ADC.w $0798,x
	PHA
CODE_0196EB:
	LDA.b [$05],y
	AND.w #$00FF
	BIT.w #$0080
	BEQ.b CODE_0196F8
	ORA.w #$0300
CODE_0196F8:
	CLC
	ADC.w $0792,x
	AND.w #$03FF
	STA.w $0792,x
	LSR
	PHA
	LDA.b [$09],y
	AND.w #$00FF
	BIT.w #$0080
	BEQ.b CODE_019711
	ORA.w #$0100
CODE_019711:
	CLC
	ADC.w $0794,x
CODE_019714:
	AND.w #$01FF
	STA.w $0794,x
	LSR
	TAY
	PLX
	PLA
	JSL.l CODE_01FA68
CODE_019723:
	PLB
	TSC
	CLC
	ADC.w #$0012
	TCS
	PLD
	PLP
	RTL

CODE_01972D:					; Note: Something related to the title screen
	AND.w #$007F
	JSL.l CODE_01E393

DATA_019734:
	dw CODE_019792
	dw CODE_01979F
	dw CODE_0197B4
	dw CODE_0197D2
	dw CODE_0197DC
	dw CODE_0197FC
	dw CODE_01981C
	dw CODE_01983C
	dw CODE_01985C
	dw CODE_01987C
	dw CODE_01989C
	dw CODE_0198BC
	dw CODE_0198DC
	dw CODE_0198FA
	dw CODE_019930
	dw CODE_019966
	dw CODE_01999C
	dw CODE_0199D2
	dw CODE_019A08
	dw CODE_019A3E
	dw CODE_019A74
	dw CODE_019AAA
	dw CODE_019AC2
	dw CODE_019AF2
	dw CODE_019B22
	dw CODE_019B52
	dw CODE_019B82
	dw CODE_019BB2
	dw CODE_019BE2
	dw CODE_019C12
	dw CODE_019C42
	dw CODE_019C5C
	dw CODE_019C76
	dw CODE_019C90
	dw CODE_019CAA
	dw CODE_019CC4
	dw CODE_019CDE
	dw CODE_019CF8
	dw CODE_019D12
	dw CODE_019D2C
	dw CODE_019D46
	dw CODE_019D60
	dw CODE_019D7A
	dw CODE_019D94
	dw CODE_019DAE
	dw CODE_019DC8
	dw CODE_019DE2

;--------------------------------------------------------------------

CODE_019792:
	LDA.b [$05],y
	STA.w $0798,x
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_01979F:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.b [$09],y
	STA.w $0591,x
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0197B4:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	DEC.w $0591,x
	BEQ.b CODE_0197CB
	PLX
	LDA.b [$09],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_0197CB:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0197D2:
	SEP.b #$20
	LDA.b [$05],y
	STA.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0197DC:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BCS.b CODE_0197F5
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_0197F5:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0197FC:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BCC.b CODE_019815
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019815:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_01981C:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BNE.b CODE_019835
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019835:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_01983C:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BEQ.b CODE_019855
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019855:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_01985C:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BPL.b CODE_019875
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019875:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_01987C:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BMI.b CODE_019895
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019895:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_01989C:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BVS.b CODE_0198B5
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_0198B5:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0198BC:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BVC.b CODE_0198D5
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_0198D5:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0198DC:
	PHX
	LDA.w $0791
	AND.w #$00FF
	PHA
	SEP.b #$20
	INC.w $0791
	LDA.w $0797,x
	INC
	PLX
	STA.w $0691,x
	PLX
	LDA.b [$05],y
	STA.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0198FA:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BCS.b CODE_019929
	REP.b #$20
	LDA.w $0791
	AND.w #$00FF
	PHA
	SEP.b #$20
	INC.w $0791
	LDA.w $0797,x
	INC
	PLX
	STA.w $0691,x
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019929:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019930:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BCC.b CODE_01995F
	REP.b #$20
	LDA.w $0791
	AND.w #$00FF
	PHA
	SEP.b #$20
	INC.w $0791
	LDA.w $0797,x
	INC
	PLX
	STA.w $0691,x
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_01995F:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019966:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BNE.b CODE_019995
	REP.b #$20
	LDA.w $0791
	AND.w #$00FF
	PHA
	SEP.b #$20
	INC.w $0791
	LDA.w $0797,x
	INC
	PLX
	STA.w $0691,x
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019995:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_01999C:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BEQ.b CODE_0199CB
	REP.b #$20
	LDA.w $0791
	AND.w #$00FF
	PHA
	SEP.b #$20
	INC.w $0791
	LDA.w $0797,x
	INC
	PLX
	STA.w $0691,x
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_0199CB:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_0199D2:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BPL.b CODE_019A01
	REP.b #$20
	LDA.w $0791
	AND.w #$00FF
	PHA
	SEP.b #$20
	INC.w $0791
	LDA.w $0797,x
	INC
	PLX
	STA.w $0691,x
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019A01:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019A08:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BMI.b CODE_019A37
	REP.b #$20
	LDA.w $0791
	AND.w #$00FF
	PHA
	SEP.b #$20
	INC.w $0791
	LDA.w $0797,x
	INC
	PLX
	STA.w $0691,x
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019A37:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019A3E:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BVS.b CODE_019A6D
	REP.b #$20
	LDA.w $0791
	AND.w #$00FF
	PHA
	SEP.b #$20
	INC.w $0791
	LDA.w $0797,x
	INC
	PLX
	STA.w $0691,x
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019A6D:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019A74:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BVC.b CODE_019AA3
	REP.b #$20
	LDA.w $0791
	AND.w #$00FF
	PHA
	SEP.b #$20
	INC.w $0791
	LDA.w $0797,x
	INC
	PLX
	STA.w $0691,x
	PLX
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019AA3:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019AAA:
	PHX
	LDA.w $0791
	DEC
	AND.w #$00FF
	TAX
	SEP.b #$20
	STA.w $0791
	LDA.w $0691,x
	PLX
	STA.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019AC2:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BCS.b CODE_019AEB
	REP.b #$20
	LDA.w $0791
	DEC
	AND.w #$00FF
	TAX
	SEP.b #$20
	STA.w $0791
	LDA.w $0691,x
	PLX
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019AEB:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019AF2:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BCC.b CODE_019B1B
	REP.b #$20
	LDA.w $0791
	DEC
	AND.w #$00FF
	TAX
	SEP.b #$20
	STA.w $0791
	LDA.w $0691,x
	PLX
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019B1B:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019B22:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BNE.b CODE_019B4B
	REP.b #$20
	LDA.w $0791
	DEC
	AND.w #$00FF
	TAX
	SEP.b #$20
	STA.w $0791
	LDA.w $0691,x
	PLX
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019B4B:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019B52:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BEQ.b CODE_019B7B
	REP.b #$20
	LDA.w $0791
	DEC
	AND.w #$00FF
	TAX
	SEP.b #$20
	STA.w $0791
	LDA.w $0691,x
	PLX
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019B7B:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019B82:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BPL.b CODE_019BAB
	REP.b #$20
	LDA.w $0791
	DEC
	AND.w #$00FF
	TAX
	SEP.b #$20
	STA.w $0791
	LDA.w $0691,x
	PLX
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019BAB:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019BB2:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BMI.b CODE_019BDB
	REP.b #$20
	LDA.w $0791
	DEC
	AND.w #$00FF
	TAX
	SEP.b #$20
	STA.w $0791
	LDA.w $0691,x
	PLX
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019BDB:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019BE2:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BVS.b CODE_019C0B
	REP.b #$20
	LDA.w $0791
	DEC
	AND.w #$00FF
	TAX
	SEP.b #$20
	STA.w $0791
	LDA.w $0691,x
	PLX
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019C0B:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019C12:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.w $0591,x
	CMP.b [$09],y
	BVC.b CODE_019C3B
	REP.b #$20
	LDA.w $0791
	DEC
	AND.w #$00FF
	TAX
	SEP.b #$20
	STA.w $0791
	LDA.w $0691,x
	PLX
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019C3B:
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019C42:
	LDA.w $0792,x
	LSR
	CMP.b [$05],y
	BCS.b CODE_019C54
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019C54:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019C5C:
	LDA.w $0794,x
	LSR
	CMP.b [$05],y
	BCS.b CODE_019C6E
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019C6E:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019C76:
	LDA.w $0792,x
	LSR
	CMP.b [$05],y
	BCC.b CODE_019C88
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019C88:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019C90:
	LDA.w $0794,x
	LSR
	CMP.b [$05],y
	BCC.b CODE_019CA2
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019CA2:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019CAA:
	LDA.w $0792,x
	LSR
	CMP.b [$05],y
	BNE.b CODE_019CBC
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019CBC:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019CC4:
	LDA.w $0794,x
	LSR
	CMP.b [$05],y
	BNE.b CODE_019CD6
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019CD6:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019CDE:
	LDA.w $0792,x
	LSR
	CMP.b [$05],y
	BEQ.b CODE_019CF0
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019CF0:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019CF8:
	LDA.w $0794,x
	LSR
	CMP.b [$05],y
	BEQ.b CODE_019D0A
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019D0A:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019D12:
	LDA.w $0792,x
	LSR
	CMP.b [$05],y
	BPL.b CODE_019D24
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019D24:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019D2C:
	LDA.w $0794,x
	LSR
	CMP.b [$05],y
	BPL.b CODE_019D3E
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019D3E:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019D46:
	LDA.w $0792,x
	LSR
	CMP.b [$05],y
	BMI.b CODE_019D58
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019D58:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019D60:
	LDA.w $0794,x
	LSR
	CMP.b [$05],y
	BMI.b CODE_019D72
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019D72:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019D7A:
	LDA.w $0792,x
	LSR
	CMP.b [$05],y
	BVS.b CODE_019D8C
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019D8C:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019D94:
	LDA.w $0794,x
	LSR
	CMP.b [$05],y
	BVS.b CODE_019DA6
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019DA6:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019DAE:
	LDA.w $0792,x
	LSR
	CMP.b [$05],y
	BVC.b CODE_019DC0
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019DC0:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019DC8:
	LDA.w $0794,x
	LSR
	CMP.b [$05],y
	BVC.b CODE_019DDA
	SEP.b #$20
	LDA.b [$0D],y
	STA.w $0797,x
	REP.b #$20
	RTS

CODE_019DDA:
	SEP.b #$20
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019DE2:
	PHX
	LDA.b [$05],y
	AND.w #$00FF
	TAX
	JSL.l CODE_01E20C
	SEP.b #$20
	AND.b [$09],y
	CLC
	ADC.b [$0D],y
	STA.w $0591,x
	PLX
	INC.w $0797,x
	REP.b #$20
	RTS

;--------------------------------------------------------------------

CODE_019DFE:
	PHP
	PHB
	PHK
	PLB
	ASL
	ASL
	ASL
	TAY
	TAX
	LDA.w DATA_019E24,y
	ASL
	STA.w $0792,x
	LDA.w DATA_019E24+$02,y
	ASL
	STA.w $0794,x
	LDA.w DATA_019E24+$04,y
	STA.w $0796,x
	LDA.w DATA_019E24+$06,y
	STA.w $0798,x
	PLB
	PLP
	RTL

DATA_019E24:
	dw $0140,$00A9,$FFFF,$0137
	dw $0050,$0048,$FFFF,$00CC
	dw $0060,$0048,$FFFF,$00CC
	dw $0078,$0048,$FFFF,$00CC
	dw $00C0,$00F0,$FFFF,$00CC
	dw $01C0,$0020,$FFFF,$00CC
	dw $0180,$0024,$FFFF,$00CC
	dw $0140,$00A1,$FFFF,$00CC
	dw $0150,$00A1,$FFFF,$00CC
	dw $0160,$00A1,$FFFF,$00CC
	dw $0170,$00A1,$FFFF,$00CC
	dw $01C0,$00A4,$FFFF,$30CC
	dw $0180,$00AC,$FFFF,$30CC
	dw $0110,$00AC,$FFFF,$0137
	dw $0040,$0048,$FFFF,$00CC
	dw $0050,$0048,$FFFF,$00CC
	dw $0060,$0048,$FFFF,$00CC
	dw $0068,$0048,$FFFF,$00CC
	dw $0078,$0048,$FFFF,$00CC
	dw $0088,$0048,$FFFF,$00CC
	dw $0098,$0048,$FFFF,$00CC
	dw $00A0,$0048,$FFFF,$00CC
	dw $00B0,$0048,$FFFF,$00CC
	dw $00C0,$0048,$FFFF,$00CC
	dw $004D,$00C4,$FFFF,$00CC
	dw $0055,$00C4,$FFFF,$00CC
	dw $005C,$00C4,$FFFF,$00CC
	dw $0064,$00C4,$FFFF,$00CC
	dw $006C,$00C4,$FFFF,$00CC
	dw $0084,$00C4,$FFFF,$00CC
	dw $0089,$00C4,$FFFF,$00CC
	dw $008E,$00C4,$FFFF,$00CC
	dw $0093,$00C4,$FFFF,$00CC
	dw $0098,$00C4,$FFFF,$00CC
	dw $009F,$00C4,$FFFF,$00CC
	dw $00A6,$00C4,$FFFF,$00CC
	dw $00AD,$00C4,$FFFF,$00CC
	dw $00C8,$0048,$FFFF,$00CC
	dw $00EC,$0006,$FFFF,$0181
	dw $00DF,$00CB,$FFFF,$0189
	dw $0078,$0074,$FFFF,$0196

;--------------------------------------------------------------------

CODE_019F6C:
	LDA.w #$0001
	STA.w $0589
	PHP
	JSL.l CODE_01E2CE
	LDA.l !RAM_MPAINT_Global_DemoActiveFlag
	STA.l $0004E4
	LDA.w #$0000
	STA.l !RAM_MPAINT_Global_DemoActiveFlag
	LDA.w #$FFFF
	STA.w $09A9
	STZ.w $0206
	JSL.l CODE_01E06F
	JSL.l CODE_01E2CE
	JSL.l CODE_01E7C9
	SEP.b #$20
	JSL.l CODE_01E30E
	JSL.l CODE_01E87B
	JSL.l CODE_01E88A
	SEI
	LDA.b #$00
CODE_019FAC:
	DEC
	BNE.b CODE_019FAC
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$40
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_0D8000
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_0D8000>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_0D8000>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$2C
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$56
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_09EC00
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_09EC00>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_09EC00>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$0C
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$5C
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_089000
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_089000>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_089000>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$06
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$5F
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_0DAC00
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_0DAC00>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_0DAC00>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$02
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$60
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_04C000
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_04C000>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_04C000>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$2A
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b #$00
	STA.w !REGISTER_VRAMAddressLo
	LDA.b #$78
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #DATA_04B000
	STA.w DMA[$00].SourceLo
	LDA.b #DATA_04B000>>8
	STA.w DMA[$00].SourceHi
	LDA.b #DATA_04B000>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$00
	STA.w DMA[$00].SizeLo
	LDA.b #$10
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	CLI
	JSL.l CODE_01E2F3
	JSL.l CODE_01D388
	JSL.l CODE_01E30E
	LDA.b #DATA_1E8000
	STA.b $CC
	LDA.b #DATA_1E8000>>8
	STA.b $CD
	LDA.b #DATA_1E8000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
	JSL.l CODE_01E2F3
	LDA.b #$17
	STA.w $011A
	STA.w !REGISTER_MainScreenLayers
	STA.w $011C
	STA.w !REGISTER_MainScreenWindowMask
	LDA.b #$66
	STA.w !REGISTER_BG1And2TileDataDesignation
	STA.w $010E
	LDA.b #$66
	STA.w !REGISTER_BG3And4TileDataDesignation
	STA.w $010F
	REP.b #$20
	LDA.w #$0000
	STA.w $0178
	STA.w $0176
	PHB
	SEP.b #$20
	LDA.b #$7F0018>>16
	PHA
	PLB
	REP.b #$20
	LDA.w #$0003
	STA.w $7F0018
	STZ.w $7F05EA
	STZ.w $7F05EB
	STZ.w $7F0012
	STZ.w $7F0014
	STZ.w $7F0016
	STZ.w $7F001A
	STZ.w $7F001C
	STZ.w $7F0022
	STZ.w $7F0024
	STZ.w $7F05EA
	STZ.w $7F0026
	STZ.w $7F0040
	LDA.l $0004DE
	CMP.w #$00D0
	BCC.b CODE_01A18B
	LDA.w #$00CF
	STA.l $0004DE
CODE_01A18B:
	LDA.w #$0057
	JSL.l CODE_01E024
	LDA.w #$0057
	JSL.l CODE_01E033
	LDA.w #$00AE
	JSL.l CODE_01E042
	JSR.w CODE_01A30D
	JSR.w CODE_01A274
	JSR.w CODE_01A2B7
	JSR.w CODE_01A373
	JSR.w CODE_01A44D
	JSL.l CODE_01DE97
	JSL.l CODE_01DEB2
	JSL.l CODE_01DECD
	JSL.l CODE_01E2CE
	JSL.l CODE_01E794
	JSL.l CODE_01E2CE
	LDA.l $0004E4
	STA.l !RAM_MPAINT_Global_DemoActiveFlag
	PHP
	TSC
	DEC
	DEC
	STA.w $0006
	LDA.w #DATA_10DC4C-DATA_108000
	STA.l $0004E6
	JSR.w CODE_01A505
	PLP
	PLB
	JSL.l CODE_01E7C9
	JSL.l CODE_01E06F
	JSL.l CODE_01E2CE
	JSL.l CODE_01E2CE
	SEP.b #$20
	JSL.l CODE_01D388
	JSL.l CODE_01E30E
	LDA.b #DATA_1A8000
	STA.b $CC
	LDA.b #DATA_1A8000>>8
	STA.b $CD
	LDA.b #DATA_1A8000>>16
	STA.b $CE
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSL.l CODE_01DF25
	REP.b #$20
	JSL.l CODE_01E2F3
	LDA.w #$FFFF
	STA.w $0220
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00D8
	BCC.b CODE_01A22B
	LDA.w #$00D7
	STA.w !RAM_MPAINT_Global_CursorYPosLo
CODE_01A22B:
	JSL.l CODE_008994
	STZ.w $0208
	LDA.w #$0001
	INC.w $0206
CODE_01A238:
	JSL.l CODE_01E2CE
	LDA.w $0208
	BNE.b CODE_01A238
	SEP.b #$20
	LDA.b #$06
	STA.w !REGISTER_BG1And2TileDataDesignation
	STA.w $010E
	LDA.b #$66
	STA.w !REGISTER_BG3And4TileDataDesignation
	STA.w $010F
	LDA.b #$13
	STA.w $011A
	STA.w !REGISTER_MainScreenLayers
	STA.w $011C
	STA.w !REGISTER_MainScreenWindowMask
	JSL.l CODE_01E794
	REP.b #$20
	JSL.l CODE_00A4AD
	JSL.l CODE_01D3AB
	PLP
	STZ.w $0589
	RTL

;--------------------------------------------------------------------

CODE_01A274:
	LDX.w #$0000
CODE_01A277:
	LDA.w #$2DC7
	STA.l $7E2800,x
	STA.l $7E2802,x
	STA.l $7E283C,x
	STA.l $7E283E,x
	TXA
	CLC
	ADC.w #$0040
	TAX
	CPX.w #$0800
	BNE.b CODE_01A277
	LDX.w #$0000
CODE_01A298:
	LDA.w #$2DC7
	STA.l $7E2800,x
	STA.l $7E2840,x
	STA.l $7E2E80,x
	STA.l $7E2EC0,x
	STA.l $7E2F00,x
	INX
	INX
	CPX.w #$0040
	BNE.b CODE_01A298
	RTS

;--------------------------------------------------------------------

CODE_01A2B7:
	LDA.w $0014
CODE_01A2BA:
	CMP.w #$0003
	BCC.b CODE_01A2C4
	SBC.w #$0003
	BRA.b CODE_01A2BA

CODE_01A2C4:
	ASL
	TAX
	LDA.l DATA_01A307,x
	LDX.w #$0000
	JSR.w CODE_01A2E7
	INC
	INX
	INX
	JSR.w CODE_01A2E7
	CLC
	ADC.w #$000F
	LDX.w #$0040
	JSR.w CODE_01A2E7
	INC
	INX
	INX
	JSR.w CODE_01A2E7
	RTS

CODE_01A2E7:
	PHA
	PHX
CODE_01A2E9:
	PHA
	STA.l $7E2000,x
	INX
	INX
	INX
	INX
	TXA
	AND.w #$003C
	BNE.b CODE_01A2FE
	TXA
	CLC
	ADC.w #$0040
	TAX
CODE_01A2FE:
	PLA
	CPX.w #$0800
	BCC.b CODE_01A2E9
	PLX
	PLA
	RTS

DATA_01A307:
	dw $11CA,$09CC,$09CE

;--------------------------------------------------------------------

CODE_01A30D:
	LDX.w #$0154
CODE_01A310:
	LDA.w #$00AE
	STA.l $7E3082,x
	DEX
	DEX
	TXA
	BIT.w #$003F
	BNE.b CODE_01A310
	SEC
	SBC.w #$002C
	TAX
	BPL.b CODE_01A310
	LDA.w $0012
	AND.w #$000F
	BEQ.b CODE_01A372
	TAY
	LDA.w #$2E20
	LDX.w #$0000
CODE_01A335:
	PHA
	STA.l $7E3084,x
	INC
	INC
	STA.l $7E3086,x
	CLC
	ADC.w #$001E
	STA.l $7E30C4,x
	INC
	INC
	STA.l $7E30C6,x
	INX
	INX
	INX
	INX
	TXA
	AND.w #$003F
	CMP.w #$0014
	BNE.b CODE_01A361
	TXA
	CLC
	ADC.w #$006C
	TAX
CODE_01A361:
	PLA
	CLC
	ADC.w #$0004
	BIT.w #$001F
	BNE.b CODE_01A36F
	CLC
	ADC.w #$0020
CODE_01A36F:
	DEY
	BNE.b CODE_01A335
CODE_01A372:
	RTS

;--------------------------------------------------------------------

CODE_01A373:
	LDA.w #$00AE
	STA.l $7E3098
	STA.l $7E309A
	STA.l $7E309C
	STA.l $7E309E
	STA.l $7E30A0
	STA.l $7E30A2
	STA.l $7E30D8
	STA.l $7E30DA
	STA.l $7E30DC
	STA.l $7E30DE
	STA.l $7E30E0
	STA.l $7E30E2
	LDY.w #$0000
	LDA.w $001A
	EOR.w #$FFFF
	CLC
	ADC.w #$0065
	BEQ.b CODE_01A3B7
	BPL.b CODE_01A3B8
CODE_01A3B7:
	RTS

CODE_01A3B8:
	CMP.w #$000A
	BCC.b CODE_01A3C3
	SBC.w #$000A
	INY
	BRA.b CODE_01A3B8

CODE_01A3C3:
	PHA
	CPY.w #$000A
	BCC.b CODE_01A3FC
	LDA.w #$0001
	PHA
	AND.w #$FFF8
	CLC
	ADC.b $01,S
	ASL
	ASL
	CLC
	ADC.w #$2F00
	PLX
	STA.l $7E3098
	INC
	INC
	STA.l $7E309A
	CLC
	ADC.w #$001E
	STA.l $7E30D8
	INC
	INC
	STA.l $7E30DA
	LDA.w #$0000
	STA.b $01,S
	LDY.w #$0000
	BRA.b CODE_01A3FF

CODE_01A3FC:
	TYA
	BEQ.b CODE_01A425
CODE_01A3FF:
	PHA
	AND.w #$FFF8
	CLC
	ADC.b $01,S
	ASL
	ASL
	CLC
	ADC.w #$2F00
	PLX
	STA.l $7E309C
	INC
	INC
	STA.l $7E309E
	CLC
	ADC.w #$001E
	STA.l $7E30DC
	INC
	INC
	STA.l $7E30DE
CODE_01A425:
	LDA.b $01,S
	AND.w #$FFF8
	CLC
	ADC.b $01,S
	ASL
	ASL
	CLC
	ADC.w #$2F00
	PLX
	STA.l $7E30A0
	INC
	INC
	STA.l $7E30A2
	CLC
	ADC.w #$001E
	STA.l $7E30E0
	INC
	INC
	STA.l $7E30E2
	RTS

;--------------------------------------------------------------------

CODE_01A44D:
	LDX.w #$00CC
CODE_01A450:
	LDA.w #$00AE
	STA.l $7E30AA,x
	DEX
	DEX
	TXA
	BIT.w #$003F
	BNE.b CODE_01A450
	SEC
	SBC.w #$0034
	TAX
	BPL.b CODE_01A450
	LDY.w $0018
	BEQ.b CODE_01A4A5
	CPY.w #$0007
	BCS.b CODE_01A4A6
	LDX.w #$0000
CODE_01A473:
	LDA.w #$2F48
	STA.l $7E30AC,x
	LDA.w #$2F4A
	STA.l $7E30AE,x
	LDA.w #$2F68
	STA.l $7E30EC,x
	LDA.w #$2F6A
	STA.l $7E30EE,x
	INX
	INX
	INX
	INX
	TXA
	AND.w #$003F
	CMP.w #$000C
	BNE.b CODE_01A4A2
	TXA
	CLC
	ADC.w #$0074
	TAX
CODE_01A4A2:
	DEY
	BNE.b CODE_01A473
CODE_01A4A5:
	RTS

CODE_01A4A6:
	LDA.w #$2F48
	STA.l $7E30AC
	LDA.w #$2F4A
	STA.l $7E30AE
	LDA.w #$2FD4
	STA.l $7E30B0
	LDA.w #$2F68
	STA.l $7E30EC
	LDA.w #$2F6A
	STA.l $7E30EE
	LDA.w #$2FF4
	STA.l $7E30F0
	TYA
	LDY.w #$0000
CODE_01A4D4:
	CMP.w #$000A
	BCC.b CODE_01A4DF
	SBC.w #$000A
	INY
	BRA.b CODE_01A4D4

CODE_01A4DF:
	PHA
	TYA
	ASL
	CLC
	ADC.w #$2FC0
	STA.l $7E30B2
	CLC
	ADC.w #$0020
	STA.l $7E30F2
	PLA
	ASL
	CLC
	ADC.w #$2FC0
	STA.l $7E30B4
	CLC
	ADC.w #$0020
	STA.l $7E30F4
	RTS

;--------------------------------------------------------------------

CODE_01A505:
	JSL.l CODE_01E06F
	LDA.w #$0040
	STA.l $000446
	JSR.w CODE_01A54F
	JSR.w CODE_01A5E4
	LDA.w $0022
	CMP.w #$0003
	BEQ.b CODE_01A52E
	LDA.w $0040
	BEQ.b CODE_01A52B
	DEC.w $0040
	BIT.w #$0001
	BEQ.b CODE_01A52E
CODE_01A52B:
	JSR.w CODE_01A5BB
CODE_01A52E:
	STZ.w $002E
	JSR.w CODE_01A60E
	JSR.w CODE_01A5F3
	LDA.w $0024
	CMP.w #$0003
	BCS.b CODE_01A542
	JSR.w CODE_01A373
CODE_01A542:
	JSL.l CODE_01DE97
	JSL.l CODE_01DECD
	JSR.w CODE_01C5F8
	BRA.b CODE_01A505

;--------------------------------------------------------------------

CODE_01A54F:
	LDA.l $0004C6
	AND.w #$00FF
	BIT.w #$0080
	BEQ.b CODE_01A55E
	ORA.w #$FF00
CODE_01A55E:
	CLC
	ADC.l $0004DC
	CMP.w #$00E8
	BPL.b CODE_01A571
	CMP.w #$0018
	BMI.b CODE_01A571
	STA.l $0004DC
CODE_01A571:
	LDA.l $0004C8
	AND.w #$00FF
	BIT.w #$0080
	BEQ.b CODE_01A580
	ORA.w #$FF00
CODE_01A580:
	CLC
	ADC.l $0004DE
	CMP.w #$00D0
	BPL.b CODE_01A593
	CMP.w #$0020
	BMI.b CODE_01A593
	STA.l $0004DE
CODE_01A593:
	LDY.w #$0004
	LDA.l $0004C6
	ORA.l $0004C8
	AND.w #$00FF
	BEQ.b CODE_01A5A6
	LDY.w #$0001
CODE_01A5A6:
	TYA
	PHA
	EOR.l $001B28
	AND.b $01,S
	ASL
	ORA.b $01,S
	STA.l $001B26
	STA.l $001B28
	PLA
	RTS

;--------------------------------------------------------------------

CODE_01A5BB:
	LDA.l $000446
	PHA
	LDA.w #$0000
	STA.l $000446
	LDA.l $0004DC
	TAX
	LDA.l $0004DE
	TAY
	LDA.w $001C
	BMI.b CODE_01A5DE
	CLC
	ADC.w #$010F
	JSL.l CODE_01F91E
CODE_01A5DE:
	PLA
	STA.l $000446
	RTS

;--------------------------------------------------------------------

CODE_01A5E4:
	LDA.w $0022
	JSL.l CODE_01E393

DATA_01A5EB:
	dw CODE_01A619
	dw CODE_01A648
	dw CODE_01A6C0
	dw CODE_01A755

;--------------------------------------------------------------------

CODE_01A5F3:
	LDA.w $0024
	JSL.l CODE_01E393

DATA_01A5FA:
	dw CODE_01C012
	dw CODE_01AF14
	dw CODE_01AFDB
	dw CODE_01B0CA
	dw CODE_01B153
	dw CODE_01B17B
	dw CODE_01B27D
	dw CODE_01B3FA
	dw CODE_01B481
	dw CODE_01B4F4

;--------------------------------------------------------------------

CODE_01A60E:
	LDA.w $0026
	JSL.l CODE_01E393

DATA_01A615:
	dw CODE_01C3C4
	dw CODE_01C43A

;--------------------------------------------------------------------

CODE_01A619:
	LDA.l $0004DC
	STA.w $0028
	LDA.l $0004DE
	STA.w $002A
	STZ.w $002C
	STZ.w $001C
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_01A645
	STZ.w $001E
	LDA.w #$FFFF
	STA.w $0020
	LDA.w #$0001
	STA.w $0022
CODE_01A645:
	JMP.w CODE_01A7D0

;--------------------------------------------------------------------

CODE_01A648:
	LDA.l $0004DC
	STA.w $0028
	LDA.l $0004DE
	STA.w $002A
	LDA.w $002C
	BNE.b CODE_01A662
	LDA.w #$0008
	JSL.l CODE_01D348
CODE_01A662:
	LDA.w #$0001
	STA.w $002C
	LDA.w $002E
	BEQ.b CODE_01A67B
	LDA.w $001E
	CMP.w #$0004
	BCS.b CODE_01A67B
	LDA.w #$0004
	STA.w $001E
CODE_01A67B:
	LDA.w $0020
	BMI.b CODE_01A684
	DEC.w $0020
	RTS

CODE_01A684:
	LDA.w $001E
	INC.w $001E
	CMP.w #$0003
	BEQ.b CODE_01A694
	CMP.w #$0006
	BNE.b CODE_01A69A
CODE_01A694:
	STZ.w $002C
	STZ.w $0022
CODE_01A69A:
	ASL
	TAX
	LDA.l DATA_01A6B2,x
	PHA
	AND.w #$00FF
	STA.w $001C
	PLA
	XBA
	AND.w #$00FF
	STA.w $0020
	JMP.w CODE_01A7D0

DATA_01A6B2:
	db $01,$02,$04,$01,$04,$01,$00,$00
	db $02,$01,$03,$01,$00,$00

;--------------------------------------------------------------------

CODE_01A6C0:
	STZ.w $002C
	LDA.w $0028
	STA.l $0004DC
	LDA.w $002A
	STA.l $0004DE
	LDA.w $0020
	BMI.b CODE_01A6DA
	DEC.w $0020
	RTS

CODE_01A6DA:
	LDA.w $001E
	INC.w $001E
	CMP.w #$0005
	BNE.b CODE_01A729
	PHA
	STZ.w $0022
	DEC.w $0018
	BPL.b CODE_01A71F
	LDA.w #$0003
	STA.w $0022
	SEP.b #$20
	LDA.b #$09
	STA.w $05D7
	LDA.b #$36
	STA.w $0047
	STZ.w $020E
	STZ.w $0290
	STZ.w $024F
	STZ.w $02D1
	STZ.w $0049
	STZ.w $004A
	REP.b #$20
	JSR.w CODE_01C0D3
	LDA.w #$0300
	STA.w $0040
	BRA.b CODE_01A728

CODE_01A71F:
	LDA.w #$00C0
	STA.w $0040
	JSR.w CODE_01A44D
CODE_01A728:
	PLA
CODE_01A729:
	ASL
	TAX
	LDA.l DATA_01A749,x
	PHA
	AND.w #$00FF
	CMP.w #$00FF
	BNE.b CODE_01A73B
	LDA.w #$FFFF
CODE_01A73B:
	STA.w $001C
	PLA
	XBA
	AND.w #$00FF
	STA.w $0020
	JMP.w CODE_01A7D0

DATA_01A749:
	db $08,$06,$07,$06,$06,$20,$07,$05
	db $08,$05,$FF,$FF

;--------------------------------------------------------------------

CODE_01A755:
	LDA.w $0040
	BEQ.b CODE_01A75F
	DEC.w $0040
	BRA.b CODE_01A7CD

CODE_01A75F:
	LDA.w #$0001
	STA.w $0040
	JSL.l CODE_01E7C9
	SEP.b #$30
	JSR.w CODE_01B5DC
	REP.b #$30
	LDA.w #$0003
	STA.w $0018
	STZ.w $0012
	STZ.w $0014
	STZ.w $0016
	STZ.w $001A
	STZ.w $001C
	STZ.w $0022
	STZ.w $0024
	STZ.w $05EA
	STZ.w $0026
	STZ.w $00C9
	STZ.w $0040
	LDA.w #$00AE
	JSL.l CODE_01E042
	JSR.w CODE_01A30D
	JSR.w CODE_01A2B7
	JSR.w CODE_01A373
	JSR.w CODE_01A44D
	JSL.l CODE_01DE97
	JSL.l CODE_01DECD
	JSL.l CODE_01E06F
	LDA.w #$0040
	STA.l $000446
	JSL.l CODE_01E2CE
	JSL.l CODE_01E2CE
	JSL.l CODE_01E2CE
	JSL.l CODE_01E794
CODE_01A7CD:
	JMP.w CODE_01A7D0

CODE_01A7D0:
	LDA.l $0004DC
	SEC
	SBC.w #$0008
	STA.w $0030
	CLC
	ADC.w #$0010
	STA.w $0032
	LDA.l $0004DE
	SEC
	SBC.w #$0010
	STA.w $0034
	CLC
	ADC.w #$0018
	STA.w $0036
	LDA.l $0004DC
	SEC
	SBC.w #$0006
	STA.w $0038
	CLC
	ADC.w #$000C
	STA.w $003A
	LDA.l $0004DE
	SEC
	SBC.w #$000E
	STA.w $003C
	CLC
	ADC.w #$0024
	STA.w $003E
	RTS

;--------------------------------------------------------------------

CODE_01A819:
	JSL.l CODE_01E20C
	AND.b #$03
	BNE.b CODE_01A83A
	JSL.l CODE_01E20C
	STA.w $014B,x
	STZ.w $010A,x
	LDA.b #$F0
	STA.w $01CD,x
	STZ.w $018C,x
	LDA.b #$50
	STA.w $024F,x
	BRA.b CODE_01A88B

CODE_01A83A:
	CMP.b #$01
	BNE.b CODE_01A857
	JSL.l CODE_01E20C
	STA.w $014B,x
	STZ.w $010A,x
	LDA.b #$F0
	STA.w $01CD,x
	STZ.w $018C,x
	LDA.b #$D0
	STA.w $024F,x
	BRA.b CODE_01A88B

CODE_01A857:
	CMP.b #$02
	BNE.b CODE_01A874
	JSL.l CODE_01E20C
	STA.w $01CD,x
	STZ.w $018C,x
	LDA.b #$08
	STA.w $014B,x
	STZ.w $010A,x
	LDA.b #$10
	STA.w $024F,x
	BRA.b CODE_01A88B

CODE_01A874:
	JSL.l CODE_01E20C
	STA.w $01CD,x
	STZ.w $018C,x
	LDA.b #$F8
	STA.w $014B,x
	STZ.w $010A,x
	LDA.b #$90
	STA.w $024F,x
CODE_01A88B:
	LDA.b #$50
	STA.w $020E,x
	JSL.l CODE_01E20C
	AND.b #$01
	STA.w $0290,x
	JSL.l CODE_01E20C
	AND.b #$01
	SEC
	SBC.b #$01
	BMI.b CODE_01A8A5
	INC
CODE_01A8A5:
	STA.w $02D1,x
	JSL.l CODE_01E20C
	AND.b #$07
	CLC
	ADC.b #$20
	STA.w $0312,x
	JSL.l CODE_01E20C
	AND.b #$07
	STA.w $0088,x
	STZ.w $0047,x
	STZ.w $00C9,x
	RTS

;--------------------------------------------------------------------

CODE_01A8C4:
	LDA.w $00C9,x
	BNE.b CODE_01A8FD
	LDA.w $0042
	BEQ.b CODE_01A906
	LDA.w $0312,x
	BNE.b CODE_01A8FD
	JSL.l CODE_01E20C
	AND.b #$01
	SEC
	SBC.b #$01
	BMI.b CODE_01A8DF
	INC
CODE_01A8DF:
	STA.w $0290,x
	JSL.l CODE_01E20C
	AND.b #$1F
	SEC
	SBC.b #$10
	BMI.b CODE_01A8EE
	INC
CODE_01A8EE:
	STA.w $02D1,x
	JSL.l CODE_01E20C
	AND.b #$1F
	CLC
	ADC.b #$10
	STA.w $0312,x
CODE_01A8FD:
	DEC.w $0312,x
	JSR.w CODE_01C51D
	JSR.w CODE_01BC7B
CODE_01A906:
	LDA.b #DATA_01A933>>16
	PHA
	LDA.b #DATA_01A933>>8
	PHA
	LDA.b #DATA_01A933
	PHA
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.b #$03
	PHA
	LDA.b #$04
	PHA
	PHA
	LDA.b #$33
	LDY.w $0014
	CPY.b #$02
	BNE.b CODE_01A92C
	LDY.w $0016
	BNE.b CODE_01A92C
	LDA.b #$37
CODE_01A92C:
	JSR.w CODE_01BE40
	PLA
	PLA
	PLA
	RTS

DATA_01A933:
	db $09,$01,$0A,$01,$FF,$00,$09,$00
	db $FF,$03

;--------------------------------------------------------------------

CODE_01A93D:
	LDA.w $00C9,x
	BEQ.b CODE_01A945
	JMP.w CODE_01A9DA

CODE_01A945:
	LDA.w $0042
	BNE.b CODE_01A94D
	JMP.w CODE_01A9E0

CODE_01A94D:
	LDA.w $0047,x
	CMP.b #$06
	BCC.b CODE_01A957
	JMP.w CODE_01A9DA

CODE_01A957:
	LDA.w $0312,x
	BNE.b CODE_01A986
	JSL.l CODE_01E20C
	AND.b #$03
	SEC
	SBC.b #$03
	BMI.b CODE_01A968
	INC
CODE_01A968:
	STA.w $0290,x
	JSL.l CODE_01E20C
	AND.b #$1F
	SEC
	SBC.b #$10
	BMI.b CODE_01A977
	INC
CODE_01A977:
	STA.w $02D1,x
	JSL.l CODE_01E20C
	AND.b #$1F
	CLC
	ADC.b #$10
	STA.w $0312,x
CODE_01A986:
	DEC.w $0312,x
	LDA.w $014B,x
	CMP.b #$30
	BCC.b CODE_01A9DA
	CMP.b #$D0
	BCS.b CODE_01A9DA
	LDA.w $01CD,x
	CMP.b #$20
	BCC.b CODE_01A9DA
	CMP.b #$C0
	BCS.b CODE_01A9DA
	LDA.w $020E,x
	CMP.b #$30
	BCC.b CODE_01A9AA
	CMP.b #$D0
	BCC.b CODE_01A9DA
CODE_01A9AA:
	CMP.b #$FF
	BNE.b CODE_01A9B0
	LDA.b #$00
CODE_01A9B0:
	CMP.b #$80
	ROR
	STA.w $020E,x
	STZ.w $0290,x
	LDA.b #$FF
	STA.w $0312,x
	LDA.w $0047,x
	CMP.b #$03
	BCS.b CODE_01A9CB
	CLC
	ADC.b #$03
	STA.w $0047,x
CODE_01A9CB:
	LDA.w $020E,x
	BNE.b CODE_01A9DA
	LDA.b #$05
	STA.w $0047,x
	LDA.b #$FF
	STA.w $0088,x
CODE_01A9DA:
	JSR.w CODE_01C51D
	JSR.w CODE_01BC7B
CODE_01A9E0:
	LDA.b #DATA_01AA20>>16
	PHA
	LDA.b #DATA_01AA20>>8
	PHA
	LDA.b #DATA_01AA20
	PHA
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.w $0047,x
	CMP.b #$10
	BNE.b CODE_01AA0E
	LDA.b #$0B
	JSL.l CODE_01D328
	JSR.w CODE_01AA48
	JSL.l CODE_01E20C
	AND.b #$7F
	CLC
	ADC.b #$40
	STA.w $020E,x
	STZ.w $0312,x
CODE_01AA0E:
	LDA.b #$12
	PHA
	LDA.b #$04
	PHA
	LDA.b #$08
	PHA
	LDA.b #$34
	JSR.w CODE_01BE40
	PLA
	PLA
	PLA
	RTS

DATA_01AA20:
	dw $010B,$010C,$00FF,$010D,$010E,$03FF,$030D,$030E
	dw $030D,$030E,$030D,$030E,$030D,$030E,$030D,$030E
	dw $000B,$00FF,$010B,$12FF

;--------------------------------------------------------------------

CODE_01AA48:
	PHX
	PHY
	LDA.w $014B,x
	PHA
	LDA.w $01CD,x
	PHA
	LDA.b #$20
	PHA
	LDY.b #$00
	LDX.b #$0F
CODE_01AA59:
	LDA.w $0353,x
	BNE.b CODE_01AA63
	TXA
	STA.w $0593,y
	INY
CODE_01AA63:
	CPY.b #$04
	BEQ.b CODE_01AA6C
	DEX
	BPL.b CODE_01AA59
	BRA.b CODE_01AAA7

CODE_01AA6C:
	DEY
CODE_01AA6D:
	LDX.w $0593,y
	LDA.b $03,S
	STA.w $0413,x
	STZ.w $03E3,x
	LDA.b $02,S
	STA.w $0473,x
	STZ.w $0443,x
	LDA.w $05AC
	STA.w $04A3,x
	LDA.b $01,S
	STA.w $04D3,x
	CLC
	ADC.b #$40
	STA.b $01,S
	STZ.w $0503,x
	STZ.w $0533,x
	LDA.b #$08
	STA.w $0563,x
	STZ.w $0383,x
	STZ.w $03B3,x
	INC.w $0353,x
	DEY
	BPL.b CODE_01AA6D
CODE_01AAA7:
	PLA
	PLA
	PLA
	PLY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_01AAAD:
	LDX.b #$0F
CODE_01AAAF:
	LDA.w $0353,x
	BEQ.b CODE_01AADF
	JSR.w CODE_01BD01
	LDA.w $0413,x
	CMP.b #$10
	BCC.b CODE_01AAC9
	CMP.b #$F0
	BCS.b CODE_01AAC9
	LDA.w $0473,x
	CMP.b #$E0
	BCC.b CODE_01AACC
CODE_01AAC9:
	STZ.w $0353,x
CODE_01AACC:
	LDA.w $0563,x
	BEQ.b CODE_01AAD6
	DEC.w $0563,x
	BRA.b CODE_01AADF

CODE_01AAD6:
	LDA.b #$04
	PHA
	PHA
	JSR.w CODE_01BF29
	PLA
	PLA
CODE_01AADF:
	DEX
	BPL.b CODE_01AAAF
	RTS

;--------------------------------------------------------------------

CODE_01AAE3:
	LDA.b #DATA_01AAFD>>16
	PHA
	LDA.b #DATA_01AAFD>>8
	PHA
	LDA.b #DATA_01AAFD
	PHA
	LDX.b #$0F
CODE_01AAEE:
	LDA.w $0353,x
	BEQ.b CODE_01AAF6
	JSR.w CODE_01BDE6
CODE_01AAF6:
	DEX
	BPL.b CODE_01AAEE
	PLA
	PLA
	PLA
	RTS

DATA_01AAFD:
	db $17,$02,$18,$02,$19,$02,$FF,$00

;--------------------------------------------------------------------

CODE_01AB05:
	JSL.l CODE_01E20C
	AND.b #$01
	BNE.b CODE_01AB1C
	LDA.b #$08
	STA.w $014B,x
	STZ.w $010A,x
	LDA.b #$00
	STA.w $024F,x
	BRA.b CODE_01AB29

CODE_01AB1C:
	LDA.b #$F8
	STA.w $014B,x
	STZ.w $010A,x
	LDA.b #$80
	STA.w $024F,x
CODE_01AB29:
	JSL.l CODE_01E20C
	AND.b #$7F
	CLC
	ADC.b #$30
	STA.w $01CD,x
	STZ.w $018C,x
	LDA.b #$30
	STA.w $020E,x
	LDA.b #$FF
	STA.w $0290,x
	STZ.w $02D1,x
	JSL.l CODE_01E20C
	AND.b #$03
	CLC
	ADC.b #$10
	STA.w $0312,x
	JSL.l CODE_01E20C
	AND.b #$07
	STA.w $0088,x
	STZ.w $0047,x
	STZ.w $00C9,x
	RTS

;--------------------------------------------------------------------

CODE_01AB61:
	LDA.w $00C9,x
	BEQ.b CODE_01AB69
	JMP.w CODE_01ABEF

CODE_01AB69:
	LDA.w $0042
	BNE.b CODE_01AB71
	JMP.w CODE_01ABF5

CODE_01AB71:
	LDA.w $0047,x
	CMP.b #$06
	BCS.b CODE_01ABEF
	LDA.w $0312,x
	BNE.b CODE_01AB9B
	JSL.l CODE_01E20C
	AND.b #$03
	SEC
	SBC.b #$02
	BMI.b CODE_01AB89
	INC
CODE_01AB89:
	STA.w $0290,x
	STZ.w $02D1,x
	JSL.l CODE_01E20C
	AND.b #$03
	CLC
	ADC.b #$10
	STA.w $0312,x
CODE_01AB9B:
	DEC.w $0312,x
	LDA.w $014B,x
	CMP.b #$30
	BCC.b CODE_01ABEF
	CMP.b #$D0
	BCS.b CODE_01ABEF
	LDA.w $01CD,x
	CMP.b #$20
	BCC.b CODE_01ABEF
	CMP.b #$C0
	BCS.b CODE_01ABEF
	LDA.w $020E,x
	CMP.b #$30
	BCC.b CODE_01ABBF
	CMP.b #$D0
	BCC.b CODE_01ABEF
CODE_01ABBF:
	CMP.b #$FF
	BNE.b CODE_01ABC5
	LDA.b #$00
CODE_01ABC5:
	CMP.b #$80
	ROR
	STA.w $020E,x
	STZ.w $0290,x
	LDA.b #$FF
	STA.w $0312,x
	LDA.w $0047,x
	CMP.b #$03
	BCS.b CODE_01ABE0
	CLC
	ADC.b #$03
	STA.w $0047,x
CODE_01ABE0:
	LDA.w $020E,x
	BNE.b CODE_01ABEF
	LDA.b #$05
	STA.w $0047,x
	LDA.b #$FF
	STA.w $0088,x
CODE_01ABEF:
	JSR.w CODE_01C51D
	JSR.w CODE_01BC7B
CODE_01ABF5:
	LDA.b #DATA_01AC3C>>16
	PHA
	LDA.b #DATA_01AC3C>>8
	PHA
	LDA.b #DATA_01AC3C
	PHA
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.w $0047,x
	CMP.b #$11
	BNE.b CODE_01AC14
	LDA.b #$0C
	JSL.l CODE_01D328
	JSR.w CODE_01AC70
CODE_01AC14:
	LDA.w $0047,x
	CMP.b #$16
	BNE.b CODE_01AC2A
	JSL.l CODE_01E20C
	AND.b #$7F
	CLC
	ADC.b #$40
	STA.w $020E,x
	STZ.w $0312,x
CODE_01AC2A:
	LDA.b #$18
	PHA
	LDA.b #$04
	PHA
	LDA.b #$08
	PHA
	LDA.b #$35
	JSR.w CODE_01BE40
	PLA
	PLA
	PLA
	RTS

DATA_01AC3C:
	dw $011A,$011B,$00FF,$011C,$011D,$03FF,$031C,$031D
	dw $031C,$031D,$031C,$031D,$031C,$031D,$031C,$031D
	dw $0A1E,$001F,$061F,$0820,$0821,$201A,$001A,$00FF
	dw $011A,$18FF

;--------------------------------------------------------------------

CODE_01AC70:
	PHX
	LDA.w $014B,x
	PHA
	LDA.w $01CD,x
	CLC
	ADC.b #$08
	PHA
	LDA.b #$50
	PHA
	LDY.b #$00
	LDX.b #$1F
CODE_01AC83:
	LDA.w $0353,x
	BNE.b CODE_01AC8D
	TXA
	STA.w $0597,y
	INY
CODE_01AC8D:
	CPY.b #$04
	BEQ.b CODE_01AC98
	DEX
	CPX.b #$10
	BPL.b CODE_01AC83
	BRA.b CODE_01ACD0

CODE_01AC98:
	DEY
CODE_01AC99:
	LDX.w $0597,y
	LDA.b $03,S
	STA.w $0413,x
	STZ.w $03E3,x
	LDA.b $02,S
	STA.w $0473,x
	STZ.w $0443,x
	STZ.w $04A3,x
	LDA.b #$40
	STA.w $04D3,x
	STZ.w $0503,x
	STZ.w $0533,x
	LDA.b $01,S
	STA.w $0563,x
	CLC
	ADC.b #$04
	STA.b $01,S
	STZ.w $0383,x
	STZ.w $03B3,x
	INC.w $0353,x
	DEY
	BPL.b CODE_01AC99
CODE_01ACD0:
	PLA
	PLA
	PLA
	PLX
	RTS

;--------------------------------------------------------------------

CODE_01ACD5:
	LDX.b #$1F
CODE_01ACD7:
	LDA.w $0353,x
	BNE.b CODE_01ACDF
	JMP.w CODE_01AD6F

CODE_01ACDF:
	JSR.w CODE_01BD01
	LDA.w $0413,x
	CMP.b #$10
	BCC.b CODE_01ACF4
	CMP.b #$F0
	BCS.b CODE_01ACF4
	LDA.w $0473,x
	CMP.b #$E0
	BCC.b CODE_01ACF7
CODE_01ACF4:
	STZ.w $0353,x
CODE_01ACF7:
	LDA.w $0563,x
	BEQ.b CODE_01AD66
	DEC.w $0563,x
	CMP.b #$50
	BCS.b CODE_01AD6F
	LDA.w $05AD
	STA.w $04A3,x
	LDA.w $0040
	BNE.b CODE_01AD6F
	STZ.w $0000
	LDA.l $0004DE
	SEC
	SBC.w $0473,x
	BCS.b CODE_01AD21
	EOR.b #$FF
	INC
	INC.w $0000
CODE_01AD21:
	STA.w $0003
	ASL.w $0000
	LDA.l $0004DC
	SEC
	SBC.w $0413,x
	BCS.b CODE_01AD37
	EOR.b #$FF
	INC
	INC.w $0000
CODE_01AD37:
	STA.w $0002
	JSR.w CODE_01CB10
	LDA.w $0563,x
	CMP.b #$30
	BCS.b CODE_01AD4C
	LDA.w $0004
	STA.w $04D3,x
	BRA.b CODE_01AD66

CODE_01AD4C:
	LDA.w $0004
	SEC
	SBC.w $04D3,x
	CMP.b #$80
	ROR
	CMP.b #$80
	ROR
	CMP.b #$80
	ROR
	CMP.b #$80
	ROR
	CLC
	ADC.w $04D3,x
	STA.w $04D3,x
CODE_01AD66:
	LDA.b #$04
	PHA
	PHA
	JSR.w CODE_01BF29
	PLA
	PLA
CODE_01AD6F:
	DEX
	CPX.b #$10
	BMI.b CODE_01AD77
	JMP.w CODE_01ACD7

CODE_01AD77:
	RTS

;--------------------------------------------------------------------

CODE_01AD78:
	LDA.b #DATA_01AD94>>16
	PHA
	LDA.b #DATA_01AD94>>8
	PHA
	LDA.b #DATA_01AD94
	PHA
	LDX.b #$1F
CODE_01AD83:
	LDA.w $0353,x
	BEQ.b CODE_01AD8B
	JSR.w CODE_01BDE6
CODE_01AD8B:
	DEX
	CPX.b #$10
	BPL.b CODE_01AD83
	PLA
	PLA
	PLA
	RTS

DATA_01AD94:
	dw $0559,$055A,$055B,$00FF

;--------------------------------------------------------------------

CODE_01AD9C:
	LDA.w $00C9,x
	BNE.b CODE_01ADDC
	LDA.w $0042
	BEQ.b CODE_01AE22
	LDA.w $0047,x
	CMP.b #$03
	BCS.b CODE_01ADDE
	LDA.w $0312,x
	BNE.b CODE_01ADDC
	JSL.l CODE_01E20C
	AND.b #$01
	SEC
	SBC.b #$01
	BMI.b CODE_01ADBE
	INC
CODE_01ADBE:
	STA.w $0290,x
	JSL.l CODE_01E20C
	AND.b #$1F
	SEC
	SBC.b #$10
	BMI.b CODE_01ADCD
	INC
CODE_01ADCD:
	STA.w $02D1,x
	JSL.l CODE_01E20C
	AND.b #$1F
	CLC
	ADC.b #$10
	STA.w $0312,x
CODE_01ADDC:
	BRA.b CODE_01AE19

CODE_01ADDE:
	LDA.w $05AE
	STA.w $020E,x
	STZ.w $0000
	LDA.l $0004DE
	SEC
	SBC.w $01CD,x
	BCS.b CODE_01ADF7
	EOR.b #$FF
	INC
	INC.w $0000
CODE_01ADF7:
	STA.w $0003
	ASL.w $0000
	LDA.l $0004DC
	SEC
	SBC.w $014B,x
	BCS.b CODE_01AE0D
	EOR.b #$FF
	INC
	INC.w $0000
CODE_01AE0D:
	STA.w $0002
	JSR.w CODE_01CB10
	LDA.w $0004
	STA.w $024F,x
CODE_01AE19:
	DEC.w $0312,x
	JSR.w CODE_01C51D
	JSR.w CODE_01BC7B
CODE_01AE22:
	LDA.b #DATA_01AEF4>>16
	PHA
	LDA.b #DATA_01AEF4>>8
	PHA
	LDA.b #DATA_01AEF4
	PHA
	LDA.w $014B,x
	CMP.b #$30
	BCC.b CODE_01AE8F
	CMP.b #$D0
	BCS.b CODE_01AE8F
	LDA.w $01CD,x
	CMP.b #$20
	BCC.b CODE_01AE8F
	CMP.b #$C0
	BCS.b CODE_01AE8F
	LDA.w $014B,x
	SEC
	SBC.b #$30
	BCC.b CODE_01AE4F
	CMP.l $0004DC
	BCS.b CODE_01AE8F
CODE_01AE4F:
	LDA.w $014B,x
	CLC
	ADC.b #$30
	BCS.b CODE_01AE5D
	CMP.l $0004DC
	BCC.b CODE_01AE8F
CODE_01AE5D:
	LDA.w $01CD,x
	CMP.b #$F8
	BCS.b CODE_01AE8F
	SEC
	SBC.b #$30
	BCC.b CODE_01AE6F
	CMP.l $0004DE
	BCS.b CODE_01AE8F
CODE_01AE6F:
	LDA.w $01CD,x
	CLC
	ADC.b #$30
	BCS.b CODE_01AE7D
	CMP.l $0004DE
	BCC.b CODE_01AE8F
CODE_01AE7D:
	LDA.w $0047,x
	CMP.b #$03
	BCS.b CODE_01AE8F
	INC
	INC
	INC
	STA.w $0047,x
	LDA.b #$18
	STA.w $0312,x
CODE_01AE8F:
	LDA.w $0047,x
	CMP.b #$03
	BCC.b CODE_01AEAF
	CMP.b #$06
	BCS.b CODE_01AEAF
	LDA.w $00C9,x
	BNE.b CODE_01AEAF
	LDY.w $0312,x
	BNE.b CODE_01AEAF
	LDA.b #$0A
	JSL.l CODE_01D328
	LDA.b #$08
	STA.w $0047,x
CODE_01AEAF:
	LDA.w $0047,x
	CMP.b #$0F
	BNE.b CODE_01AEB9
	JSR.w CODE_01A819
CODE_01AEB9:
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.w $0047,x
	CMP.b #$08
	BCS.b CODE_01AED7
	LDA.b #$06
	PHA
	LDA.b #$08
	PHA
	PHA
	LDA.b #$36
	JSR.w CODE_01BE40
	PLA
	PLA
	PLA
	BRA.b CODE_01AEF3

CODE_01AED7:
	LDA.w $014B,x
	STA.w $0403,x
	LDA.w $01CD,x
	STA.w $0463,x
	PHX
	TXA
	SEC
	SBC.b #$10
	TAX
	LDA.b #$10
	PHA
	PHA
	JSR.w CODE_01BF29
	PLA
	PLA
	PLX
CODE_01AEF3:
	RTS

DATA_01AEF4:
	dw $010F,$0110,$00FF,$0411,$0412,$03FF,$010F,$06FF
	dw $0313,$0414,$0015,$0216,$0015,$0216,$0015,$0016

;--------------------------------------------------------------------

CODE_01AF14:
	PHP
	SEP.b #$30
	LDA.w $0014
	ASL
	ASL
	CLC
	ADC.w $0014
	CLC
	ADC.w $0016
	TAX
	LDA.l DATA_01CD3B,x
	STA.w $05A0
	LDA.l DATA_01CD4A,x
	STA.w $05A1
	LDA.l DATA_01CD59,x
	STA.w $05A2
	LDA.l DATA_01CD68,x
	STA.w $05A3
	LDA.l DATA_01CCFF,x
	STA.w $05A4
	LDA.l DATA_01CD0E,x
	STA.w $05A5
	LDA.l DATA_01CD1D,x
	STA.w $05A6
	LDA.l DATA_01CD2C,x
	STA.w $05A7
	LDA.l DATA_01CC96,x
	STA.w $05A8
	LDA.l DATA_01CCA5,x
	STA.w $05A9
	LDA.l DATA_01CCB4,x
	STA.w $05AA
	LDA.l DATA_01CCC3,x
	STA.w $05AB
	LDA.l DATA_01CCD2,x
	STA.w $05AC
	LDA.l DATA_01CCE1,x
	STA.w $05AD
	LDA.l DATA_01CCF0,x
	STA.w $05AE
	LDY.w $05A4
	BEQ.b CODE_01AF9E
	LDX.b #$0F
CODE_01AF95:
	PHY
	JSR.w CODE_01A819
	PLY
	DEX
	DEY
	BNE.b CODE_01AF95
CODE_01AF9E:
	LDY.w $05A5
	BEQ.b CODE_01AFAE
	LDX.b #$1F
CODE_01AFA5:
	PHY
	JSR.w CODE_01A819
	PLY
	DEX
	DEY
	BNE.b CODE_01AFA5
CODE_01AFAE:
	LDY.w $05A6
	BEQ.b CODE_01AFBE
	LDX.b #$2F
CODE_01AFB5:
	PHY
	JSR.w CODE_01AB05
	PLY
	DEX
	DEY
	BNE.b CODE_01AFB5
CODE_01AFBE:
	LDY.w $05A7
	BEQ.b CODE_01AFCE
	LDX.b #$3F
CODE_01AFC5:
	PHY
	JSR.w CODE_01A819
	PLY
	DEX
	DEY
	BNE.b CODE_01AFC5
CODE_01AFCE:
	JSR.w CODE_01BF99
	LDA.b #$01
	STA.w $0046
	INC.w $0024
	PLP
	RTS

;--------------------------------------------------------------------

CODE_01AFDB:
	PHP
	SEP.b #$30
	LDY.w $05A4
	BEQ.b CODE_01B00D
	STY.w $0045
	LDA.w $05A0
	STA.w $0044
	STZ.w $0042
	LDA.w $059C
	CLC
	ADC.w $05A8
	STA.w $059C
	ROL.w $0042
	LDX.b #$0F
CODE_01AFFE:
	PHY
	JSR.w CODE_01A8C4
	PLY
	DEX
	DEY
	BNE.b CODE_01AFFE
	LDA.w $0044
	STA.w $05A0
CODE_01B00D:
	LDY.w $05A5
	STY.w $0045
	BEQ.b CODE_01B03C
	LDA.w $05A1
	STA.w $0044
	STZ.w $0042
	LDA.w $059D
	CLC
	ADC.w $05A9
	STA.w $059D
	ROL.w $0042
	LDX.b #$1F
CODE_01B02D:
	PHY
	JSR.w CODE_01A93D
	PLY
	DEX
	DEY
	BNE.b CODE_01B02D
	LDA.w $0044
	STA.w $05A1
CODE_01B03C:
	LDY.w $05A6
	STY.w $0045
	BEQ.b CODE_01B06B
	LDA.w $05A2
	STA.w $0044
	STZ.w $0042
	LDA.w $059E
	CLC
	ADC.w $05AA
	STA.w $059E
	ROL.w $0042
	LDX.b #$2F
CODE_01B05C:
	PHY
	JSR.w CODE_01AB61
	PLY
	DEX
	DEY
	BNE.b CODE_01B05C
	LDA.w $0044
	STA.w $05A2
CODE_01B06B:
	LDY.w $05A7
	STY.w $0045
	BEQ.b CODE_01B09A
	LDA.w $05A3
	STA.w $0044
	STZ.w $0042
	LDA.w $059F
	CLC
	ADC.w $05AB
	STA.w $059F
	ROL.w $0042
	LDX.b #$3F
CODE_01B08B:
	PHY
	JSR.w CODE_01AD9C
	PLY
	DEX
	DEY
	BNE.b CODE_01B08B
	LDA.w $0044
	STA.w $05A3
CODE_01B09A:
	JSR.w CODE_01AAAD
	JSR.w CODE_01AAE3
	JSR.w CODE_01ACD5
	JSR.w CODE_01AD78
	LDA.w $05A0
	ORA.w $05A1
	ORA.w $05A2
	ORA.w $05A3
	BNE.b CODE_01B0C8
	LDA.b #$01
	STA.w $0024
	INC.w $0016
	LDA.w $0016
	CMP.b #$05
	BNE.b CODE_01B0C8
	LDA.b #$03
	STA.w $0024
CODE_01B0C8:
	PLP
	RTS

;--------------------------------------------------------------------

CODE_01B0CA:
	PHP
	LDA.w $0014
	CLC
	ADC.w #$000B
	JSL.l CODE_01D308
	JSR.w CODE_01CD86
	SEP.b #$30
	LDA.w $0014
	TAX
	LDA.l DATA_01CD77,x
	STA.w $05AF
	LDA.l DATA_01CD7A,x
	STA.w $05B0
	LDA.l DATA_01CD7D,x
	STA.w $05B1
	LDA.l DATA_01CD80,x
	STA.w $05B2
	LDA.l DATA_01CD83,x
	STA.w $05B3
	LDX.b #$03
CODE_01B104:
	LDA.b #$80
	STA.w $014B,x
	STZ.w $010A,x
	LDA.b #$40
	STA.w $01CD,x
	STZ.w $018C,x
	STZ.w $0047,x
	STZ.w $0088,x
	STZ.w $00C9,x
	STZ.w $020E,x
	STZ.w $024F,x
	STZ.w $0290,x
	STZ.w $02D1,x
	STZ.w $0312,x
	DEX
	BPL.b CODE_01B104
	LDA.b #$40
	STA.w $05B4
	STZ.w $05D5
	STZ.w $05D7
	STZ.w $05E7
	JSR.w CODE_01BF99
	INC.w $0024
	REP.b #$30
	JSR.w CODE_01B5D1
	JSR.w CODE_01A44D
	LDA.w #$0001
	STA.w $0046
	PLP
	RTS

;--------------------------------------------------------------------

CODE_01B153:
	PHP
	SEP.b #$30
	LDA.w $05B4
	BIT.b #$03
	BNE.b CODE_01B166
	DEC
	LSR
	LSR
	STA.l $000104
	BRA.b CODE_01B16C

CODE_01B166:
	LDA.b #$0F
	STA.l $000104
CODE_01B16C:
	DEC.w $05B4
	BNE.b CODE_01B179
	LDA.b #$40
	STA.w $05B4
	INC.w $0024
CODE_01B179:
	PLP
	RTS

;--------------------------------------------------------------------

CODE_01B17B:
	PHP
	LDA.w $05B4
	BIT.w #$0001
	BNE.b CODE_01B1EE
	LDX.w #$001E
CODE_01B187:
	LDA.w $05B5,x
	AND.w #$001F
	INC
	PHA
	LDA.l DATA_02FE00+$0160,x
	AND.w #$001F
	CMP.b $01,S
	BCC.b CODE_01B1A5
	LDA.w $05B5,x
	AND.w #$FFE0
	ORA.b $01,S
	STA.w $05B5,x
CODE_01B1A5:
	PLA
	LDA.w $05B5,x
	AND.w #$03E0
	CLC
	ADC.w #$0020
	PHA
	LDA.l DATA_02FE00+$0160,x
	AND.w #$03E0
	CMP.b $01,S
	BCC.b CODE_01B1C7
	LDA.w $05B5,x
	AND.w #$FC1F
	ORA.b $01,S
	STA.w $05B5,x
CODE_01B1C7:
	PLA
	LDA.w $05B5,x
	AND.w #$7C00
	CLC
	ADC.w #$0400
	PHA
	LDA.l DATA_02FE00+$0160,x
	AND.w #$7C00
	CMP.b $01,S
	BCC.b CODE_01B1E9
	LDA.w $05B5,x
	AND.w #$83FF
	ORA.b $01,S
	STA.w $05B5,x
CODE_01B1E9:
	PLA
	DEX
	DEX
	BPL.b CODE_01B187
CODE_01B1EE:
	SEP.b #$30
	LDA.w $05B4
	BIT.b #$03
	BNE.b CODE_01B205
	DEC
	LSR
	LSR
	EOR.b #$FF
	CLC
	ADC.b #$10
	STA.l $000104
	BRA.b CODE_01B20B

CODE_01B205:
	LDA.b #$0F
	STA.l $000104
CODE_01B20B:
	JSR.w CODE_01B60F
	LDA.w $014B
	STA.w $014C
	STA.w $014D
	STA.w $014E
	LDA.w $01CD
	STA.w $01CE
	STA.w $01CF
	STA.w $01D0
	LDA.b #DATA_01B340>>16
	PHA
	LDA.b #DATA_01B340>>8
	PHA
	LDA.b #DATA_01B340
	PHA
	LDX.b #$00
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.b #DATA_01B3B6>>16
	PHA
	LDA.b #DATA_01B3B6>>8
	PHA
	LDA.b #DATA_01B3B6
	PHA
	LDX.b #$01
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	JSR.w CODE_01B255
	DEC.w $05B4
	BNE.b CODE_01B253
	INC.w $0024
CODE_01B253:
	PLP
	RTS

;--------------------------------------------------------------------

CODE_01B255:
	LDA.b #$00
	STA.l $000202
	LDX.b #$07
CODE_01B25D:
	LDA.l DATA_01B275,x
	STA.l $000182,x
	DEX
	BPL.b CODE_01B25D
	LDA.b #$07
	STA.l $000204
	LDA.b #$01
	STA.l $000202
	RTS

DATA_01B275:
	db $01 : dl $7F05B5 : dw $0020,$00B0

;--------------------------------------------------------------------

CODE_01B27D:
	PHP
	SEP.b #$30
	STZ.w $0042
	LDA.w $0043
	CLC
	ADC.w $05AF
	STA.w $0043
	ROL.w $0042
	JSR.w CODE_01B60F
	JSR.w CODE_01B5F4
	LDA.w $0047
	BNE.b CODE_01B2A8
	JSL.l CODE_01E20C
	CMP.b #$80
	BCC.b CODE_01B2A8
	LDA.b #$2E
	STA.w $0047
CODE_01B2A8:
	LDA.w $014B
	STA.w $014C
	STA.w $014D
	STA.w $014E
	LDA.w $01CD
	STA.w $01CE
	STA.w $01CF
	STA.w $01D0
	LDA.w $05D5
	BNE.b CODE_01B2C8
	JSR.w CODE_01B925
CODE_01B2C8:
	LDA.b #$01
	STA.w $0046
	LDA.w $05D5
	BEQ.b CODE_01B2DC
	DEC.w $05D5
	BIT.b #$01
	BEQ.b CODE_01B2DC
	STZ.w $0046
CODE_01B2DC:
	LDA.w $05D7
	CMP.b #$08
	BCS.b CODE_01B2EF
	JSR.w CODE_01BAD1
	JSR.w CODE_01BB1A
	JSR.w CODE_01BBBE
	JSR.w CODE_01BC57
CODE_01B2EF:
	LDA.b #DATA_01B340>>16
	PHA
	LDA.b #DATA_01B340>>8
	PHA
	LDA.b #DATA_01B340
	PHA
	LDX.b #$00
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.b #DATA_01B3B6>>16
	PHA
	LDA.b #DATA_01B3B6>>8
	PHA
	LDA.b #DATA_01B3B6
	PHA
	LDX.b #$01
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.b #DATA_01B3CA>>16
	PHA
	LDA.b #DATA_01B3CA>>8
	PHA
	LDA.b #DATA_01B3CA
	PHA
	LDX.b #$02
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.b #DATA_01B3F0>>16
	PHA
	LDA.b #DATA_01B3F0>>8
	PHA
	LDA.b #DATA_01B3F0
	PHA
	LDX.b #$03
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.w $00C9
	BPL.b CODE_01B33E
	INC.w $0024
	STZ.w $001A
CODE_01B33E:
	PLP
	RTS

DATA_01B340:
	dw $1042,$1043,$00FF,$0444,$0445,$0444,$0445,$0444
	dw $0445,$0444,$0445,$0444,$0445,$3046,$00FF,$0447
	dw $3048,$0447,$5042,$00FF,$0342,$0549,$084A,$00FF
	dw $0349,$034A,$0342,$0349,$034A,$18FF,$0449,$044A
	dw $0442,$0549,$054A,$0549,$064A,$0642,$0649,$074A
	dw $0749,$074A,$0842,$0849,$014A,$2CFF,$07C9,$07CA
	dw $07CB,$07CC,$07CB,$07CA,$07C9,$00FF,$4FCD,$0FCE
	dw $03CF,$03D0,$38FF

DATA_01B3B6:
	dw $044B,$024C,$044D,$024C,$00FF,$024B,$014C,$024D
	dw $014C,$05FF

DATA_01B3CA:
	dw $0000,$00FF,$034E,$034F,$0350,$02FF,$0851,$0852
	dw $0853,$0D54,$0D55,$0D56,$0D55,$0D56,$0D55,$1056
	dw $0D57,$0A58,$00FF

DATA_01B3F0:
	dw $0000,$00FF,$025C,$025D,$02FF

;--------------------------------------------------------------------

CODE_01B3FA:
	PHP
	SEP.b #$30
	LDA.b #DATA_01B340>>16
	PHA
	LDA.b #DATA_01B340>>8
	PHA
	LDA.b #DATA_01B340
	PHA
	LDX.b #$00
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.b #DATA_01B3B6>>16
	PHA
	LDA.b #DATA_01B3B6>>8
	PHA
	LDA.b #DATA_01B3B6
	PHA
	LDX.b #$01
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.w $014B
	PHA
	LDA.w $01CD
	PHA
	LDX.b #$06
CODE_01B429:
	LDA.b $02,S
	CLC
	ADC.l DATA_01B46C,x
	STA.w $014B,x
	STZ.w $010A,x
	LDA.b $01,S
	CLC
	ADC.l DATA_01B473,x
	STA.w $01CD,x
	STZ.w $018C,x
	STZ.w $00C9,x
	LDA.b #$7F
	STA.w $020E,x
	LDA.l DATA_01B47A,x
	STA.w $024F,x
	LDA.b #$FE
	STA.w $0290,x
	STZ.w $02D1,x
	STZ.w $0312,x
	DEX
	BPL.b CODE_01B429
	LDA.b #$40
	STA.w $0312
	INC.w $0024
	PLA
	PLA
	PLP
	RTS

DATA_01B46C:
	db $18,$E8,$15,$EB,$00,$00,$00

DATA_01B473:
	db $FA,$FA,$FF,$FF,$0A,$0E,$F1

DATA_01B47A:
	db $20,$60,$E8,$98,$B0,$40,$D0

;--------------------------------------------------------------------

CODE_01B481:
	PHP
	SEP.b #$30
	LDX.b #$06
CODE_01B486:
	LDA.w $00C9,x
	BNE.b CODE_01B4B6
	JSR.w CODE_01BC7B
	LDA.w $020E,x
	CLC
	ADC.w $0290,x
	CMP.b #$40
	BCS.b CODE_01B4A1
	LDA.b #$3F
	STA.w $020E,x
	STZ.w $0290,x
CODE_01B4A1:
	LDA.w $014B,x
	CMP.b #$08
	BCC.b CODE_01B4B3
	CMP.b #$F8
	BCS.b CODE_01B4B3
	LDA.w $01CD,x
	CMP.b #$E0
	BCC.b CODE_01B4B6
CODE_01B4B3:
	INC.w $00C9,x
CODE_01B4B6:
	DEX
	BPL.b CODE_01B486
	LDX.b #$06
CODE_01B4BB:
	LDA.w $00C9,x
	BNE.b CODE_01B4E7
	PHX
	TXA
	REP.b #$30
	AND.w #$00FF
	CLC
	ADC.w #$0170
	PHA
	TXA
	AND.w #$00FF
	TAX
	LDA.w $01CD,x
	AND.w #$00FF
	TAY
	LDA.w $014B,x
	AND.w #$00FF
	TAX
	PLA
	JSL.l CODE_01F91E
	SEP.b #$30
	PLX
CODE_01B4E7:
	DEX
	BPL.b CODE_01B4BB
	DEC.w $0312
	BNE.b CODE_01B4F2
	INC.w $0024
CODE_01B4F2:
	PLP
	RTS

;--------------------------------------------------------------------

CODE_01B4F4:
	LDA.w #$000F
	LDY.w $0014
	CPY.w #$0002
	BNE.b CODE_01B502
	LDA.w #$001F
CODE_01B502:
	JSL.l CODE_01D308
	LDA.w #$003A
	JSL.l CODE_01D368
	JSR.w CODE_01CD93
	JSL.l CODE_01E2CE
	JSR.w CODE_01BFA8
	JSR.w CODE_01C133
	LDA.w $0150
	STA.w $0010
	LDX.w #$0200
CODE_01B523:
	PHX
	PHX
	JSL.l CODE_01E06F
	LDA.w #$0040
	STA.l $000446
	PLX
	CPX.w #$0180
	BCS.b CODE_01B567
	JSR.w CODE_01C18D
	SEP.b #$20
	LDA.w $01D2
	CMP.b #$90
	BEQ.b CODE_01B551
	LDA.w $0150
	CMP.b #$82
	BNE.b CODE_01B565
	LDA.b #$3C
	JSL.l CODE_01D368
	BRA.b CODE_01B565

CODE_01B551:
	LDA.l $00016C
	AND.b #$07
	BNE.b CODE_01B55F
	LDA.b #$3B
	JSL.l CODE_01D368
CODE_01B55F:
	LDA.w $0150
	STA.w $0010
CODE_01B565:
	REP.b #$20
CODE_01B567:
	JSR.w CODE_01C30F
	JSL.l CODE_01E2CE
	PLX
	DEX
	BNE.b CODE_01B523
	INC.w $0014
	STZ.w $0016
	LDA.w $0014
	CMP.w #$0003
	BNE.b CODE_01B586
	INC.w $0012
	STZ.w $0014
CODE_01B586:
	LDA.w #$0000
	JSL.l CODE_01D308
	JSL.l CODE_01E7C9
	LDA.w #$00AE
	JSL.l CODE_01E042
	JSR.w CODE_01A30D
	JSR.w CODE_01A2B7
	JSR.w CODE_01A373
	JSR.w CODE_01A44D
	JSL.l CODE_01DE97
	JSL.l CODE_01DECD
	JSL.l CODE_01E06F
	LDA.w #$0040
	STA.l $000446
	JSL.l CODE_01E2CE
	JSL.l CODE_01E2CE
	JSL.l CODE_01E2CE
	JSL.l CODE_01E794
	STZ.w $0024
	STZ.w $05EA
	STZ.w $0026
	RTS

;--------------------------------------------------------------------

CODE_01B5D1:
	LDX.w #$001E
CODE_01B5D4:
	STZ.w $05B5,x
	DEX
	DEX
	BPL.b CODE_01B5D4
	RTS

;--------------------------------------------------------------------

CODE_01B5DC:
	PHP
	REP.b #$30
	LDX.w #$001E
CODE_01B5E2:
	LDA.l DATA_02FE00+$0160,x
	STA.w $05B5,x
	DEX
	DEX
	BPL.b CODE_01B5E2
	SEP.b #$30
	JSR.w CODE_01B255
	PLP
	RTS

;--------------------------------------------------------------------

CODE_01B5F4:
	LDA.w $05D7
	JSL.l CODE_01E393

DATA_01B5FB:
	dw CODE_01B6AA
	dw CODE_01B70F
	dw CODE_01B784
	dw CODE_01B7A9
	dw CODE_01B7C7
	dw CODE_01B7E3
	dw CODE_01B841
	dw CODE_01B8A8
	dw CODE_01B8C8
	dw CODE_01B6A1

;--------------------------------------------------------------------

CODE_01B60F:
	LDA.w $05D7
	JSL.l CODE_01E393

DATA_01B616:
	dw CODE_01B62E
	dw CODE_01B62E
	dw CODE_01B62E
	dw CODE_01B62E
	dw CODE_01B62E
	dw CODE_01B62A
	dw CODE_01B62A
	dw CODE_01B66F
	dw CODE_01B66F
	dw CODE_01B62A

CODE_01B62A:
	STZ.w $05E7
	RTS

CODE_01B62E:
	LDA.w $05E7
	BNE.b CODE_01B65E
	LDA.w $01CD
	CMP.b #$40
	BCS.b CODE_01B64F
	LDA.b #$40
	STA.w $01CD
	STZ.w $018C
	JSL.l CODE_01E20C
	AND.b #$3F
	CLC
	ADC.b #$20
	STA.w $05E7
	RTS

CODE_01B64F:
	LDA.w $018C
	SEC
	SBC.b #$40
	STA.w $018C
	BCS.b CODE_01B66E
	DEC.w $01CD
	RTS

CODE_01B65E:
	DEC.w $05E7
	LDA.w $018C
	ADC.b #$20
	STA.w $018C
	BCC.b CODE_01B66E
	INC.w $01CD
CODE_01B66E:
	RTS

CODE_01B66F:
	LDA.w $05E7
	BNE.b CODE_01B691
	LDA.w $01CD
	CMP.b #$40
	BCS.b CODE_01B68D
	LDA.b #$40
	STA.w $01CD
	STZ.w $018C
	JSL.l CODE_01E20C
	AND.b #$07
	STA.w $05E7
	RTS

CODE_01B68D:
	DEC.w $01CD
	RTS

CODE_01B691:
	DEC.w $05E7
	INC.w $01CD
	RTS

CODE_01B698:
	LDX.b #$00
	JSR.w CODE_01BC7B
	DEC.w $0312
	RTS

;--------------------------------------------------------------------

CODE_01B6A1:
	LDA.w $0042
	BEQ.b CODE_01B6A9
	JSR.w CODE_01B698
CODE_01B6A9:
	RTS

;--------------------------------------------------------------------

CODE_01B6AA:
	LDA.w $0042
	BEQ.b CODE_01B70E
	JSR.w CODE_01B698
	JSL.l CODE_01E20C
	CMP.b #$40
	BCC.b CODE_01B6C4
	LDA.l $0004DE
	CMP.b #$90
	BCC.b CODE_01B709
	BRA.b CODE_01B6CC

CODE_01B6C4:
	LDA.l $0004DE
	CMP.b #$90
	BCS.b CODE_01B709
CODE_01B6CC:
	LDA.w $014B
	SEC
	SBC.b #$10
	CMP.l $0004DC
	BCS.b CODE_01B6F4
	LDA.w $014B
	CLC
	ADC.b #$10
	CMP.l $0004DC
	BCC.b CODE_01B6F4
	LDA.b #$0F
	STA.w $0047
	LDA.b #$FF
	STA.w $0088
	LDA.b #$05
	STA.w $05D7
	RTS

CODE_01B6F4:
	LDA.w $0040
	BNE.b CODE_01B709
	LDA.b #$0F
	STA.w $0047
	LDA.b #$FF
	STA.w $0088
	LDA.b #$03
	STA.w $05D7
	RTS

CODE_01B709:
	LDA.b #$01
	STA.w $05D7
CODE_01B70E:
	RTS

;--------------------------------------------------------------------

CODE_01B70F:
	LDA.w $0042
	BEQ.b CODE_01B783
	JSR.w CODE_01B698
	LDA.w $020E
	BNE.b CODE_01B765
	LDA.l $0004DC
	CMP.b #$38
	BCS.b CODE_01B728
	LDA.b #$38
	BRA.b CODE_01B72E

CODE_01B728:
	CMP.b #$C8
	BCC.b CODE_01B72E
	LDA.b #$C8
CODE_01B72E:
	SEC
	SBC.w $014B
	BEQ.b CODE_01B76A
	BCS.b CODE_01B750
	EOR.b #$FF
	INC
	LSR
	BEQ.b CODE_01B76A
	STA.w $0312
	LDA.b #$20
	STA.w $020E
	STZ.w $0290
	LDA.b #$80
	STA.w $024F
	STZ.w $02D1
	RTS

CODE_01B750:
	LSR
	BEQ.b CODE_01B76A
	STA.w $0312
	LDA.b #$20
	STA.w $020E
	STZ.w $0290
	STZ.w $024F
	STZ.w $02D1
	RTS

CODE_01B765:
	LDA.w $0312
	BNE.b CODE_01B783
CODE_01B76A:
	STZ.w $020E
	STZ.w $0290
	STZ.w $024F
	STZ.w $02D1
	LDA.b #$03
	STA.w $0047
	LDA.b #$FF
	STA.w $0088
	INC.w $05D7
CODE_01B783:
	RTS

;--------------------------------------------------------------------

CODE_01B784:
	LDA.w $0042
	BEQ.b CODE_01B78C
	JSR.w CODE_01B698
CODE_01B78C:
	LDA.w $0047
	BEQ.b CODE_01B7A5
	CMP.b #$0D
	BNE.b CODE_01B7A8
	LDA.w $0088
	CMP.b #$2C
	BNE.b CODE_01B7A8
	LDA.b #$03
	JSL.l CODE_01D328
	JMP.w CODE_01BA61

CODE_01B7A5:
	STZ.w $05D7
CODE_01B7A8:
	RTS

;--------------------------------------------------------------------

CODE_01B7A9:
	LDA.w $0042
	BEQ.b CODE_01B7B1
	JSR.w CODE_01B698
CODE_01B7B1:
	LDA.w $0047
	CMP.b #$12
	BNE.b CODE_01B7C6
	LDA.b #$0D
	JSL.l CODE_01D328
	LDA.b #$06
	STA.w $0049
	INC.w $05D7
CODE_01B7C6:
	RTS

;--------------------------------------------------------------------

CODE_01B7C7:
	LDA.w $0042
	BEQ.b CODE_01B7CF
	JSR.w CODE_01B698
CODE_01B7CF:
	LDA.w $0049
	CMP.b #$0F
	BNE.b CODE_01B7E2
	LDA.b #$04
	JSL.l CODE_01D328
	JSR.w CODE_01BB3C
	STZ.w $05D7
CODE_01B7E2:
	RTS

;--------------------------------------------------------------------

CODE_01B7E3:
	JSR.w CODE_01B698
	LDA.w $020E
	BNE.b CODE_01B812
	LDA.w $0047
	CMP.b #$12
	BNE.b CODE_01B840
	LDA.b #$7F
	STA.w $020E
	STZ.w $0290
	LDA.b #$40
	STA.w $024F
	STZ.w $02D1
	LDA.b #$0D
	STA.w $0312
	LDA.b #$02
	STA.w $004A
	LDA.b #$0E
	JSL.l CODE_01D328
CODE_01B812:
	LDA.w $0312
	BNE.b CODE_01B826
	STZ.w $020E
	STZ.w $0290
	STZ.w $024F
	STZ.w $02D1
	INC.w $05D7
CODE_01B826:
	LDA.w $014B
	STA.w $0442
	LDA.w $01CD
	CLC
	ADC.b #$2C
	STA.w $04A2
	LDX.b #$2F
	LDA.b #$04
	PHA
	PHA
	JSR.w CODE_01BF29
	PLA
	PLA
CODE_01B840:
	RTS

;--------------------------------------------------------------------

CODE_01B841:
	LDA.w $0042
	BEQ.b CODE_01B849
	JSR.w CODE_01B698
CODE_01B849:
	LDA.w $020E
	BNE.b CODE_01B86F
	LDA.b #$40
	STA.w $020E
	STZ.w $0290
	LDA.w $014B
	BPL.b CODE_01B867
	LDA.b #$80
	STA.w $024F
	LDA.b #$02
	STA.w $02D1
	BRA.b CODE_01B86F

CODE_01B867:
	STZ.w $024F
	LDA.b #$FE
	STA.w $02D1
CODE_01B86F:
	LDA.w $01CD
	CMP.b #$40
	BCS.b CODE_01B88D
	LDA.b #$40
	STA.w $01CD
	STZ.w $020E
	STZ.w $0290
	STZ.w $024F
	STZ.w $02D1
	STZ.w $05D7
	STZ.w $004A
CODE_01B88D:
	LDA.w $014B
	STA.w $0442
	LDA.w $01CD
	CLC
	ADC.b #$2C
	STA.w $04A2
	LDX.b #$2F
	LDA.b #$04
	PHA
	PHA
	JSR.w CODE_01BF29
	PLA
	PLA
	RTS

;--------------------------------------------------------------------

CODE_01B8A8:
	LDA.w $0047
	BNE.b CODE_01B8C7
	LDA.w $05D8
	STA.w $05D7
	STZ.w $0048
	LDA.w $004B
	STA.w $0047
	LDA.w $008C
	STA.w $0088
	LDA.b #$20
	STA.w $05D5
CODE_01B8C7:
	RTS

;--------------------------------------------------------------------

CODE_01B8C8:
	DEC.w $0312
	BNE.b CODE_01B8D2
	LDA.b #$FF
	STA.w $00C9
CODE_01B8D2:
	LDA.w $0312
	CMP.b #$80
	BNE.b CODE_01B8DE
	LDA.b #$1E
	STA.w $0047
CODE_01B8DE:
	LDA.w $0312
	BMI.b CODE_01B924
	LSR
	LSR
	LSR
	LSR
	LSR
	EOR.b #$FF
	CLC
	ADC.b #$04
	TAY
	BEQ.b CODE_01B924
CODE_01B8F0:
	PHY
	JSL.l CODE_01E20C
	AND.b #$1F
	SEC
	SBC.b #$10
	CLC
	ADC.w $014B
	TAX
	JSL.l CODE_01E20C
	AND.b #$3F
	SEC
	SBC.b #$20
	CLC
	ADC.w $01CD
	TAY
	JSL.l CODE_01E20C
	REP.b #$20
	AND.w #$0001
	CLC
	ADC.w #$0122
	JSL.l CODE_01F91E
	SEP.b #$20
	PLY
	DEY
	BNE.b CODE_01B8F0
CODE_01B924:
	RTS

;--------------------------------------------------------------------

CODE_01B925:
	LDA.w $05D7
	CMP.b #$07
	BCC.b CODE_01B92D
	RTS

CODE_01B92D:
	LDA.w $002C
	BNE.b CODE_01B933
	RTS

CODE_01B933:
	LDA.w $014B
	SEC
	SBC.b #$08
	CMP.w $0030
	BCC.b CODE_01B944
	CMP.w $0032
	BCC.b CODE_01B952
	RTS

CODE_01B944:
	LDA.w $014B
	CLC
	ADC.b #$08
	CMP.w $0030
	BCS.b CODE_01B952
	JMP.w CODE_01B9FA

CODE_01B952:
	LDA.w $01CD
	SEC
	SBC.b #$08
	CMP.w $0034
	BCC.b CODE_01B963
	CMP.w $0036
	BCC.b CODE_01B971
	RTS

CODE_01B963:
	LDA.w $01CD
	CLC
	ADC.b #$08
	CMP.w $0034
	BCS.b CODE_01B971
	JMP.w CODE_01B9FA

CODE_01B971:
	LDA.b #$0A
	JSL.l CODE_01D348
	LDA.w $0014
	CMP.b #$02
	BEQ.b CODE_01B982
	LDA.b #$38
	BRA.b CODE_01B984

CODE_01B982:
	LDA.b #$39
CODE_01B984:
	JSL.l CODE_01D368
	STZ.w $05E7
	LDA.w $05D7
	STA.w $05D8
	LDA.b #$07
	STA.w $05D7
	LDA.w $0047
	STA.w $004B
	LDA.b #$14
	STA.w $0047
	LDA.w $0088
	STA.w $008C
	STZ.w $0088
	LDA.b #$05
	STA.w $0048
	LDA.b #$01
	STA.w $002E
	INC.w $00C9
	LDA.w $00C9
	PHA
	SEC
	SBC.b #$0A
	BCC.b CODE_01B9C7
	BIT.b #$01
	BNE.b CODE_01B9C7
	JSR.w CODE_01B9FB
CODE_01B9C7:
	PLA
	CMP.b #$14
	BCC.b CODE_01B9FA
	LDA.w $0014
	CMP.b #$02
	BEQ.b CODE_01B9D7
	LDA.b #$1A
	BRA.b CODE_01B9D9

CODE_01B9D7:
	LDA.b #$1E
CODE_01B9D9:
	JSL.l CODE_01D308
	INC.w $05D7
	LDA.b #$18
	STA.w $0047
	LDA.b #$05
	STA.w $0048
	LDA.b #$02
	STA.w $0049
	STZ.w $004A
	LDA.b #$FF
	STA.w $0312
	JSR.w CODE_01B5DC
CODE_01B9FA:
	RTS

CODE_01B9FB:
	PHP
	REP.b #$30
	LDX.w #$001E
CODE_01BA01:
	LDA.w $05B5,x
	AND.w #$001F
	INC
	INC
	BIT.w #$0020
	BEQ.b CODE_01BA11
	LDA.w #$001F
CODE_01BA11:
	PHA
	LDA.w $05B5,x
	AND.w #$FFE0
	ORA.b $01,S
	STA.w $05B5,x
	PLA
	LDA.w $05B5,x
	AND.w #$03E0
	SEC
	SBC.w #$0040
	BCS.b CODE_01BA2D
	LDA.w #$0000
CODE_01BA2D:
	PHA
	LDA.w $05B5,x
	AND.w #$FC1F
	ORA.b $01,S
	STA.w $05B5,x
	PLA
	LDA.w $05B5,x
	AND.w #$7C00
	SEC
	SBC.w #$0800
	BCS.b CODE_01BA49
	LDA.w #$0000
CODE_01BA49:
	PHA
	LDA.w $05B5,x
	AND.w #$83FF
	ORA.b $01,S
	STA.w $05B5,x
	PLA
	DEX
	DEX
	BPL.b CODE_01BA01
	SEP.b #$30
	JSR.w CODE_01B255
	PLP
	RTS

;--------------------------------------------------------------------

CODE_01BA61:
	LDA.w $014B
	PHA
	LDA.w $01CD
	SEC
	SBC.b #$04
	PHA
	INC.w $05E5
	LDA.w $05E5
	AND.b #$1F
	PHA
	LDY.b #$00
	LDX.b #$0F
CODE_01BA79:
	LDA.w $0353,x
	BNE.b CODE_01BA83
	TXA
	STA.w $05D9,y
	INY
CODE_01BA83:
	CPY.b #$08
	BEQ.b CODE_01BA8C
	DEX
	BPL.b CODE_01BA79
	BRA.b CODE_01BACD

CODE_01BA8C:
	DEY
CODE_01BA8D:
	LDX.w $05D9,y
	LDA.b $03,S
	STA.w $0413,x
	STZ.w $03E3,x
	LDA.b $02,S
	STA.w $0473,x
	STZ.w $0443,x
	LDA.w $05B0
	STA.w $04A3,x
	LDA.b $01,S
	STA.w $04D3,x
	CLC
	ADC.b #$20
	STA.b $01,S
	LDA.w $05B1
	STA.w $0503,x
	LDA.w $05B2
	STA.w $0533,x
	LDA.b #$04
	STA.w $0563,x
	STZ.w $0383,x
	STZ.w $03B3,x
	INC.w $0353,x
	DEY
	BPL.b CODE_01BA8D
CODE_01BACD:
	PLA
	PLA
	PLA
	RTS

;--------------------------------------------------------------------

CODE_01BAD1:
	LDX.b #$0F
CODE_01BAD3:
	LDA.w $0353,x
	BEQ.b CODE_01BB16
	JSR.w CODE_01BD01
	LDA.w $04A3,x
	CLC
	ADC.w $0503,x
	CMP.b #$7F
	BCC.b CODE_01BAEE
	LDA.b #$7F
	STA.w $04A3,x
	STZ.w $0503,x
CODE_01BAEE:
	LDA.w $0413,x
	CMP.b #$10
	BCC.b CODE_01BB00
	CMP.b #$F0
	BCS.b CODE_01BB00
	LDA.w $0473,x
	CMP.b #$E0
	BCC.b CODE_01BB03
CODE_01BB00:
	STZ.w $0353,x
CODE_01BB03:
	LDA.w $0563,x
	BEQ.b CODE_01BB0D
	DEC.w $0563,x
	BRA.b CODE_01BB16

CODE_01BB0D:
	LDA.b #$04
	PHA
	PHA
	JSR.w CODE_01BF29
	PLA
	PLA
CODE_01BB16:
	DEX
	BPL.b CODE_01BAD3
	RTS

;--------------------------------------------------------------------

CODE_01BB1A:
	LDA.b #DATA_01BB34>>16
	PHA
	LDA.b #DATA_01BB34>>8
	PHA
	LDA.b #DATA_01BB34
	PHA
	LDX.b #$0F
CODE_01BB25:
	LDA.w $0353,x
	BEQ.b CODE_01BB2D
	JSR.w CODE_01BDE6
CODE_01BB2D:
	DEX
	BPL.b CODE_01BB25
	PLA
	PLA
	PLA
	RTS

DATA_01BB34:
	db $5E,$02,$5F,$02,$60,$02,$FF,$00

;--------------------------------------------------------------------

CODE_01BB3C:
	LDA.w $014B
	INC
	PHA
	LDA.w $01CD
	CLC
	ADC.b #$30
	PHA
	LDA.b #$04
	PHA
	LDA.b #$00
	PHA
	LDY.b #$00
	LDX.b #$2E
CODE_01BB52:
	LDA.w $0353,x
	BNE.b CODE_01BB5C
	TXA
	STA.w $05D9,y
	INY
CODE_01BB5C:
	CPY.b #$0C
	BEQ.b CODE_01BB67
	DEX
	CPX.b #$10
	BPL.b CODE_01BB52
	BRA.b CODE_01BBB9

CODE_01BB67:
	DEY
CODE_01BB68:
	LDX.w $05D9,y
	LDA.b $04,S
	STA.w $0413,x
	STZ.w $03E3,x
	LDA.b $03,S
	STA.w $0473,x
	STZ.w $0443,x
	LDA.b $02,S
	STA.w $04A3,x
	LDA.b $01,S
	STA.w $04D3,x
	CLC
	ADC.b #$40
	STA.b $01,S
	STZ.w $0503,x
	STZ.w $0533,x
	LDA.b #$90
	STA.w $0563,x
	STZ.w $0383,x
	STZ.w $03B3,x
	INC.w $0353,x
	CPY.b #$09
	BCS.b CODE_01BBA6
	LDA.b #$09
	STA.b $02,S
CODE_01BBA6:
	CPY.b #$08
	BNE.b CODE_01BBAE
	LDA.b #$13
	STA.b $01,S
CODE_01BBAE:
	CPY.b #$04
	BNE.b CODE_01BBB6
	LDA.b #$2D
	STA.b $01,S
CODE_01BBB6:
	DEY
	BPL.b CODE_01BB68
CODE_01BBB9:
	PLA
	PLA
	PLA
	PLA
	RTS

;--------------------------------------------------------------------

CODE_01BBBE:
	LDX.b #$2E
CODE_01BBC0:
	LDA.w $0353,x
	BNE.b CODE_01BBC8
	JMP.w CODE_01BC4E

CODE_01BBC8:
	JSR.w CODE_01BD01
	LDA.w $0413,x
	CMP.b #$10
	BCC.b CODE_01BBDD
	CMP.b #$F0
	BCS.b CODE_01BBDD
	LDA.w $0473,x
	CMP.b #$E0
	BCC.b CODE_01BBE0
CODE_01BBDD:
	STZ.w $0353,x
CODE_01BBE0:
	LDA.w $0563,x
	BEQ.b CODE_01BC45
	DEC.w $0563,x
	CMP.b #$60
	BCC.b CODE_01BBF5
	CMP.b #$70
	BNE.b CODE_01BC4E
	STZ.w $04A3,x
	BRA.b CODE_01BC4E

CODE_01BBF5:
	LDA.w $05B3
	STA.w $04A3,x
	LDA.w $0040
	BNE.b CODE_01BC4E
	TXA
	AND.b #$0F
	STA.w $05E6
	LDA.w $0563,x
	AND.b #$0F
	CMP.w $05E6
	BNE.b CODE_01BC4E
	STZ.w $0000
	LDA.l $0004DE
	SEC
	SBC.w $0473,x
	BCS.b CODE_01BC23
	EOR.b #$FF
	INC
	INC.w $0000
CODE_01BC23:
	STA.w $0003
	ASL.w $0000
	LDA.l $0004DC
	SEC
	SBC.w $0413,x
	BCS.b CODE_01BC39
	EOR.b #$FF
	INC
	INC.w $0000
CODE_01BC39:
	STA.w $0002
	JSR.w CODE_01CB10
	LDA.w $0004
	STA.w $04D3,x
CODE_01BC45:
	LDA.b #$04
	PHA
	PHA
	JSR.w CODE_01BF29
	PLA
	PLA
CODE_01BC4E:
	DEX
	CPX.b #$10
	BMI.b CODE_01BC56
	JMP.w CODE_01BBC0

CODE_01BC56:
	RTS

;--------------------------------------------------------------------

CODE_01BC57:
	LDA.b #DATA_01BC73>>16
	PHA
	LDA.b #DATA_01BC73>>8
	PHA
	LDA.b #DATA_01BC73
	PHA
	LDX.b #$2E
CODE_01BC62:
	LDA.w $0353,x
	BEQ.b CODE_01BC6A
	JSR.w CODE_01BDE6
CODE_01BC6A:
	DEX
	CPX.b #$10
	BPL.b CODE_01BC62
	PLA
	PLA
	PLA
	RTS

DATA_01BC73:
	db $59,$05,$5A,$05,$5B,$05,$FF,$00

;--------------------------------------------------------------------

CODE_01BC7B:
	STZ.w $0001
	LDA.w $020E,x
	CLC
	ADC.w $0290,x
	STA.w $020E,x
	BPL.b CODE_01BC90
	EOR.b #$FF
	INC
	INC.w $0001
CODE_01BC90:
	STA.l !REGISTER_Multiplicand
	LDA.w $024F,x
	CLC
	ADC.w $02D1,x
	STA.w $024F,x
	PHA
	JSR.w CODE_01CAAE
	STA.l !REGISTER_Multiplier
	LDA.w $0000
	EOR.w $0001
	TAY
	REP.b #$20
	LDA.l !REGISTER_ProductOrRemainderLo
	LSR
	LSR
	LSR
	LSR
	CPY.b #$00
	BEQ.b CODE_01BCBF
	EOR.w #$FFFF
	INC
CODE_01BCBF:
	SEP.b #$20
	CLC
	ADC.w $010A,x
	STA.w $010A,x
	XBA
	ADC.w $014B,x
	STA.w $014B,x
	PLA
	JSR.w CODE_01CA98
	STA.l !REGISTER_Multiplier
	LDA.w $0000
	EOR.w $0001
	TAY
	REP.b #$20
	LDA.l !REGISTER_ProductOrRemainderLo
	LSR
	LSR
	LSR
	LSR
	CPY.b #$00
	BEQ.b CODE_01BCF0
	EOR.w #$FFFF
	INC
CODE_01BCF0:
	SEP.b #$20
	CLC
	ADC.w $018C,x
	STA.w $018C,x
	XBA
	ADC.w $01CD,x
	STA.w $01CD,x
	RTS

;--------------------------------------------------------------------

CODE_01BD01:
	STZ.w $0001
	LDA.w $04A3,x
	CLC
	ADC.w $0503,x
	STA.w $04A3,x
	BPL.b CODE_01BD16
	EOR.b #$FF
	INC
	INC.w $0001
CODE_01BD16:
	STA.l !REGISTER_Multiplicand
	LDA.w $04D3,x
	CLC
	ADC.w $0533,x
	STA.w $04D3,x
	PHA
	JSR.w CODE_01CAAE
	STA.l !REGISTER_Multiplier
	LDA.w $0000
	EOR.w $0001
	TAY
	REP.b #$20
	LDA.l !REGISTER_ProductOrRemainderLo
	LSR
	LSR
	LSR
	LSR
	CPY.b #$00
	BEQ.b CODE_01BD45
	EOR.w #$FFFF
	INC
CODE_01BD45:
	SEP.b #$20
	CLC
	ADC.w $03E3,x
	STA.w $03E3,x
	XBA
	ADC.w $0413,x
	STA.w $0413,x
	PLA
	JSR.w CODE_01CA98
	STA.l !REGISTER_Multiplier
	LDA.w $0000
	EOR.w $0001
	TAY
	REP.b #$20
	LDA.l !REGISTER_ProductOrRemainderLo
	LSR
	LSR
	LSR
	LSR
	CPY.b #$00
	BEQ.b CODE_01BD76
	EOR.w #$FFFF
	INC
CODE_01BD76:
	SEP.b #$20
	CLC
	ADC.w $0443,x
	STA.w $0443,x
	XBA
	ADC.w $0473,x
	STA.w $0473,x
	RTS

;--------------------------------------------------------------------

CODE_01BD87:
	PHX
	PHD
	TSC
	TCD
	LDA.w $0088,x
	DEC
	STA.w $0088,x
	BPL.b CODE_01BDB1
	LDA.w $0047,x
	INC
	STA.w $0047,x
	ASL
	TAY
	LDA.b [$06],y
	CMP.b #$FF
	BNE.b CODE_01BDAB
	INY
	LDA.b [$06],y
	STA.w $0047,x
	ASL
	TAY
CODE_01BDAB:
	INY
	LDA.b [$06],y
	STA.w $0088,x
CODE_01BDB1:
	LDA.w $0047,x
	ASL
	TAY
	LDA.w $0046
	BEQ.b CODE_01BDE1
	LDA.b [$06],y
	REP.b #$30
	AND.w #$00FF
	BEQ.b CODE_01BDE1
	CLC
	ADC.w #$010F
	PHA
	TXA
	AND.w #$00FF
	TAX
	LDA.w $01CD,x
	AND.w #$00FF
	TAY
	LDA.w $014B,x
	AND.w #$00FF
	TAX
	PLA
	JSL.l CODE_01F91E
CODE_01BDE1:
	SEP.b #$30
	PLD
	PLX
	RTS

;--------------------------------------------------------------------

CODE_01BDE6:
	PHX
	PHD
	TSC
	TCD
	LDA.w $03B3,x
	DEC
	STA.w $03B3,x
	BPL.b CODE_01BE10
	LDA.w $0383,x
	INC
	STA.w $0383,x
	ASL
	TAY
	LDA.b [$06],y
	CMP.b #$FF
	BNE.b CODE_01BE0A
	INY
	LDA.b [$06],y
	STA.w $0383,x
	ASL
	TAY
CODE_01BE0A:
	INY
	LDA.b [$06],y
	STA.w $03B3,x
CODE_01BE10:
	LDA.w $0383,x
	ASL
	TAY
	LDA.b [$06],y
	REP.b #$30
	AND.w #$00FF
	BEQ.b CODE_01BE3B
	CLC
	ADC.w #$010F
	PHA
	TXA
	AND.w #$00FF
	TAX
	LDA.w $0473,x
	AND.w #$00FF
	TAY
	LDA.w $0413,x
	AND.w #$00FF
	TAX
	PLA
	JSL.l CODE_01F91E
CODE_01BE3B:
	SEP.b #$30
	PLD
	PLX
	RTS

;--------------------------------------------------------------------

CODE_01BE40:
	STA.w $0005
	LDA.w $00C9,x
	BEQ.b CODE_01BE4B
	JMP.w CODE_01BED4

CODE_01BE4B:
	LDA.w $002C
	BNE.b CODE_01BE53
	JMP.w CODE_01BED3

CODE_01BE53:
	LDA.w $014B,x
	SEC
	SBC.b $04,S
	CMP.w $0030
	BCC.b CODE_01BE65
	CMP.w $0032
	BCC.b CODE_01BE70
	BRA.b CODE_01BED3

CODE_01BE65:
	LDA.w $014B,x
	CLC
	ADC.b $04,S
	CMP.w $0030
	BCC.b CODE_01BED3
CODE_01BE70:
	LDA.w $01CD,x
	SEC
	SBC.b $03,S
	CMP.w $0034
	BCC.b CODE_01BE82
	CMP.w $0036
	BCC.b CODE_01BE8D
	BRA.b CODE_01BED3

CODE_01BE82:
	LDA.w $01CD,x
	CLC
	ADC.b $03,S
	CMP.w $0034
	BCC.b CODE_01BED3
CODE_01BE8D:
	LDA.b #$0A
	JSL.l CODE_01D348
	LDA.w $0005
	JSL.l CODE_01D368
	STZ.w $020E,x
	LDA.b #$40
	STA.w $024F,x
	LDA.b #$07
	STA.w $0290,x
	STZ.w $02D1,x
	INC.w $001A
	INC.w $00C9,x
	LDA.b #$01
	STA.w $002E
	LDA.w $001A
	CMP.b #$4B
	BEQ.b CODE_01BED0
	CMP.b #$32
	BEQ.b CODE_01BED0
	CMP.b #$19
	BEQ.b CODE_01BED0
	LDA.w $0012
	BEQ.b CODE_01BED3
	LDA.w $001A
	CMP.b #$0A
	BNE.b CODE_01BED3
CODE_01BED0:
	STA.w $05EB
CODE_01BED3:
	RTS

CODE_01BED4:
	BMI.b CODE_01BF17
	LDA.b $05,S
	STA.w $0047,x
	LDA.w $01CD,x
	CMP.b #$F0
	BCC.b CODE_01BF04
	LDA.w $0005
	SEC
	SBC.b #$2E
	JSL.l CODE_01D328
	DEC.w $0044
	LDA.w $0044
	CMP.w $0045
	BPL.b CODE_01BF18
	STZ.w $020E,x
	STZ.w $0290,x
	LDA.b #$FF
	STA.w $00C9,x
	BRA.b CODE_01BF17

CODE_01BF04:
	LDA.w $020E,x
	CLC
	ADC.w $0290,x
	CMP.b #$7F
	BCC.b CODE_01BF17
	LDA.b #$7F
	STA.w $020E,x
	STZ.w $0290,x
CODE_01BF17:
	RTS

CODE_01BF18:
	TXA
	LSR
	LSR
	LSR
	LSR
	JSL.l CODE_01E393

DATA_01BF21:
	dw CODE_01A819
	dw CODE_01A819
	dw CODE_01AB05
	dw CODE_01A819

;--------------------------------------------------------------------

CODE_01BF29:
	LDA.w $0040
	BNE.b CODE_01BF98
	LDA.w $0022
	CMP.b #$02
	BEQ.b CODE_01BF98
	LDA.w $0413,x
	SEC
	SBC.b $04,S
	CMP.w $0038
	BCC.b CODE_01BF47
	CMP.w $003A
	BCC.b CODE_01BF52
	BRA.b CODE_01BF98

CODE_01BF47:
	LDA.w $0413,x
	CLC
	ADC.b $04,S
	CMP.w $0038
	BCC.b CODE_01BF98
CODE_01BF52:
	LDA.w $0473,x
	SEC
	SBC.b $03,S
	CMP.w $003C
	BCC.b CODE_01BF64
	CMP.w $003E
	BCC.b CODE_01BF6F
	BRA.b CODE_01BF98

CODE_01BF64:
	LDA.w $0473,x
	CLC
	ADC.b $03,S
	CMP.w $003C
	BCC.b CODE_01BF98
CODE_01BF6F:
	LDA.w $0022
	CMP.b #$03
	BEQ.b CODE_01BF7C
	LDA.b #$09
	JSL.l CODE_01D348
CODE_01BF7C:
	STZ.w $0353,x
	REP.b #$20
	STZ.w $001E
	LDA.w #$FFFF
	STA.w $0020
	SEP.b #$20
	LDA.w $0022
	CMP.b #$03
	BEQ.b CODE_01BF98
	LDA.b #$02
	STA.w $0022
CODE_01BF98:
	RTS

CODE_01BF99:
	PHP
	REP.b #$30
	LDX.w #$002E
CODE_01BF9F:
	STZ.w $0353,x
	DEX
	DEX
	BPL.b CODE_01BF9F
	PLP
	RTS

CODE_01BFA8:
	LDA.w #$00AE
	JSL.l CODE_01E042
	LDX.w #$001C
CODE_01BFB2:
	LDA.l DATA_01BFD6,x
	STA.l $7E3250,x
	LDA.l DATA_01BFF4,x
	STA.l $7E3290,x
	DEX
	DEX
	BPL.b CODE_01BFB2
	JSL.l CODE_01DECD
	JSL.l CODE_01E2CE
	LDA.w #$000F
	JSL.l CODE_01D308
	RTS

DATA_01BFD6:
	dw $2F4C,$2F4E,$2F50,$2F52,$2F54,$2F56,$2F58,$2F5A
	dw $2F5C,$2F56,$2F58,$2F5E,$2F80,$2F82,$2F84

DATA_01BFF4:
	dw $2F6C,$2F6E,$2F70,$2F72,$2F74,$2F76,$2F78,$2F7A
	dw $2F7C,$2F76,$2F78,$2F7E,$2FA0,$2FA2

;--------------------------------------------------------------------

CODE_01C010:
	LDY.b $2F
CODE_01C012:
	JSR.w CODE_01A44D
	JSR.w CODE_01A373
	LDX.w #$0008
CODE_01C01B:
	LDA.l DATA_01C0BF,x
	STA.l $7E32D6,x
	LDA.l DATA_01C0C9,x
	STA.l $7E3316,x
	DEX
	DEX
	BPL.b CODE_01C01B
	LDA.w $0014
	ASL
	ASL
	CLC
	ADC.w #$2F04
	STA.l $7E32E4
	INC
	INC
	STA.l $7E32E6
	CLC
	ADC.w #$001E
	STA.l $7E3324
	INC
	INC
	STA.l $7E3326
	JSL.l CODE_01DECD
	LDA.w #$0040
CODE_01C057:
	PHA
	JSL.l CODE_01E06F
	LDA.w #$0040
	STA.l $000446
	JSR.w CODE_01A54F
	JSR.w CODE_01A5E4
	JSR.w CODE_01A5BB
	JSR.w CODE_01C5F8
	PLA
	DEC
	BNE.b CODE_01C057
	LDA.w #$00AE
	JSL.l CODE_01E042
	JSR.w CODE_01A30D
	JSR.w CODE_01A44D
	JSR.w CODE_01A373
	LDA.w $0014
	CLC
	ADC.w #$0008
	JSL.l CODE_01D308
	JSL.l CODE_01DECD
	LDA.w #$00B4
CODE_01C095:
	PHA
	JSL.l CODE_01E06F
	LDA.w #$0040
	STA.l $000446
	JSR.w CODE_01A54F
	JSR.w CODE_01A5E4
	JSR.w CODE_01A5BB
	JSR.w CODE_01C5F8
	PLA
	DEC
	BNE.b CODE_01C095
	LDA.w #$0000
	STA.l $000446
	JSR.w CODE_01A5BB
	INC.w $0024
	RTS

DATA_01C0BF:
	dw $2F5C,$2F88,$2F8C,$2F88,$2F5C

DATA_01C0C9:
	dw $2F7C,$2FA8,$2FAC,$2FA8,$2F7C

;--------------------------------------------------------------------

CODE_01C0D3:
	LDA.w #$000E
	JSL.l CODE_01D308
	LDA.w #$00AE
	JSL.l CODE_01E042
	JSR.w CODE_01A30D
	LDA.w $0024
	CMP.w #$0003
	BCS.b CODE_01C0EF
	JSR.w CODE_01A373
CODE_01C0EF:
	LDX.w #$0010
CODE_01C0F2:
	LDA.l DATA_01C10F,x
	STA.l $7E32D6,x
	LDA.l DATA_01C121,x
	STA.l $7E3316,x
	DEX
	DEX
	BPL.b CODE_01C0F2
	JSL.l CODE_01DECD
	JSL.l CODE_01E2CE
	RTS

DATA_01C10F:
	dw $2F52,$2F56,$2F86,$2F88,$2FAE,$2F8A,$2F8C,$2F88
	dw $2F54

DATA_01C121:
	dw $2F72,$2F76,$2FA6,$2FA8,$2FAE,$2FAA,$2FAC,$2FA8
	dw $2F74

;--------------------------------------------------------------------

CODE_01C133:
	PHP
	SEP.b #$30
	LDX.b #$09
CODE_01C138:
	LDA.l DATA_01C179,x
	STA.w $014B,x
	STZ.w $010A,x
	LDA.l DATA_01C183,x
	STA.w $01CD,x
	STZ.w $018C,x
	STZ.w $0047,x
	STZ.w $0088,x
	STZ.w $00C9,x
	STZ.w $020E,x
	STZ.w $024F,x
	STZ.w $0290,x
	STZ.w $02D1,x
	STZ.w $0312,x
	DEX
	BPL.b CODE_01C138
	STZ.w $05E8
	STZ.w $05E9
	LDA.b #$20
	STA.w $0212
	LDA.b #$40
	STA.w $0253
CODE_01C177:
	PLP
	RTS

DATA_01C179:
	dw $6838,$C898,$F850,$F8F8,$F8F8

DATA_01C183:
	dw $B0B0,$B0B0,$90F0,$9090,$9090

;--------------------------------------------------------------------

CODE_01C18D:
	PHP
	SEP.b #$30
	LDA.w $0316
	BNE.b CODE_01C1DE
	LDA.w $05E8
	ASL
	CLC
	ADC.w $05E8
	TAX
	LDA.l DATA_01C2D3,x
	AND.l DATA_01C2D3+$01,x
	AND.l DATA_01C2D3+$02,x
	CMP.b #$FF
	BNE.b CODE_01C1C6
	STZ.w $0212
	STZ.w $0253
	STZ.w $0294
	STZ.w $02D5
	LDA.b #$20
	STA.w $0213
	LDA.b #$80
	STA.w $0254
	BRA.b CODE_01C1DE

CODE_01C1C6:
	LDA.l DATA_01C2D3,x
	STA.w $0294
	LDA.l DATA_01C2D3+$01,x
	STA.w $02D5
	LDA.l DATA_01C2D3+$02,x
	STA.w $0316
	INC.w $05E8
CODE_01C1DE:
	DEC.w $0316
	LDX.b #$04
	JSR.w CODE_01BC7B
	LDA.w $0150
	CMP.b #$08
	BCC.b CODE_01C222
	LDA.w $0213
	BNE.b CODE_01C1F4
	PLP
	RTS

CODE_01C1F4:
	LDA.w $0317
	BNE.b CODE_01C21A
	LDA.w $05E9
	ASL
	CLC
	ADC.w $05E9
	TAX
	LDA.l DATA_01C2F4,x
	STA.w $0295
	LDA.l DATA_01C2F4+$01,x
	STA.w $02D6
	LDA.l DATA_01C2F4+$02,x
	STA.w $0317
	INC.w $05E9
CODE_01C21A:
	DEC.w $0317
	LDX.b #$05
	JSR.w CODE_01BC7B
CODE_01C222:
	LDA.w $0014
	BEQ.b CODE_01C296
	LDA.w $0150
	CMP.b #$E4
	BCS.b CODE_01C23C
	CMP.b #$08
	BCC.b CODE_01C23C
	LDA.b #$20
	STA.w $0214
	LDA.b #$80
	STA.w $0255
CODE_01C23C:
	LDX.b #$06
	JSR.w CODE_01BC7B
	LDA.w $0014
	CMP.b #$01
	BEQ.b CODE_01C296
	LDA.w $0151
	CMP.b #$E4
	BCS.b CODE_01C25D
	CMP.b #$08
	BCC.b CODE_01C25D
	LDA.b #$20
	STA.w $0215
	LDA.b #$80
	STA.w $0256
CODE_01C25D:
	LDX.b #$07
	JSR.w CODE_01BC7B
	LDA.w $0152
	CMP.b #$E4
	BCS.b CODE_01C277
	CMP.b #$08
	BCC.b CODE_01C277
	LDA.b #$20
	STA.w $0216
	LDA.b #$80
	STA.w $0257
CODE_01C277:
	LDX.b #$08
	JSR.w CODE_01BC7B
	LDA.w $0153
	CMP.b #$E4
	BCS.b CODE_01C291
	CMP.b #$08
	BCC.b CODE_01C291
	LDA.b #$20
	STA.w $0217
	LDA.b #$80
	STA.w $0258
CODE_01C291:
	LDX.b #$09
	JSR.w CODE_01BC7B
CODE_01C296:
	LDA.w $05E9
	CMP.b #$02
	BNE.b CODE_01C2A7
	LDA.b #$02
	STA.w $004C
	STZ.w $008D
	BRA.b CODE_01C2BD

CODE_01C2A7:
	CMP.b #$04
	BNE.b CODE_01C2BD
	LDA.b #$60
	STA.w $0212
	LDA.b #$C0
	STA.w $0253
	STZ.w $0316
	LDA.b #$09
	STA.w $05E8
CODE_01C2BD:
	LDX.b #$09
CODE_01C2BF:
	LDA.w $014B,x
	CMP.b #$08
	BCS.b CODE_01C2CC
	STZ.w $020E,x
	STZ.w $0290,x
CODE_01C2CC:
	DEX
	CPX.b #$05
	BPL.b CODE_01C2BF
	PLP
	RTS

DATA_01C2D3:
	db $00,$00,$1C,$00,$F9,$10,$00,$F2
	db $10,$00,$03,$10,$00,$F5,$10,$00
	db $FC,$10,$00,$01,$10,$00,$00,$02
	db $FF,$FF,$FF,$FF,$00,$18,$FF,$FF
	db $FF

DATA_01C2F4:
	db $00,$00,$32,$30,$30,$01,$FA,$FA
	db $08,$06,$FA,$01,$06,$FA,$07,$D0
	db $30,$01,$00,$00,$FF,$00,$00,$36
	db $FF,$FF,$FF

;--------------------------------------------------------------------

CODE_01C30F:
	PHP
	SEP.b #$30
	LDA.b #DATA_01C39A>>16
	PHA
	LDA.b #DATA_01C39A>>8
	PHA
	LDA.b #DATA_01C39A
	PHA
	LDX.b #$03
CODE_01C31D:
	JSR.w CODE_01BD87
	DEX
	BPL.b CODE_01C31D
	PLA
	PLA
	PLA
	LDA.b #DATA_01A933>>16
	PHA
	LDA.b #DATA_01A933>>8
	PHA
	LDA.b #DATA_01A933
	PHA
	LDX.b #$04
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.b #DATA_01C3A2>>16
	PHA
	LDA.b #DATA_01C3A2>>8
	PHA
	LDA.b #DATA_01C3A2
	PHA
	LDX.b #$05
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.w $0014
	BEQ.b CODE_01C398
	LDA.b #DATA_01C3AC>>16
	PHA
	LDA.b #DATA_01C3AC>>8
	PHA
	LDA.b #DATA_01C3AC
	PHA
	LDX.b #$06
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.w $0014
	CMP.b #$01
	BEQ.b CODE_01C398
	LDA.b #DATA_01C3B2>>16
	PHA
	LDA.b #DATA_01C3B2>>8
	PHA
	LDA.b #DATA_01C3B2
	PHA
	LDX.b #$07
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.b #DATA_01C3B8>>16
	PHA
	LDA.b #DATA_01C3B8>>8
	PHA
	LDA.b #DATA_01C3B8
	PHA
	LDX.b #$08
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	LDA.b #DATA_01C3BE>>16
	PHA
	LDA.b #DATA_01C3BE>>8
	PHA
	LDA.b #DATA_01C3BE
	PHA
	LDX.b #$09
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
CODE_01C398:
	PLP
	RTS

DATA_01C39A:
	dw $0326,$0224,$0225,$00FF

DATA_01C3A2:
	dw $023B,$033C,$00FF,$103E,$00FF

DATA_01C3AC:
	dw $0433,$0434,$00FF

DATA_01C3B2:
	dw $0435,$0436,$00FF

DATA_01C3B8:
	dw $0437,$0438,$00FF

DATA_01C3BE:
	dw $0439,$043A,$00FF

;--------------------------------------------------------------------

CODE_01C3C4:
	PHP
	SEP.b #$30
	LDA.w $0012
	BNE.b CODE_01C3DA
	LDA.w $0024
	CMP.b #$03
	BCS.b CODE_01C3E3
	LDA.w $05EB
	BNE.b CODE_01C3EA
CODE_01C3D8:
	PLP
	RTS

CODE_01C3DA:
	LDA.w $05EB
	CMP.b #$0A
	BNE.b CODE_01C3D8
	BRA.b CODE_01C3EA

CODE_01C3E3:
	LDA.w $00C9
	CMP.b #$0F
	BNE.b CODE_01C3D8
CODE_01C3EA:
	CMP.w $05EA
	BEQ.b CODE_01C3D8
	STA.w $05EA
	STZ.w $05EB
	LDA.w $0018
	CMP.b #$06
	BEQ.b CODE_01C3D8
	JSL.l CODE_01E20C
	AND.b #$3F
	CLC
	ADC.b #$60
	STA.w $018B
	STZ.w $014A
	LDA.b #$F8
	STA.w $020D
	STZ.w $01CC
	LDA.b #$20
	STA.w $024E
	LDA.b #$60
	STA.w $028F
	STZ.w $02D0
	JSL.l CODE_01E20C
	AND.b #$03
	SEC
	SBC.b #$04
	STA.w $0311
	STZ.w $00C8
	STZ.w $0087
	STZ.w $0109
	INC.w $0026
	PLP
	RTS

;--------------------------------------------------------------------

CODE_01C43A:
	PHP
	SEP.b #$30
	LDA.w $0042
	BEQ.b CODE_01C48B
	LDA.w $028F
	CMP.b #$10
	BCC.b CODE_01C45B
	CMP.b #$70
	BCC.b CODE_01C465
	JSL.l CODE_01E20C
	AND.b #$03
	SEC
	SBC.b #$04
	STA.w $0311
	BRA.b CODE_01C465

CODE_01C45B:
	JSL.l CODE_01E20C
	AND.b #$03
	INC
	STA.w $0311
CODE_01C465:
	LDA.w $018B
	CMP.b #$08
	BCS.b CODE_01C478
	LDA.b #$30
	STA.w $028F
	LDA.b #$FF
	STA.w $0311
	BRA.b CODE_01C486

CODE_01C478:
	CMP.b #$F8
	BCC.b CODE_01C486
	LDA.b #$50
	STA.w $028F
	LDA.b #$01
	STA.w $0311
CODE_01C486:
	LDX.b #$40
	JSR.w CODE_01BC7B
CODE_01C48B:
	JSR.w CODE_01C4BC
	LDA.w $020D
	CMP.b #$E8
	BCC.b CODE_01C499
	CMP.b #$F0
	BCC.b CODE_01C49E
CODE_01C499:
	LDA.w $0109
	BEQ.b CODE_01C4A3
CODE_01C49E:
	STZ.w $0026
	PLP
	RTS

CODE_01C4A3:
	LDA.b #DATA_01C4B6>>16
	PHA
	LDA.b #DATA_01C4B6>>8
	PHA
	LDA.b #DATA_01C4B6
	PHA
	LDX.b #$40
	JSR.w CODE_01BD87
	PLA
	PLA
	PLA
	PLP
	RTS

DATA_01C4B6:
	dw $0222,$0223,$00FF

;--------------------------------------------------------------------

CODE_01C4BC:
	LDA.w $002C
	BEQ.b CODE_01C51C
	LDA.w $018B
	SEC
	SBC.b #$08
	CMP.w $0030
	BCC.b CODE_01C4D3
	CMP.w $0032
	BCC.b CODE_01C4DE
	BRA.b CODE_01C51C

CODE_01C4D3:
	LDA.w $018B
	CLC
	ADC.b #$08
	CMP.w $0030
	BCC.b CODE_01C51C
CODE_01C4DE:
	LDA.w $020D
	SEC
	SBC.b #$08
	CMP.w $0034
	BCC.b CODE_01C4F0
	CMP.w $0036
	BCC.b CODE_01C4FB
	BRA.b CODE_01C51C

CODE_01C4F0:
	LDA.w $020D
	CLC
	ADC.b #$08
	CMP.w $0034
	BCC.b CODE_01C51C
CODE_01C4FB:
	REP.b #$30
	LDA.w #$0001
	JSL.l CODE_01D328
	LDA.w $0018
	CMP.w #$0063
	BCS.b CODE_01C50F
	INC.w $0018
CODE_01C50F:
	JSR.w CODE_01A44D
	SEP.b #$30
	INC.w $0109
	LDA.b #$01
	STA.w $002E
CODE_01C51C:
	RTS

;--------------------------------------------------------------------

CODE_01C51D:
	LDA.w $00C9,x
	BNE.b CODE_01C590
	LDA.w $020E,x
	BPL.b CODE_01C52A
	JMP.w CODE_01C591

CODE_01C52A:
	LDA.w $014B,x
	CMP.b #$18
	BCS.b CODE_01C54A
	LDA.w $024F,x
	CMP.b #$40
	BCC.b CODE_01C565
	CMP.b #$C0
	BCS.b CODE_01C565
	EOR.b #$FF
	CLC
	ADC.b #$81
	SEC
	SBC.w $02D1,x
	STA.w $024F,x
	BRA.b CODE_01C565

CODE_01C54A:
	CMP.b #$E8
	BCC.b CODE_01C565
	LDA.w $024F,x
	CMP.b #$40
	BCC.b CODE_01C559
	CMP.b #$C0
	BCC.b CODE_01C565
CODE_01C559:
	EOR.b #$FF
	CLC
	ADC.b #$81
	SEC
	SBC.w $02D1,x
	STA.w $024F,x
CODE_01C565:
	LDA.w $01CD,x
	CMP.b #$18
	BCS.b CODE_01C57D
	LDA.w $024F,x
	BPL.b CODE_01C590
	EOR.b #$FF
	INC
	SEC
	SBC.w $02D1,x
	STA.w $024F,x
	BRA.b CODE_01C590

CODE_01C57D:
	CMP.b #$C8
	BCC.b CODE_01C590
	LDA.w $024F,x
	BMI.b CODE_01C590
	EOR.b #$FF
	INC
	SEC
	SBC.w $02D1,x
	STA.w $024F,x
CODE_01C590:
	RTS

CODE_01C591:
	LDA.w $014B,x
	CMP.b #$18
	BCS.b CODE_01C5B1
	LDA.w $024F,x
	CMP.b #$40
	BCC.b CODE_01C5A3
	CMP.b #$C0
	BCC.b CODE_01C5CC
CODE_01C5A3:
	EOR.b #$FF
	CLC
	ADC.b #$81
	SEC
	SBC.w $02D1,x
	STA.w $024F,x
	BRA.b CODE_01C5CC

CODE_01C5B1:
	CMP.b #$E8
	BCC.b CODE_01C5CC
	LDA.w $024F,x
	CMP.b #$40
	BCC.b CODE_01C5CC
	CMP.b #$C0
	BCS.b CODE_01C5CC
	EOR.b #$FF
	CLC
	ADC.b #$81
	SEC
	SBC.w $02D1,x
	STA.w $024F,x
CODE_01C5CC:
	LDA.w $01CD,x
	CMP.b #$18
	BCS.b CODE_01C5E4
	LDA.w $024F,x
	BMI.b CODE_01C5F7
	EOR.b #$FF
	INC
	SEC
	SBC.w $02D1,x
	STA.w $024F,x
	BRA.b CODE_01C5F7

CODE_01C5E4:
	CMP.b #$C8
	BCC.b CODE_01C5F7
	LDA.w $024F,x
	BPL.b CODE_01C5F7
	EOR.b #$FF
	INC
	SEC
	SBC.w $02D1,x
	STA.w $024F,x
CODE_01C5F7:
	RTS

;--------------------------------------------------------------------

CODE_01C5F8:
	PHP
	REP.b #$20
	LDA.l $0004CA
	BIT.w #$0002
	BEQ.b CODE_01C61C
	LDA.w #$00F0
	JSL.l CODE_01D308
	JSR.w CODE_01C622
	BCC.b CODE_01C615
	LDA.w $0006
	TCS
	RTS

CODE_01C615:
	LDA.w #$00F1
	JSL.l CODE_01D308
CODE_01C61C:
	JSL.l CODE_01E2CE
	PLP
	RTS

CODE_01C622:
	PHP
	SEP.b #$20
	LDA.l $000104
	PHA
	LDA.b #$0F
	STA.l $000104
	REP.b #$20
	LDA.l $000446
	PHA
	LDA.l $0004DC
	CMP.w #$0050
	BCS.b CODE_01C643
	LDA.w #$0050
CODE_01C643:
	CMP.w #$00A8
	BCC.b CODE_01C64B
	LDA.w #$00A8
CODE_01C64B:
	AND.w #$FFF8
	STA.w $000C
	SEC
	SBC.w #$0030
	STA.w $0008
	LSR
	LSR
	PHA
	LDA.l $0004DE
	CMP.w #$0060
	BCS.b CODE_01C667
	LDA.w #$0060
CODE_01C667:
	CMP.w #$0090
	BCC.b CODE_01C66F
	LDA.w #$0090
CODE_01C66F:
	AND.w #$FFF8
	STA.w $000E
	SEC
	SBC.w #$0040
	STA.w $000A
	ASL
	ASL
	ASL
	CLC
	ADC.b $01,S
	TAX
	PLA
	PHB
	SEP.b #$20
	LDA.b #DATA_01C7F2>>16
	PHA
	PLB
	REP.b #$20
	LDY.w #$0000
	LDA.w #$000E
CODE_01C693:
	PHA
	PHX
	LDA.w #$000D
CODE_01C698:
	PHA
	LDA.w DATA_01C7F2,y
	STA.l $7E2800,x
	PLA
	INY
	INY
	INX
	INX
	DEC
	BNE.b CODE_01C698
	PLX
	TXA
	CLC
	ADC.w #$0040
	TAX
	PLA
	DEC
	BNE.b CODE_01C693
	PLB
	JSL.l CODE_01E2CE
	JSL.l CODE_01DEB2
	LDA.w #$0001
	STA.l $000220
	SEP.b #$20
	LDA.b #$02
	STA.l $000112
	REP.b #$20
	JSR.w CODE_01C9EF
	LDA.w #$0023
	JSL.l CODE_01F825
	LDA.w $0008
	LSR
	XBA
	CLC
	ADC.l $001A28
	STA.l $001A28
	LDA.w $000A
	XBA
	CLC
	ADC.l $001A2A
	STA.l $001A2A
	LDA.w #$0024
	JSL.l CODE_01F825
	LDA.w $0008
	LSR
	XBA
	CLC
	ADC.l $001A30
	STA.l $001A30
	LDA.w $000A
	XBA
	CLC
	ADC.l $001A32
	STA.l $001A32
	LDA.w #$0025
	JSL.l CODE_01F825
	LDA.w $0008
	LSR
	XBA
	CLC
	ADC.l $001A38
	STA.l $001A38
	LDA.w $000A
	XBA
	CLC
	ADC.l $001A3A
	STA.l $001A3A
	LDA.w #$0000
	STA.l $0004CA
CODE_01C73D:
	LDA.l $0004CA
	BIT.w #$0020
	BEQ.b CODE_01C779
	LDA.w $000C
	SEC
	SBC.w $0008
	BCC.b CODE_01C779
	CMP.w #$0067
	BCS.b CODE_01C779
	LDA.w $000E
	SEC
	SBC.w $000A
	CMP.w #$0008
	BCC.b CODE_01C779
	CMP.w #$001F
	BCC.b CODE_01C77E
	CMP.w #$0030
	BCC.b CODE_01C779
	CMP.w #$0047
	BCC.b CODE_01C7B2
	CMP.w #$0050
	BCC.b CODE_01C779
	CMP.w #$0067
	BCC.b CODE_01C78A
CODE_01C779:
	JSR.w CODE_01C95E
	BRA.b CODE_01C73D

CODE_01C77E:
	LDA.w #$FFFF
	STA.l $001A3D
	JSR.w CODE_01C95E
	BRA.b CODE_01C73D

CODE_01C78A:
	LDA.w #$003F
	JSL.l CODE_01D368
	LDA.w #$FFFF
	STA.l $001A35
	LDA.w #$0040
CODE_01C79B:
	PHA
	JSR.w CODE_01C95E
	PLA
	DEC
	BNE.b CODE_01C79B
	PLA
	STA.l $000446
	SEP.b #$20
	PLA
	STA.l $000104
	PLP
	SEC
	RTS

CODE_01C7B2:
	LDA.w #$003F
	JSL.l CODE_01D368
	LDA.w #$FFFF
	STA.l $001A2D
	LDA.w #$0040
CODE_01C7C3:
	PHA
	JSR.w CODE_01C95E
	PLA
	DEC
	BNE.b CODE_01C7C3
	JSR.w CODE_01C9CE
	LDA.w #$0057
	JSL.l CODE_01E033
	JSR.w CODE_01A274
	JSL.l CODE_01DEB2
	LDA.w #$FFFF
	STA.l $000220
	PLA
	STA.l $000446
	SEP.b #$20
	PLA
	STA.l $000104
	PLP
	CLC
	RTS

DATA_01C7F2:
	dw $2C00,$2C01,$2C01,$2C01,$2C01,$2C01,$2C01,$2C01
	dw $2C01,$2C01,$2C01,$2C01,$2C03,$2C10,$2CE7,$2CE7
	dw $2CE7,$2CE0,$2CE1,$2CE2,$2CE3,$2CE4,$2CE5,$2CE6
	dw $2CE7,$2C13,$2C10,$2CE7,$2CE7,$2CE7,$2CF0,$2CF1
	dw $2CF2,$2CF3,$2CF4,$2CF5,$2CF6,$2CF7,$2C13,$2C10
	dw $2CE7,$2CE7,$2CE7,$2D00,$2D01,$2D02,$2D03,$2D04
	dw $2D05,$2D06,$2D07,$2C13,$2C30,$2C31,$2C31,$2C31
	dw $2C31,$2C31,$2C31,$2C31,$2C31,$2C31,$2C31,$2C31
	dw $2C33,$2C04,$2C05,$2C05,$2C02,$2C01,$2C01,$2C01
	dw $2C01,$2C01,$2C01,$2C01,$2C01,$2C03,$2C14,$2C15
	dw $2C15,$2C12,$304D,$3070,$3071,$3072,$3073,$3074
	dw $3075,$304D,$2C13,$2C14,$2C15,$2C15,$2C12,$304D
	dw $3080,$3081,$3082,$3083,$3084,$3085,$304D,$2C13
	dw $2C14,$2C15,$2C15,$2C12,$304D,$3090,$3091,$3092
	dw $3093,$3094,$3095,$304D,$2C13,$2C24,$2C25,$2C25
	dw $2C22,$2C21,$2C21,$2C21,$2C21,$2C21,$2C21,$2C21
	dw $2C21,$2C23,$2C14,$2C15,$2C15,$2C12,$304D,$3076
	dw $3077,$3078,$3079,$307A,$307B,$304D,$2C13,$2C14
	dw $2C15,$2C15,$2C12,$304D,$3086,$3087,$3088,$3089
	dw $308A,$308B,$304D,$2C13,$2C14,$2C15,$2C15,$2C12
	dw $304D,$3096,$3097,$3098,$3099,$309A,$309B,$304D
	dw $2C13,$2C34,$2C35,$2C35,$2C32,$2C31,$2C31,$2C31
	dw $2C31,$2C31,$2C31,$2C31,$2C31,$2C33

;--------------------------------------------------------------------

CODE_01C95E:
	JSR.w CODE_01C9CE
	LDA.l $0004C6
	AND.w #$00FF
	BIT.w #$0080
	BEQ.b CODE_01C970
	ORA.w #$FF00
CODE_01C970:
	CLC
	ADC.w $000C
	TAX
	SEC
	SBC.w $0008
	BMI.b CODE_01C983
	CMP.w #$0067
	BPL.b CODE_01C983
	STX.w $000C
CODE_01C983:
	LDA.l $0004C8
	AND.w #$00FF
	BIT.w #$0080
	BEQ.b CODE_01C992
	ORA.w #$FF00
CODE_01C992:
	CLC
	ADC.w $000E
	TAX
	SEC
	SBC.w $000A
	BMI.b CODE_01C9A5
	CMP.w #$006F
	BPL.b CODE_01C9A5
	STX.w $000E
CODE_01C9A5:
	LDA.w $000C
	TAX
	LDA.w $000E
	TAY
	LDA.w #$0136
	JSL.l CODE_01F91E
	LDA.w #$0023
	JSL.l CODE_01F84F
	LDA.w #$0024
	JSL.l CODE_01F84F
	LDA.w #$0025
	JSL.l CODE_01F84F
	JSL.l CODE_01E2CE
	RTS

;--------------------------------------------------------------------

CODE_01C9CE:
	LDX.w #$003E
	LDA.w #$F400
CODE_01C9D4:
	STA.l $000226,x
	DEX
	DEX
	BPL.b CODE_01C9D4
	LDA.w #$5555
	STA.l $000426
	STA.l $000428
	LDA.w #$0000
	STA.l $000446
	RTS

;--------------------------------------------------------------------

CODE_01C9EF:
	PHP
	PHB
	SEP.b #$20
	LDA.b #DATA_01CA78>>16
	PHA
	PLB
	LDX.w #$0000
	LDA.l $7F000A
	DEC
CODE_01C9FF:
	CMP.b #$7F
	BCC.b CODE_01CA1E
	SBC.b #$7F
	PHA
	LDA.b #$7F
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	INX
	LDA.b #$01
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	INX
	LDA.b #$00
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	INX
	PLA
	BRA.b CODE_01C9FF

CODE_01CA1E:
	CMP.b #$00
	BEQ.b CODE_01CA35
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	INX
	LDA.b #$01
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	INX
	LDA.b #$00
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	INX
CODE_01CA35:
	LDY.w #$0000
CODE_01CA38:
	LDA.w DATA_01CA78,y
	BEQ.b CODE_01CA71
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	BPL.b CODE_01CA44
	DEC
CODE_01CA44:
	INY
	INX
CODE_01CA46:
	PHA
	LDA.w DATA_01CA78,y
	CLC
	ADC.l $7F0008
	BCC.b CODE_01CA53
	LDA.b #$FF
CODE_01CA53:
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	INY
	INX
	LDA.w DATA_01CA78,y
	CLC
	ADC.l $7F0008
	BCC.b CODE_01CA65
	LDA.b #$FF
CODE_01CA65:
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	INY
	INX
	PLA
	DEC
	BMI.b CODE_01CA46
	BRA.b CODE_01CA38

CODE_01CA71:
	STA.l !RAM_MPAINT_Canvas_AnimationCellGFXBuffer,x
	PLB
	PLP
	RTS

DATA_01CA78:
	dw $0282,$0165,$2466,$6700,$0181,$0266,$6502,$0181
	dw $4466,$6700,$0182,$0266,$7F65,$0001,$0181,$0000

;--------------------------------------------------------------------

CODE_01CA98:
	PHX
	STZ.w $0000
	CMP.b #$80
	BCC.b CODE_01CAA3
	INC.w $0000
CODE_01CAA3:
	BIT.b #$40
	BEQ.b CODE_01CAAA
	EOR.b #$FF
	INC
CODE_01CAAA:
	AND.b #$7F
	BRA.b CODE_01CAC8

CODE_01CAAE:
	PHX
	STZ.w $0000
	CMP.b #$40
	BCC.b CODE_01CABD
	CMP.b #$C0
	BCS.b CODE_01CABD
	INC.w $0000
CODE_01CABD:
	BIT.b #$40
	BNE.b CODE_01CAC4
	EOR.b #$FF
	INC
CODE_01CAC4:
	EOR.b #$40
	AND.b #$7F
CODE_01CAC8:
	TAX
	LDA.l DATA_01CACF,x
	PLX
	RTS

DATA_01CACF:
	db $00,$06,$0C,$12,$19,$1F,$25,$2B
	db $31,$38,$3E,$44,$4A,$50,$56,$5C
	db $61,$67,$6D,$73,$78,$7E,$83,$88
	db $8E,$93,$98,$9D,$A2,$A7,$AB,$B0
	db $B5,$B9,$BD,$C1,$C5,$C9,$CD,$D1
	db $D4,$D8,$DB,$DE,$E1,$E4,$E7,$EA
	db $EC,$EE,$F1,$F3,$F4,$F6,$F8,$F9
	db $FB,$FC,$FD,$FE,$FE,$FF,$FF,$FF
	db $FF

;--------------------------------------------------------------------

CODE_01CB10:
	PHX
	LDA.w $0002
	BEQ.b CODE_01CB70
	LDA.w $0003
	BEQ.b CODE_01CB74
	CMP.w $0002
	BEQ.b CODE_01CB78
	BCS.b CODE_01CB46
	STA.l !REGISTER_DividendHi
	LDA.b #$00
	STA.l !REGISTER_DividendLo
	LDA.w $0002
	STA.l !REGISTER_Divisor
	NOP #8
	LDA.l !REGISTER_QuotientLo
	TAX
	LDA.l DATA_01CB96,x
	BRA.b CODE_01CB7A

CODE_01CB46:
	LDA.w $0002
	STA.l !REGISTER_DividendHi
	LDA.b #$00
	STA.l !REGISTER_DividendLo
	LDA.w $0003
	STA.l !REGISTER_Divisor
	NOP #8
	LDA.l !REGISTER_QuotientLo
	TAX
	LDA.b #$40
	SEC
	SBC.l DATA_01CB96,x
	BRA.b CODE_01CB7A

CODE_01CB70:
	LDA.b #$40
	BRA.b CODE_01CB7A

CODE_01CB74:
	LDA.b #$00
	BRA.b CODE_01CB7A

CODE_01CB78:
	LDA.b #$20
CODE_01CB7A:
	LDX.w $0000
	CPX.b #$01
	BCC.b CODE_01CB8A
	CPX.b #$03
	BCS.b CODE_01CB8A
	EOR.b #$FF
	CLC
	ADC.b #$81
CODE_01CB8A:
	CPX.b #$02
	BCC.b CODE_01CB91
	CLC
	ADC.b #$80
CODE_01CB91:
	STA.w $0004
	PLX
	RTS

DATA_01CB96:
	db $00,$00,$00,$00,$00,$00,$00,$01
	db $01,$01,$01,$01,$01,$02,$02,$02
	db $02,$02,$02,$03,$03,$03,$03,$03
	db $03,$03,$04,$04,$04,$04,$04,$04
	db $05,$05,$05,$05,$05,$05,$06,$06
	db $06,$06,$06,$06,$06,$07,$07,$07
	db $07,$07,$07,$08,$08,$08,$08,$08
	db $08,$08,$09,$09,$09,$09,$09,$09
	db $09,$0A,$0A,$0A,$0A,$0A,$0A,$0B
	db $0B,$0B,$0B,$0B,$0B,$0B,$0C,$0C
	db $0C,$0C,$0C,$0C,$0C,$0D,$0D,$0D
	db $0D,$0D,$0D,$0D,$0E,$0E,$0E,$0E
	db $0E,$0E,$0E,$0F,$0F,$0F,$0F,$0F
	db $0F,$0F,$0F,$10,$10,$10,$10,$10
	db $10,$10,$11,$11,$11,$11,$11,$11
	db $11,$11,$12,$12,$12,$12,$12,$12
	db $12,$13,$13,$13,$13,$13,$13,$13
	db $13,$14,$14,$14,$14,$14,$14,$14
	db $14,$14,$15,$15,$15,$15,$15,$15
	db $15,$15,$16,$16,$16,$16,$16,$16
	db $16,$16,$16,$17,$17,$17,$17,$17
	db $17,$17,$17,$17,$18,$18,$18,$18
	db $18,$18,$18,$18,$18,$19,$19,$19
	db $19,$19,$19,$19,$19,$19,$1A,$1A
	db $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
	db $1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B
	db $1B,$1B,$1B,$1C,$1C,$1C,$1C,$1C
	db $1C,$1C,$1C,$1C,$1C,$1D,$1D,$1D
	db $1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D
	db $1D,$1E,$1E,$1E,$1E,$1E,$1E,$1E
	db $1E,$1E,$1E,$1E,$1F,$1F,$1F,$1F
	db $1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F

;--------------------------------------------------------------------

DATA_01CC96:
	db $60,$60,$FF,$FF,$FF,$70,$FF,$FF
	db $FF,$FF,$80,$FF,$FF,$80,$FF

DATA_01CCA5:
	db $FF,$FF,$FF,$60,$FF,$FF,$FF,$FF
	db $70,$70,$FF,$80,$FF,$80,$80

DATA_01CCB4:
	db $FF,$60,$FF,$FF,$60,$FF,$70,$FF
	db $FF,$70,$FF,$FF,$80,$80,$80

DATA_01CCC3:
	db $FF,$FF,$60,$FF,$FF,$FF,$FF,$70
	db $FF,$FF,$FF,$FF,$80,$FF,$FF

DATA_01CCD2:
	db $00,$00,$00,$18,$00,$00,$00,$00
	db $20,$28,$00,$30,$00,$34,$38

DATA_01CCE1:
	db $00,$20,$00,$00,$28,$00,$30,$00
	db $00,$38,$00,$00,$40,$44,$48

DATA_01CCF0:
	db $00,$00,$60,$00,$00,$00,$00,$68
	db $00,$00,$00,$00,$70,$00,$00

DATA_01CCFF:
	db $02,$01,$00,$00,$00,$04,$00,$00
	db $00,$00,$06,$00,$00,$02,$00

DATA_01CD0E:
	db $00,$00,$00,$02,$00,$00,$00,$00
	db $04,$02,$00,$06,$00,$02,$03

DATA_01CD1D:
	db $00,$01,$00,$00,$02,$00,$04,$00
	db $00,$02,$00,$00,$03,$02,$03

DATA_01CD2C:
	db $00,$00,$02,$00,$00,$00,$00,$04
	db $00,$00,$00,$00,$03,$00,$00

DATA_01CD3B:
	db $14,$0A,$00,$00,$00,$14,$00,$00
	db $00,$00,$14,$00,$00,$06,$00

DATA_01CD4A:
	db $00,$00,$00,$14,$00,$00,$00,$00
	db $14,$0A,$00,$14,$00,$07,$0A

DATA_01CD59:
	db $00,$0A,$00,$00,$14,$00,$14,$00
	db $00,$0A,$00,$00,$0A,$07,$0A

DATA_01CD68:
	db $00,$00,$14,$00,$00,$00,$00,$14
	db $00,$00,$00,$00,$0A,$00,$00

;--------------------------------------------------------------------

DATA_01CD77:
	db $80,$B0,$E0

DATA_01CD7A:
	db $08,$08,$10

DATA_01CD7D:
	db $01,$02,$03

DATA_01CD80:
	db $01,$02,$02

DATA_01CD83:
	db $20,$30,$40

;--------------------------------------------------------------------

CODE_01CD86:
	PHD
	LDA.w #DATA_01CDCD>>16
	PHA
	LDA.w #DATA_01CDCD
	PHA
	TSC
	TCD
	BRA.b CODE_01CD9E

CODE_01CD93:
	PHD
	LDA.w #DATA_01CDD7>>16
	PHA
	LDA.w #DATA_01CDD7
	PHA
	TSC
	TCD
CODE_01CD9E:
	LDA.w #$0000
	STA.l $000202
	LDY.w #$0000
	LDA.l $000204
	TAX
CODE_01CDAD:
	LDA.b [$01],y
	STA.l $000182,x
	INX
	INX
	INY
	INY
	CPY.w #$000A
	BNE.b CODE_01CDAD
	DEX
	TXA
	STA.l $000204
	LDA.w #$0001
	STA.l $000202
	PLA
	PLA
	PLD
	RTS

DATA_01CDCD:
	db $02 : dl DATA_08F200 : dw $0800,$0080,$0056

DATA_01CDD7:
	db $02 : dl DATA_09EC00 : dw $0800,$0080,$0056

;--------------------------------------------------------------------

CODE_01CDE1:
	PHP
	PHD
	PHA
	PHA
	PHA
	TSC
	TCD
	BRA.b CODE_01CDEE

CODE_01CDEA:
	JSL.l CODE_01E2CE
CODE_01CDEE:
	LDA.w $0202
	ORA.w $0204
	AND.w #$00FF
	BNE.b CODE_01CDEA
	LDA.b $03
	CMP.w #DATA_01CEE4
	BCC.b CODE_01CE05
	STA.w $1966
	BRA.b CODE_01CE08

CODE_01CE05:
	STA.w $1964
CODE_01CE08:
	LDA.w #DATA_01CE4B>>16
	STA.b $05
	SEP.b #$30
	LDY.b #$00
CODE_01CE11:
	LDA.w $0204
	TAX
	CLC
	ADC.b #$09
	STA.b $01
CODE_01CE1A:
	LDA.b [$03],y
	STA.w $0182,x
CODE_01CE1F:
	INY
	INX
	CPX.b $01
	BNE.b CODE_01CE1A
	LDA.b [$03],y
	STA.w $0182,x
	BEQ.b CODE_01CE35
	LDA.b $01
	CLC
	ADC.b #$09
	STA.b $01
	BRA.b CODE_01CE1F

CODE_01CE35:
	INC.w $0202
	PHY
	JSL.l CODE_01E2CE
	PLY
	INY
	LDA.b [$03],y
	BPL.b CODE_01CE11
	REP.b #$20
	PLA
	PLA
	PLA
	PLD
	PLP
	RTL

DATA_01CE4B:
	db $02 : dl DATA_088000 : dw $1000,$0080,$0040
	db $02 : dl DATA_089000 : dw $1000,$0080,$0048
	db $02 : dl DATA_08A000 : dw $1000,$0080,$0050
	db $02 : dl DATA_08B000 : dw $1000,$0080,$0058
	db $FF

DATA_01CE74:
	db $02 : dl DATA_098000 : dw $1000,$0080,$0040
	db $02 : dl DATA_099000 : dw $1000,$0080,$0048
	db $02 : dl DATA_09A000 : dw $1000,$0080,$0050
	db $02 : dl DATA_09B000 : dw $1000,$0080,$0058
	db $FF

DATA_01CE9D:
	db $02 : dl DATA_08C000 : dw $1000,$0080,$0050
	db $02 : dl DATA_08D000 : dw $1000,$0080,$0058
	db $FF

DATA_01CEB2:
	db $02 : dl DATA_088000 : dw $0400,$0080 : db $40
	db $02 : dl DATA_08E000 : dw $0A00,$0080,$0042
	db $02 : dl DATA_089000 : dw $1000,$0080,$0048
	db $02 : dl DATA_08A000 : dw $1000,$0080,$0050
	db $02 : dl DATA_08B000 : dw $1000,$0080,$0058
	db $FF

DATA_01CEE4:
	db $02 : dl DATA_04C000 : dw $1000,$0080,$0060
	db $02 : dl DATA_04D000 : dw $1000,$0080,$0068
	db $02 : dl DATA_038000 : dw $0800,$0080,$0074
	db $02 : dl DATA_038000+$0800 : dw $0A00,$0080 : db $78
	db $02 : dl DATA_04FA00 : dw $0600,$0080,$007D
	db $FF

DATA_01CF16:
	db $02 : dl DATA_04C000 : dw $1000,$0080,$0060
	db $02 : dl DATA_04D000 : dw $1000,$0080,$0068
	db $FF

DATA_01CF2B:
	db $02 : dl DATA_049000 : dw $0800,$0080 : db $70
	db $02 : dl DATA_049800 : dw $0800,$0080 : db $40
	db $02 : dl $7E2040 : dw $0080,$2080,$0030
	db $FF

DATA_01CF48:
	db $02 : dl DATA_048000 : dw $0800,$0080 : db $70
	db $02 : dl DATA_048800 : dw $0800,$0080 : db $40
	db $02 : dl $7E2040 : dw $0080,$2080,$0030
	db $FF

DATA_01CF65:
	db $02 : dl DATA_04A000 : dw $1000,$0080,$0060
	db $02 : dl DATA_04B000 : dw $1000,$0080,$0068
	db $02 : dl DATA_0AC000 : dw $0800,$0080 : db $48
	db $02 : dl DATA_08EE00 : dw $0400,$0080,$0056
	db $02 : dl DATA_09F000 : dw $0800,$0080 : db $58
	db $02 : dl DATA_08D000+$07A0 : dw $0060,$4080 : db $5A
	db $02 : dl DATA_08D000+$09A0 : dw $0060,$4080,$005B
	db $FF

DATA_01CFA9:
	db $02 : dl DATA_08B000 : dw $1000,$0080,$0058
	db $FF

DATA_01CFB4:
	db $02 : dl DATA_08E600 : dw $0800,$0080,$0058
	db $FF

DATA_01CFBF:
	db $02 : dl DATA_08FC00 : dw $0400,$0080,$0040
	db $FF

DATA_01CFCA:
	db $02 : dl DATA_03FC00 : dw $0400,$0080,$0070
	db $FF

;--------------------------------------------------------------------

CODE_01CFD5:
	LDA.w #$0000
	JSR.w CODE_01D259
	JSR.w CODE_01D22B
	JSL.l CODE_01E2CE
	JSR.w CODE_01D08D
	INC.w $0222
	INC.w $0224
	LDA.w #$0010
CODE_01CFEE:
	PHA
	EOR.w #$FFFF
	CLC
	ADC.w #$0011
	JSR.w CODE_01D259
CODE_01CFF9:
	PHA
	JSR.w CODE_01D0AD
	JSL.l CODE_01E2CE
	PLA
	DEC
	BPL.b CODE_01CFF9
	LDA.b $01,S
	EOR.w #$FFFF
	CLC
	ADC.w #$0011
	LSR
	LSR
	CLC
	ADC.w #$0004
	JSR.w CODE_01D259
	LDA.b $01,S
CODE_01D019:
	PHA
	JSR.w CODE_01D1A1
	JSL.l CODE_01E2CE
	PLA
	DEC
	BPL.b CODE_01D019
	PLA
	DEC
	BNE.b CODE_01CFEE
	LDA.w #$000F
	JSR.w CODE_01D259
	LDA.w #$0010
CODE_01D032:
	PHA
	EOR.w #$FFFF
	CLC
	ADC.w #$0011
CODE_01D03A:
	PHA
	JSR.w CODE_01D0AD
	JSR.w CODE_01D13B
	JSL.l CODE_01E2CE
	PLA
	DEC
	BPL.b CODE_01D03A
	LDA.b $01,S
CODE_01D04B:
	PHA
	TYA
	JSR.w CODE_01D0AD
	JSR.w CODE_01D1E6
	JSL.l CODE_01E2CE
	PLA
	DEC
	BPL.b CODE_01D04B
	PLA
	DEC
	BNE.b CODE_01D032
	STZ.w $0206
	LDA.w #$00B8
CODE_01D065:
	PHA
	JSR.w CODE_01D0AD
	JSR.w CODE_01D13B
	LDA.b $01,S
	TAX
	JSL.l CODE_008A8A
	PLA
	DEC
	CMP.w #$0008
	BNE.b CODE_01D065
	INC.w $0206
	LDA.w #$FFFF
	STA.w $0222
	STA.w $0224
	JSR.w CODE_01D242
	JSR.w CODE_01D279
	RTL

CODE_01D08D:
	PHB
	PEA.w $7F7F
	PLB
	PLB
	LDX.w #$01FE
CODE_01D096:					; Optimization: Pointless loop
	STZ.w $7F9200
	STZ.w $7F9400
	STZ.w $7F9600
	STZ.w $7F9800
	DEX
	BPL.b CODE_01D096
	PLB
	STZ.w $0222
	STZ.w $0224
	RTS

CODE_01D0AD:
	PHB
	PEA.w $7F7F
	PLB
	PLB
	LDX.w #$0000
	LDA.l $000222
	LSR
	BCC.b CODE_01D0C0
	LDX.w #$0200
CODE_01D0C0:
	SEP.b #$20
	LDA.b #$FF
	STA.w $7F9200,x
	INX
	REP.b #$20
CODE_01D0CA:
	JSL.l CODE_01E20C
	AND.w #$000F
	TAY
CODE_01D0D2:
	STZ.w $7F9200,x
	INX
	INX
	TXA
	AND.w #$01FF
	CMP.w #$01C2
	BEQ.b CODE_01D127
	CMP.w #$00FF
	BNE.b CODE_01D0EF
	SEP.b #$20
	LDA.b #$E1
	STA.w $7F9200,x
	INX
	REP.b #$20
CODE_01D0EF:
	DEY
	BPL.b CODE_01D0D2
	JSL.l CODE_01E20C
	AND.w #$0003
	TAY
CODE_01D0FA:
	JSL.l CODE_01E20C
	AND.w #$000F
	SEC
	SBC.w #$0008
	STA.w $7F9200,x
	INX
	INX
	TXA
	AND.w #$01FF
	CMP.w #$01C2
	BEQ.b CODE_01D127
	CMP.w #$00FF
	BNE.b CODE_01D122
	SEP.b #$20
	LDA.b #$E1
	STA.w $7F9200,x
	INX
	REP.b #$20
CODE_01D122:
	DEY
	BPL.b CODE_01D0FA
	BRA.b CODE_01D0CA

CODE_01D127:
	SEP.b #$20
	STZ.w $7F9200,x
	REP.b #$20
	LDA.l $000222
	EOR.w #$0003
	STA.l $000222
	PLB
	RTS

CODE_01D13B:
	PHB
	PEA.w $7F7F
	PLB
	PLB
	LDX.w #$0000
	LDA.l $000224
	LSR
	BCC.b CODE_01D14E
	LDX.w #$0200
CODE_01D14E:
	SEP.b #$20
	LDA.b #$FF
	STA.w $7F9600,x
	INX
	REP.b #$20
	LDA.w #$0000
	PHA
	JSL.l CODE_01E20C
	AND.w #$000F
	INC
	PHA
CODE_01D165:
	LDA.b $03,S
	STA.w $7F9600,x
	CLC
	ADC.b $01,S
	STA.b $03,S
	INX
	INX
	TXA
	AND.w #$01FF
	CMP.w #$01C2
	BEQ.b CODE_01D18B
	CMP.w #$00FF
	BNE.b CODE_01D189
	SEP.b #$20
	LDA.b #$E1
	STA.w $7F9600,x
	INX
	REP.b #$20
CODE_01D189:
	BRA.b CODE_01D165

CODE_01D18B:
	PLA
	PLA
	SEP.b #$20
	STZ.w $7F9600,x
	REP.b #$20
	LDA.l $000224
	EOR.w #$0003
	STA.l $000224
	PLB
	RTS

CODE_01D1A1:
	PHB
	PEA.w $7F7F
	PLB
	PLB
	LDX.w #$0000
	LDA.l $000222
	LSR
	BCC.b CODE_01D1B4
	LDX.w #$0200
CODE_01D1B4:
	SEP.b #$20
	LDA.b #$7F
	STA.w $7F9200,x
	INX
	REP.b #$20
	STZ.w $7F9200,x
	INX
	INX
	SEP.b #$20
	LDA.b #$61
	STA.w $7F9200,x
	INX
	REP.b #$20
	STZ.w $7F9200,x
	INX
	INX
	SEP.b #$20
	STZ.w $7F9200,x
	REP.b #$20
	LDA.l $000222
	EOR.w #$0003
	STA.l $000222
	PLB
	RTS

CODE_01D1E6:
	PHB
	PEA.w $7F7F
	PLB
	PLB
	LDX.w #$0000
	LDA.l $000224
	LSR
	BCC.b CODE_01D1F9
	LDX.w #$0200
CODE_01D1F9:
	SEP.b #$20
	LDA.b #$7F
	STA.w $7F9600,x
	INX
	REP.b #$20
	STZ.w $7F9600,x
	INX
	INX
	SEP.b #$20
	LDA.b #$61
	STA.w $7F9600,x
	INX
	REP.b #$20
	STZ.w $7F9600,x
	INX
	INX
	SEP.b #$20
	STZ.w $7F9600,x
	REP.b #$20
	LDA.l $000224
	EOR.w #$0003
	STA.l $000224
	PLB
	RTS

CODE_01D22B:
	LDX.w #$057E
CODE_01D22E:
	LDA.l $7E28C0,x
	ORA.w #$1C00
	STA.l $7E28C0,x
	DEX
	DEX
	BPL.b CODE_01D22E
	JSL.l CODE_01DEB2
	RTS

CODE_01D242:
	LDX.w #$057E
CODE_01D245:
	LDA.l $7E28C0,x
	AND.w #$E3FF
	STA.l $7E28C0,x
	DEX
	DEX
	BPL.b CODE_01D245
	JSL.l CODE_01DEB2
	RTS

CODE_01D259:
	PHA
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w #$001E
	TAX
	LDY.w #$001E
CODE_01D267:
	LDA.l DATA_02FA00,x
	STA.w $09AF,y
	DEX
	DEX
	DEY
	DEY
	BPL.b CODE_01D267
	JSR.w CODE_01D287
	PLA
	RTS

CODE_01D279:
	LDX.w #$001E
CODE_01D27C:
	LDA.l DATA_02FE00+$E0,x
	STA.w $09AF,x
	DEX
	DEX
	BPL.b CODE_01D27C
CODE_01D287:
	PHP
	PHB
	SEP.b #$30
	LDA.b #DATA_01D2B7>>16
	PHA
	PLB
	LDA.b #$00
	STA.l $000202
	LDA.l $000204
	CLC
	ADC.b #$07
	STA.l $000204
	TAX
	LDY.b #$07
CODE_01D2A3:
	LDA.w DATA_01D2B7,y
	STA.l $000182,x
	DEX
	DEY
	BPL.b CODE_01D2A3
	LDA.b #$01
	STA.l $000202
	PLB
	PLP
	RTS

DATA_01D2B7:
	db $01 : dl $0009AF : dw $0020,$0070

;--------------------------------------------------------------------

CODE_01D2BF:
	PHX
	PHP
	SEP.b #$30
	PHA
	LDA.l $00053A
	BNE.b CODE_01D2FB
	LDA.l $000530
	CMP.l $00052C
	BNE.b CODE_01D2FB
	LDA.b #$02
	JSL.l CODE_01D348
	LDA.b #$20
	STA.l $00053A
	LDA.l $000530
	TAX
	PLA
	STA.l $0004EC,x
	INX
	TXA
	AND.b #$0F
	CMP.l $00052C
	BEQ.b CODE_01D2F8
	STA.l $000530
CODE_01D2F8:
	PLP
	PLX
	RTL

CODE_01D2FB:
	LDA.l $00052C
	TAX
	PLA
	STA.l $0004EC,x
	PLP
	PLX
	RTL

;--------------------------------------------------------------------

CODE_01D308:
	PHX
	PHP
	SEP.b #$30
	PHA
	LDA.l $000530
	TAX
	PLA
	STA.l $0004EC,x
	INX
	TXA
	AND.b #$0F
	CMP.l $00052C
	BEQ.b CODE_01D325
	STA.l $000530
CODE_01D325:
	PLP
	PLX
	RTL

;--------------------------------------------------------------------

CODE_01D328:
	PHX
	PHP
	SEP.b #$30
	PHA
	LDA.l $000531
	TAX
	PLA
	STA.l $0004FC,x
	INX
	TXA
	AND.b #$0F
	CMP.l $00052D
	BEQ.b CODE_01D345
	STA.l $000531
CODE_01D345:
	PLP
	PLX
	RTL

;--------------------------------------------------------------------

CODE_01D348:
	PHX
	PHP
	SEP.b #$30
	PHA
	LDA.l $000532
	TAX
	PLA
	STA.l $00050C,x
	INX
	TXA
	AND.b #$0F
	CMP.l $00052E
	BEQ.b CODE_01D365
	STA.l $000532
CODE_01D365:
	PLP
	PLX
	RTL

;--------------------------------------------------------------------

CODE_01D368:
	PHX
	PHP
	SEP.b #$30
	PHA
	LDA.l $000533
	TAX
	PLA
	STA.l $00051C,x
	INX
	TXA
	AND.b #$0F
	CMP.l $00052F
	BEQ.b CODE_01D385
	STA.l $000533
CODE_01D385:
	PLP
	PLX
	RTL

;--------------------------------------------------------------------

CODE_01D388:
	LDA.b #$00
	JSL.l CODE_01D2BF
CODE_01D38E:
	LDA.w $053A
	BNE.b CODE_01D38E
	LDA.b #$12
CODE_01D395:
	PHA
	JSL.l CODE_01E2CE
	PLA
	DEC
	BNE.b CODE_01D395
	RTL

;--------------------------------------------------------------------

CODE_01D39F:
	LDA.b #$40
CODE_01D3A1:
	PHA
	JSL.l CODE_01E2CE
	PLA
	DEC
	BNE.b CODE_01D3A1
	RTL

;--------------------------------------------------------------------

CODE_01D3AB:
	LDA.w $1012
	BEQ.b CODE_01D3B4
	INC
	INC
	BRA.b CODE_01D3B7

CODE_01D3B4:
	LDA.w #$001D
CODE_01D3B7:
	JMP.w CODE_01D2BF

;--------------------------------------------------------------------

CODE_01D3BA:
	LDA.w $04CA
	BIT.w #$0044
	BEQ.b CODE_01D408
	BIT.w #$0040
	BEQ.b CODE_01D3CC
	INC.w $0997
	BRA.b CODE_01D3CF

CODE_01D3CC:
	DEC.w $0997
CODE_01D3CF:
	LDA.w #$0006
	JSL.l CODE_01D368
	LDA.w #$0003
	LDY.w $099F
	BEQ.b CODE_01D3E1
	LDA.w #$0007
CODE_01D3E1:
	AND.w $0997
	STA.w $0997
	LDA.w #$0001
	STA.w $058B
	JSR.w CODE_01D409
	STZ.w $058B
	LDA.w $04D0
	CMP.w #$0006
	BEQ.b CODE_01D408
	CMP.w #$0007
	BEQ.b CODE_01D408
	JSL.l CODE_00A44D
	JML.l CODE_00E64B

CODE_01D408:
	RTL

CODE_01D409:
	LDA.w $0997
	ASL
	TAX
	JMP.w (DATA_01D411,x)

DATA_01D411:
	dw CODE_01D4BB
	dw CODE_01D4CC
	dw CODE_01D4E3
	dw CODE_01D4FA
	dw CODE_01D511
	dw CODE_01D528
	dw CODE_01D53F
	dw CODE_01D556

;--------------------------------------------------------------------

CODE_01D421:
	LDA.b $AA
	ASL
	TAX
	LDA.l DATA_01DB31,x
	TAX
	PHB
	PEA.w $7F7F
	PLB
	PLB
	LDY.w #$0000
	LDA.w #$0000
CODE_01D436:
	PHA
	PHX
	LDA.l DATA_01DB53,x
	BMI.b CODE_01D48B
	CMP.w #$5400
	BEQ.b CODE_01D448
	CMP.w #$5A00
	BNE.b CODE_01D459
CODE_01D448:
	PHA
	LDA.l $0000AA
	TAX
	PLA
	CPX.w #$000F
	BEQ.b CODE_01D459
	CLC
	ADC.l $000999
CODE_01D459:
	TAX
CODE_01D45A:
	LDA.l DATA_038000,x
	STA.w $7F8000,y
	LDA.l DATA_038000+$0200,x
	STA.w $7F8000+$0200,y
	LDA.l DATA_038000+$0400,x
	STA.w $7F8000+$0400,y
	INX
	INX
	INY
	INY
	TYA
	BIT.w #$003F
	BNE.b CODE_01D45A
	PLX
	INX
	INX
	PLA
	INC
	BIT.w #$0007
	BNE.b CODE_01D436
	TYA
	CLC
	ADC.w #$0400
	TAY
	BRA.b CODE_01D436

CODE_01D48B:
	PLX
	PLA
	PLB
	LDA.w $0204
	BEQ.b CODE_01D497
	JSL.l CODE_01E2CE
CODE_01D497:
	LDX.w #$0008
CODE_01D49A:
	LDA.l DATA_01D4AD,x
	STA.w $0182,x
	DEX
	DEX
	BPL.b CODE_01D49A
	INC.w $0202
	JSL.l CODE_01E2CE
	RTS

DATA_01D4AD:
	db $02 : dl $7F8000 : dw $1200,$0080,$0074

;--------------------------------------------------------------------

CODE_01D4B7:
	INC.w $0995
	RTL

;--------------------------------------------------------------------

CODE_01D4BB:
	STZ.w $0997
	STZ.w $0999
	JSL.l CODE_01D56D
	JSL.l CODE_01D597
	JMP.w CODE_01D421

;--------------------------------------------------------------------

CODE_01D4CC:
	LDA.w #$0001
	STA.w $0997
	LDA.w #$0040
	STA.w $0999
	JSL.l CODE_01D56D
	JSL.l CODE_01D597
	JMP.w CODE_01D421

;--------------------------------------------------------------------

CODE_01D4E3:
	LDA.w #$0002
	STA.w $0997
	LDA.w #$0080
	STA.w $0999
	JSL.l CODE_01D56D
	JSL.l CODE_01D597
	JMP.w CODE_01D421

CODE_01D4FA:
	LDA.w #$0003
	STA.w $0997
	LDA.w #$00C0
	STA.w $0999
	JSL.l CODE_01D56D
	JSL.l CODE_01D597
	JMP.w CODE_01D421

;--------------------------------------------------------------------

CODE_01D511:
	LDA.w #$0004
	STA.w $0997
	LDA.w #$0100
	STA.w $0999
	JSL.l CODE_01D56D
	JSL.l CODE_01D597
	JMP.w CODE_01D421

;--------------------------------------------------------------------

CODE_01D528:
	LDA.w #$0005
	STA.w $0997
	LDA.w #$0140
	STA.w $0999
	JSL.l CODE_01D56D
	JSL.l CODE_01D597
	JMP.w CODE_01D421

;--------------------------------------------------------------------

CODE_01D53F:
	LDA.w #$0006
	STA.w $0997
	LDA.w #$0180
	STA.w $0999
	JSL.l CODE_01D56D
	JSL.l CODE_01D597
	JMP.w CODE_01D421

;--------------------------------------------------------------------

CODE_01D556:
	LDA.w #$0007
	STA.w $0997
	LDA.w #$01C0
	STA.w $0999
	JSL.l CODE_01D56D
	JSL.l CODE_01D597
	JMP.w CODE_01D421

;--------------------------------------------------------------------

CODE_01D56D:
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
	BEQ.b CODE_01D577
	LDA.w #$0000
	BRA.b CODE_01D57A

CODE_01D577:
	LDA.w $0997
CODE_01D57A:
	ASL
	TAX
	LDA.w #$1BAA
	PHA
	LDA.w #$1CAA
	PHA
	JMP.w (DATA_01D587,x)

DATA_01D587:
	dw CODE_01D5C1
	dw CODE_01D5CF
	dw CODE_01D625
	dw CODE_01D68B
	dw CODE_01D6A1
	dw CODE_01D6E8
	dw CODE_01D72F
	dw CODE_01D745

;--------------------------------------------------------------------

CODE_01D597:
	LDA.w !RAM_MPAINT_Canvas_EraseToolSelected
	BEQ.b CODE_01D5A1
	LDA.w #$0000
	BRA.b CODE_01D5A4

CODE_01D5A1:
	LDA.w $0997
CODE_01D5A4:
	ASL
	TAX
	LDA.w #$1B2A
	PHA
	LDA.w #$1C2A
	PHA
	JMP.w (DATA_01D5B1,x)

DATA_01D5B1:
	dw CODE_01D5C1
	dw CODE_01D5CF
	dw CODE_01D625
	dw CODE_01D68B
	dw CODE_01D6A1
	dw CODE_01D6E8
	dw CODE_01D72F
	dw CODE_01D745

;--------------------------------------------------------------------

CODE_01D5C1:
	LDY.w #$007E
CODE_01D5C4:
	LDA.b ($03,S),y
	STA.b ($01,S),y
	DEY
	DEY
	BPL.b CODE_01D5C4
	PLA
	PLA
	RTL

;--------------------------------------------------------------------

CODE_01D5CF:
	LDA.b $03,S
	CLC
	ADC.w #$0020
	PHA
	CLC
	ADC.w #$0020
	PHA
	CLC
	ADC.w #$0020
	PHA
	LDA.b $07,S
	CLC
	ADC.w #$0020
	PHA
	CLC
	ADC.w #$0020
	PHA
	CLC
	ADC.w #$0020
	PHA
	SEP.b #$30
	LDY.b #$1F
CODE_01D5F5:
	LDA.b ($0F,S),y
	TAX
	LDA.l DATA_02F000,x
	STA.b ($05,S),y
	LDA.b ($0B,S),y
	TAX
	LDA.l DATA_02F000,x
	STA.b ($0D,S),y
	LDA.b ($09,S),y
	TAX
	LDA.l DATA_02F000,x
	STA.b ($01,S),y
	LDA.b ($07,S),y
	TAX
	LDA.l DATA_02F000,x
	STA.b ($03,S),y
	DEY
	BPL.b CODE_01D5F5
	REP.b #$30
	TSC
	CLC
	ADC.w #$0010
	TCS
	RTL

;--------------------------------------------------------------------

CODE_01D625:
	LDA.b $03,S
	CLC
	ADC.w #$0020
	PHA
	CLC
	ADC.w #$0020
	PHA
	CLC
	ADC.w #$0020
	PHA
	LDA.b $07,S
	CLC
	ADC.w #$0020
	PHA
	CLC
	ADC.w #$0020
	PHA
	CLC
	ADC.w #$0020
	PHA
	PHD
	TSC
	TCD
	LDY.w #$000E
CODE_01D64D:
	LDA.b ($11),y
	STA.b ($05)
	LDA.b ($0D),y
	STA.b ($03)
	LDA.b ($0B),y
	STA.b ($0F)
	LDA.b ($09),y
	STA.b ($07)
	INC.b $0F
	INC.b $0F
	INC.b $07
	INC.b $07
	INC.b $05
	INC.b $05
	INC.b $03
	INC.b $03
	DEY
	DEY
	CPY.w #$0010
	BPL.b CODE_01D64D
	CPY.w #$000E
	BEQ.b CODE_01D683
	CPY.w #$0000
	BPL.b CODE_01D64D
	LDY.w #$001E
	BRA.b CODE_01D64D

CODE_01D683:
	PLD
	TSC
	CLC
	ADC.w #$0010
	TCS
	RTL

;--------------------------------------------------------------------

CODE_01D68B:
	PHK
	PEA.w CODE_01D699-$01
	LDA.b $06,S
	PHA
	LDA.w #$1D2A
	PHA
	JMP.w CODE_01D5CF

CODE_01D699:
	LDA.w #$1D2A
	STA.b $03,S
	JMP.w CODE_01D625

CODE_01D6A1:
	PHA
	LDY.w #$007E
CODE_01D6A5:
	TYA
	AND.w #$000F
	CMP.w #$000E
	BNE.b CODE_01D6C0
	TYA
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.l DATA_01D6E0,x
	AND.w #$00FF
	CLC
	ADC.b $03,S
	STA.b $01,S
CODE_01D6C0:
	LDA.b ($05,S),y
	XBA
	PHY
	LDY.w #$000F
	SEP.b #$20
CODE_01D6C9:
	ASL
	PHA
	LDA.b ($04,S),y
	ROR
	STA.b ($04,S),y
	PLA
	XBA
	DEY
	BPL.b CODE_01D6C9
	REP.b #$20
	PLY
	DEY
	DEY
	BPL.b CODE_01D6A5
	PLA
	PLA
	PLA
	RTL

DATA_01D6E0:
	db $40,$50,$00,$10,$60,$70,$20,$30

;--------------------------------------------------------------------

CODE_01D6E8:
	PHA
	LDY.w #$007E
CODE_01D6EC:
	TYA
	AND.w #$000F
	CMP.w #$000E
	BNE.b CODE_01D707
	TYA
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.l DATA_01D727,x
	AND.w #$00FF
	CLC
	ADC.b $03,S
	STA.b $01,S
CODE_01D707:
	LDA.b ($05,S),y
	XBA
	PHY
	LDY.w #$000F
	SEP.b #$20
CODE_01D710:
	LSR
	PHA
	LDA.b ($04,S),y
	ROL
	STA.b ($04,S),y
	PLA
	XBA
	DEY
	BPL.b CODE_01D710
	REP.b #$20
	PLY
	DEY
	DEY
	BPL.b CODE_01D6EC
	PLA
	PLA
	PLA
	RTL

DATA_01D727:
	db $20,$30,$60,$70,$00,$10,$40,$50

;--------------------------------------------------------------------

CODE_01D72F:
	PHK
	PEA.w CODE_01D73D-$01
	LDA.b $06,S
	PHA
	LDA.w #$1D2A
	PHA
	JMP.w CODE_01D6A1

CODE_01D73D:
	LDA.w #$1D2A
	STA.b $03,S
	JMP.w CODE_01D625

CODE_01D745:
	PHK
	PEA.w CODE_01D753-$01
	LDA.b $06,S
	PHA
	LDA.w #$1D2A
	PHA
	JMP.w CODE_01D6E8

CODE_01D753:
	LDA.w #$1D2A
	STA.b $03,S
	JMP.w CODE_01D625

CODE_01D75B:
	LDA.b $26
	SEC
	SBC.b $22
	STA.l $7F0000
	LDA.b $28
	SEC
	SBC.b $24
	STA.l $7F0002
	LDA.b $22
	AND.w #$0007
	STA.l $7F0004
	LDA.b $26
	AND.w #$0007
	STA.l $7F0006
	LDA.b $22
	AND.w #$FFF8
	PHA
	LDA.b $26
	AND.w #$FFF8
	SEC
	SBC.b $01,S
	LSR
	LSR
	INC
	STA.b $C2
	PLA
	LDA.b $22
	STA.b $80
	LDA.b $24
	STA.b $82
	JSR.w CODE_01D9A9
	LDX.w #$0000
	LDA.l $7F0002
	TAY
CODE_01D7A6:
	JSR.w CODE_01D7F0
	INC.b $84
	INC.b $84
	LDA.b $84
	BIT.w #$000F
	BNE.b CODE_01D7BA
	CLC
	ADC.w #$03F0
	STA.b $84
CODE_01D7BA:
	TXA
	CLC
	ADC.w #$0080
	TAX
	DEY
	BPL.b CODE_01D7A6
	LDA.w $0997
	CMP.w #$0004
	BCC.b CODE_01D7EF
	LDA.l $7F0000
	PHA
	LDA.l $7F0002
	STA.l $7F0000
	PLA
	STA.l $7F0002
	LDA.b $22
	CLC
	ADC.l $7F0000
	STA.b $26
	LDA.b $24
	CLC
	ADC.l $7F0002
	STA.b $28
CODE_01D7EF:
	RTL

CODE_01D7F0:
	PHX
	PHY
	LDA.b $C2
	STA.b $C0
	LDY.b $84
CODE_01D7F8:
	LDA.b [$0A],y
	STA.l $7F0008,x
	TYA
	CLC
	ADC.w #$0010
	TAY
	INX
	INX
	LDA.b $C0
	DEC
	STA.b $C0
	BPL.b CODE_01D7F8
	PLY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_01D810:
	LDA.b $0A
	CLC
	ADC.w #$0010
	STA.b $0D
	LDA.b $22
	CMP.w $19B6
	BPL.b CODE_01D822
	LDA.w $19B6
CODE_01D822:
	STA.b $80
	LDA.b $24
	CMP.w $19BA
	BPL.b CODE_01D82F
	LDA.w $19BA
	INC
CODE_01D82F:
	STA.b $82
	JSR.w CODE_01D9A9
	LDA.w $19BA
	SEC
	SBC.b $24
	BPL.b CODE_01D840
	STZ.b $C4
	BRA.b CODE_01D843

CODE_01D840:
	INC
	STA.b $C4
CODE_01D843:
	JSR.w CODE_01D874
	INC.b $84
	INC.b $84
	LDA.b $84
	BIT.w #$000F
	BNE.b CODE_01D857
	CLC
	ADC.w #$03F0
	STA.b $84
CODE_01D857:
	CMP.w #$6000
	BCS.b CODE_01D873
	LDA.b $C4
	CLC
	ADC.b $24
	DEC
	CMP.w $19BC
	BCS.b CODE_01D873
	INC.b $C4
	LDA.b $C4
	CMP.l $7F0002
	BCC.b CODE_01D843
	BEQ.b CODE_01D843
CODE_01D873:
	RTL

CODE_01D874:
	LDA.w $19B6
	SEC
	SBC.b $22
	BPL.b CODE_01D880
	STZ.b $C0
	BRA.b CODE_01D882

CODE_01D880:
	STA.b $C0
CODE_01D882:
	LDY.b $84
CODE_01D884:
	LDA.b $22
	CLC
	ADC.b $C0
	DEC
	CMP.w $19B8
	BCS.b CODE_01D8CD
	INC
	AND.w #$0007
	ASL
	TAX
	JSR.w CODE_01D8CE
	LDA.b $C6
	ORA.b $C8
	BEQ.b CODE_01D8B6
	LDA.b $C6
	EOR.b [$0A],y
	AND.l DATA_01D9D1,x
	EOR.b [$0A],y
	STA.b [$0A],y
	LDA.b $C8
	EOR.b [$0D],y
	AND.l DATA_01D9D1,x
	EOR.b [$0D],y
	STA.b [$0D],y
CODE_01D8B6:
	CPX.w #$000E
	BNE.b CODE_01D8C1
	TYA
	CLC
	ADC.w #$0020
	TAY
CODE_01D8C1:
	INC.b $C0
	LDA.b $C0
	CMP.l $7F0000
	BCC.b CODE_01D884
	BEQ.b CODE_01D884
CODE_01D8CD:
	RTS

CODE_01D8CE:
	PHX
	PHY
	LDA.w $0997
	JSL.l CODE_01E393

DATA_01D8D7:
	dw CODE_01D941
	dw CODE_01D948
	dw CODE_01D955
	dw CODE_01D962
	dw CODE_01D975
	dw CODE_01D982
	dw CODE_01D98F
	dw CODE_01D996

CODE_01D8E7:
	TXA
	CLC
	ADC.l $7F0004
	PHA
	AND.w #$FFF8
	LSR
	PHA
	TYA
	AND.w #$00FF
	XBA
	LSR
	CLC
	ADC.b $01,S
	TAX
	PLA
	PLA
	AND.w #$0007
	ASL
	TAY
	LDA.l $7F0008,x
	PHX
	TYX
	AND.l DATA_01D9D1,x
	BIT.w #$00FF
	BEQ.b CODE_01D916
	ORA.w #$00FF
CODE_01D916:
	BIT.w #$FF00
	BEQ.b CODE_01D91E
	ORA.w #$FF00
CODE_01D91E:
	STA.b $C6
	PLX
	LDA.l $7F000A,x
	TYX
	AND.l DATA_01D9D1,x
	BIT.w #$00FF
	BEQ.b CODE_01D932
	ORA.w #$00FF
CODE_01D932:
	BIT.w #$FF00
	BEQ.b CODE_01D93A
	ORA.w #$FF00
CODE_01D93A:
	STA.l $0000C8
	PLY
	PLX
	RTS

CODE_01D941:
	LDX.b $C0
	LDY.b $C4
	JMP.w CODE_01D8E7

CODE_01D948:
	LDA.l $7F0000
	SEC
	SBC.b $C0
	TAX
	LDY.b $C4
	JMP.w CODE_01D8E7

CODE_01D955:
	LDX.b $C0
	LDA.l $7F0002
	SEC
	SBC.b $C4
	TAY
	JMP.w CODE_01D8E7

CODE_01D962:
	LDA.l $7F0000
	SEC
	SBC.b $C0
	TAX
	LDA.l $7F0002
	SEC
	SBC.b $C4
	TAY
	JMP.w CODE_01D8E7

CODE_01D975:
	LDA.l $7F0002
	SEC
	SBC.b $C4
	TAX
	LDY.b $C0
	JMP.w CODE_01D8E7

CODE_01D982:
	LDX.b $C4
	LDA.l $7F0000
	SEC
	SBC.b $C0
	TAY
	JMP.w CODE_01D8E7

CODE_01D98F:
	LDX.b $C4
	LDY.b $C0
	JMP.w CODE_01D8E7

CODE_01D996:
	LDA.l $7F0002
	SEC
	SBC.b $C4
	TAX
	LDA.l $7F0000
	SEC
	SBC.b $C0
	TAY
	JMP.w CODE_01D8E7

CODE_01D9A9:
	PHP
	REP.b #$20
	LDA.b $80
	AND.w #$00F8
	ASL
	ASL
	STA.b $84
	LDA.b $82
	AND.w #$00F8
	XBA
	LSR
	CLC
	ADC.b $84
	STA.b $84
	LDA.b $82
	AND.w #$0007
	ASL
	ADC.b $84
	SEC
	SBC.w #$0800
	STA.b $84
	PLP
	RTS

DATA_01D9D1:
	dw $8080,$4040,$2020,$1010,$0808,$0404,$0202,$0101

;--------------------------------------------------------------------

CODE_01D9E1:
	PHB
	PHK
	PLB
	LDA.w $04BF
	BNE.b CODE_01DA0B
	INC.w $04BF
	LDA.w $04C1
	BNE.b CODE_01DA05
	STZ.w $04CA
	STZ.w !RAM_MPAINT_Global_MouseXDisplacementLo
	STZ.w !RAM_MPAINT_Global_MouseYDisplacementLo
	STZ.w $04CB
	STZ.w !RAM_MPAINT_Global_MouseXDisplacementHi
	STZ.w !RAM_MPAINT_Global_MouseYDisplacementHi
	BRA.b CODE_01DA08

CODE_01DA05:
	JSR.w CODE_01DA0D
CODE_01DA08:
	STZ.w $04BF
CODE_01DA0B:
	PLB
	RTL

CODE_01DA0D:
	LDA.w !REGISTER_HVBlankFlagsAndJoypadStatus
	AND.b #$01
	BNE.b CODE_01DA0D
	STZ.w $04C2
	STZ.w !RAM_MPAINT_Global_MouseXDisplacementLo
	STZ.w !RAM_MPAINT_Global_MouseXDisplacementHi
	STZ.w !RAM_MPAINT_Global_MouseYDisplacementLo
	STZ.w !RAM_MPAINT_Global_MouseYDisplacementHi
	STZ.w $04CA
	STZ.w $04CB
	LDX.b #$01
CODE_01DA2B:
	TXA
	ASL
	TAY
	LDA.w !REGISTER_Joypad1Lo,y
	STA.b $DE
	AND.b #$0F
	CMP.b #!Mouse_Signature>>8
	BEQ.b CODE_01DA41
	STZ.w $04CC,x
	STZ.w $04CE,x
	BRA.b CODE_01DA62

CODE_01DA41:
	LDA.w $04C2
	ORA.w DATA_01DA66,x
	STA.w $04C2
	LDY.b #$10
CODE_01DA4C:
	LDA.w !REGISTER_JoypadSerialPort1,x
	LSR
	ROL.w !RAM_MPAINT_Global_MouseXDisplacementLo,x
	ROL.w !RAM_MPAINT_Global_MouseYDisplacementLo,x
	DEY
	BNE.b CODE_01DA4C
	JSR.w CODE_01DA68
	JSR.w CODE_01DA88
	JSR.w CODE_01DAF9
CODE_01DA62:
	DEX
	BPL.b CODE_01DA2B
	RTS

DATA_01DA66:
	db $01,$02

CODE_01DA68:
	JSR.w CODE_01DA73
	PHX
	INX
	INX
	JSR.w CODE_01DA73
	PLX
	RTS

CODE_01DA73:
	LDA.w !RAM_MPAINT_Global_MouseXDisplacementLo,x
	BPL.b CODE_01DA82
	AND.b #$7F
	EOR.b #$FF
	INC
	STA.w !RAM_MPAINT_Global_MouseXDisplacementLo,x
	BRA.b CODE_01DA84

CODE_01DA82:
	AND.b #$7F
CODE_01DA84:
	STA.w !RAM_MPAINT_Global_MouseXDisplacementLo,x
	RTS

CODE_01DA88:
	TXA
	ASL
	TAY
	LDA.w $0142,y
	ASL
	ASL
	ROL.w $04CA,x
	LDA.w !RAM_MPAINT_Global_PressedButtonsLoP1,y
	ASL
	ASL
	ROL.w $04CA,x
	LDA.w !RAM_MPAINT_Global_HeldButtonsLoP1,y
	ASL
	ASL
	ROL.w $04CA,x
	ASL.w $04CA,x
	LDA.w $0142,y
	ASL
	ROL.w $04CA,x
	LDA.w !RAM_MPAINT_Global_PressedButtonsLoP1,y
	ASL
	ROL.w $04CA,x
	LDA.w !RAM_MPAINT_Global_HeldButtonsLoP1,y
	ASL
	ROL.w $04CA,x
	JSR.w CODE_01DABF
	RTS

CODE_01DABF:
	LDA.w $04CE,x
	BNE.b CODE_01DAD5
	LDA.w $04CA,x
	AND.b #$22
	BEQ.b CODE_01DAF8
	STA.w $04CC,x
	LDA.b #$20
	STA.w $04CE,x
	BRA.b CODE_01DAF8

CODE_01DAD5:
	LDA.w !RAM_MPAINT_Global_MouseXDisplacementLo,x
	ORA.w !RAM_MPAINT_Global_MouseYDisplacementLo,x
	BNE.b CODE_01DAF2
	DEC.w $04CE,x
	LDA.w $04CA,x
	AND.b #$22
	AND.w $04CC,x
	BEQ.b CODE_01DAF8
	ASL
	ASL
	ORA.w $04CA,x
	STA.w $04CA,x
CODE_01DAF2:
	STZ.w $04CE,x
	STZ.w $04CC,x
CODE_01DAF8:
	RTS

CODE_01DAF9:
	TXA
	ASL
	TAY
	LDA.w !REGISTER_Joypad1Lo,y
	LSR
	LSR
	LSR
	LSR
	AND.b #$03
	CMP.w $04C4,x
	BEQ.b CODE_01DB1F
	LDA.w $04C3
	BPL.b CODE_01DB14
	LDA.b #$20
	STA.w $04C3
CODE_01DB14:
	DEC.w $04C3
	BEQ.b CODE_01DB1F
	JSL.l CODE_01DB25
	BRA.b CODE_01DAF9

CODE_01DB1F:
	LDA.b #$FF
	STA.w $04C3
	RTS

CODE_01DB25:				; Note: This changes the mouse speed setting.
	LDA.b #$01
	STA.w !REGISTER_JoypadSerialPort1
	LDA.w !REGISTER_JoypadSerialPort1,x
	STZ.w !REGISTER_JoypadSerialPort1
	RTL

;--------------------------------------------------------------------

DATA_01DB31:
	dw $0000,$002E,$0060,$0062,$008C,$00A2,$00A4,$00AC
	dw $00C8,$00F4,$00FA,$0100,$0124,$0126,$0128,$012A
	dw $0150

DATA_01DB53:
	dw $0000,$0040,$0080,$00C0,$0100,$0140,$01C0,$0600
	dw $0640,$5A00,$06C0,$0700,$1800,$1840,$1880,$18C0
	dw $1900,$1940,$1980,$19C0,$1E40,$0DC0,$FFFF,$1200
	dw $1240,$1280,$12C0,$1300,$1340,$1380,$13C0,$4E00
	dw $4E40,$4E80,$4EC0,$2A00,$2A40,$2A80,$2AC0,$2B00
	dw $2B40,$2B80,$2BC0,$4F00,$4F40,$4F80,$4FC0,$FFFF
	dw $FFFF,$3C00,$3C40,$3C80,$3CC0,$3D00,$3D40,$3DC0
	dw $4240,$4380,$0180,$4800,$4840,$4880,$48C0,$4900
	dw $4940,$49C0,$1F00,$1FC0,$5400,$FFFF,$4280,$42C0
	dw $4200,$4300,$4380,$0180,$4980,$1EC0,$1F00,$1FC0
	dw $FFFF,$FFFF,$4340,$43C0,$1F40,$FFFF,$0740,$0780
	dw $07C0,$0C00,$0C40,$0C80,$0CC0,$0D00,$0D40,$0700
	dw $0DC0,$6000,$6040,$FFFF,$3000,$3040,$3080,$3100
	dw $3140,$3180,$31C0,$4240,$4380,$3600,$3640,$3680
	dw $3700,$3740,$3780,$37C0,$49C0,$1F00,$30C0,$36C0
	dw $5400,$FFFF,$4380,$1F00,$FFFF,$4380,$1F00,$FFFF
	dw $4240,$2400,$2440,$2480,$24C0,$4380,$1E00,$2500
	dw $2540,$2580,$25C0,$1F00,$0680,$6080,$6140,$6180
	dw $61C0,$FFFF,$FFFF,$FFFF,$FFFF,$5400,$5440,$5480
	dw $54C0,$5500,$5540,$5580,$55C0,$5A00,$5A40,$5A80
	dw $5AC0,$5B00,$5B40,$5B80,$5BC0,$4380,$1F00,$FFFF
	dw $60C0,$6600,$6680,$6700,$6100,$6640,$66C0,$6740
	dw $4380,$1F00,$FFFF

;--------------------------------------------------------------------

CODE_01DCB9:
	LDA.w $1B1C
	BEQ.b CODE_01DCF8
	LDA.w $1B1D
	BPL.b CODE_01DCF8
	LDA.w $1B1E
	INC
	INC
	INC
	INC
	CMP.b #$80
	BCC.b CODE_01DCD0
	LDA.b #$10
CODE_01DCD0:
	STA.w $1B1E
	TAX
	LDA.l DATA_01DCF9,x
	CLC
	ADC.w MPAINT_Global_OAMBuffer[$00].XDisp
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp
	LDA.l DATA_01DCF9+$01,x
	CLC
	ADC.w MPAINT_Global_OAMBuffer[$00].YDisp
	STA.w MPAINT_Global_OAMBuffer[$00].YDisp
	LDA.l DATA_01DCF9+$02,x
	STA.w MPAINT_Global_OAMBuffer[$00].Tile
	LDA.l DATA_01DCF9+$03,x
	STA.w $1B1D
CODE_01DCF8:
	RTL

DATA_01DCF9:
	dw $0000,$300A,$0000,$1040,$0000,$1042,$0000,$1044
	dw $0000,$2046,$0000,$1048,$0000,$1046,$0000,$1048
	dw $0000,$1046,$0000,$1048,$0000,$9046,$0000,$104A
	dw $0000,$104C,$0000,$104A,$0000,$104C,$0000,$0662
	dw $0000,$0944,$0000,$0662,$0000,$104C,$0000,$104A
	dw $0000,$0764,$0000,$4066,$0000,$0764,$0000,$4046
	dw $0000,$104C,$FE00,$084E,$0000,$0760,$0200,$084E
	dw $0000,$6046,$0000,$504A,$0000,$104C,$0000,$104A

;--------------------------------------------------------------------

CODE_01DD79:
	PHP
	REP.b #$30
	PHD
	PHX
	PEA.w $0000
	PEA.w $0000
	TSC
	TCD
	LDX.w #$0021
CODE_01DD89:
	LDA.b $03
	CMP.b $0F
	BCC.b CODE_01DDA1
	BNE.b CODE_01DD97
	LDA.b $01
	CMP.b $0D
	BCC.b CODE_01DDA1
CODE_01DD97:
	SBC.b $0D
	STA.b $01
	LDA.b $03
	SBC.b $0F
	STA.b $03
CODE_01DDA1:
	ROL.b $11
	ROL.b $13
	ROL.b $01
	ROL.b $03
	DEX
	BNE.b CODE_01DD89
	PLA
	PLA
	PLX
	PLD
	PLA
	STA.b $03,S
	PLA
	STA.b $03,S
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01DDB8:
	LDA.w $053B
	BNE.b CODE_01DDBE
	RTL

CODE_01DDBE:
	LDX.w $053F
	LDA.w $052C,x
	CMP.w $0530,x
	BNE.b CODE_01DDE0
	LDA.w $053D
	BNE.b CODE_01DDDD
	LDA.w $053B
	STA.w $053D
	LDA.w $052C,x
	DEC
	AND.b #$0F
	STA.w $052C,x
CODE_01DDDD:
	DEC.w $053D
CODE_01DDE0:
	RTL

;--------------------------------------------------------------------

CODE_01DDE1:
	LDA.w $0538
	BNE.b CODE_01DE2C
	PHP
	LDA.w $053A
	BEQ.b CODE_01DDF1
	DEC.w $053A
	BRA.b CODE_01DE2B

CODE_01DDF1:
	REP.b #$20
	LDA.w #$04EC
	PHA
	LDX.b #$00
	SEP.b #$20
	LDA.w $052C,x
	TAY
	CMP.w $0530,x
	BEQ.b CODE_01DE28
	LDA.w $0534,x
	BNE.b CODE_01DE17
CODE_01DE09:
	LDA.b ($01,S),y
	LDX.b #$00
	STA.w !REGISTER_APUPort0,x
	LDA.b #$01
	STA.w $0534,x
	BRA.b CODE_01DE28

CODE_01DE17:
	LDA.b ($01,S),y
	CMP.w !REGISTER_APUPort0,x
	BNE.b CODE_01DE09
	INY
	TYA
	AND.b #$0F
	STA.w $052C,x
	STZ.w $0534,x
CODE_01DE28:
	REP.b #$20
	PLA
CODE_01DE2B:
	PLP
CODE_01DE2C:
	RTL

;--------------------------------------------------------------------

CODE_01DE2D:
	LDA.w $0538
	BNE.b CODE_01DE96
	PHP
	REP.b #$20
	LDA.w #$051C
	PHA
	LDX.b #$03
CODE_01DE3B:
	SEP.b #$20
	LDA.w $052C,x
	TAY
	CMP.w $0530,x
	BEQ.b CODE_01DE84
	LDA.w $0534,x
	BNE.b CODE_01DE61
	LDA.w !REGISTER_APUPort0,x
	BNE.b CODE_01DE89
	LDA.b #$04
	STA.w $0541,x
	LDA.b ($01,S),y
CODE_01DE57:
	STA.w !REGISTER_APUPort0,x
	LDA.b #$01
	STA.w $0534,x
	BRA.b CODE_01DE89

CODE_01DE61:
	LDA.b ($01,S),y
	CMP.w !REGISTER_APUPort0,x
	BEQ.b CODE_01DE77
	LDA.w $0541,x
	DEC
	STA.w $0541,x
	CMP.b #$00
	BEQ.b CODE_01DE77
	LDA.b ($01,S),Y
	BRA.b CODE_01DE57

CODE_01DE77:
	INY
	TYA
	AND.b #$0F
	STA.w $052C,x
	STZ.w $0534,x
	STZ.w $0541,x
CODE_01DE84:
	LDA.b #$00
	STZ.w !REGISTER_APUPort0,x
CODE_01DE89:
	REP.b #$20
	PLA
	SEC
	SBC.w #$0010
	PHA
	DEX
	BNE.b CODE_01DE3B
	PLA
	PLP
CODE_01DE96:
	RTL

;--------------------------------------------------------------------

CODE_01DE97:
	PHP
	PHB
	PHD
	PEA.w $0000
	PLD
	PHK
	PLB
	REP.b #$30
	LDA.w #DATA_01DEA8
	PHA
	BRA.b CODE_01DEDC

DATA_01DEA8:
	db $02 : dl $7E2000 : dw $0800,$0080,$0030

CODE_01DEB2:
	PHP
	PHB
	PHD
	PEA.w $0000
	PLD
	PHK
	PLB
	REP.b #$30
	LDA.w #DATA_01DEC3
	PHA
	BRA.b CODE_01DEDC

DATA_01DEC3:
	db $02 : dl $7E2800 : dw $0800,$0080,$0034

CODE_01DECD:
	PHP
	PHB
	PHD
	PEA.w $0000
	PLD
	PHK
	PLB
	REP.b #$30
	LDA.w #DATA_01DF1B
	PHA
CODE_01DEDC:
	STZ.w $0202
	LDX.w $0204
	LDY.w #$0000
CODE_01DEE5:
	LDA.b ($01,S),y
	STA.w $0182,x
	INY
	INY
	INX
	INX
	CPY.w #$000A
	BCC.b CODE_01DEE5
	PLA
	LDA.w $0204
	CLC
	ADC.w #$0009
	STA.w $0204
	SEP.b #$30
	LDA.w $0104
	BIT.b #$80
	BEQ.b CODE_01DF14
	LDA.w $0122
	BIT.b #$80
	BNE.b CODE_01DF14
	JSL.l CODE_01E6D0
	BRA.b CODE_01DF17

CODE_01DF14:
	INC.w $0202
CODE_01DF17:
	PLD
	PLB
	PLP
	RTL

DATA_01DF1B:
	db $02 : dl $7E3000 : dw $0800,$0080,$0038

;--------------------------------------------------------------------

CODE_01DF25:
	PHP
	PHB
	PHD
	PHK
	PLB
	PEA.w $0000
	PLD
	SEP.b #$30
	LDA.w $0530
	STA.w $052C
	LDA.w $0531
	STA.w $052D
	LDA.w $0532
	STA.w $052E
	LDA.w $0533
	STA.w $052F
	REP.b #$30
	LDA.b $CC
	SEC
	SBC.w #$8000
	TAY
	LDA.w #$8000
	STA.b $CC
	LDA.w #$BBAA
CODE_01DF59:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_01DF59
	SEP.b #$20
	LDA.b #$CC
	BRA.b CODE_01DF8E

CODE_01DF64:
	LDA.b [$CC],y
	JSR.w CODE_01DFC1
	XBA
	LDA.b #$00
	BRA.b CODE_01DF7B

CODE_01DF6E:
	XBA
	LDA.b [$CC],y
	JSR.w CODE_01DFC1
	XBA
CODE_01DF75:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_01DF75
	INC
CODE_01DF7B:
	REP.b #$20
	STA.w !REGISTER_APUPort0
	SEP.b #$20
	DEX
	BNE.b CODE_01DF6E
CODE_01DF85:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_01DF85
CODE_01DF8A:
	ADC.b #$03
	BEQ.b CODE_01DF8A
CODE_01DF8E:
	PHA
	REP.b #$20
	LDA.b [$CC],y
	JSR.w CODE_01DFC1
	JSR.w CODE_01DFC1
	TAX
	LDA.b [$CC],y
	JSR.w CODE_01DFC1
	JSR.w CODE_01DFC1
	STA.w !REGISTER_APUPort2
	SEP.b #$20
	CPX.w #$0001
	LDA.b #$00
	ROL
	STA.w !REGISTER_APUPort1
	ADC.b #$7F
	PLA
	STA.w !REGISTER_APUPort0
CODE_01DFB6:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_01DFB6
	BVS.b CODE_01DF64
	PLD
	PLB
	PLP
	RTL

CODE_01DFC1:
	INY
	BPL.b CODE_01DFD2
	INC.b $CE
	INC.b $CE
	LDA.b [$CC]
	STA.w $0000
	DEC.b $CE
	LDY.w #$0000
CODE_01DFD2:
	RTS

;--------------------------------------------------------------------

CODE_01DFD3:
	PHP
	REP.b #$30
	LDA.l $000105
	AND.w #$00E0
	ASL
	ASL
	ASL
	XBA
	TAX
	LDA.l DATA_01DFFA,x
	AND.w #$00FF
	STA.l $00012E
	LDA.l DATA_01E000,x
	AND.w #$00FF
	STA.l $000130
	PLP
	RTL

DATA_01DFFA:
	db $08,$08,$08,$10,$10,$20

DATA_01E000:
	db $10,$20,$40,$20,$40,$40

;--------------------------------------------------------------------

CODE_01E006:
	PHP
	SEP.b #$20
	REP.b #$10
CODE_01E00B:
	STA.l $0000CC,x
	INX
	DEY
	BNE.b CODE_01E00B
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E015:
	PHP
	REP.b #$30
CODE_01E018:
	STA.l $0000CC,x
	INX
	INX
	DEY
	DEY
	BNE.b CODE_01E018
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E024:
	PHP
	REP.b #$30
	LDX.w #$2000
	LDY.w #$0800
	JSL.l CODE_01E060
	PLP
	RTL

CODE_01E033:
	PHP
	REP.b #$30
	LDX.w #$2800
	LDY.w #$0800
	JSL.l CODE_01E060
	PLP
	RTL

CODE_01E042:
	PHP
	REP.b #$30
	LDX.w #$3000
	LDY.w #$0800
	JSL.l CODE_01E060
	PLP
	RTL

CODE_01E051:
	PHP
	SEP.b #$20
	REP.b #$10
CODE_01E056:
	STA.l $7E0000,x
	INX
	DEY
	BNE.b CODE_01E056
	PLP
	RTL

CODE_01E060:
	PHP
	REP.b #$30
CODE_01E063:
	STA.l $7E0000,x
	INX
	INX
	DEY
	DEY
	BNE.b CODE_01E063
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E06F:
	PHP
	PHB
	PHD
	PEA.w $0000
	PLD
	PHK
	PLB
	REP.b #$30
	LDX.w #$01FE
	LDA.w #$F400
CODE_01E080:
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	DEX
	DEX
	BPL.b CODE_01E080
	LDA.w #$5555
	LDX.w #$001E
CODE_01E08D:
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	DEX
	DEX
	BPL.b CODE_01E08D
	STZ.w $0446
	PLD
	PLB
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E09B:
	PHP
	PHB
	PHD
	PEA.w $0000
	PLD
	PHK
	PLB
	REP.b #$30
	LDX.w $0446
	CPX.w #$0200
	BCS.b CODE_01E0EC
	LDA.w #$F400
CODE_01E0B1:
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	CPX.w #$0200
	BNE.b CODE_01E0B1
	LDA.w $0446
	AND.w #$FFE0
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w $0446
	AND.w #$001C
	LSR
	TAY
	LDA.w #$5555
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	AND.w DATA_01E0F3,y
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	LDA.w #$5555
CODE_01E0E0:
	INX
	INX
	CPX.w #$0020
	BEQ.b CODE_01E0EC
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	BRA.b CODE_01E0E0

CODE_01E0EC:
	STZ.w $0446
	PLD
	PLB
	PLP
	RTL

DATA_01E0F3:
	dw $FFFF,$FFFC,$FFF0,$FFC0,$FF00,$FC00,$F000,$C000

;--------------------------------------------------------------------

CODE_01E103:
	LDA.w $0104
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.w $0105
	STA.w !REGISTER_OAMSizeAndDataAreaDesignation
	LDA.w $0108
	STA.w !REGISTER_BGModeAndTileSizeSetting
	LDA.w $0109
	STA.w !REGISTER_MosaicSizeAndBGEnable
	LDA.w $010A
	STA.w !REGISTER_BG1AddressAndSize
	LDA.w $010B
	STA.w !REGISTER_BG2AddressAndSize
	LDA.w $010C
	STA.w !REGISTER_BG3AddressAndSize
	LDA.w $010D
	STA.w !REGISTER_BG4AddressAndSize
	LDA.w $010E
	STA.w !REGISTER_BG1And2TileDataDesignation
	LDA.w $010F
	STA.w !REGISTER_BG3And4TileDataDesignation
	LDA.w $0110
	STA.w !REGISTER_Mode7TilemapSettings
	LDA.w $0111
	STA.w !REGISTER_BG1And2WindowMaskSettings
	LDA.w $0112
	STA.w !REGISTER_BG3And4WindowMaskSettings
	LDA.w $0113
	STA.w !REGISTER_ObjectAndColorWindowSettings
	LDA.w $0114
	STA.w !REGISTER_Window1LeftPositionDesignation
	LDA.w $0115
	STA.w !REGISTER_Window1RightPositionDesignation
	LDA.w $0116
	STA.w !REGISTER_Window2LeftPositionDesignation
	LDA.w $0117
	STA.w !REGISTER_Window2RightPositionDesignation
	LDA.w $0118
	STA.w !REGISTER_BGWindowLogicSettings
	LDA.w $0119
	STA.w !REGISTER_ColorAndObjectWindowLogicSettings
	LDA.w $011A
	STA.w !REGISTER_MainScreenLayers
	LDA.w $011C
	STA.w !REGISTER_MainScreenWindowMask
	LDA.w $011B
	STA.w !REGISTER_SubScreenLayers
	LDA.w $011D
	STA.w !REGISTER_SubScreenWindowMask
	LDA.w $011E
	STA.w !REGISTER_ColorMathInitialSettings
	LDA.w $011F
	STA.w !REGISTER_ColorMathSelectAndEnable
	LDA.w $0120
	STA.w !REGISTER_FixedColorData
	LDA.w $0121
	STA.w !REGISTER_InitialScreenSettings
CODE_01E1AB:
	LDA.w $016E
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.w $016F
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.w $0170
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.w $0171
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.w $0172
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.w $0173
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.w $0174
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.w $0175
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.w $0176
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.w $0177
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.w $0178
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.w $0179
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.w $017A
	STA.w !REGISTER_BG4HorizScrollOffset
	LDA.w $017B
	STA.w !REGISTER_BG4HorizScrollOffset
	LDA.w $017C
	STA.w !REGISTER_BG4VertScrollOffset
	LDA.w $017D
	STA.w !REGISTER_BG4VertScrollOffset
	RTL

;--------------------------------------------------------------------

CODE_01E20C:
	PHB
	PHD
	PHX
	PHY
	PHP
	PEA.w $0000
	PLB
	PLB
	PEA.w $0000
	PLD
	REP.b #$30
	INC.w $044A
	LDA.w $044A
	CMP.w #$0037
	BCC.b CODE_01E22D
	JSR.w CODE_01E298
	STZ.w $044A
CODE_01E22D:
	ASL
	TAY
	LDA.w $044C,y
	PLP
	PLY
	PLX
	PLD
	PLB
	RTL

;--------------------------------------------------------------------

CODE_01E238:
	PHB
	PHD
	PHX
	PHY
	PHP
	PEA.w $0000
	PLB
	PLB
	PEA.w $0000
	PLD
	REP.b #$30
	LDA.b $02
	AND.w #$001F
	PHA
	STA.w $04B8
	LDA.w #$0001
	PHA
	STZ.w $044A
	LDY.w #$0028
	LDX.w #$006C
CODE_01E25E:
	LDA.b $01,S
	STA.w $044C,y
	LDA.b $03,S
	SEC
	SBC.b $01,S
	BCS.b CODE_01E26E
	CLC
	ADC.w $0448
CODE_01E26E:
	STA.b $01,S
	LDA.w $044C,y
	STA.b $03,S
	TYA
	CLC
	ADC.w #$002A
	CMP.w #$006E
	BCC.b CODE_01E282
	SBC.w #$006E
CODE_01E282:
	TAY
	DEX
	DEX
	BNE.b CODE_01E25E
	PLA
	PLA
	JSR.w CODE_01E298
	JSR.w CODE_01E298
	JSR.w CODE_01E298
	PLP
	PLY
	PLX
	PLD
	PLB
	RTL

;--------------------------------------------------------------------

CODE_01E298:
	PHA
	PHA
	LDY.w #$0000
CODE_01E29D:
	TYA
	STA.b $03,S
	CMP.w #$0030
	BCS.b CODE_01E2AA
	ADC.w #$003E
	BRA.b CODE_01E2AD

CODE_01E2AA:
	SBC.w #$0030
CODE_01E2AD:
	TAY
	LDA.w $044C,y
	STA.b $01,S
	LDA.b $03,S
	TAY
	LDA.w $044C,y
	SEC
	SBC.b $01,S
	BCS.b CODE_01E2C1
	ADC.w $0448
CODE_01E2C1:
	STA.w $044C,y
	INY
	INY
	CPY.w #$006E
	BNE.b CODE_01E29D
	PLA
	PLA
	RTS

;--------------------------------------------------------------------

CODE_01E2CE:
	PHP
	SEP.b #$30
	LDA.l $000122
	ORA.b #$01
	STA.l !REGISTER_IRQNMIAndJoypadEnableFlags
	LDA.l $000129
	AND.b #$FE
	STA.l !REGISTER_HVBlankFlagsAndJoypadStatus
	LDA.b #$01
	STA.l $00016A
CODE_01E2EB:
	LDA.l $00016A
	BNE.b CODE_01E2EB
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E2F3:
	PHP
	SEP.b #$20
CODE_01E2F6:
	LDA.l !REGISTER_HVBlankFlagsAndJoypadStatus
	BIT.b #$80
	BNE.b CODE_01E2F6
	LDA.l $000122
	ORA.b #$80
	STA.l !REGISTER_IRQNMIAndJoypadEnableFlags
	STA.l $000122
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E30E:
	PHP
	SEP.b #$20
	LDA.l $000122
	AND.b #$7F
	STA.l !REGISTER_IRQNMIAndJoypadEnableFlags
	STA.l $000122
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E321:
	PHP
	SEP.b #$20
	LDA.l $000104
	ORA.b #$80
	STA.l $000104
	JSL.l CODE_01E2CE
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E334:
	PHP
	SEP.b #$20
	LDA.l $000104
	AND.b #$7F
	STA.l $000104
	JSL.l CODE_01E2CE
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E347:
	PHP
	SEP.b #$20
	LDA.l $000122
	ORA.b #$10
	STA.l $000122
	STA.l !REGISTER_IRQNMIAndJoypadEnableFlags
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E35A:
	PHP
	SEP.b #$20
	LDA.l $000122
	AND.b #$EF
	STA.l $000122
	STA.l !REGISTER_IRQNMIAndJoypadEnableFlags
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E36D:
	PHP
	SEP.b #$20
	LDA.l $000122
	ORA.b #$20
	STA.l $000122
	STA.l !REGISTER_IRQNMIAndJoypadEnableFlags
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E380:
	PHP
	SEP.b #$20
	LDA.l $000122
	AND.b #$DF
	STA.l $000122
	STA.l !REGISTER_IRQNMIAndJoypadEnableFlags
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E393:
	PHP
	REP.b #$30
	PHX
	PHY
	AND.w #$00FF
	ASL
	TAY
	INY
	PHD
	TSC
	TCD
	LDA.b [$08],y
	STA.b $08
	DEC.b $08
	PLD
	PLY
	PLX
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E3AC:
	PHP
	PHD
	TSC
	TCD
	LDA.b $09
	XBA
	LSR
	LSR
	LSR
	STA.b $09
	STZ.w $0202
	LDX.w $0204
CODE_01E3BE:
	SEP.b #$20
	LDA.b #$02
	STA.w $0182,x
	INX
	LDA.b $0F
	STA.w $0182,x
	INX
	LDA.b $10
	STA.w $0182,x
	INX
	LDA.b $0D
	STA.w $0182,x
	INX
	LDA.b $09
	STA.w $0182,x
	INX
	LDA.b $0A
	STA.w $0182,x
	INX
	LDA.b #$80
	STA.w $0182,x
	INX
	LDA.b $0B
	STA.w $0182,x
	INX
	LDA.b $0C
	STA.w $0182,x
	INX
	REP.b #$20
	LDA.b $0F
	CLC
	ADC.w #$0200
	STA.b $0F
	LDA.b $0B
	CLC
	ADC.w #$0100
	STA.b $0B
	DEC.b $07
	BNE.b CODE_01E3BE
	STX.w $0204
	SEP.b #$20
	LDA.b #$00
	STA.w $0182,x
	LDA.b $06,S
	STA.b $10,S
	REP.b #$20
	LDA.b $04,S
	STA.b $0E,S
	TSC
	CLC
	ADC.w #$000D
	PLD
	PLP
	TCS
	RTL

;--------------------------------------------------------------------

CODE_01E429:
	SEP.b #$20
	LDA.w $0107
	STA.w !REGISTER_OAMAddressHi
	LDA.w $0106
	STA.w !REGISTER_OAMAddressLo
	LDA.b #$00
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_OAMDataWritePort
	STA.w DMA[$00].Destination
	LDA.b #!RAM_MPAINT_Global_OAMBuffer
	STA.w DMA[$00].SourceLo
	LDA.b #!RAM_MPAINT_Global_OAMBuffer>>8
	STA.w DMA[$00].SourceHi
	LDA.b #!RAM_MPAINT_Global_OAMBuffer>>16
	STA.w DMA[$00].SourceBank
	LDA.b #$20
	STA.w DMA[$00].SizeLo
	LDA.b #$02
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	RTL

;--------------------------------------------------------------------

CODE_01E460:
	LDA.w $0206
	BNE.b CODE_01E466
	RTL

CODE_01E466:
	LDA.w $0202
	BEQ.b CODE_01E46C
	RTL

CODE_01E46C:
	PHP
	REP.b #$20
	LDA.w $0208
	BNE.b CODE_01E48B
	LDA.w #$6000
	STA.w $020A
	STZ.w $020E
	LDA.w #$A000
	LDY.w $19FA
	BEQ.b CODE_01E488
	LDA.w #$4000
CODE_01E488:
	STA.w $0210
CODE_01E48B:
	STZ.w $0208
	LDA.w $020A
	CMP.w #$1000
	BCC.b CODE_01E4A4
	BEQ.b CODE_01E4A4
	SBC.w #$1000
	STA.w $020A
	INC.w $0208
	LDA.w #$1000
CODE_01E4A4:
	STA.w $020C
	SEP.b #$20
	LDA.w $0210
	STA.w DMA[$00].SourceLo
	LDA.w $0211
	STA.w DMA[$00].SourceHi
	LDA.w $0212
	STA.w DMA[$00].SourceBank
	LDA.w $020C
	STA.w DMA[$00].SizeLo
	LDA.w $020D
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.w $020E
	STA.w !REGISTER_VRAMAddressLo
	LDA.w $020F
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	REP.b #$20
	LDA.w $020C
	LSR
	CLC
	ADC.w $020E
	STA.w $020E
	LDA.w $020C
	CLC
	ADC.w $0210
	STA.w $0210
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E500:
	PHP
	LDA.w $0214
	BNE.b CODE_01E508
	PLP
	RTL

CODE_01E508:
	REP.b #$20
	LDA.w $0216
	BNE.b CODE_01E521
	LDA.w #$5800
	STA.w $0218
	LDA.w #$4400
	STA.w $021C
	LDA.w #$0000
	STA.w $021E
CODE_01E521:
	STZ.w $0214
	STZ.w $0216
	LDA.w $0218
	CMP.w #$1000
	BCC.b CODE_01E540
	BEQ.b CODE_01E540
	SBC.w #$1000
	STA.w $0218
	INC.w $0214
	INC.w $0216
	LDA.w #$1000
CODE_01E540:
	STA.w $021A
	SEP.b #$20
	LDA.w $021E
	STA.w DMA[$00].SourceLo
	LDA.w $021F
	STA.w DMA[$00].SourceHi
	LDA.b #$7F
	STA.w DMA[$00].SourceBank
	LDA.w $021A
	STA.w DMA[$00].SizeLo
	LDA.w $021B
	STA.w DMA[$00].SizeHi
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.w $021C
	STA.w !REGISTER_VRAMAddressLo
	LDA.w $021D
	STA.w !REGISTER_VRAMAddressHi
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	REP.b #$20
	LDA.w $021A
	LSR
	CLC
	ADC.w $021C
	STA.w $021C
	LDA.w $021A
	CLC
	ADC.w $021E
	STA.w $021E
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E59B:
	LDA.w $0220
	BNE.b CODE_01E5A1
	RTL

CODE_01E5A1:
	BPL.b CODE_01E5C6
	LDA.b #$02
	EOR.b #$FF
	AND.w $0127
	STA.w $0127
	STA.w !REGISTER_HDMAEnable
	STZ.w $0111
	STZ.w !REGISTER_BG1And2WindowMaskSettings
	STZ.w $0112
	STZ.w !REGISTER_BG3And4WindowMaskSettings
	STZ.w $0113
	STZ.w !REGISTER_ObjectAndColorWindowSettings
	STZ.w $0220
	RTL

CODE_01E5C6:
	LSR
	BCC.b CODE_01E5E4
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_Window1LeftPositionDesignation
	STA.w HDMA[$01].Destination
	LDA.b #!RAM_MPAINT_Canvas_AnimationCellGFXBuffer
	STA.w HDMA[$01].SourceLo
	LDA.b #!RAM_MPAINT_Canvas_AnimationCellGFXBuffer>>8
	STA.w HDMA[$01].SourceHi
	LDA.b #!RAM_MPAINT_Canvas_AnimationCellGFXBuffer>>16
	STA.w HDMA[$01].SourceBank
	BRA.b CODE_01E5FD

CODE_01E5E4:
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_Window1LeftPositionDesignation
	STA.w HDMA[$01].Destination
	LDA.b #$7E4200
	STA.w HDMA[$01].SourceLo
	LDA.b #$7E4200>>8
	STA.w HDMA[$01].SourceHi
	LDA.b #$7E4200>>16
	STA.w HDMA[$01].SourceBank
CODE_01E5FD:
	LDA.w $0127
	ORA.b #$02
	STA.w $0127
	STA.w !REGISTER_HDMAEnable
	STZ.w $0220
	RTL

;--------------------------------------------------------------------

CODE_01E60C:
	LDA.w $0224
	BNE.b CODE_01E612
	RTL

CODE_01E612:
	BPL.b CODE_01E625
	LDA.b #$04
	EOR.b #$FF
	AND.w $0127
	STA.w $0127
	STA.w !REGISTER_HDMAEnable
	STZ.w $0224
	RTL

CODE_01E625:
	LSR
	BCC.b CODE_01E643
	LDA.b #$02
	STA.w HDMA[$02].Parameters
	LDA.b #!REGISTER_BG2VertScrollOffset
	STA.w HDMA[$02].Destination
	LDA.b #$7F9600
	STA.w HDMA[$02].SourceLo
	LDA.b #$7F9600>>8
	STA.w HDMA[$02].SourceHi
	LDA.b #$7F9600>>16
	STA.w HDMA[$02].SourceBank
	BRA.b CODE_01E65C

CODE_01E643:
	LDA.b #$02
	STA.w HDMA[$02].Parameters
	LDA.b #!REGISTER_BG2VertScrollOffset
	STA.w HDMA[$02].Destination
	LDA.b #$7F9800
	STA.w HDMA[$02].SourceLo
	LDA.b #$7F9800>>8
	STA.w HDMA[$02].SourceHi
	LDA.b #$7F9800>>16
	STA.w HDMA[$02].SourceBank
CODE_01E65C:
	LDA.w $0127
	ORA.b #$04
	STA.w $0127
	STA.w !REGISTER_HDMAEnable
	STZ.w $0224
	RTL

;--------------------------------------------------------------------

CODE_01E66B:
	LDA.w $0222
	BNE.b CODE_01E671
	RTL

CODE_01E671:
	BPL.b CODE_01E684
	LDA.b #$08
	EOR.b #$FF
	AND.w $0127
	STA.w $0127
	STA.w !REGISTER_HDMAEnable
	STZ.w $0222
	RTL

CODE_01E684:
	LSR
	BCC.b CODE_01E6A2
	LDA.b #$02
	STA.w HDMA[$03].Parameters
	LDA.b #!REGISTER_BG2HorizScrollOffset
	STA.w HDMA[$03].Destination
	LDA.b #$7F9200
	STA.w HDMA[$03].SourceLo
	LDA.b #$7F9200>>8
	STA.w HDMA[$03].SourceHi
	LDA.b #$7F9200>>16
	STA.w HDMA[$03].SourceBank
	BRA.b CODE_01E6BB

CODE_01E6A2:
	LDA.b #$02
	STA.w HDMA[$03].Parameters
	LDA.b #!REGISTER_BG2HorizScrollOffset
	STA.w HDMA[$03].Destination
	LDA.b #$7F9400
	STA.w HDMA[$03].SourceLo
	LDA.b #$7F9400>>8
	STA.w HDMA[$03].SourceHi
	LDA.b #$7F9400>>16
	STA.w HDMA[$03].SourceBank
CODE_01E6BB:
	LDA.w $0127
	ORA.b #$08
	STA.w $0127
	STA.w !REGISTER_HDMAEnable
	STZ.w $0222
	RTL

;--------------------------------------------------------------------

CODE_01E6CA:
	LDA.w $0202
	BNE.b CODE_01E6D0
	RTL

CODE_01E6D0:
	LDX.b #$0182>>8
	LDY.b #$0182
	STZ.w $0202
	STZ.w $0204
	STZ.w $0205
	STX.b $CD
	STY.b $CC
	REP.b #$10
	LDY.w #$0000
CODE_01E6E6:
	LDA.b ($CC),y
	BEQ.b CODE_01E744
	STA.b $DE
	INY
	LDA.b ($CC),y
	STA.w DMA[$00].SourceLo
	INY
	LDA.b ($CC),y
	STA.w DMA[$00].SourceHi
	INY
	LDA.b ($CC),y
	STA.w DMA[$00].SourceBank
	INY
	LDA.b ($CC),y
	STA.w DMA[$00].SizeLo
	INY
	LDA.b ($CC),y
	STA.w DMA[$00].SizeHi
	INY
	LDA.b $DE
	AND #$01
	BEQ.b CODE_01E721
	STZ.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToCGRAMPort
	STA.w DMA[$00].Destination
	LDA.b ($CC),y
	INY
	STA.w !REGISTER_CGRAMAddress
	BRA.b CODE_01E73D

CODE_01E721:
	LDA.b #$01
	STA.w DMA[$00].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination
	LDA.b ($CC),y
	INY
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b ($CC),y
	INY
	STA.w !REGISTER_VRAMAddressLo
	LDA.b ($CC),y
	INY
	STA.w !REGISTER_VRAMAddressHi
CODE_01E73D:
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	BRA.b CODE_01E6E6

CODE_01E744:
	SEP.b #$10
	RTL

;--------------------------------------------------------------------

CODE_01E747:
	PHP
	LDA.w !REGISTER_HVBlankFlagsAndJoypadStatus
	AND.b #$01
	BNE.b CODE_01E747
	REP.b #$20
	LDX.b #$06
CODE_01E753:
	LDA.w !REGISTER_Joypad1Lo,x
	STA.w !RAM_MPAINT_Global_HeldButtonsLoP1,x
	EOR.w !RAM_MPAINT_Global_DisableButtonsLoP1,x
	AND.w !RAM_MPAINT_Global_HeldButtonsLoP1,x
	STA.w !RAM_MPAINT_Global_PressedButtonsLoP1,x
	STA.w $0142,x
	LDA.w !RAM_MPAINT_Global_HeldButtonsLoP1,x
	BEQ.b CODE_01E782
	CMP.w !RAM_MPAINT_Global_DisableButtonsLoP1,x
	BNE.b CODE_01E782
	DEC.w $0162,x
	BNE.b CODE_01E788
	LDA.w !RAM_MPAINT_Global_HeldButtonsLoP1,x
	STA.w $0142,x
	LDA.w $012C
	STA.w $0162,x
	BRA.b CODE_01E788

CODE_01E782:
	LDA.w $012A
	STA.w $0162,x
CODE_01E788:
	LDA.w !RAM_MPAINT_Global_HeldButtonsLoP1,x
	STA.w !RAM_MPAINT_Global_DisableButtonsLoP1,x
	DEX
	DEX
	BPL.b CODE_01E753
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E794:
	PHP
	PHB
	PHD
	PEA.w $0000
	PLD
	PHK
	PLB
	SEP.b #$30
	LDA.w $0104
	AND.b #$70
	STA.w $0104
CODE_01E7A7:
	LDA.b #$01
	STA.w $04BD
CODE_01E7AC:
	JSL.l CODE_01E2CE
	DEC.w $04BD
	BNE.b CODE_01E7AC
	INC.w $0104
	LDA.w $0104
	AND.b #$0F
	CMP.b #$0F
	BNE.b CODE_01E7A7
	JSL.l CODE_01E2CE
	PLD
	PLB
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E7C9:
	PHP
	PHB
	PHD
	PEA.w $0000
	PLD
	PHK
	PLB
	SEP.b #$30
	LDA.w $0104
	AND.b #$0F
	BEQ.b CODE_01E7F3
CODE_01E7DB:
	LDA.b #$01
	STA.w $04BD
CODE_01E7E0:
	JSL.l CODE_01E2CE
	DEC.w $04BD
	BNE.b CODE_01E7E0
	DEC.w $0104
	LDA.w $0104
	AND.b #$0F
	BNE.b CODE_01E7DB
CODE_01E7F3:
	LDA.w $0104
	ORA.b #$80
	STA.w $0104
	JSL.l CODE_01E2CE
	PLD
	PLB
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E803:
	PHP
	SEP.b #$30
	LDA.b $F2
	STA.w !REGISTER_Multiplicand
	LDA.b $F4
	STA.w !REGISTER_Multiplier
	NOP #3
	LDA.w !REGISTER_ProductOrRemainderLo
	STA.b $F8
	LDA.w !REGISTER_ProductOrRemainderHi
	STA.b $F9
	LDA.b $F3
	STA.w !REGISTER_Multiplicand
	LDA.b $F4
	STA.w !REGISTER_Multiplier
	NOP #3
	LDA.w !REGISTER_ProductOrRemainderLo
	STA.b $FA
	LDA.w !REGISTER_ProductOrRemainderHi
	STA.b $FB
	LDA.b $F2
	STA.w !REGISTER_Multiplicand
	LDA.b $F5
	STA.w !REGISTER_Multiplier
	NOP #3
	LDA.w !REGISTER_ProductOrRemainderLo
	STA.b $FC
	LDA.w !REGISTER_ProductOrRemainderHi
	STA.b $FD
	LDA.b $F3
	STA.w !REGISTER_Multiplicand
	LDA.b $F5
	STA.w !REGISTER_Multiplier
	NOP #3
	REP.b #$20
	LDA.w !REGISTER_ProductOrRemainderLo
	STA.b $F6
	LDA.b $FA
	CLC
	ADC.b $FC
	STA.b $FA
	SEP.b #$20
	LDA.b $FA
	CLC
	ADC.b $F9
	STA.b $F9
	LDA.b $FB
	ADC.b $F6
	STA.b $F6
	BCC.b CODE_01E879
	INC.b $F7
CODE_01E879:
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E87B:
	PHP
	SEP.b #$20
	LDA.b #$00
	STA.l $000127
	STA.l !REGISTER_HDMAEnable
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E88A:
	PHP
	SEP.b #$20
	LDA.b #$00
	STA.l !REGISTER_DMAEnable
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01E895:
	PHD
	LDA.w #$0070
	PHA
	LDA.w #$0580
	PHA
	LDA.w #$0070
	PHA
	LDA.w #$0780
	PHA
	TSC
	TCD
	LDX.w #$001C
CODE_01E8AB:
	LDA.w #$0000
	STZ.w $0569,x
	LDY.w #$003E
CODE_01E8B4:
	ORA.b [$01],y
	ORA.b [$05],y
	DEY
	DEY
	BPL.b CODE_01E8B4
	CMP.w #$0000
	BNE.b CODE_01E8C4
	INC.w $0569,x
CODE_01E8C4:
	TXA
	CMP.w #$0010
	BEQ.b CODE_01E8DC
	LDA.b $01
	SEC
	SBC.w #$0040
	STA.b $01
	LDA.b $05
	SEC
	SBC.w #$0040
	STA.b $05
	BRA.b CODE_01E8EC

CODE_01E8DC:
	LDA.b $01
	SEC
	SBC.w #$0240
	STA.b $01
	LDA.b $05
	SEC
	SBC.w #$0240
	STA.b $05
CODE_01E8EC:
	DEX
	DEX
	BPL.b CODE_01E8AB
	PLA
	PLA
	PLA
	PLA
	PLD
	RTL

;--------------------------------------------------------------------

CODE_01E8F6:
	STZ.w $0567
	LDA.w $0EB8
	BEQ.b CODE_01E913
	LDA.w $04D0
	CMP.w #$0007
	BEQ.b CODE_01E939
	LDA.w $0EBE
	CMP.w #$00F0
	BCC.b CODE_01E939
	AND.w #$000F
	BRA.b CODE_01E931

CODE_01E913:
	LDA.b !RAM_MPAINT_Canvas_CurrentPaletteRowLo
	CMP.w #$00F0
	BNE.b CODE_01E939
	LDA.w $04D0
	AND.w #$00FF
	CMP.w #$0008
	BEQ.b CODE_01E92A
	CMP.w #$0006
	BCS.b CODE_01E939
CODE_01E92A:
	LDA.w $04D0
	AND.w #$FF00
	XBA
CODE_01E931:
	ASL
	TAX
	LDA.w $0569,x
	STA.w $0567
CODE_01E939:
	RTL

;--------------------------------------------------------------------

CODE_01E93A:
	LDA.w #$0001
	STA.w $0C32
	LDX.w #$0006
CODE_01E943:
	LDA.l DATA_01E980,x
	STA.l $7E2654,x
	LDA.l DATA_01E988,x
	STA.l $7E2694,x
	LDA.l DATA_01E990,x
	STA.l $7E26D4,x
	DEX
	DEX
	BPL.b CODE_01E943
	LDA.w $0EB6
	ASL
	TAX
	LDA.l DATA_01E97A-$02,x
	TAX
	LDY.w #$024E
CODE_01E96C:
	LDA.l DATA_02F310,x
	STA.w $09E4,y
	DEX
	DEX
	DEY
	DEY
	BPL.b CODE_01E96C
	RTL

DATA_01E97A:
	dw DATA_02F310_End-DATA_02F310-$02
	dw DATA_02F560_End-DATA_02F310-$02
	dw DATA_02F7B0_End-DATA_02F310-$02

DATA_01E980:
	dw $2546,$2547,$2574,$2575

DATA_01E988:
	dw $2556,$2557,$2584,$2585

DATA_01E990:
	dw $2566,$2567,$2594,$2595

;--------------------------------------------------------------------

CODE_01E998:
	PHB
	PHK
	PLB
	LDA.w $0EB6
	BEQ.b CODE_01E9B3
	DEC
	PHA
	LDA.w $0EB2
	BEQ.b CODE_01E9AD
	LDA.w $016C
	AND.w #$0008
CODE_01E9AD:
	CMP.w #$0008
	PLA
	ROL
	INC
CODE_01E9B3:
	ASL
	TAX
	LDA.w DATA_01EA07,x
	PHA
	CLC
	ADC.w #$0010
	PHA
	CLC
	ADC.w #$0010
	PHA
	LDX.w #$000E
	TXY
CODE_01E9C7:
	LDA.b ($05,S),y
	STA.l $7E2662,x
	LDA.b ($03,S),y
	STA.l $7E26A2,x
	LDA.b ($01,S),y
	STA.l $7E26E2,x
	DEY
	DEY
	DEX
	DEX
	BPL.b CODE_01E9C7
	PLA
	PLA
	PLA
	STZ.w $0202
	LDY.w #$0000
	LDX.w $0204
CODE_01E9EB:
	LDA.w DATA_01EB65,y
	STA.w $0182,x
	INX
	INX
	INY
	INY
	CPY.w #$001C
	BNE.b CODE_01E9EB
	DEX
	TXA
	STA.w $0204
	LDA.w #$0001
	STA.w $0202
	PLB
	RTL

DATA_01EA07:
	dw DATA_01EA15,DATA_01EA45,DATA_01EA75,DATA_01EAA5,DATA_01EAD5,DATA_01EB05,DATA_01EB35

DATA_01EA15:
	dw $2542,$2543,$25D7,$2544,$2545,$25D7,$257C,$257D
	dw $2552,$2553,$25E7,$2554,$2555,$25E7,$258C,$258D
	dw $2562,$2563,$25F7,$2564,$2565,$25F7,$259C,$259D

DATA_01EA45:
	dw $2578,$2579,$25D7,$2544,$2545,$25D7,$257C,$257D
	dw $2588,$2589,$25E7,$2554,$2555,$25E7,$258C,$258D
	dw $2598,$2599,$25F7,$2564,$2565,$25F7,$259C,$259D

DATA_01EA75:
	dw $254E,$254F,$25D7,$2544,$2545,$25D7,$257C,$257D
	dw $255E,$255F,$25E7,$2554,$2555,$25E7,$258C,$258D
	dw $256E,$256F,$25F7,$2564,$2565,$25F7,$259C,$259D

DATA_01EAA5:
	dw $2542,$2543,$25D7,$257A,$257B,$25D7,$257C,$257D
	dw $2552,$2553,$25E7,$258A,$258B,$25E7,$258C,$258D
	dw $2562,$2563,$25F7,$259A,$259B,$25F7,$259C,$259D

DATA_01EAD5:
	dw $2542,$2543,$25D7,$2570,$2571,$25D7,$257C,$257D
	dw $2552,$2553,$25E7,$2580,$2581,$25E7,$258C,$258D
	dw $2562,$2563,$25F7,$2590,$2591,$25F7,$259C,$259D

DATA_01EB05:
	dw $2542,$2543,$25D7,$2544,$2545,$25D7,$257E,$257F
	dw $2552,$2553,$25E7,$2554,$2555,$25E7,$258E,$258F
	dw $2562,$2563,$25F7,$2564,$2565,$25F7,$259E,$259F

DATA_01EB35:
	dw $2542,$2543,$25D7,$2544,$2545,$25D7,$25A0,$25A1
	dw $2552,$2553,$25E7,$2554,$2555,$25E7,$25B0,$25B1
	dw $2562,$2563,$25F7,$2564,$2565,$25F7,$25C0,$25C1

DATA_01EB65:
	db $02 : dl $7E2662 : dw $0010,$3180 : db $33
	db $02 : dl $7E26A2 : dw $0010,$5180 : db $33
	db $02 : dl $7E26E2 : dw $0010,$7180,$0033

;--------------------------------------------------------------------

CODE_01EB81:
	DEC.w $0563
	BNE.b CODE_01EBB4
	LDX.w #$007E
	LDA.w #$21EE
CODE_01EB8C:
	STA.l $7E2040,x
	DEX
	DEX
	BPL.b CODE_01EB8C
	JSL.l CODE_01DE97
	JSL.l CODE_01E2CE
	LDA.w #$0010
	STA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSL.l CODE_00A097
	JSL.l CODE_008AFF
	LDA.w #$000C
	STA.w $09D6
CODE_01EBB4:
	RTL

;--------------------------------------------------------------------

CODE_01EBB5:
	LDA.w #$0004
	STA.w $0446
	JSL.l CODE_01E09B
	JSL.l CODE_00C410
	JSL.l CODE_01DE97
	LDA.w #$00D0
	STA.w !RAM_MPAINT_Global_CursorYPosLo
CODE_01EBCD:
	JSL.l CODE_01E2CE
	JSL.l CODE_008B3C
	LDA.w !RAM_MPAINT_Global_CursorYPosLo
	CMP.w #$00C8
	BCS.b CODE_01EBE3
	LDA.w #$00C8
	STA.w !RAM_MPAINT_Global_CursorYPosLo
CODE_01EBE3:
	JSL.l CODE_008B44
	LDA.w $04CA
	BIT.w #$0020
	BEQ.b CODE_01EBCD
	LDA.w !RAM_MPAINT_Global_CursorXPosLo
	CMP.w #$0008
	BCC.b CODE_01EBCD
	CMP.w #$0017
	BCS.b CODE_01EC06
	LDA.w #$0041
	JSL.l CODE_01D368
	JMP.w CODE_01EC45

CODE_01EC06:
	CMP.w #$0028
	BCC.b CODE_01EBCD
	CMP.w #$0087
	BCS.b CODE_01EC19
	STZ.w $0206
	JSR.w CODE_01EC4B
	JMP.w CODE_01EC29

CODE_01EC19:
	CMP.w #$00D8
	BCC.b CODE_01EBCD
	CMP.w #$00E7
	BCS.b CODE_01EBCD
	STZ.w $0206
	JSR.w CODE_01ECAF
CODE_01EC29:
	STZ.w $0208
	INC.w $0206
CODE_01EC2F:
	JSL.l CODE_01E2CE
	LDA.w $0208
	BNE.b CODE_01EC2F
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSL.l CODE_00A097
	BRA.b CODE_01EBCD

CODE_01EC45:
	LDA.w #$000C
	STA.b $AA
	RTL

CODE_01EC4B:
	PHB
	PHD
	SEC
	SBC.w #$0028
	LDY.w #$0000
CODE_01EC54:
	CMP.w #$0018
	BCC.b CODE_01EC5F
	SBC.w #$0018
	INY
	BRA.b CODE_01EC54

CODE_01EC5F:
	CMP.w #$000F
	BCS.b CODE_01EC9C
	LDA.w #$0003
	JSL.l CODE_01D368
	TYA
	PHA
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSL.l CODE_00A097
	PLA
	ASL
	ASL
	TAX
	LDA.l DATA_01EC9F,x
	PHA
	LDA.l DATA_01EC9F+$02,x
	PHA
	TSC
	TCD
	PEA.w $7E7E
	PLB
	PLB
	LDY.w #$5FFE
CODE_01EC91:
	LDA.b [$01],y
	STA.w !RAM_MPAINT_Canvas_CanvasGFXBuffer,y
	DEY
	DEY
	BPL.b CODE_01EC91
	PLA
	PLA
CODE_01EC9C:
	PLD
	PLB
	RTS

DATA_01EC9F:
	dw DATA_0EA000>>16,DATA_0EA000
	dw DATA_13A000>>16,DATA_13A000
	dw DATA_14A000>>16,DATA_14A000
	dw DATA_15A000>>16,DATA_15A000

;--------------------------------------------------------------------

CODE_01ECAF:
	LDA.w #$0009
	JSL.l CODE_01D368
	LDA.w #$0004
	PHA
	LDA.b $AA
	PHA
	LDA.w #$0001
	PHA
	JSL.l CODE_00A097
	JSL.l CODE_008B14
	LDA.b $AA
	PHA
	LDA.w #$0000
	PHA
	JSL.l CODE_00A097
	RTS

;--------------------------------------------------------------------

CODE_01ECD5:
	LDX.w #$0000
	LDA.w #$FFFF
CODE_01ECDB:
	STA.l $7F0004,x
	INX
	INX
	CPX.w #$0200
	BNE.b CODE_01ECDB
	LDX.w #$0000
CODE_01ECE9:
	STA.l $7F0204,x
	STA.l $7F0304,x
	STA.l $7F0404,x
	INX
	INX
	CPX.w #$0100
	BNE.b CODE_01ECE9
	STZ.b $16
	STZ.b $18
	STZ.b $1A
	RTS

;--------------------------------------------------------------------

CODE_01ED03:
	PHX
	PHY
	LDX.b $18
	LDA.w $4400,x
	EOR.w $4401,x
	EOR.w $4402,x
	AND.w #$00FF
	ASL
	STA.b $1A
	LDX.b $16
	LDA.l $7F0304,x
	BMI.b CODE_01ED52
	PHA
	AND.w #$4000
	BNE.b CODE_01ED3A
	LDA.l $7F0304,x
	TAY
	LDA.l $7F0204,x
	PLX
	STA.l $7F0204,x
	TAX
	TYA
	STA.l $7F0304,x
	BRA.b CODE_01ED52

CODE_01ED3A:
	PLA
	AND.w #$01FF
	PHA
	LDA.l $7F0204,x
	PLX
	STA.l $7F0004,x
	TAY
	TXA
	ORA.w #$4000
	TYX
	STA.l $7F0304,x
CODE_01ED52:
	LDX.b $1A
	LDA.l $7F0004,x
	BPL.b CODE_01ED79
	LDA.b $16
	STA.l $7F0004,x
	TXA
	LDX.b $16
	ORA.w #$4000
	STA.l $7F0304,x
	LDA.w #$FFFF
	STA.l $7F0204,x
	LDA.b $18
	STA.l $7F0404,x
	BRA.b CODE_01ED9A

CODE_01ED79:
	TAX
	LDA.l $7F0204,x
	BPL.b CODE_01ED79
	LDA.b $16
	STA.l $7F0204,x
	TXA
	LDX.b $16
	STA.l $7F0304,x
	LDA.w #$FFFF
	STA.l $7F0204,x
	LDA.b $18
	STA.l $7F0404,x
CODE_01ED9A:
	INX
	INX
	CPX.w #$0100
	BNE.b CODE_01EDA4
	LDX.w #$0000
CODE_01EDA4:
	STX.b $16
	INC.b $18
	PLY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_01EDAB:
	LDA.w $7E4400,x
	EOR.w $7E4401,x
	EOR.w $7E4402,x
	AND.w #$00FF
	ASL
	TAX
	LDA.l $7F0004,x
	BMI.b CODE_01EDC8
	TAX
	LDA.l $7F0404,x
	STX.b $1C
	SEC
	RTS

CODE_01EDC8:
	CLC
	RTS

CODE_01EDCA:
	LDX.b $1C
	LDA.l $7F0204,x
	BMI.b CODE_01EDC8
	TAX
	LDA.l $7F0404,x
	STX.b $1C
	SEC
	RTS

CODE_01EDDB:					; Note: Save routine?
	SEP.b #$20
	PHB
	LDA.b #$7E4400>>16
	PHA
	PLB
	REP.b #$20
	PHD
	TSC
	SEC
	SBC.w #$001E
	TCS
	TCD
	JSR.w CODE_01ECD5
	LDA.w #$BA52
	STA.b $14
	LDX.w #$FEFC
	STX.b $0E
	LDX.w #$2000
	STX.b $10
	STX.b $12
	LDA.w #$0001
	STA.l $7F0000,x
	INX
	INX
	SEP.b #$20
	LDA.w $4400
	STA.l $7F0000,x
	REP.b #$20
	INX
	STX.b $02
	LDY.w #$0001
	STY.b $04
	JSR.w CODE_01EFB9
	JSR.w CODE_01ED03
CODE_01EE22:
	STZ.b $0A
	LDX.b $04
	JSR.w CODE_01EDAB
	BCC.b CODE_01EE6B
CODE_01EE2B:
	STA.b $06
	TAX
	LDY.b $04
	STZ.b $08
CODE_01EE32:
	SEP.b #$20
	LDA.w $7E4400,y
	CMP.w $7E4400,x
	BNE.b CODE_01EE53
	REP.b #$20
	INY
	INX
	INC.b $08
	LDA.b $08
	CMP.w #$0012
	BNE.b CODE_01EE32
	LDA.b $08
	STA.b $0A
	LDA.b $06
	STA.b $0C
	BRA.b CODE_01EE6D

CODE_01EE53:
	REP.b #$20
	LDA.b $08
	CMP.b $0A
	BCC.b CODE_01EE61
	STA.b $0A
	LDA.b $06
	STA.b $0C
CODE_01EE61:
	JSR.w CODE_01EDCA
	BCS.b CODE_01EE2B
	LDA.b $0A
	CMP.w #$0004
CODE_01EE6B:
	BCC.b CODE_01EEB2
CODE_01EE6D:
	LDY.b $0A
CODE_01EE6F:
	JSR.w CODE_01EFB9
	JSR.w CODE_01ED03
	DEY
	BNE.b CODE_01EE6F
	LDY.b $02
	LDX.b $12
	LDA.l $7F0000,x
	BNE.b CODE_01EE84
	DEY
	DEY
CODE_01EE84:
	TYX
	LDA.b $04
	SEC
	SBC.b $0C
	STA.b $0C
	LDA.b $0A
	XBA
	ORA.b $0C
	ORA.w #$8000
	STA.l $7F0000,x
	INX
	INX
	LDA.w #$0000
	STA.l $7F0000,x
	STX.b $12
	INX
	INX
	CPX.b $0E
	BCS.b CODE_01EEFA
	STX.b $02
	LDA.b $0A
	ADC.b $04
	TAY
	BRA.b CODE_01EEFD

CODE_01EEB2:
	LDX.b $02
	LDY.b $04
	SEP.b #$20
	LDA.w $7E4400,y
	STA.l $7F0000,x
	REP.b #$20
	INX
	STX.b $02
	LDX.b $12
	LDA.l $7F0000,x
	INC
	STA.l $7F0000,x
	BPL.b CODE_01EEF0
	DEC
	STA.l $7F0000,x
	LDX.b $02
	LDA.w #$0000
	STA.l $7F0000,x
	STX.b $12
	INX
	INX
	SEP.b #$20
	LDA.w $7E4400,y
	STA.l $7F0000,x
	REP.b #$20
	STX.b $02
CODE_01EEF0:
	JSR.w CODE_01EFB9
	JSR.w CODE_01ED03
	LDX.b $02
	CPX.b $0E
CODE_01EEFA:
	BCS.b CODE_01EF2A
	INY
CODE_01EEFD:
	STY.b $04
	CPY.b $14
	BCS.b CODE_01EF06
	JMP.w CODE_01EE22

CODE_01EF06:
	LDA.w #$FFFF
	LDX.b $02
	DEX
	DEX
	STA.l $7F0000,x
	INX
	INX
	INX
	TXA
	SEC
	SBC.b $10
	STA.b $14
	STA.l $7F0002
	TSC
	CLC
	ADC.w #$001E
	TCS
	PLD
	LDA.w #$0000
	PLB
	RTL

CODE_01EF2A:
	TSC
	CLC
	ADC.w #$001E
	TCS
	PLD
	LDA.w #$FFFF
	PLB
	RTS

;--------------------------------------------------------------------

CODE_01EF36:
	PHB
	SEP.b #$20
	LDA.b #$7F2000>>16
	PHA
	PLB
	REP.b #$20
	PHD
	TSC
	SEC
	SBC.w #$001E
	TCS
	TCD
	LDY.w #$0000
	TYX
CODE_01EF4B:
	CPX.w #$BA52
	BCS.b CODE_01EFB0
	LDA.w $7F2000,y
	BPL.b CODE_01EF91
	LDA.w $7F2000,y
	AND.w #$00FF
	STA.b $02
	LDA.w $2000,y
	AND.w #$7F00
	XBA
	STA.b $04
	TXA
	SEC
	SBC.b $02
	PHY
	TAY
CODE_01EF6C:
	PHX
	TYX
	SEP.b #$20
	LDA.l $7E4400,x
	PLX
	STA.l $7E4400,x
	REP.b #$20
	JSR.w CODE_01EFB9
	INY
	INX
	CPX.w #$BA52
	BCC.b CODE_01EF88
	PLY
	BRA.b CODE_01EFB0

CODE_01EF88:
	DEC.b $04
	BNE.b CODE_01EF6C
	PLY
	INY
	INY
	BRA.b CODE_01EF4B

CODE_01EF91:
	STA.b $04
	INY
	INY
CODE_01EF95:
	SEP.b #$20
	LDA.w $7F2000,y
	STA.l $7E4400,x
	REP.b #$20
	JSR.w CODE_01EFB9
	INX
	INY
	CPX.w #$BA52
	BCS.b CODE_01EFB0
	DEC.b $04
	BNE.b CODE_01EF95
	BRA.b CODE_01EF4B

CODE_01EFB0:
	TSC
	CLC
	ADC.w #$001E
	TCS
	PLD
	PLB
	RTL

;--------------------------------------------------------------------

CODE_01EFB9:
	LDA.l $000555
	CLC
	ADC.l $000551
	STA.l $000555
	LDA.l $000557
	ADC.l $000553
	STA.l $000557
	LDA.l $00016C
	CMP.l $00054D
	BCS.b CODE_01EFDD
	RTS

CODE_01EFDD:
	PHX
	PHY
	LDA.w #$0000
	STA.l $00016C
	PHK
	PEA.w CODE_01F00D-$01
	SEP.b #$20
	LDA.l $00054B
	PHA
	REP.b #$20
	LDA.l $000549
	PHA
	LDA.w #$0004
	STA.l $000446
	JSL.l CODE_01E30E
CODE_01F003:
	LDA.l !REGISTER_HVBlankFlagsAndJoypadStatus
	BIT.w #$0080
	BNE.b CODE_01F003
	RTL

CODE_01F00D:
	JSL.l CODE_01E09B
	JSL.l CODE_01E2F3
	PLY
	PLX
	RTS

;--------------------------------------------------------------------

CODE_01F018:
	LDX.w #$0004
	LDY.w #$FFFF
CODE_01F01E:
	LDA.w $0A04,x
	BNE.b CODE_01F02F
	TYA
	CMP.w $0A06,x
	BCC.b CODE_01F02F
	LDY.w $0A06,x
	STX.w $1C08
CODE_01F02F:
	INX
	INX
	INX
	INX
	TXA
	CMP.w $1C0E
	BNE.b CODE_01F01E
	RTS

;--------------------------------------------------------------------

CODE_01F03A:
	PHB
	PEA.w $7F7F
	PLB
	PLB
	PHD
	TSC
	SEC
	SBC.w #$0010
	TCS
	TCD
	LDA.b $17
	INC
	AND.w #$FFFE
	TAX
	LDY.w #$E000
CODE_01F052:
	LDA.w $7F1FFE,x
	STA.w $7F1FFE,y
	DEY
	DEY
	DEX
	DEX
	BNE.b CODE_01F052
	STY.b $01
	LDX.w #$0200
CODE_01F063:
	STZ.w $7F0000,x
	DEX
	DEX
	BPL.b CODE_01F063
	LDY.b $01
CODE_01F06C:
	JSR.w CODE_01EFB9
	LDA.w $7F1FFF,y
	AND.w #$00FF
	ASL
	TAX
	INC.w $7F0000,x
	INY
	CPY.w #$E000
	BNE.b CODE_01F06C
	LDX.w #$0004
	LDY.w #$0000
CODE_01F086:
	STZ.w $7F0200,x
	STZ.w $7F0A04,x
	INX
	INX
	TYA
	STA.w $7F0200,x
	ASL
	PHX
	TAX
	LDA.w $7F0000,x
	PLX
	STA.w $7F0A04,x
	INY
	INX
	INX
	CPY.w #$0100
	BNE.b CODE_01F086
CODE_01F0A4:
	STZ.w $7F0200,x
	STZ.w $7F0A04,x
	INX
	INX
	STZ.w $7F0200,x
	STZ.w $7F0A04,x
	INX
	INX
	CPX.w #$0800
	BNE.b CODE_01F0A4
	LDA.w #$0404
	STA.w $7F1C0E
CODE_01F0BF:
	JSR.w CODE_01EFB9
	JSR.w CODE_01F018
	LDX.w $7F1C08
	LDA.w #$0001
	STA.w $7F0A04,x
	TXA
	LDX.w $7F1C0E
	STA.w $7F0200,x
	TYA
	STA.w $7F0A06,x
	JSR.w CODE_01F018
	TYA
	CMP.w #$FFFF
	BEQ.b CODE_01F106
	LDX.w $7F1C08
	LDA.w #$0001
	STA.w $7F0A04,x
	TXA
	LDX.w $7F1C0E
	STA.w $7F0202,x
	TYA
	CLC
	ADC.w $7F0A06,x
	STA.w $7F0A06,x
	LDA.w $7F1C0E
	CLC
	ADC.w #$0004
	STA.w $7F1C0E
	BRA.b CODE_01F0BF

CODE_01F106:
	LDY.w #$0000
	STY.w $7F1C0A
	LDA.w #$0004
	STA.w $7F1C0C
CODE_01F112:
	JSR.w CODE_01EFB9
	LDA.w $7F1C0A
	STA.w $7F1208,y
	LDX.w $7F1C0A
	STZ.w $7F1408,x
	STZ.w $7F1409,x
	LDA.w $7F1C0C
	LDX.w #$0404
CODE_01F12A:
	CMP.w $7F0200,x
	BNE.b CODE_01F13E
	PHX
	LDX.w $7F1C0A
	INC.w $7F1408,x
	CLC
	ROL.w $7F1409,x
	PLX
	TXA
	BRA.b CODE_01F15D

CODE_01F13E:
	CMP.w $7F0202,x
	BNE.b CODE_01F152
	PHX
	LDX.w $7F1C0A
	INC.w $7F1408,x
	SEC
	ROL.w $7F1409,x
	PLX
	TXA
	BRA.b CODE_01F15D

CODE_01F152:
	INX
	INX
	INX
	INX
	CPX.w $7F1C0E
	BEQ.b CODE_01F162
	BRA.b CODE_01F12A

CODE_01F15D:
	LDX.w #$0404
	BRA.b CODE_01F12A

CODE_01F162:
	LDA.w $7F1C0A
	CLC
	ADC.w #$0003
	STA.w $7F1C0A
	LDA.w $7F1C0C
	CLC
	ADC.w #$0004
	STA.w $7F1C0C
	INY
	INY
	CMP.w #$0404
	BNE.b CODE_01F112
	LDA.w #$0010
	STA.b $05
	STZ.w $7F2800
	STZ.b $03
CODE_01F187:
	LDX.b $01
	LDA.w $7F2000,x
	AND.w #$00FF
	ASL
	TAX
	LDA.w $7F1208,x
	TAX
	LDA.w $7F1408,x
	AND.w #$00FF
	TAY
	LDA.w $7F1409,x
	ROR
	LDX.b $03
CODE_01F1A2:
	ROL.w $7F2800,x
	DEC.b $05
	BNE.b CODE_01F1BD
	PHA
	LDA.w #$0010
	STA.b $05
	PLA
	INC.b $03
	INC.b $03
	LDX.b $03
	CPX.b $01
	BEQ.b CODE_01F211
	STZ.w $7F2800,x
CODE_01F1BD:
	ROR
	DEY
	BNE.b CODE_01F1A2
	INC.b $01
	JSR.w CODE_01EFB9
	LDA.b $01
	CMP.w #$E000
	BNE.b CODE_01F187
	LDX.b $03
CODE_01F1CF:
	CLC
	ROL.w $7F2800,x
	DEC.b $05
	BNE.b CODE_01F1CF
	LDX.w $7F1C0E
	DEX
	DEX
	LDA.w $7F0200,x
	STA.w $7F2002
	DEX
	DEX
	LDA.w $7F0200,x
	STA.w $7F2000
	LDX.w #$0004
CODE_01F1ED:
	LDA.w $7F0200,x
	STA.w $7F2000,x
	INX
	INX
	CPX.w #$0800
	BNE.b CODE_01F1ED
	LDA.b $03
	CLC
	ADC.w #$0801
	AND.w #$FFFE
	STA.b $17
	TSC
	CLC
	ADC.w #$0010
	TCS
	LDA.w #$0000
	PLD
	PLB
	RTL

CODE_01F211:
	TSC
	CLC
	ADC.w #$0010
	TCS
	LDA.w #$FFFF
	PLD
	PLB
	RTL

;--------------------------------------------------------------------

CODE_01F21D:
	PHB
	PEA.w $7F7F
	PLB
	PLB
	PHD
	TSC
	SEC
	SBC.w #$0010
	TCS
	TCD
	LDX.w #$07FE
CODE_01F22E:
	LDA.w $7F2000,x
	STA.w $7F0200,x
	DEX
	DEX
	BPL.b CODE_01F22E
	LDA.b $17
	SEC
	SBC.w #$0800
	TAX
	LDY.w #$D800
CODE_01F242:
	LDA.w $7F27FE,x
	STA.w $7F27FE,y
	DEY
	DEY
	DEX
	DEX
	BNE.b CODE_01F242
	STY.b $01
	STZ.b $03
	LDA.w #$0011
	STA.b $07
CODE_01F257:
	STZ.b $05
CODE_01F259:
	DEC.b $07
	BNE.b CODE_01F273
	INC.b $01
	INC.b $01
	JSR.w CODE_01EFB9
	LDA.b $01
	CMP.w #$D800
	BNE.b CODE_01F26E
	JMP.w CODE_01F2B7

CODE_01F26E:
	LDA.w #$0010
	STA.b $07
CODE_01F273:
	LDX.b $01
	ROL.w $7F2800,x
	BCS.b CODE_01F289
	LDX.b $05
	LDA.w $7F0200,x
	STA.b $05
	TAX
	LDA.w $7F0200,x
	BEQ.b CODE_01F298
	BRA.b CODE_01F259

CODE_01F289:
	LDX.b $05
	LDA.w $7F0202,x
	STA.b $05
	TAX
	LDA.w $7F0200,x
	BEQ.b CODE_01F298
	BRA.b CODE_01F259

CODE_01F298:
	LDA.w $7F0202,x
	LDX.b $03
	STA.w $7F2000,x
	INC.b $03
	LDA.b $03
	CMP.b $01
	BEQ.b CODE_01F2AB
	JMP.w CODE_01F257

CODE_01F2AB:
	TSC
	CLC
	ADC.w #$0010
	TCS
	LDA.w #$FFFF
	PLD
	PLB
	RTL

CODE_01F2B7:
	LDA.b $03
	STA.b $17
	TSC
	CLC
	ADC.w #$0010
	TCS
	LDA.w #$0000
	PLD
	PLB
	RTL

	%FREE_BYTES(NULLROM, 1337, $00)

;--------------------------------------------------------------------

CODE_01F800:
	ASL
	ASL
	ASL
	AND.w #$00FF
	TAX
	LDA.w $1A10,x
	AND.w #$FF80
	CMP.w #$8000
	ROL
	XBA
	PHA
	LDA.w $1A12,x
	AND.w #$FF00
	XBA
	TAY
	LDA.w $1A14,x
	AND.w #$00FF
	PLX
	JMP.w CODE_01F91E

;--------------------------------------------------------------------

CODE_01F825:
	PHP
	PHB
	PHA
	SEP.b #$20
	LDA.b #$001A00>>16
	PHA
	PLB
	REP.b #$20
	PLA
	ASL
	ASL
	ASL
	TAX
	AND.w #$00FF
	TAY
	LDA.w #$0004
CODE_01F83C:
	PHA
	LDA.l DATA_0DEB22,x
	STA.w $1A10,y
	INX
	INX
	INY
	INY
	PLA
	DEC
	BNE.b CODE_01F83C
	PLB
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01F84F:
	PHP
	REP.b #$30
	PHD
	PHA
	TSC
	SEC
	SBC.w #$0010
	TCS
	TCD
	PHB
	SEP.b #$20
	LDA.b #$00
	PHA
	PLB
	REP.b #$20
	LDA.w #DATA_0DED92>>16
	STA.b $0B
	LDA.b $11
	ASL
	TAY
	ASL
	ASL
	AND.w #$00FF
	TAX
	LDA.w $1A10,x
	AND.w #$FF80
	CMP.w #$8000
	ROL
	XBA
	STA.b $01
	LDA.w $1A12,x
	AND.w #$FF00
	XBA
	STA.b $03
	PHX
	TYX
	LDA.l DATA_0DED92,x
	STA.b $09
	LDY.w #$0000
	LDA.b [$09],y
	STA.b $07
	INC.b $09
	INC.b $09
	PLX
	SEP.b #$20
	LDA.w $1A15,x
	CMP.b #$FF
	BNE.b CODE_01F8D4
CODE_01F8A6:
	INC.w $1A16,x
	REP.b #$20
	LDA.w $1A16,x
	AND.w #$00FF
	INC
	ASL
	ASL
	DEC
	TAY
	SEP.b #$20
	LDA.b [$09],y
	BNE.b CODE_01F8C4
	LDA.w $1A16,x
	STA.w $1A17,x
	BRA.b CODE_01F8A6

CODE_01F8C4:
	CMP.b #$FF
	BNE.b CODE_01F8D0
	LDA.w $1A17,x
	STA.w $1A16,x
	BRA.b CODE_01F8A6

CODE_01F8D0:
	DEC
	STA.w $1A15,x
CODE_01F8D4:
	REP.b #$20
	LDA.w $1A16,x
	AND.w #$00FF
	ASL
	ASL
	TAY
	LDA.b [$09],y
	CLC
	ADC.b $01
	AND.w #$00FF
	STA.b $01
	INY
	LDA.b [$09],y
	AND.w #$00FF
	CLC
	ADC.b $03
	STA.b $03
	INY
	LDA.b [$09],y
	AND.w #$00FF
	STA.b $05
	SEP.b #$20
	DEC.w $1A15,x
	REP.b #$20
	LDA.b $05
	CMP.w #$00FF
	BEQ.b CODE_01F914
	ORA.b $07
	LDX.b $01
	LDY.b $03
	JSL.l CODE_01F91E
CODE_01F914:
	PLB
	TSC
	CLC
	ADC.w #$0012
	TCS
	PLD
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01F91E:
	PHP
	REP.b #$30
	PHD
	PHA
	TSC
	SEC
	SBC.w #$0010
	TCS
	TCD
	PHB
	SEP.b #$20
	LDA.b #DATA_0DB018>>16
	PHA
	PLB
	REP.b #$20
	STX.b $01
	STY.b $03
	LDA.b $11
	ASL
	TAX
	LDA.w DATA_0DB018,x
	STA.b $05
	LDY.w #$0000
	LDA.b ($05),y
	INY
	INY
	STA.b $09
	LDX.w $0446
CODE_01F94C:
	CPX.w #$0200
	BCS.b CODE_01F9AE
	LDA.b ($05),y
	INY
	INY
	PHA
	CLC
	ADC.b $01
	AND.w #$01FF
	STA.b $07
	PLA
	AND.w #$0200
	ORA.b $07
	STA.b $07
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	PHY
	PHX
	TXA
	LSR
	LSR
	STA.b $0B
	LSR
	LSR
	AND.w #$FFFE
	PHA
	LDA.b $0B
	AND.w #$0007
	ASL
	TAY
	LDA.b $08
	AND.w #$0003
	ASL
	TAX
	LDA.w DATA_0DB000,x
	PLX
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	AND.w DATA_0DB008,y
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	PLX
	PLY
	LDA.b ($05),y
	INY
	CLC
	ADC.b $03
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	LDA.b ($05),y
	INY
	INY
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	DEC.b $09
	BNE.b CODE_01F94C
CODE_01F9AE:
	STX.w $0446
	PLB
	TSC
	CLC
	ADC.w #$0012
	TCS
	PLD
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01F9BB:
	PHP
	REP.b #$30
	PHD
	PHA
	TSC
	SEC
	SBC.w #$0010
	TCS
	TCD
	PHB
	SEP.b #$20
	LDA.b #DATA_0DB018>>16
	PHA
	PLB
	REP.b #$20
	STX.b $01
	STY.b $03
	LDA.b $11
	ASL
	TAX
	LDA.w DATA_0DB018,x
	STA.b $05
	LDY.w #$0000
	LDA.b ($05),y
	INY
	INY
	STA.b $09
	LDX.w $0446
CODE_01F9E9:
	CPX.w #$0200
	BCS.b CODE_01FA5B
	LDA.b ($05),y
	INY
	INY
	PHA
	CLC
	ADC.b $01
	AND.w #$01FF
	STA.b $07
	CMP.w #$0100
	BCC.b CODE_01FA0B
	CMP.w #$01C0
	BCS.b CODE_01FA0B
	PLA
	INY
	INY
	INY
	BRA.b CODE_01FA57

CODE_01FA0B:
	PLA
	AND.w #$0200
	ORA.b $07
	STA.b $07
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	PHY
	PHX
	TXA
	LSR
	LSR
	STA.b $0B
	LSR
	LSR
	AND.w #$FFFE
	PHA
	LDA.b $0B
	AND.w #$0007
	ASL
	TAY
	LDA.b $08
	AND.w #$0003
	ASL
	TAX
	LDA.w DATA_0DB000,x
	PLX
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	AND.w DATA_0DB008,y
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	PLX
	PLY
	LDA.b ($05),y
	INY
	CLC
	ADC.b $03
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	LDA.b ($05),y
	INY
	INY
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
CODE_01FA57:
	DEC.b $09
	BNE.b CODE_01F9E9
CODE_01FA5B:
	STX.w $0446
	PLB
	TSC
	CLC
	ADC.w #$0012
	TCS
	PLD
	PLP
	RTL

;--------------------------------------------------------------------

CODE_01FA68:
	PHP
	REP.b #$30
	PHD
	PHA
	TSC
	SEC
	SBC.w #$0020
	TCS
	TCD
	PHB
	SEP.b #$20
	LDA.b #DATA_0DB018>>16
	PHA
	PLB
	REP.b #$20
	STX.b $01
	STY.b $03
	LDA.b $21
	PHA
	AND.w #$C000
	STA.b $13
	LDA.b $01,S
	AND.w #$3000
	STA.b $15
	PLA
	ASL
	ROR.b $0D
	ASL
	ROR.b $0F
	AND.w #$3FFF
	LSR
	TAX
	LDA.w DATA_0DB018,x
	STA.b $05
	LDY.w #$0000
	LDA.b ($05),y
	INY
	INY
	STA.b $09
	LDX.w $0446
CODE_01FAAD:
	CPX.w #$0200
	BCC.b CODE_01FAB5
	JMP.w CODE_01FB5B

CODE_01FAB5:
	LDA.b ($05),y
	INY
	INY
	PHA
	BIT.w #$0200
	BNE.b CODE_01FAC6
	LDA.w $012E
	STA.b $11
	BRA.b CODE_01FACB

CODE_01FAC6:
	LDA.w $0130
	STA.b $11
CODE_01FACB:
	LDA.b $0F
	BPL.b CODE_01FADA
	LDA.b $01,S
	EOR.w #$01FF
	INC
	SEC
	SBC.b $11
	BRA.b CODE_01FADC

CODE_01FADA:
	LDA.b $01,S
CODE_01FADC:
	CLC
	ADC.b $01
	AND.w #$01FF
	STA.b $07
	CMP.w #$0100
	BCC.b CODE_01FAF4
	CMP.w #$01C0
	BCS.b CODE_01FAF4
	PLA
	INY
	INY
	INY
	BRA.b CODE_01FB54

CODE_01FAF4:
	PLA
	AND.w #$0200
	ORA.b $07
	STA.b $07
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	PHY
	PHX
	TXA
	LSR
	LSR
	STA.b $0B
	LSR
	LSR
	AND.w #$FFFE
	PHA
	LDA.b $0B
	AND.w #$0007
	ASL
	TAY
	LDA.b $08
	AND.w #$0003
	ASL
	TAX
	LDA.w DATA_0DB000,x
	PLX
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	AND.w DATA_0DB008,y
	EOR.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	STA.w MPAINT_Global_UpperOAMBuffer[$00].Slot,x
	PLX
	PLY
	LDA.b ($05),y
	INY
	PHA
	LDA.b $0D
	BPL.b CODE_01FB3F
	PLA
	EOR.w #$00FF
	INC
	SEC
	SBC.b $11
	BRA.b CODE_01FB40

CODE_01FB3F:
	PLA
CODE_01FB40:
	CLC
	ADC.b $03
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	LDA.b ($05),y
	INY
	INY
	EOR.b $13
	ORA.b $15
	STA.w MPAINT_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
CODE_01FB54:
	DEC.b $09
	BEQ.b CODE_01FB5B
	JMP.w CODE_01FAAD

CODE_01FB5B:
	STX.w $0446
	PLB
	TSC
	CLC
	ADC.w #$0022
	TCS
	PLD
	PLP
	RTL

;--------------------------------------------------------------------

%FREE_BYTES(NULLROM, 1176, $00)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank02Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_028000:
	incbin "Tilemaps/CanvasBorder.bin"

DATA_028580:
	incbin "Tilemaps/4FrameAnimationCanvasBorders.bin"

DATA_028B00:
	incbin "Tilemaps/6FrameAnimationCanvasBorders.bin"

DATA_029080:
	incbin "Tilemaps/9FrameAnimationCanvasBorders.bin"

DATA_029600:
	incbin "Tilemaps/MainDrawingToolsStatusBar.bin"
	incbin "Tilemaps/ShapeToolStatusBar.bin"
	incbin "Tilemaps/BlankAnimationToolStatusBar.bin"
	incbin "Tilemaps/AnimationDrawingToolsStatusBar1.bin"
	incbin "Tilemaps/AnimationDrawingToolsStatusBar2.bin"
	incbin "Tilemaps/BlankAnimationPathToolsStatusBar.bin"
	incbin "Tilemaps/PlayAnimationToolsStatusBar.bin"
	incbin "Tilemaps/MainMiscOptionsStatusBar.bin"
	incbin "Tilemaps/LetterToolStatusBar.bin"
	incbin "Tilemaps/FillCanvasToolStatusBar.bin"
	incbin "Tilemaps/SpecialStampToolStatusBar.bin"
	incbin "Tilemaps/MusicToolStatusBar.bin"
	incbin "Tilemaps/BlankSaveLoadMenuStatusBar.bin"
	incbin "Tilemaps/BlankMouseSpeedMenuStatusBar.bin"
	incbin "Tilemaps/BlankMusicSelectionMenuStatusBar.bin"
	incbin "Tilemaps/UnknownStatusBar.bin"
	incbin "Tilemaps/ColoringBookMenuStatusBar.bin"

DATA_02A2C0:
	incbin "Tilemaps/AnimationLandMenu.bin"

DATA_02A7C0:
	incbin "Tilemaps/MouseSpeedMenu.bin"

DATA_02AC80:
	incbin "Tilemaps/MusicSelectionMenu.bin"

DATA_02B180:
	incbin "Tilemaps/SpecialStampsScreen.bin"

DATA_02B700:
	incbin "Tilemaps/SaveLoadMenu.bin"

DATA_02BC00:
	incbin "Tilemaps/MusicToolScreen_Layer1.bin"

DATA_02C100:
	incbin "Tilemaps/MusicToolScreen_Layer2.bin"

DATA_02C480:
	incbin "Tilemaps/TitleScreenFlowerGarden.bin"

cleartable
table Tables/CreditsText.txt

DATA_02C700:
	dw "          MARIO PAINT           "
	dw "             STAFF              "
	dw "        GRAPHIC DESIGNER        "
	dw "       HIROFUMI MATSUOKA        "
	dw "           PROGRAMMER           "
	dw "        NORIAKI TERAMOTO        "
	dw "           KENJI IMAI           "
	dw "         KENJI NAKAJIMA         "
	dw "          GENJI KUBOTA          "
	dw "          SOUND STAFF           "
	dw "        HIROKAZU TANAKA         "
	dw "         KAZUMI TOTAKA          "
	dw "        RYOJI YOSHITOMI         "
	dw "            DIRECTOR            "
	dw "       HIROFUMI MATSUOKA        "
	dw "          MOUSE MAKER           "
	dw "             STAFF              "
	dw "          HIDEO NAGATA          "
	dw "         KATSUYA YAMANO         "
	dw "        HITOSHI YAMAGAMI        "
	dw "        NOBORU WAKITANI         "
	dw "            DIRECTOR            "
	dw "          SATORU OKADA          "
	dw "       SPECIAL THANKS TO        "
	dw "         FUJIKO NOMURA          "
	dw "        TOMOYOSHI YAMANE        "
	dw "          YASUO INOUE           "
	dw "          KOUTA FUKUI           "
	dw "       YOSHINORI KATSUKI        "
	dw "          ISAO HIRANO           "
	dw "          KENJI YAMADA          "
	dw "          NAOKI NAKANO          "
	dw "          KEIJI NANBA           "
	dw "       MITSUHITO FUKUTOME       "
	dw "       TOSHIAKI YONEZAWA        "
	dw "          ISAMU KUBOTA          "
	dw "        KUMIKO MATSUMOTO        "
	dw "        HIRONOBU SUZUKI         "
	dw "        MAKOTO KATAYAMA         "
	dw "         YOSHIKAZU MORI         "
	dw "          JEFFERY HUTT          "
	dw "           DON JAMES            "
	dw "          TONY HARMAN           "
	dw "          STEVE MILES           "
	dw "          PHIL SANDHOP          "
	dw "          HIRO YAMADA           "
	dw "          YUKA NAKATA           "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "
	dw "                                "

cleartable

DATA_02E000:							; Note: This data affects how the different tools draw.
	db $00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$00,$00
	db $02,$01,$00,$00,$00,$00,$00,$00,$03,$01,$00,$00,$00,$00,$00,$00
	db $04,$02,$01,$00,$00,$00,$00,$00,$05,$02,$01,$00,$00,$00,$00,$00
	db $06,$03,$01,$00,$00,$00,$00,$00,$07,$03,$01,$00,$00,$00,$00,$00
	db $08,$04,$02,$01,$00,$00,$00,$00,$09,$04,$02,$01,$00,$00,$00,$00
	db $0A,$05,$02,$01,$00,$00,$00,$00,$0B,$05,$02,$01,$00,$00,$00,$00
	db $0C,$06,$03,$01,$00,$00,$00,$00,$0D,$06,$03,$01,$00,$00,$00,$00
	db $0E,$07,$03,$01,$00,$00,$00,$00,$0F,$07,$03,$01,$00,$00,$00,$00
	db $10,$08,$04,$02,$01,$00,$00,$00,$11,$08,$04,$02,$01,$00,$00,$00
	db $12,$09,$04,$02,$01,$00,$00,$00,$13,$09,$04,$02,$01,$00,$00,$00
	db $14,$0A,$05,$02,$01,$00,$00,$00,$15,$0A,$05,$02,$01,$00,$00,$00
	db $16,$0B,$05,$02,$01,$00,$00,$00,$17,$0B,$05,$02,$01,$00,$00,$00
	db $18,$0C,$06,$03,$01,$00,$00,$00,$19,$0C,$06,$03,$01,$00,$00,$00
	db $1A,$0D,$06,$03,$01,$00,$00,$00,$1B,$0D,$06,$03,$01,$00,$00,$00
	db $1C,$0E,$07,$03,$01,$00,$00,$00,$1D,$0E,$07,$03,$01,$00,$00,$00
	db $1E,$0F,$07,$03,$01,$00,$00,$00,$1F,$0F,$07,$03,$01,$00,$00,$00
	db $20,$10,$08,$04,$02,$01,$00,$00,$21,$10,$08,$04,$02,$01,$00,$00
	db $22,$11,$08,$04,$02,$01,$00,$00,$23,$11,$08,$04,$02,$01,$00,$00
	db $24,$12,$09,$04,$02,$01,$00,$00,$25,$12,$09,$04,$02,$01,$00,$00
	db $26,$13,$09,$04,$02,$01,$00,$00,$27,$13,$09,$04,$02,$01,$00,$00
	db $28,$14,$0A,$05,$02,$01,$00,$00,$29,$14,$0A,$05,$02,$01,$00,$00
	db $2A,$15,$0A,$05,$02,$01,$00,$00,$2B,$15,$0A,$05,$02,$01,$00,$00
	db $2C,$16,$0B,$05,$02,$01,$00,$00,$2D,$16,$0B,$05,$02,$01,$00,$00
	db $2E,$17,$0B,$05,$02,$01,$00,$00,$2F,$17,$0B,$05,$02,$01,$00,$00
	db $30,$18,$0C,$06,$03,$01,$00,$00,$31,$18,$0C,$06,$03,$01,$00,$00
	db $32,$19,$0C,$06,$03,$01,$00,$00,$33,$19,$0C,$06,$03,$01,$00,$00
	db $34,$1A,$0D,$06,$03,$01,$00,$00,$35,$1A,$0D,$06,$03,$01,$00,$00
	db $36,$1B,$0D,$06,$03,$01,$00,$00,$37,$1B,$0D,$06,$03,$01,$00,$00
	db $38,$1C,$0E,$07,$03,$01,$00,$00,$39,$1C,$0E,$07,$03,$01,$00,$00
	db $3A,$1D,$0E,$07,$03,$01,$00,$00,$3B,$1D,$0E,$07,$03,$01,$00,$00
	db $3C,$1E,$0F,$07,$03,$01,$00,$00,$3D,$1E,$0F,$07,$03,$01,$00,$00
	db $3E,$1F,$0F,$07,$03,$01,$00,$00,$3F,$1F,$0F,$07,$03,$01,$00,$00
	db $40,$20,$10,$08,$04,$02,$01,$00,$41,$20,$10,$08,$04,$02,$01,$00
	db $42,$21,$10,$08,$04,$02,$01,$00,$43,$21,$10,$08,$04,$02,$01,$00
	db $44,$22,$11,$08,$04,$02,$01,$00,$45,$22,$11,$08,$04,$02,$01,$00
	db $46,$23,$11,$08,$04,$02,$01,$00,$47,$23,$11,$08,$04,$02,$01,$00
	db $48,$24,$12,$09,$04,$02,$01,$00,$49,$24,$12,$09,$04,$02,$01,$00
	db $4A,$25,$12,$09,$04,$02,$01,$00,$4B,$25,$12,$09,$04,$02,$01,$00
	db $4C,$26,$13,$09,$04,$02,$01,$00,$4D,$26,$13,$09,$04,$02,$01,$00
	db $4E,$27,$13,$09,$04,$02,$01,$00,$4F,$27,$13,$09,$04,$02,$01,$00
	db $50,$28,$14,$0A,$05,$02,$01,$00,$51,$28,$14,$0A,$05,$02,$01,$00
	db $52,$29,$14,$0A,$05,$02,$01,$00,$53,$29,$14,$0A,$05,$02,$01,$00
	db $54,$2A,$15,$0A,$05,$02,$01,$00,$55,$2A,$15,$0A,$05,$02,$01,$00
	db $56,$2B,$15,$0A,$05,$02,$01,$00,$57,$2B,$15,$0A,$05,$02,$01,$00
	db $58,$2C,$16,$0B,$05,$02,$01,$00,$59,$2C,$16,$0B,$05,$02,$01,$00
	db $5A,$2D,$16,$0B,$05,$02,$01,$00,$5B,$2D,$16,$0B,$05,$02,$01,$00
	db $5C,$2E,$17,$0B,$05,$02,$01,$00,$5D,$2E,$17,$0B,$05,$02,$01,$00
	db $5E,$2F,$17,$0B,$05,$02,$01,$00,$5F,$2F,$17,$0B,$05,$02,$01,$00
	db $60,$30,$18,$0C,$06,$03,$01,$00,$61,$30,$18,$0C,$06,$03,$01,$00
	db $62,$31,$18,$0C,$06,$03,$01,$00,$63,$31,$18,$0C,$06,$03,$01,$00
	db $64,$32,$19,$0C,$06,$03,$01,$00,$65,$32,$19,$0C,$06,$03,$01,$00
	db $66,$33,$19,$0C,$06,$03,$01,$00,$67,$33,$19,$0C,$06,$03,$01,$00
	db $68,$34,$1A,$0D,$06,$03,$01,$00,$69,$34,$1A,$0D,$06,$03,$01,$00
	db $6A,$35,$1A,$0D,$06,$03,$01,$00,$6B,$35,$1A,$0D,$06,$03,$01,$00
	db $6C,$36,$1B,$0D,$06,$03,$01,$00,$6D,$36,$1B,$0D,$06,$03,$01,$00
	db $6E,$37,$1B,$0D,$06,$03,$01,$00,$6F,$37,$1B,$0D,$06,$03,$01,$00
	db $70,$38,$1C,$0E,$07,$03,$01,$00,$71,$38,$1C,$0E,$07,$03,$01,$00
	db $72,$39,$1C,$0E,$07,$03,$01,$00,$73,$39,$1C,$0E,$07,$03,$01,$00
	db $74,$3A,$1D,$0E,$07,$03,$01,$00,$75,$3A,$1D,$0E,$07,$03,$01,$00
	db $76,$3B,$1D,$0E,$07,$03,$01,$00,$77,$3B,$1D,$0E,$07,$03,$01,$00
	db $78,$3C,$1E,$0F,$07,$03,$01,$00,$79,$3C,$1E,$0F,$07,$03,$01,$00
	db $7A,$3D,$1E,$0F,$07,$03,$01,$00,$7B,$3D,$1E,$0F,$07,$03,$01,$00
	db $7C,$3E,$1F,$0F,$07,$03,$01,$00,$7D,$3E,$1F,$0F,$07,$03,$01,$00
	db $7E,$3F,$1F,$0F,$07,$03,$01,$00,$7F,$3F,$1F,$0F,$07,$03,$01,$00
	db $80,$40,$20,$10,$08,$04,$02,$01,$81,$40,$20,$10,$08,$04,$02,$01
	db $82,$41,$20,$10,$08,$04,$02,$01,$83,$41,$20,$10,$08,$04,$02,$01
	db $84,$42,$21,$10,$08,$04,$02,$01,$85,$42,$21,$10,$08,$04,$02,$01
	db $86,$43,$21,$10,$08,$04,$02,$01,$87,$43,$21,$10,$08,$04,$02,$01
	db $88,$44,$22,$11,$08,$04,$02,$01,$89,$44,$22,$11,$08,$04,$02,$01
	db $8A,$45,$22,$11,$08,$04,$02,$01,$8B,$45,$22,$11,$08,$04,$02,$01
	db $8C,$46,$23,$11,$08,$04,$02,$01,$8D,$46,$23,$11,$08,$04,$02,$01
	db $8E,$47,$23,$11,$08,$04,$02,$01,$8F,$47,$23,$11,$08,$04,$02,$01
	db $90,$48,$24,$12,$09,$04,$02,$01,$91,$48,$24,$12,$09,$04,$02,$01
	db $92,$49,$24,$12,$09,$04,$02,$01,$93,$49,$24,$12,$09,$04,$02,$01
	db $94,$4A,$25,$12,$09,$04,$02,$01,$95,$4A,$25,$12,$09,$04,$02,$01
	db $96,$4B,$25,$12,$09,$04,$02,$01,$97,$4B,$25,$12,$09,$04,$02,$01
	db $98,$4C,$26,$13,$09,$04,$02,$01,$99,$4C,$26,$13,$09,$04,$02,$01
	db $9A,$4D,$26,$13,$09,$04,$02,$01,$9B,$4D,$26,$13,$09,$04,$02,$01
	db $9C,$4E,$27,$13,$09,$04,$02,$01,$9D,$4E,$27,$13,$09,$04,$02,$01
	db $9E,$4F,$27,$13,$09,$04,$02,$01,$9F,$4F,$27,$13,$09,$04,$02,$01
	db $A0,$50,$28,$14,$0A,$05,$02,$01,$A1,$50,$28,$14,$0A,$05,$02,$01
	db $A2,$51,$28,$14,$0A,$05,$02,$01,$A3,$51,$28,$14,$0A,$05,$02,$01
	db $A4,$52,$29,$14,$0A,$05,$02,$01,$A5,$52,$29,$14,$0A,$05,$02,$01
	db $A6,$53,$29,$14,$0A,$05,$02,$01,$A7,$53,$29,$14,$0A,$05,$02,$01
	db $A8,$54,$2A,$15,$0A,$05,$02,$01,$A9,$54,$2A,$15,$0A,$05,$02,$01
	db $AA,$55,$2A,$15,$0A,$05,$02,$01,$AB,$55,$2A,$15,$0A,$05,$02,$01
	db $AC,$56,$2B,$15,$0A,$05,$02,$01,$AD,$56,$2B,$15,$0A,$05,$02,$01
	db $AE,$57,$2B,$15,$0A,$05,$02,$01,$AF,$57,$2B,$15,$0A,$05,$02,$01
	db $B0,$58,$2C,$16,$0B,$05,$02,$01,$B1,$58,$2C,$16,$0B,$05,$02,$01
	db $B2,$59,$2C,$16,$0B,$05,$02,$01,$B3,$59,$2C,$16,$0B,$05,$02,$01
	db $B4,$5A,$2D,$16,$0B,$05,$02,$01,$B5,$5A,$2D,$16,$0B,$05,$02,$01
	db $B6,$5B,$2D,$16,$0B,$05,$02,$01,$B7,$5B,$2D,$16,$0B,$05,$02,$01
	db $B8,$5C,$2E,$17,$0B,$05,$02,$01,$B9,$5C,$2E,$17,$0B,$05,$02,$01
	db $BA,$5D,$2E,$17,$0B,$05,$02,$01,$BB,$5D,$2E,$17,$0B,$05,$02,$01
	db $BC,$5E,$2F,$17,$0B,$05,$02,$01,$BD,$5E,$2F,$17,$0B,$05,$02,$01
	db $BE,$5F,$2F,$17,$0B,$05,$02,$01,$BF,$5F,$2F,$17,$0B,$05,$02,$01
	db $C0,$60,$30,$18,$0C,$06,$03,$01,$C1,$60,$30,$18,$0C,$06,$03,$01
	db $C2,$61,$30,$18,$0C,$06,$03,$01,$C3,$61,$30,$18,$0C,$06,$03,$01
	db $C4,$62,$31,$18,$0C,$06,$03,$01,$C5,$62,$31,$18,$0C,$06,$03,$01
	db $C6,$63,$31,$18,$0C,$06,$03,$01,$C7,$63,$31,$18,$0C,$06,$03,$01
	db $C8,$64,$32,$19,$0C,$06,$03,$01,$C9,$64,$32,$19,$0C,$06,$03,$01
	db $CA,$65,$32,$19,$0C,$06,$03,$01,$CB,$65,$32,$19,$0C,$06,$03,$01
	db $CC,$66,$33,$19,$0C,$06,$03,$01,$CD,$66,$33,$19,$0C,$06,$03,$01
	db $CE,$67,$33,$19,$0C,$06,$03,$01,$CF,$67,$33,$19,$0C,$06,$03,$01
	db $D0,$68,$34,$1A,$0D,$06,$03,$01,$D1,$68,$34,$1A,$0D,$06,$03,$01
	db $D2,$69,$34,$1A,$0D,$06,$03,$01,$D3,$69,$34,$1A,$0D,$06,$03,$01
	db $D4,$6A,$35,$1A,$0D,$06,$03,$01,$D5,$6A,$35,$1A,$0D,$06,$03,$01
	db $D6,$6B,$35,$1A,$0D,$06,$03,$01,$D7,$6B,$35,$1A,$0D,$06,$03,$01
	db $D8,$6C,$36,$1B,$0D,$06,$03,$01,$D9,$6C,$36,$1B,$0D,$06,$03,$01
	db $DA,$6D,$36,$1B,$0D,$06,$03,$01,$DB,$6D,$36,$1B,$0D,$06,$03,$01
	db $DC,$6E,$37,$1B,$0D,$06,$03,$01,$DD,$6E,$37,$1B,$0D,$06,$03,$01
	db $DE,$6F,$37,$1B,$0D,$06,$03,$01,$DF,$6F,$37,$1B,$0D,$06,$03,$01
	db $E0,$70,$38,$1C,$0E,$07,$03,$01,$E1,$70,$38,$1C,$0E,$07,$03,$01
	db $E2,$71,$38,$1C,$0E,$07,$03,$01,$E3,$71,$38,$1C,$0E,$07,$03,$01
	db $E4,$72,$39,$1C,$0E,$07,$03,$01,$E5,$72,$39,$1C,$0E,$07,$03,$01
	db $E6,$73,$39,$1C,$0E,$07,$03,$01,$E7,$73,$39,$1C,$0E,$07,$03,$01
	db $E8,$74,$3A,$1D,$0E,$07,$03,$01,$E9,$74,$3A,$1D,$0E,$07,$03,$01
	db $EA,$75,$3A,$1D,$0E,$07,$03,$01,$EB,$75,$3A,$1D,$0E,$07,$03,$01
	db $EC,$76,$3B,$1D,$0E,$07,$03,$01,$ED,$76,$3B,$1D,$0E,$07,$03,$01
	db $EE,$77,$3B,$1D,$0E,$07,$03,$01,$EF,$77,$3B,$1D,$0E,$07,$03,$01
	db $F0,$78,$3C,$1E,$0F,$07,$03,$01,$F1,$78,$3C,$1E,$0F,$07,$03,$01
	db $F2,$79,$3C,$1E,$0F,$07,$03,$01,$F3,$79,$3C,$1E,$0F,$07,$03,$01
	db $F4,$7A,$3D,$1E,$0F,$07,$03,$01,$F5,$7A,$3D,$1E,$0F,$07,$03,$01
	db $F6,$7B,$3D,$1E,$0F,$07,$03,$01,$F7,$7B,$3D,$1E,$0F,$07,$03,$01
	db $F8,$7C,$3E,$1F,$0F,$07,$03,$01,$F9,$7C,$3E,$1F,$0F,$07,$03,$01
	db $FA,$7D,$3E,$1F,$0F,$07,$03,$01,$FB,$7D,$3E,$1F,$0F,$07,$03,$01
	db $FC,$7E,$3F,$1F,$0F,$07,$03,$01,$FD,$7E,$3F,$1F,$0F,$07,$03,$01
	db $FE,$7F,$3F,$1F,$0F,$07,$03,$01,$FF,$7F,$3F,$1F,$0F,$07,$03,$01

DATA_02E800:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$40,$20,$10,$08,$04,$02
	db $00,$00,$80,$40,$20,$10,$08,$04,$00,$80,$C0,$60,$30,$18,$0C,$06
	db $00,$00,$00,$80,$40,$20,$10,$08,$00,$80,$40,$A0,$50,$28,$14,$0A
	db $00,$00,$80,$C0,$60,$30,$18,$0C,$00,$80,$C0,$E0,$70,$38,$1C,$0E
	db $00,$00,$00,$00,$80,$40,$20,$10,$00,$80,$40,$20,$90,$48,$24,$12
	db $00,$00,$80,$40,$A0,$50,$28,$14,$00,$80,$C0,$60,$B0,$58,$2C,$16
	db $00,$00,$00,$80,$C0,$60,$30,$18,$00,$80,$40,$A0,$D0,$68,$34,$1A
	db $00,$00,$80,$C0,$E0,$70,$38,$1C,$00,$80,$C0,$E0,$F0,$78,$3C,$1E
	db $00,$00,$00,$00,$00,$80,$40,$20,$00,$80,$40,$20,$10,$88,$44,$22
	db $00,$00,$80,$40,$20,$90,$48,$24,$00,$80,$C0,$60,$30,$98,$4C,$26
	db $00,$00,$00,$80,$40,$A0,$50,$28,$00,$80,$40,$A0,$50,$A8,$54,$2A
	db $00,$00,$80,$C0,$60,$B0,$58,$2C,$00,$80,$C0,$E0,$70,$B8,$5C,$2E
	db $00,$00,$00,$00,$80,$C0,$60,$30,$00,$80,$40,$20,$90,$C8,$64,$32
	db $00,$00,$80,$40,$A0,$D0,$68,$34,$00,$80,$C0,$60,$B0,$D8,$6C,$36
	db $00,$00,$00,$80,$C0,$E0,$70,$38,$00,$80,$40,$A0,$D0,$E8,$74,$3A
	db $00,$00,$80,$C0,$E0,$F0,$78,$3C,$00,$80,$C0,$E0,$F0,$F8,$7C,$3E
	db $00,$00,$00,$00,$00,$00,$80,$40,$00,$80,$40,$20,$10,$08,$84,$42
	db $00,$00,$80,$40,$20,$10,$88,$44,$00,$80,$C0,$60,$30,$18,$8C,$46
	db $00,$00,$00,$80,$40,$20,$90,$48,$00,$80,$40,$A0,$50,$28,$94,$4A
	db $00,$00,$80,$C0,$60,$30,$98,$4C,$00,$80,$C0,$E0,$70,$38,$9C,$4E
	db $00,$00,$00,$00,$80,$40,$A0,$50,$00,$80,$40,$20,$90,$48,$A4,$52
	db $00,$00,$80,$40,$A0,$50,$A8,$54,$00,$80,$C0,$60,$B0,$58,$AC,$56
	db $00,$00,$00,$80,$C0,$60,$B0,$58,$00,$80,$40,$A0,$D0,$68,$B4,$5A
	db $00,$00,$80,$C0,$E0,$70,$B8,$5C,$00,$80,$C0,$E0,$F0,$78,$BC,$5E
	db $00,$00,$00,$00,$00,$80,$C0,$60,$00,$80,$40,$20,$10,$88,$C4,$62
	db $00,$00,$80,$40,$20,$90,$C8,$64,$00,$80,$C0,$60,$30,$98,$CC,$66
	db $00,$00,$00,$80,$40,$A0,$D0,$68,$00,$80,$40,$A0,$50,$A8,$D4,$6A
	db $00,$00,$80,$C0,$60,$B0,$D8,$6C,$00,$80,$C0,$E0,$70,$B8,$DC,$6E
	db $00,$00,$00,$00,$80,$C0,$E0,$70,$00,$80,$40,$20,$90,$C8,$E4,$72
	db $00,$00,$80,$40,$A0,$D0,$E8,$74,$00,$80,$C0,$60,$B0,$D8,$EC,$76
	db $00,$00,$00,$80,$C0,$E0,$F0,$78,$00,$80,$40,$A0,$D0,$E8,$F4,$7A
	db $00,$00,$80,$C0,$E0,$F0,$F8,$7C,$00,$80,$C0,$E0,$F0,$F8,$FC,$7E
	db $00,$00,$00,$00,$00,$00,$00,$80,$00,$80,$40,$20,$10,$08,$04,$82
	db $00,$00,$80,$40,$20,$10,$08,$84,$00,$80,$C0,$60,$30,$18,$0C,$86
	db $00,$00,$00,$80,$40,$20,$10,$88,$00,$80,$40,$A0,$50,$28,$14,$8A
	db $00,$00,$80,$C0,$60,$30,$18,$8C,$00,$80,$C0,$E0,$70,$38,$1C,$8E
	db $00,$00,$00,$00,$80,$40,$20,$90,$00,$80,$40,$20,$90,$48,$24,$92
	db $00,$00,$80,$40,$A0,$50,$28,$94,$00,$80,$C0,$60,$B0,$58,$2C,$96
	db $00,$00,$00,$80,$C0,$60,$30,$98,$00,$80,$40,$A0,$D0,$68,$34,$9A
	db $00,$00,$80,$C0,$E0,$70,$38,$9C,$00,$80,$C0,$E0,$F0,$78,$3C,$9E
	db $00,$00,$00,$00,$00,$80,$40,$A0,$00,$80,$40,$20,$10,$88,$44,$A2
	db $00,$00,$80,$40,$20,$90,$48,$A4,$00,$80,$C0,$60,$30,$98,$4C,$A6
	db $00,$00,$00,$80,$40,$A0,$50,$A8,$00,$80,$40,$A0,$50,$A8,$54,$AA
	db $00,$00,$80,$C0,$60,$B0,$58,$AC,$00,$80,$C0,$E0,$70,$B8,$5C,$AE
	db $00,$00,$00,$00,$80,$C0,$60,$B0,$00,$80,$40,$20,$90,$C8,$64,$B2
	db $00,$00,$80,$40,$A0,$D0,$68,$B4,$00,$80,$C0,$60,$B0,$D8,$6C,$B6
	db $00,$00,$00,$80,$C0,$E0,$70,$B8,$00,$80,$40,$A0,$D0,$E8,$74,$BA
	db $00,$00,$80,$C0,$E0,$F0,$78,$BC,$00,$80,$C0,$E0,$F0,$F8,$7C,$BE
	db $00,$00,$00,$00,$00,$00,$80,$C0,$00,$80,$40,$20,$10,$08,$84,$C2
	db $00,$00,$80,$40,$20,$10,$88,$C4,$00,$80,$C0,$60,$30,$18,$8C,$C6
	db $00,$00,$00,$80,$40,$20,$90,$C8,$00,$80,$40,$A0,$50,$28,$94,$CA
	db $00,$00,$80,$C0,$60,$30,$98,$CC,$00,$80,$C0,$E0,$70,$38,$9C,$CE
	db $00,$00,$00,$00,$80,$40,$A0,$D0,$00,$80,$40,$20,$90,$48,$A4,$D2
	db $00,$00,$80,$40,$A0,$50,$A8,$D4,$00,$80,$C0,$60,$B0,$58,$AC,$D6
	db $00,$00,$00,$80,$C0,$60,$B0,$D8,$00,$80,$40,$A0,$D0,$68,$B4,$DA
	db $00,$00,$80,$C0,$E0,$70,$B8,$DC,$00,$80,$C0,$E0,$F0,$78,$BC,$DE
	db $00,$00,$00,$00,$00,$80,$C0,$E0,$00,$80,$40,$20,$10,$88,$C4,$E2
	db $00,$00,$80,$40,$20,$90,$C8,$E4,$00,$80,$C0,$60,$30,$98,$CC,$E6
	db $00,$00,$00,$80,$40,$A0,$D0,$E8,$00,$80,$40,$A0,$50,$A8,$D4,$EA
	db $00,$00,$80,$C0,$60,$B0,$D8,$EC,$00,$80,$C0,$E0,$70,$B8,$DC,$EE
	db $00,$00,$00,$00,$80,$C0,$E0,$F0,$00,$80,$40,$20,$90,$C8,$E4,$F2
	db $00,$00,$80,$40,$A0,$D0,$E8,$F4,$00,$80,$C0,$60,$B0,$D8,$EC,$F6
	db $00,$00,$00,$80,$C0,$E0,$F0,$F8,$00,$80,$40,$A0,$D0,$E8,$F4,$FA
	db $00,$00,$80,$C0,$E0,$F0,$F8,$FC,$00,$80,$C0,$E0,$F0,$F8,$FC,$FE
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$40,$20,$10,$08,$04,$02
	db $00,$00,$80,$40,$20,$10,$08,$04,$00,$80,$C0,$60,$30,$18,$0C,$06
	db $00,$00,$00,$80,$40,$20,$10,$08,$00,$80,$40,$A0,$50,$28,$14,$0A
	db $00,$00,$80,$C0,$60,$30,$18,$0C,$00,$80,$C0,$E0,$70,$38,$1C,$0E
	db $00,$00,$00,$00,$80,$40,$20,$10,$00,$80,$40,$20,$90,$48,$24,$12
	db $00,$00,$80,$40,$A0,$50,$28,$14,$00,$80,$C0,$60,$B0,$58,$2C,$16
	db $00,$00,$00,$80,$C0,$60,$30,$18,$00,$80,$40,$A0,$D0,$68,$34,$1A
	db $00,$00,$80,$C0,$E0,$70,$38,$1C,$00,$80,$C0,$E0,$F0,$78,$3C,$1E
	db $00,$00,$00,$00,$00,$80,$40,$20,$00,$80,$40,$20,$10,$88,$44,$22
	db $00,$00,$80,$40,$20,$90,$48,$24,$00,$80,$C0,$60,$30,$98,$4C,$26
	db $00,$00,$00,$80,$40,$A0,$50,$28,$00,$80,$40,$A0,$50,$A8,$54,$2A
	db $00,$00,$80,$C0,$60,$B0,$58,$2C,$00,$80,$C0,$E0,$70,$B8,$5C,$2E
	db $00,$00,$00,$00,$80,$C0,$60,$30,$00,$80,$40,$20,$90,$C8,$64,$32
	db $00,$00,$80,$40,$A0,$D0,$68,$34,$00,$80,$C0,$60,$B0,$D8,$6C,$36
	db $00,$00,$00,$80,$C0,$E0,$70,$38,$00,$80,$40,$A0,$D0,$E8,$74,$3A
	db $00,$00,$80,$C0,$E0,$F0,$78,$3C,$00,$80,$C0,$E0,$F0,$F8,$7C,$3E
	db $00,$00,$00,$00,$00,$00,$80,$40,$00,$80,$40,$20,$10,$08,$84,$42
	db $00,$00,$80,$40,$20,$10,$88,$44,$00,$80,$C0,$60,$30,$18,$8C,$46
	db $00,$00,$00,$80,$40,$20,$90,$48,$00,$80,$40,$A0,$50,$28,$94,$4A
	db $00,$00,$80,$C0,$60,$30,$98,$4C,$00,$80,$C0,$E0,$70,$38,$9C,$4E
	db $00,$00,$00,$00,$80,$40,$A0,$50,$00,$80,$40,$20,$90,$48,$A4,$52
	db $00,$00,$80,$40,$A0,$50,$A8,$54,$00,$80,$C0,$60,$B0,$58,$AC,$56
	db $00,$00,$00,$80,$C0,$60,$B0,$58,$00,$80,$40,$A0,$D0,$68,$B4,$5A
	db $00,$00,$80,$C0,$E0,$70,$B8,$5C,$00,$80,$C0,$E0,$F0,$78,$BC,$5E
	db $00,$00,$00,$00,$00,$80,$C0,$60,$00,$80,$40,$20,$10,$88,$C4,$62
	db $00,$00,$80,$40,$20,$90,$C8,$64,$00,$80,$C0,$60,$30,$98,$CC,$66
	db $00,$00,$00,$80,$40,$A0,$D0,$68,$00,$80,$40,$A0,$50,$A8,$D4,$6A
	db $00,$00,$80,$C0,$60,$B0,$D8,$6C,$00,$80,$C0,$E0,$70,$B8,$DC,$6E
	db $00,$00,$00,$00,$80,$C0,$E0,$70,$00,$80,$40,$20,$90,$C8,$E4,$72
	db $00,$00,$80,$40,$A0,$D0,$E8,$74,$00,$80,$C0,$60,$B0,$D8,$EC,$76
	db $00,$00,$00,$80,$C0,$E0,$F0,$78,$00,$80,$40,$A0,$D0,$E8,$F4,$7A
	db $00,$00,$80,$C0,$E0,$F0,$F8,$7C,$00,$80,$C0,$E0,$F0,$F8,$FC,$7E
	db $00,$00,$00,$00,$00,$00,$00,$80,$00,$80,$40,$20,$10,$08,$04,$82
	db $00,$00,$80,$40,$20,$10,$08,$84,$00,$80,$C0,$60,$30,$18,$0C,$86
	db $00,$00,$00,$80,$40,$20,$10,$88,$00,$80,$40,$A0,$50,$28,$14,$8A
	db $00,$00,$80,$C0,$60,$30,$18,$8C,$00,$80,$C0,$E0,$70,$38,$1C,$8E
	db $00,$00,$00,$00,$80,$40,$20,$90,$00,$80,$40,$20,$90,$48,$24,$92
	db $00,$00,$80,$40,$A0,$50,$28,$94,$00,$80,$C0,$60,$B0,$58,$2C,$96
	db $00,$00,$00,$80,$C0,$60,$30,$98,$00,$80,$40,$A0,$D0,$68,$34,$9A
	db $00,$00,$80,$C0,$E0,$70,$38,$9C,$00,$80,$C0,$E0,$F0,$78,$3C,$9E
	db $00,$00,$00,$00,$00,$80,$40,$A0,$00,$80,$40,$20,$10,$88,$44,$A2
	db $00,$00,$80,$40,$20,$90,$48,$A4,$00,$80,$C0,$60,$30,$98,$4C,$A6
	db $00,$00,$00,$80,$40,$A0,$50,$A8,$00,$80,$40,$A0,$50,$A8,$54,$AA
	db $00,$00,$80,$C0,$60,$B0,$58,$AC,$00,$80,$C0,$E0,$70,$B8,$5C,$AE
	db $00,$00,$00,$00,$80,$C0,$60,$B0,$00,$80,$40,$20,$90,$C8,$64,$B2
	db $00,$00,$80,$40,$A0,$D0,$68,$B4,$00,$80,$C0,$60,$B0,$D8,$6C,$B6
	db $00,$00,$00,$80,$C0,$E0,$70,$B8,$00,$80,$40,$A0,$D0,$E8,$74,$BA
	db $00,$00,$80,$C0,$E0,$F0,$78,$BC,$00,$80,$C0,$E0,$F0,$F8,$7C,$BE
	db $00,$00,$00,$00,$00,$00,$80,$C0,$00,$80,$40,$20,$10,$08,$84,$C2
	db $00,$00,$80,$40,$20,$10,$88,$C4,$00,$80,$C0,$60,$30,$18,$8C,$C6
	db $00,$00,$00,$80,$40,$20,$90,$C8,$00,$80,$40,$A0,$50,$28,$94,$CA
	db $00,$00,$80,$C0,$60,$30,$98,$CC,$00,$80,$C0,$E0,$70,$38,$9C,$CE
	db $00,$00,$00,$00,$80,$40,$A0,$D0,$00,$80,$40,$20,$90,$48,$A4,$D2
	db $00,$00,$80,$40,$A0,$50,$A8,$D4,$00,$80,$C0,$60,$B0,$58,$AC,$D6
	db $00,$00,$00,$80,$C0,$60,$B0,$D8,$00,$80,$40,$A0,$D0,$68,$B4,$DA
	db $00,$00,$80,$C0,$E0,$70,$B8,$DC,$00,$80,$C0,$E0,$F0,$78,$BC,$DE
	db $00,$00,$00,$00,$00,$80,$C0,$E0,$00,$80,$40,$20,$10,$88,$C4,$E2
	db $00,$00,$80,$40,$20,$90,$C8,$E4,$00,$80,$C0,$60,$30,$98,$CC,$E6
	db $00,$00,$00,$80,$40,$A0,$D0,$E8,$00,$80,$40,$A0,$50,$A8,$D4,$EA
	db $00,$00,$80,$C0,$60,$B0,$D8,$EC,$00,$80,$C0,$E0,$70,$B8,$DC,$EE
	db $00,$00,$00,$00,$80,$C0,$E0,$F0,$00,$80,$40,$20,$90,$C8,$E4,$F2
	db $00,$00,$80,$40,$A0,$D0,$E8,$F4,$00,$80,$C0,$60,$B0,$D8,$EC,$F6
	db $00,$00,$00,$80,$C0,$E0,$F0,$F8,$00,$80,$40,$A0,$D0,$E8,$F4,$FA
	db $00,$00,$80,$C0,$E0,$F0,$F8,$FC,$00,$80,$C0,$E0,$F0,$F8,$FC,$FE

DATA_02F000:						; Note: Something related to flipping the selected palette/stamp.
	db $00,$80,$40,$C0,$20,$A0,$60,$E0,$10,$90,$50,$D0,$30,$B0,$70,$F0
	db $08,$88,$48,$C8,$28,$A8,$68,$E8,$18,$98,$58,$D8,$38,$B8,$78,$F8
	db $04,$84,$44,$C4,$24,$A4,$64,$E4,$14,$94,$54,$D4,$34,$B4,$74,$F4
	db $0C,$8C,$4C,$CC,$2C,$AC,$6C,$EC,$1C,$9C,$5C,$DC,$3C,$BC,$7C,$FC
	db $02,$82,$42,$C2,$22,$A2,$62,$E2,$12,$92,$52,$D2,$32,$B2,$72,$F2
	db $0A,$8A,$4A,$CA,$2A,$AA,$6A,$EA,$1A,$9A,$5A,$DA,$3A,$BA,$7A,$FA
	db $06,$86,$46,$C6,$26,$A6,$66,$E6,$16,$96,$56,$D6,$36,$B6,$76,$F6
	db $0E,$8E,$4E,$CE,$2E,$AE,$6E,$EE,$1E,$9E,$5E,$DE,$3E,$BE,$7E,$FE
	db $01,$81,$41,$C1,$21,$A1,$61,$E1,$11,$91,$51,$D1,$31,$B1,$71,$F1
	db $09,$89,$49,$C9,$29,$A9,$69,$E9,$19,$99,$59,$D9,$39,$B9,$79,$F9
	db $05,$85,$45,$C5,$25,$A5,$65,$E5,$15,$95,$55,$D5,$35,$B5,$75,$F5
	db $0D,$8D,$4D,$CD,$2D,$AD,$6D,$ED,$1D,$9D,$5D,$DD,$3D,$BD,$7D,$FD
	db $03,$83,$43,$C3,$23,$A3,$63,$E3,$13,$93,$53,$D3,$33,$B3,$73,$F3
	db $0B,$8B,$4B,$CB,$2B,$AB,$6B,$EB,$1B,$9B,$5B,$DB,$3B,$BB,$7B,$FB
	db $07,$87,$47,$C7,$27,$A7,$67,$E7,$17,$97,$57,$D7,$37,$B7,$77,$F7
	db $0F,$8F,$4F,$CF,$2F,$AF,$6F,$EF,$1F,$9F,$5F,$DF,$3F,$BF,$7F,$FF

	%FREE_BYTES(NULLROM, 528, $00)

DATA_02F310:
	incbin "UnsortedData/PreComposedMusicToolSong1.bin"
.End:

DATA_02F560:
	incbin "UnsortedData/PreComposedMusicToolSong2.bin"
.End:

DATA_02F7B0:
	incbin "UnsortedData/PreComposedMusicToolSong3.bin"
.End:

DATA_02FA00:
	incbin "Palettes/EraseTool_VideoSignalInterferance.bin"

DATA_02FC00:
	incbin "Palettes/TitleScreen.bin"

DATA_02FE00:
	incbin "Palettes/Canvas.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank03Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_038000:
	incbin "Graphics/GFX_038000.bin"

	%FREE_BYTES(NULLROM, 3632 ,$00)
	%FREE_BYTES(NULLROM, 16 ,$FF)
	%FREE_BYTES(NULLROM, 448 ,$00)

DATA_03FC00:
	incbin "Graphics/GFX_03FC00.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank04Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_048000:
	incbin "Graphics/GFX_048000.bin"

DATA_048800:
	incbin "Graphics/GFX_048800.bin"

DATA_049000:
	incbin "Graphics/GFX_049000.bin"

DATA_049800:
	incbin "Graphics/GFX_049800.bin"

DATA_04A000:
	incbin "Graphics/GFX_04A000.bin"

DATA_04B000:
	incbin "Graphics/GFX_04B000.bin"

DATA_04C000:
	incbin "Graphics/GFX_04C000.bin"

DATA_04D000:
	incbin "Graphics/GFX_04D000.bin"

DATA_04EA00:
	incbin "Graphics/GFX_04EA00.bin"

DATA_04FA00:
	incbin "Graphics/GFX_04FA00.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank05Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_058000:
	incbin "Graphics/GFX_058000.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank06Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_068000:
	incbin "Graphics/GFX_068000.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank07Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_078000:
	incbin "Graphics/GFX_078000.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank08Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_088000:
	incbin "Graphics/GFX_088000.bin"

DATA_089000:
	incbin "Graphics/GFX_089000.bin"

DATA_089C00:
	incbin "Graphics/GFX_089C00.bin"

DATA_08A000:
	incbin "Graphics/GFX_08A000.bin"

DATA_08B000:
	incbin "Graphics/GFX_08B000.bin"

DATA_08C000:
	incbin "Graphics/GFX_08C000.bin"

DATA_08D000:
	incbin "Graphics/GFX_08D000.bin"

DATA_08E000:
	incbin "Graphics/GFX_08E000.bin"

DATA_08E600:
	incbin "Graphics/GFX_08E600.bin"

DATA_08EE00:
	incbin "Graphics/GFX_08EE00.bin"

DATA_08F200:
	incbin "Graphics/GFX_08F200.bin"

DATA_08FC00:
	incbin "Graphics/GFX_08FC00.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank09Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_098000:
	incbin "Graphics/GFX_098000.bin"

DATA_099000:
	incbin "Graphics/GFX_099000.bin"

DATA_09A000:
	incbin "Graphics/GFX_09A000.bin"

DATA_09B000:
	incbin "Graphics/GFX_09B000.bin"

DATA_09C000:
	incbin "Graphics/GFX_09C000.bin"

DATA_09EC00:
	incbin "Graphics/GFX_09EC00.bin"

DATA_09F000:
	incbin "Graphics/GFX_09F000.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank0AMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_0A8000:
	incbin "Graphics/GFX_0A8000.bin"

DATA_0AC000:
	incbin "Graphics/GFX_0AC000.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank0BMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_0B8000:
	incbin "Graphics/GFX_0B8000.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank0CMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_0C8000:
	incbin "Graphics/GFX_0C8000.bin"

%FREE_BYTES(NULLROM, 6144, $00)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank0DMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_0D8000:
	incbin "Graphics/GFX_0D8000.bin"

DATA_0DAC00:
	incbin "Graphics/GFX_0DAC00.bin"

	%FREE_BYTES(NULLROM, 512, $00)

DATA_0DB000:
	dw $0000,$5555,$AAAA,$FFFF

DATA_0DB008:
	dw $0003,$000C,$0030,$00C0,$0300,$0C00,$3000,$C000

DATA_0DB018:
	dw DATA_0DB438,DATA_0DB44E,DATA_0DB473,DATA_0DB489,DATA_0DB4AE,DATA_0DB4D3,DATA_0DB4F8,DATA_0DB51D
	dw DATA_0DB53D,DATA_0DB544,DATA_0DB550,DATA_0DB438,DATA_0DB561,DATA_0DB568,DATA_0DB56F,DATA_0DB58F
	dw DATA_0DB5A0,DATA_0DB5AC,DATA_0DB5BD,DATA_0DB5D3,DATA_0DB5E9,DATA_0DB604,DATA_0DB62E,DATA_0DB653
	dw DATA_0DB67D,DATA_0DB68E,DATA_0DB69F,DATA_0DB6B0,DATA_0DB6C1,DATA_0DB5A0,DATA_0DB5A0,DATA_0DB5A0
	dw DATA_0DB6D2,DATA_0DB7EC,DATA_0DB906,DATA_0DBA20,DATA_0DBB3A,DATA_0DBBEB,DATA_0DBCE7,DATA_0DBD98
	dw DATA_0DBE49,DATA_0DBF45,DATA_0DBFF6,DATA_0DC156,DATA_0DC2B6,DATA_0DC416,DATA_0DC576,DATA_0DC6D6
	dw DATA_0DC836,DATA_0DC996,DATA_0DCAF6,DATA_0DCC56,DATA_0DCC67,DATA_0DCC78,DATA_0DCC89,DATA_0DCC9A
	dw DATA_0DB438,DATA_0DB438,DATA_0DB438,DATA_0DB438,DATA_0DCCAB,DATA_0DCCB2,DATA_0DCCBE,DATA_0DCCCF
	dw DATA_0DCCD6,DATA_0DCCE2,DATA_0DCCF3,DATA_0DCCFA,DATA_0DCD06,DATA_0DCD17,DATA_0DCD69,DATA_0DCD70
	dw DATA_0DCD77,DATA_0DCD83,DATA_0DCD8A,DATA_0DCD96,DATA_0DCDAC,DATA_0DCDC2,DATA_0DCDD8,DATA_0DCDEE
	dw DATA_0DCDF5,DATA_0DCDFC,DATA_0DCE03,DATA_0DCE0A,DATA_0DCE16,DATA_0DCE22,DATA_0DCE2E,DATA_0DB438
	dw DATA_0DCE3A,DATA_0DCE41,DATA_0DCE48,DATA_0DCE4F,DATA_0DCE56,DATA_0DCE5D,DATA_0DCE64,DATA_0DCE6B
	dw DATA_0DCE7C,DATA_0DCE8D,DATA_0DCE94,DATA_0DCE9B,DATA_0DCEA2,DATA_0DCEB8,DATA_0DCECE,DATA_0DCEE4
	dw DATA_0DCF0E,DATA_0DCF38,DATA_0DCF62,DATA_0DB438,DATA_0DB438,DATA_0DB438,DATA_0DB438,DATA_0DCF8C
	dw DATA_0DCFA2,DATA_0DCFB8,DATA_0DCFCE,DATA_0DCFD5,DATA_0DCFDC,DATA_0DCFE3,DATA_0DCFEA,DATA_0DCFF1
	dw DATA_0DCFF8,DATA_0DCFFF,DATA_0DB438,DATA_0DB438,DATA_0DB3D8,DATA_0DB3F8,DATA_0DB418,DATA_0DD006
	dw DATA_0DD026,DATA_0DD055,DATA_0DD093,DATA_0DD0D1,DATA_0DD0F1,DATA_0DD120,DATA_0DD159,DATA_0DB438
	dw DATA_0DB438,DATA_0DB438,DATA_0DB438,DATA_0DB438,DATA_0DD192,DATA_0DB438,DATA_0DD19E,DATA_0DD1B4
	dw DATA_0DD1CA,DATA_0DD1F9,DATA_0DB438,DATA_0DB438,DATA_0DB438,DATA_0DB438,DATA_0DD228,DATA_0DD22F
	dw DATA_0DD236,DATA_0DD23D,DATA_0DD244,DATA_0DD24B,DATA_0DD252,DATA_0DD259,DATA_0DD260,DATA_0DD267
	dw DATA_0DD26E,DATA_0DD275,DATA_0DD27C,DATA_0DD283,DATA_0DD28A,DATA_0DD29B,DATA_0DD2AC,DATA_0DD2BD
	dw DATA_0DD2CE,DATA_0DD2D5,DATA_0DD2E1,DATA_0DD2F2,DATA_0DD308,DATA_0DD323,DATA_0DD343,DATA_0DD368
	dw DATA_0DD392,DATA_0DD3C6,DATA_0DD3D7,DATA_0DD3E8,DATA_0DD3F9,DATA_0DD419,DATA_0DD443,DATA_0DD45E
	dw DATA_0DD479,DATA_0DD485,DATA_0DD491,DATA_0DD49D,DATA_0DD4A9,DATA_0DD4B5,DATA_0DD4C1,DATA_0DD4CD
	dw DATA_0DD4D9,DATA_0DD4E5,DATA_0DD4F1,DATA_0DD4F8,DATA_0DD4FF,DATA_0DD506,DATA_0DD50D,DATA_0DD514
	dw DATA_0DD51B,DATA_0DD522,DATA_0DD529,DATA_0DD530,DATA_0DE50B,DATA_0DE521,DATA_0DE537,DATA_0DE54D
	dw DATA_0DE559,DATA_0DE56F,DATA_0DE585,DATA_0DE59B,DATA_0DE5B1,DATA_0DE5B8,DATA_0DE5BF,DATA_0DE5C6
	dw DATA_0DE5CD,DATA_0DE5D4,DATA_0DE5DB,DATA_0DE5E2,DATA_0DE5E9,DATA_0DE5F0,DATA_0DE5F7,DATA_0DE60D
	dw DATA_0DE623,DATA_0DE639,DATA_0DE64F,DATA_0DE66A,DATA_0DE685,DATA_0DE6A0,DATA_0DE6BB,DATA_0DE6C2
	dw DATA_0DE6C9,DATA_0DE6D0,DATA_0DE6D7,DATA_0DE6DE,DATA_0DE6E5,DATA_0DE6EC,DATA_0DE794,DATA_0DE79B
	dw DATA_0DE7B6,DATA_0DE7BD,DATA_0DB438,DATA_0DB438,DATA_0DD537,DATA_0DD548,DATA_0DD559,DATA_0DD56A
	dw DATA_0DD594,DATA_0DD5BE,DATA_0DD5F7,DATA_0DD603,DATA_0DD60F,DATA_0DD625,DATA_0DD668,DATA_0DD6A1
	dw DATA_0DD6A8,DATA_0DD6BE,DATA_0DD6E3,DATA_0DD703,DATA_0DD723,DATA_0DD743,DATA_0DD763,DATA_0DD779
	dw DATA_0DD78F,DATA_0DD7A5,DATA_0DD7BB,DATA_0DD7D1,DATA_0DD7E7,DATA_0DD7FD,DATA_0DD813,DATA_0DD829
	dw DATA_0DD83F,DATA_0DD855,DATA_0DD875,DATA_0DD895,DATA_0DD8A1,DATA_0DD8A1,DATA_0DD8B7,DATA_0DD8BE
	dw DATA_0DD8C5,DATA_0DD8CC,DATA_0DD8D3,DATA_0DD8DA,DATA_0DD8E1,DATA_0DD8E8,DATA_0DD8EF,DATA_0DD8F6
	dw DATA_0DD8FD,DATA_0DD904,DATA_0DD90B,DATA_0DD921,DATA_0DD941,DATA_0DD957,DATA_0DD96D,DATA_0DD974
	dw DATA_0DD97B,DATA_0DD982,DATA_0DD998,DATA_0DD9AE,DATA_0DD9C4,DATA_0DD9DA,DATA_0DD9F0,DATA_0DDA10
	dw DATA_0DDA3A,DATA_0DDA64,DATA_0DDA6B,DATA_0DDA72,DATA_0DDA88,DATA_0DDA9E,DATA_0DDAB4,DATA_0DDACF
	dw DATA_0DDADB,DATA_0DDAE7,DATA_0DDAF3,DATA_0DDAFF,DATA_0DDB0B,DATA_0DDB17,DATA_0DDB23,DATA_0DDB2F
	dw DATA_0DDB36,DATA_0DDB42,DATA_0DDB4E,DATA_0DDB64,DATA_0DDB7A,DATA_0DDB81,DATA_0DDB88,DATA_0DDB8F
	dw DATA_0DDB96,DATA_0DDB9D,DATA_0DDBA4,DATA_0DDBB5,DATA_0DDBC6,DATA_0DDBD7,DATA_0DDBE8,DATA_0DDBF9
	dw DATA_0DDC0A,DATA_0DDC1B,DATA_0DDC6D,DATA_0DDCBF,DATA_0DDD11,DATA_0DDD63,DATA_0DDDB5,DATA_0DDE07
	dw DATA_0DDE59,DATA_0DDEAB,DATA_0DE18D,DATA_0DE1A3,DATA_0DE1B9,DATA_0DE1CF,DATA_0DE1D6,DATA_0DE1DD
	dw DATA_0DE1E4,DATA_0DE1EB,DATA_0DE1F2,DATA_0DE1F9,DATA_0DE200,DATA_0DE207,DATA_0DE20E,DATA_0DE215
	dw DATA_0DE21C,DATA_0DE223,DATA_0DE22A,DATA_0DE231,DATA_0DE238,DATA_0DE23F,DATA_0DE246,DATA_0DE24D
	dw DATA_0DE254,DATA_0DE260,DATA_0DE26C,DATA_0DE278,DATA_0DE284,DATA_0DE29A,DATA_0DE2B0,DATA_0DE2C6
	dw DATA_0DE2D7,DATA_0DE2F2,DATA_0DE308,DATA_0DE31E,DATA_0DE334,DATA_0DE34A,DATA_0DE360,DATA_0DE36C
	dw DATA_0DE382,DATA_0DE38E,DATA_0DE395,DATA_0DE39C,DATA_0DE3A3,DATA_0DE3AA,DATA_0DE3B1,DATA_0DE3B8
	dw DATA_0DE3BF,DATA_0DE3C6,DATA_0DE3CD,DATA_0DE3D4,DATA_0DE3DB,DATA_0DE3E2,DATA_0DE3E9,DATA_0DE3F0
	dw DATA_0DE3F7,DATA_0DE3FE,DATA_0DE405,DATA_0DE40C,DATA_0DE413,DATA_0DE41A,DATA_0DE7C9,DATA_0DE848
	dw DATA_0DE8E5,DATA_0DE97D,DATA_0DEA01,DATA_0DEA85,DATA_0DB438,DATA_0DB438,DATA_0DB438,DATA_0DB438
	dw DATA_0DE42B,DATA_0DE432,DATA_0DE439,DATA_0DE440,DATA_0DE447,DATA_0DE44E,DATA_0DE455,DATA_0DE45C
	dw DATA_0DE463,DATA_0DE46A,DATA_0DE471,DATA_0DE478,DATA_0DE47F,DATA_0DE486,DATA_0DE48D,DATA_0DE494
	dw DATA_0DE49B,DATA_0DE4A2,DATA_0DE4A9,DATA_0DE4B0,DATA_0DE4B7,DATA_0DE4BE,DATA_0DE4C5,DATA_0DE4CC
	dw DATA_0DE4D3,DATA_0DE4DA,DATA_0DE4E1,DATA_0DE4E8,DATA_0DE4EF,DATA_0DE4F6,DATA_0DE4FD,DATA_0DE504
	dw DATA_0DE6F3,DATA_0DE6FA,DATA_0DE701,DATA_0DE708,DATA_0DE70F,DATA_0DE716,DATA_0DE71D,DATA_0DE724
	dw DATA_0DE72B,DATA_0DE732,DATA_0DE739,DATA_0DE740,DATA_0DE747,DATA_0DE74E,DATA_0DE755,DATA_0DE75C
	dw DATA_0DE763,DATA_0DE76A,DATA_0DE771,DATA_0DE778,DATA_0DE77F,DATA_0DE786,DATA_0DE78D,DATA_0DB438
	dw DATA_0DDEFD,DATA_0DDF4F,DATA_0DDFA1,DATA_0DDFF3,DATA_0DE045,DATA_0DE097,DATA_0DE0E9,DATA_0DE13B

DATA_0DB3D8:
	db $06,$00,$00,$02,$00,$D0,$35,$10,$02,$00,$D2,$35,$00,$00,$10,$F0
	db $35,$08,$00,$10,$F1,$35,$10,$00,$10,$F2,$35,$18,$00,$10,$F3,$35

DATA_0DB3F8:
	db $06,$00,$00,$02,$00,$D4,$35,$10,$02,$00,$D6,$35,$00,$00,$10,$F4
	db $35,$08,$00,$10,$F5,$35,$10,$00,$10,$F6,$35,$18,$00,$10,$F7,$35

DATA_0DB418:
	db $06,$00,$00,$02,$00,$D8,$35,$10,$02,$00,$DA,$35,$00,$00,$10,$F8
	db $35,$08,$00,$10,$F9,$35,$10,$00,$10,$FA,$35,$18,$00,$10,$FB,$35

DATA_0DB438:
	db $04,$00,$10,$00,$00,$B2,$33,$08,$00,$00,$B1,$33,$10,$02,$08,$C2
	db $33,$00,$02,$08,$C0,$33

DATA_0DB44E:
	db $07,$00,$18,$00,$10,$D3,$33,$18,$00,$08,$C3,$33,$08,$02,$00,$B1
	db $33,$10,$00,$10,$D6,$33,$08,$00,$10,$D5,$33,$00,$00,$10,$D4,$33
	db $00,$00,$08,$C4,$33

DATA_0DB473:
	db $04,$00,$10,$00,$00,$BA,$33,$08,$00,$00,$B9,$33,$10,$02,$08,$CA
	db $33,$00,$02,$08,$C8,$33

DATA_0DB489:
	db $07,$00,$FF,$01,$10,$D7,$33,$FF,$01,$08,$C0,$33,$0F,$00,$10,$C5
	db $33,$07,$00,$10,$B5,$33,$17,$00,$10,$C6,$33,$17,$00,$08,$B6,$33
	db $07,$02,$00,$B1,$33

DATA_0DB4AE:
	db $07,$00,$10,$00,$10,$C5,$33,$08,$00,$10,$B5,$33,$18,$00,$10,$C6
	db $33,$18,$00,$08,$B6,$33,$08,$02,$00,$B1,$33,$00,$00,$10,$B3,$33
	db $00,$00,$08,$B0,$33

DATA_0DB4D3:
	db $07,$00,$10,$00,$10,$C5,$33,$08,$00,$10,$B5,$33,$18,$00,$10,$C6
	db $33,$18,$00,$08,$B6,$33,$08,$02,$00,$B1,$33,$00,$00,$10,$B7,$33
	db $00,$00,$08,$B4,$33

DATA_0DB4F8:
	db $07,$00,$00,$00,$10,$C7,$33,$10,$00,$10,$C5,$33,$08,$00,$10,$B5
	db $33,$18,$00,$10,$C6,$33,$18,$00,$08,$B6,$33,$08,$02,$00,$B1,$33
	db $00,$00,$08,$B8,$33

DATA_0DB51D:
	db $06,$00,$00,$00,$10,$BB,$33,$10,$00,$10,$C5,$33,$08,$00,$10,$B5
	db $33,$18,$00,$10,$C6,$33,$18,$00,$08,$B6,$33,$08,$02,$00,$B1,$33

DATA_0DB53D:
	db $01,$00,$00,$02,$00,$AA,$38

DATA_0DB544:
	db $02,$00,$00,$02,$00,$AA,$38,$10,$02,$00,$AA,$38

DATA_0DB550:
	db $03,$00,$00,$02,$00,$AA,$38,$10,$02,$00,$AA,$38,$20,$02,$00,$AA
	db $38

DATA_0DB561:
	db $01,$00,$00,$02,$00,$AC,$32

DATA_0DB568:
	db $01,$00,$00,$02,$00,$EE,$33

DATA_0DB56F:
	db $06,$00,$18,$00,$10,$A3,$39,$10,$00,$10,$A2,$39,$08,$00,$10,$A1
	db $39,$18,$00,$08,$93,$39,$00,$00,$08,$90,$39,$08,$02,$00,$81,$39

DATA_0DB58F:
	db $03,$00,$08,$00,$00,$85,$39,$10,$02,$08,$96,$39,$00,$02,$08,$94
	db $39

DATA_0DB5A0:
	db $02,$00,$10,$02,$08,$9A,$39,$00,$02,$08,$98,$39

DATA_0DB5AC:
	db $03,$00,$00,$00,$08,$9C,$39,$08,$02,$08,$9D,$39,$08,$00,$00,$8D
	db $39

DATA_0DB5BD:
	db $04,$00,$10,$00,$10,$8A,$39,$08,$00,$10,$89,$39,$10,$00,$08,$7A
	db $39,$00,$02,$00,$68,$39

DATA_0DB5D3:
	db $04,$00,$08,$00,$10,$89,$39,$10,$00,$10,$8C,$39,$10,$00,$08,$7C
	db $39,$00,$02,$00,$68,$39

DATA_0DB5E9:
	db $05,$00,$20,$00,$08,$DE,$39,$28,$00,$00,$DD,$39,$20,$00,$00,$DC
	db $39,$10,$02,$00,$BE,$39,$00,$02,$00,$BC,$39

DATA_0DB604:
	db $08,$00,$08,$00,$08,$AF,$39,$18,$00,$08,$8B,$39,$10,$00,$08,$8E
	db $39,$20,$00,$00,$AC,$39,$18,$00,$00,$A0,$39,$10,$00,$00,$9F,$39
	db $08,$00,$00,$8F,$39,$00,$00,$00,$88,$39

DATA_0DB62E:
	db $07,$00,$10,$00,$08,$7D,$39,$08,$00,$08,$7B,$39,$20,$00,$00,$6E
	db $39,$18,$00,$00,$6D,$39,$10,$00,$00,$6C,$39,$08,$00,$00,$6B,$39
	db $00,$00,$00,$6A,$39

DATA_0DB653:
	db $08,$00,$08,$00,$08,$6F,$39,$18,$00,$08,$7F,$39,$10,$00,$08,$7E
	db $39,$20,$00,$00,$87,$39,$18,$00,$00,$86,$39,$10,$00,$00,$84,$39
	db $08,$00,$00,$83,$39,$00,$00,$00,$80,$39

DATA_0DB67D:
	db $03,$00,$08,$00,$10,$A1,$38,$00,$00,$10,$A0,$38,$00,$02,$00,$80
	db $38

DATA_0DB68E:
	db $03,$00,$08,$00,$10,$A3,$38,$00,$00,$10,$A2,$38,$00,$02,$00,$82
	db $38

DATA_0DB69F:
	db $03,$00,$08,$00,$10,$A5,$38,$00,$00,$10,$A4,$38,$00,$02,$00,$84
	db $38

DATA_0DB6B0:
	db $03,$00,$08,$00,$10,$A7,$38,$00,$00,$10,$A6,$38,$00,$02,$00,$86
	db $38

DATA_0DB6C1:
	db $03,$00,$08,$00,$10,$A9,$38,$00,$00,$10,$A8,$38,$00,$02,$00,$88
	db $38

DATA_0DB6D2:
	db $38,$00,$C0,$03,$D4,$A0,$20,$D0,$03,$D4,$A2,$20,$E0,$03,$D4,$A4
	db $20,$F0,$03,$D4,$A6,$20,$00,$02,$D4,$A8,$20,$10,$02,$D4,$AA,$20
	db $20,$02,$D4,$AC,$20,$30,$02,$D4,$AE,$20,$C0,$03,$E4,$C0,$20,$D0
	db $03,$E4,$C2,$20,$E0,$03,$E4,$C4,$20,$F0,$03,$E4,$C6,$20,$00,$02
	db $E4,$C8,$20,$10,$02,$E4,$CA,$20,$20,$02,$E4,$CC,$20,$30,$02,$E4
	db $CE,$20,$C0,$03,$F4,$E0,$20,$D0,$03,$F4,$E2,$20,$E0,$03,$F4,$E4
	db $20,$F0,$03,$F4,$E6,$20,$00,$02,$F4,$E8,$20,$10,$02,$F4,$EA,$20
	db $20,$02,$F4,$EC,$20,$30,$02,$F4,$EE,$20,$C0,$03,$04,$00,$21,$D0
	db $03,$04,$02,$21,$E0,$03,$04,$04,$21,$F0,$03,$04,$06,$21,$00,$02
	db $04,$08,$21,$10,$02,$04,$0A,$21,$20,$02,$04,$0C,$21,$30,$02,$04
	db $0E,$21,$C0,$03,$14,$20,$21,$D0,$03,$14,$22,$21,$E0,$03,$14,$24
	db $21,$F0,$03,$14,$26,$21,$00,$02,$14,$28,$21,$10,$02,$14,$2A,$21
	db $20,$02,$14,$2C,$21,$30,$02,$14,$2E,$21,$C0,$01,$24,$40,$21,$C8
	db $01,$24,$41,$21,$D0,$01,$24,$42,$21,$D8,$01,$24,$43,$21,$E0,$01
	db $24,$44,$21,$E8,$01,$24,$45,$21,$F0,$01,$24,$46,$21,$F8,$01,$24
	db $47,$21,$00,$00,$24,$48,$21,$08,$00,$24,$49,$21,$10,$00,$24,$4A
	db $21,$18,$00,$24,$4B,$21,$20,$00,$24,$4C,$21,$28,$00,$24,$4D,$21
	db $30,$00,$24,$4E,$21,$38,$00,$24,$4F,$21

DATA_0DB7EC:
	db $38,$00,$C0,$03,$D4,$50,$21,$D0,$03,$D4,$52,$21,$E0,$03,$D4,$54
	db $21,$F0,$03,$D4,$56,$21,$00,$02,$D4,$58,$21,$10,$02,$D4,$5A,$21
	db $20,$02,$D4,$5C,$21,$30,$02,$D4,$5E,$21,$C0,$03,$E4,$70,$21,$D0
	db $03,$E4,$72,$21,$E0,$03,$E4,$74,$21,$F0,$03,$E4,$76,$21,$00,$02
	db $E4,$78,$21,$10,$02,$E4,$7A,$21,$20,$02,$E4,$7C,$21,$30,$02,$E4
	db $7E,$21,$C0,$03,$F4,$90,$21,$D0,$03,$F4,$92,$21,$E0,$03,$F4,$94
	db $21,$F0,$03,$F4,$96,$21,$00,$02,$F4,$98,$21,$10,$02,$F4,$9A,$21
	db $20,$02,$F4,$9C,$21,$30,$02,$F4,$9E,$21,$C0,$03,$04,$B0,$21,$D0
	db $03,$04,$B2,$21,$E0,$03,$04,$B4,$21,$F0,$03,$04,$B6,$21,$00,$02
	db $04,$B8,$21,$10,$02,$04,$BA,$21,$20,$02,$04,$BC,$21,$30,$02,$04
	db $BE,$21,$C0,$03,$14,$D0,$21,$D0,$03,$14,$D2,$21,$E0,$03,$14,$D4
	db $21,$F0,$03,$14,$D6,$21,$00,$02,$14,$D8,$21,$10,$02,$14,$DA,$21
	db $20,$02,$14,$DC,$21,$30,$02,$14,$DE,$21,$C0,$01,$24,$F0,$21,$C8
	db $01,$24,$F1,$21,$D0,$01,$24,$F2,$21,$D8,$01,$24,$F3,$21,$E0,$01
	db $24,$F4,$21,$E8,$01,$24,$F5,$21,$F0,$01,$24,$F6,$21,$F8,$01,$24
	db $F7,$21,$00,$00,$24,$F8,$21,$08,$00,$24,$F9,$21,$10,$00,$24,$FA
	db $21,$18,$00,$24,$FB,$21,$20,$00,$24,$FC,$21,$28,$00,$24,$FD,$21
	db $30,$00,$24,$FE,$21,$38,$00,$24,$FF,$21

DATA_0DB906:
	db $38,$00,$C0,$03,$D4,$00,$21,$D0,$03,$D4,$02,$21,$E0,$03,$D4,$04
	db $21,$F0,$03,$D4,$06,$21,$00,$02,$D4,$08,$21,$10,$02,$D4,$0A,$21
	db $20,$02,$D4,$0C,$21,$30,$02,$D4,$0E,$21,$C0,$03,$E4,$20,$21,$D0
	db $03,$E4,$22,$21,$E0,$03,$E4,$24,$21,$F0,$03,$E4,$26,$21,$00,$02
	db $E4,$28,$21,$10,$02,$E4,$2A,$21,$20,$02,$E4,$2C,$21,$30,$02,$E4
	db $2E,$21,$C0,$03,$F4,$40,$21,$D0,$03,$F4,$42,$21,$E0,$03,$F4,$44
	db $21,$F0,$03,$F4,$46,$21,$00,$02,$F4,$48,$21,$10,$02,$F4,$4A,$21
	db $20,$02,$F4,$4C,$21,$30,$02,$F4,$4E,$21,$C0,$03,$04,$60,$21,$D0
	db $03,$04,$62,$21,$E0,$03,$04,$64,$21,$F0,$03,$04,$66,$21,$00,$02
	db $04,$68,$21,$10,$02,$04,$6A,$21,$20,$02,$04,$6C,$21,$30,$02,$04
	db $6E,$21,$C0,$03,$14,$80,$21,$D0,$03,$14,$82,$21,$E0,$03,$14,$84
	db $21,$F0,$03,$14,$86,$21,$00,$02,$14,$88,$21,$10,$02,$14,$8A,$21
	db $20,$02,$14,$8C,$21,$30,$02,$14,$8E,$21,$C0,$01,$24,$A0,$21,$C8
	db $01,$24,$A1,$21,$D0,$01,$24,$A2,$21,$D8,$01,$24,$A3,$21,$E0,$01
	db $24,$A4,$21,$E8,$01,$24,$A5,$21,$F0,$01,$24,$A6,$21,$F8,$01,$24
	db $A7,$21,$00,$00,$24,$A8,$21,$08,$00,$24,$A9,$21,$10,$00,$24,$AA
	db $21,$18,$00,$24,$AB,$21,$20,$00,$24,$AC,$21,$28,$00,$24,$AD,$21
	db $30,$00,$24,$AE,$21,$38,$00,$24,$AF,$21

DATA_0DBA20:
	db $38,$00,$C0,$03,$D4,$40,$20,$D0,$03,$D4,$42,$20,$E0,$03,$D4,$44
	db $20,$F0,$03,$D4,$46,$20,$00,$02,$D4,$48,$20,$10,$02,$D4,$4A,$20
	db $20,$02,$D4,$4C,$20,$30,$02,$D4,$4E,$20,$C0,$03,$E4,$60,$20,$D0
	db $03,$E4,$62,$20,$E0,$03,$E4,$64,$20,$F0,$03,$E4,$66,$20,$00,$02
	db $E4,$68,$20,$10,$02,$E4,$6A,$20,$20,$02,$E4,$6C,$20,$30,$02,$E4
	db $6E,$20,$C0,$03,$F4,$80,$20,$D0,$03,$F4,$82,$20,$E0,$03,$F4,$84
	db $20,$F0,$03,$F4,$86,$20,$00,$02,$F4,$88,$20,$10,$02,$F4,$8A,$20
	db $20,$02,$F4,$8C,$20,$30,$02,$F4,$8E,$20,$C0,$03,$04,$B0,$21,$D0
	db $03,$04,$B2,$21,$E0,$03,$04,$B4,$21,$F0,$03,$04,$B6,$21,$00,$02
	db $04,$B8,$21,$10,$02,$04,$BA,$21,$20,$02,$04,$BC,$21,$30,$02,$04
	db $BE,$21,$C0,$03,$14,$D0,$21,$D0,$03,$14,$D2,$21,$E0,$03,$14,$D4
	db $21,$F0,$03,$14,$D6,$21,$00,$02,$14,$D8,$21,$10,$02,$14,$DA,$21
	db $20,$02,$14,$DC,$21,$30,$02,$14,$DE,$21,$C0,$01,$24,$F0,$21,$C8
	db $01,$24,$F1,$21,$D0,$01,$24,$F2,$21,$D8,$01,$24,$F3,$21,$E0,$01
	db $24,$F4,$21,$E8,$01,$24,$F5,$21,$F0,$01,$24,$F6,$21,$F8,$01,$24
	db $F7,$21,$00,$00,$24,$F8,$21,$08,$00,$24,$F9,$21,$10,$00,$24,$FA
	db $21,$18,$00,$24,$FB,$21,$20,$00,$24,$FC,$21,$28,$00,$24,$FD,$21
	db $30,$00,$24,$FE,$21,$38,$00,$24,$FF,$21

DATA_0DBB3A:
	db $23,$00,$D8,$03,$D4,$A1,$20,$E8,$03,$D4,$A3,$20,$F8,$03,$D4,$A5
	db $20,$08,$02,$D4,$A7,$20,$18,$02,$D4,$A9,$20,$D8,$03,$E4,$C1,$20
	db $E8,$03,$E4,$C3,$20,$F8,$03,$E4,$C5,$20,$08,$02,$E4,$C7,$20,$18
	db $02,$E4,$C9,$20,$D8,$03,$F4,$E1,$20,$E8,$03,$F4,$E3,$20,$F8,$03
	db $F4,$E5,$20,$08,$02,$F4,$E7,$20,$18,$02,$F4,$E9,$20,$D8,$03,$04
	db $01,$21,$E8,$03,$04,$03,$21,$F8,$03,$04,$05,$21,$08,$02,$04,$07
	db $21,$18,$02,$04,$09,$21,$D8,$03,$14,$21,$21,$E8,$03,$14,$23,$21
	db $F8,$03,$14,$25,$21,$08,$02,$14,$27,$21,$18,$02,$14,$29,$21,$D8
	db $01,$24,$41,$21,$E0,$01,$24,$42,$21,$E8,$01,$24,$43,$21,$F0,$01
	db $24,$44,$21,$F8,$01,$24,$45,$21,$00,$00,$24,$46,$21,$08,$00,$24
	db $47,$21,$10,$00,$24,$48,$21,$18,$00,$24,$49,$21,$20,$00,$24,$4A
	db $21

DATA_0DBBEB:
	db $32,$00,$D8,$03,$D4,$AB,$20,$E8,$03,$D4,$AD,$20,$F8,$01,$D4,$AF
	db $20,$00,$00,$D4,$50,$21,$F8,$01,$DC,$BF,$20,$00,$00,$DC,$60,$21
	db $08,$02,$D4,$51,$21,$18,$02,$D4,$53,$21,$D8,$03,$E4,$CB,$20,$E8
	db $03,$E4,$CD,$20,$F8,$01,$E4,$CF,$20,$00,$00,$E4,$70,$21,$F8,$01
	db $EC,$DF,$20,$00,$00,$EC,$80,$21,$08,$02,$E4,$71,$21,$18,$02,$E4
	db $73,$21,$D8,$03,$F4,$EB,$20,$E8,$03,$F4,$ED,$20,$F8,$01,$F4,$EF
	db $20,$00,$00,$F4,$90,$21,$F8,$01,$FC,$FF,$20,$00,$00,$FC,$A0,$21
	db $08,$02,$F4,$91,$21,$18,$02,$F4,$93,$21,$D8,$03,$04,$0B,$21,$E8
	db $03,$04,$0D,$21,$F8,$01,$04,$0F,$21,$00,$00,$04,$B0,$21,$F8,$01
	db $0C,$1F,$21,$00,$00,$0C,$C0,$21,$08,$02,$04,$B1,$21,$18,$02,$04
	db $B3,$21,$D8,$03,$14,$2B,$21,$E8,$03,$14,$2D,$21,$F8,$01,$14,$2F
	db $21,$00,$00,$14,$D0,$21,$F8,$01,$1C,$3F,$21,$00,$00,$1C,$E0,$21
	db $08,$02,$14,$D1,$21,$18,$02,$14,$D3,$21,$D8,$01,$24,$4B,$21,$E0
	db $01,$24,$4C,$21,$E8,$01,$24,$4D,$21,$F0,$01,$24,$4E,$21,$F8,$01
	db $24,$4F,$21,$00,$00,$24,$F0,$21,$08,$00,$24,$F1,$21,$10,$00,$24
	db $F2,$21,$18,$00,$24,$F3,$21,$20,$00,$24,$F4,$21

DATA_0DBCE7:
	db $23,$00,$D8,$03,$D4,$55,$21,$E8,$03,$D4,$57,$21,$F8,$03,$D4,$59
	db $21,$08,$02,$D4,$5B,$21,$18,$02,$D4,$5D,$21,$D8,$03,$E4,$75,$21
	db $E8,$03,$E4,$77,$21,$F8,$03,$E4,$79,$21,$08,$02,$E4,$7B,$21,$18
	db $02,$E4,$7D,$21,$D8,$03,$F4,$95,$21,$E8,$03,$F4,$97,$21,$F8,$03
	db $F4,$99,$21,$08,$02,$F4,$9B,$21,$18,$02,$F4,$9D,$21,$D8,$03,$04
	db $B5,$21,$E8,$03,$04,$B7,$21,$F8,$03,$04,$B9,$21,$08,$02,$04,$BB
	db $21,$18,$02,$04,$BD,$21,$D8,$03,$14,$D5,$21,$E8,$03,$14,$D7,$21
	db $F8,$03,$14,$D9,$21,$08,$02,$14,$DB,$21,$18,$02,$14,$DD,$21,$D8
	db $01,$24,$F5,$21,$E0,$01,$24,$F6,$21,$E8,$01,$24,$F7,$21,$F0,$01
	db $24,$F8,$21,$F8,$01,$24,$F9,$21,$00,$00,$24,$FA,$21,$08,$00,$24
	db $FB,$21,$10,$00,$24,$FC,$21,$18,$00,$24,$FD,$21,$20,$00,$24,$FE
	db $21

DATA_0DBD98:
	db $23,$00,$D8,$03,$D4,$01,$21,$E8,$03,$D4,$03,$21,$F8,$03,$D4,$05
	db $21,$08,$02,$D4,$07,$21,$18,$02,$D4,$09,$21,$D8,$03,$E4,$21,$21
	db $E8,$03,$E4,$23,$21,$F8,$03,$E4,$25,$21,$08,$02,$E4,$27,$21,$18
	db $02,$E4,$29,$21,$D8,$03,$F4,$41,$21,$E8,$03,$F4,$43,$21,$F8,$03
	db $F4,$45,$21,$08,$02,$F4,$47,$21,$18,$02,$F4,$49,$21,$D8,$03,$04
	db $61,$21,$E8,$03,$04,$63,$21,$F8,$03,$04,$65,$21,$08,$02,$04,$67
	db $21,$18,$02,$04,$69,$21,$D8,$03,$14,$81,$21,$E8,$03,$14,$83,$21
	db $F8,$03,$14,$85,$21,$08,$02,$14,$87,$21,$18,$02,$14,$89,$21,$D8
	db $01,$24,$A1,$21,$E0,$01,$24,$A2,$21,$E8,$01,$24,$A3,$21,$F0,$01
	db $24,$A4,$21,$F8,$01,$24,$A5,$21,$00,$00,$24,$A6,$21,$08,$00,$24
	db $A7,$21,$10,$00,$24,$A8,$21,$18,$00,$24,$A9,$21,$20,$00,$24,$AA
	db $21

DATA_0DBE49:
	db $32,$00,$D8,$03,$D4,$0B,$21,$E8,$03,$D4,$0D,$21,$F8,$01,$D4,$0F
	db $21,$00,$00,$D4,$40,$20,$F8,$01,$DC,$1F,$21,$00,$00,$DC,$50,$20
	db $08,$02,$D4,$41,$20,$18,$02,$D4,$43,$20,$D8,$03,$E4,$2B,$21,$E8
	db $03,$E4,$2D,$21,$F8,$01,$E4,$2F,$21,$00,$00,$E4,$60,$20,$F8,$01
	db $EC,$3F,$21,$00,$00,$EC,$70,$20,$08,$02,$E4,$61,$20,$18,$02,$E4
	db $63,$20,$D8,$03,$F4,$4B,$21,$E8,$03,$F4,$4D,$21,$F8,$01,$F4,$4F
	db $21,$00,$00,$F4,$80,$20,$F8,$01,$FC,$5F,$21,$00,$00,$FC,$90,$20
	db $08,$02,$F4,$81,$20,$18,$02,$F4,$83,$20,$D8,$03,$04,$6B,$21,$E8
	db $03,$04,$6D,$21,$F8,$01,$04,$6F,$21,$00,$00,$04,$B0,$21,$F8,$01
	db $0C,$7F,$21,$00,$00,$0C,$C0,$21,$08,$02,$04,$B1,$21,$18,$02,$04
	db $B3,$21,$D8,$03,$14,$8B,$21,$E8,$03,$14,$8D,$21,$F8,$01,$14,$8F
	db $21,$00,$00,$14,$D0,$21,$F8,$01,$1C,$9F,$21,$00,$00,$1C,$E0,$21
	db $08,$02,$14,$D1,$21,$18,$02,$14,$D3,$21,$D8,$01,$24,$AB,$21,$E0
	db $01,$24,$AC,$21,$E8,$01,$24,$AD,$21,$F0,$01,$24,$AE,$21,$F8,$01
	db $24,$AF,$21,$00,$00,$24,$F0,$21,$08,$00,$24,$F1,$21,$10,$00,$24
	db $F2,$21,$18,$00,$24,$F3,$21,$20,$00,$24,$F4,$21

DATA_0DBF45:
	db $23,$00,$D8,$03,$D4,$45,$20,$E8,$03,$D4,$47,$20,$F8,$03,$D4,$49
	db $20,$08,$02,$D4,$4B,$20,$18,$02,$D4,$4D,$20,$D8,$03,$E4,$65,$20
	db $E8,$03,$E4,$67,$20,$F8,$03,$E4,$69,$20,$08,$02,$E4,$6B,$20,$18
	db $02,$E4,$6D,$20,$D8,$03,$F4,$85,$20,$E8,$03,$F4,$87,$20,$F8,$03
	db $F4,$89,$20,$08,$02,$F4,$8B,$20,$18,$02,$F4,$8D,$20,$D8,$03,$04
	db $B5,$21,$E8,$03,$04,$B7,$21,$F8,$03,$04,$B9,$21,$08,$02,$04,$BB
	db $21,$18,$02,$04,$BD,$21,$D8,$03,$14,$D5,$21,$E8,$03,$14,$D7,$21
	db $F8,$03,$14,$D9,$21,$08,$02,$14,$DB,$21,$18,$02,$14,$DD,$21,$D8
	db $01,$24,$F5,$21,$E0,$01,$24,$F6,$21,$E8,$01,$24,$F7,$21,$F0,$01
	db $24,$F8,$21,$F8,$01,$24,$F9,$21,$00,$00,$24,$FA,$21,$08,$00,$24
	db $FB,$21,$10,$00,$24,$FC,$21,$18,$00,$24,$FD,$21,$20,$00,$24,$FE
	db $21

DATA_0DBFF6:
	db $46,$00,$D8,$01,$E4,$40,$20,$E0,$01,$E4,$41,$20,$E8,$01,$E4,$42
	db $20,$F0,$01,$E4,$43,$20,$F8,$01,$E4,$44,$20,$00,$00,$E4,$45,$20
	db $08,$00,$E4,$46,$20,$10,$00,$E4,$47,$20,$18,$00,$E4,$48,$20,$20
	db $00,$E4,$49,$20,$D8,$01,$EC,$4A,$20,$E0,$01,$EC,$4B,$20,$E8,$01
	db $EC,$4C,$20,$F0,$01,$EC,$4D,$20,$F8,$01,$EC,$4E,$20,$00,$00,$EC
	db $4F,$20,$08,$00,$EC,$50,$20,$10,$00,$EC,$51,$20,$18,$00,$EC,$52
	db $20,$20,$00,$EC,$53,$20,$D8,$01,$F4,$54,$20,$E0,$01,$F4,$55,$20
	db $E8,$01,$F4,$56,$20,$F0,$01,$F4,$57,$20,$F8,$01,$F4,$58,$20,$00
	db $00,$F4,$59,$20,$08,$00,$F4,$5A,$20,$10,$00,$F4,$5B,$20,$18,$00
	db $F4,$5C,$20,$20,$00,$F4,$5D,$20,$D8,$01,$FC,$5E,$20,$E0,$01,$FC
	db $5F,$20,$E8,$01,$FC,$60,$20,$F0,$01,$FC,$61,$20,$F8,$01,$FC,$62
	db $20,$00,$00,$FC,$63,$20,$08,$00,$FC,$64,$20,$10,$00,$FC,$65,$20
	db $18,$00,$FC,$66,$20,$20,$00,$FC,$67,$20,$D8,$01,$04,$68,$20,$E0
	db $01,$04,$69,$20,$E8,$01,$04,$6A,$20,$F0,$01,$04,$6B,$20,$F8,$01
	db $04,$6C,$20,$00,$00,$04,$6D,$20,$08,$00,$04,$6E,$20,$10,$00,$04
	db $6F,$20,$18,$00,$04,$70,$20,$20,$00,$04,$71,$20,$D8,$01,$0C,$72
	db $20,$E0,$01,$0C,$73,$20,$E8,$01,$0C,$74,$20,$F0,$01,$0C,$75,$20
	db $F8,$01,$0C,$76,$20,$00,$00,$0C,$77,$20,$08,$00,$0C,$78,$20,$10
	db $00,$0C,$79,$20,$18,$00,$0C,$7A,$20,$20,$00,$0C,$7B,$20,$D8,$01
	db $14,$7C,$20,$E0,$01,$14,$7D,$20,$E8,$01,$14,$7E,$20,$F0,$01,$14
	db $7F,$20,$F8,$01,$14,$80,$20,$00,$00,$14,$81,$20,$08,$00,$14,$82
	db $20,$10,$00,$14,$83,$20,$18,$00,$14,$84,$20,$20,$00,$14,$85,$20

DATA_0DC156:
	db $46,$00,$D8,$01,$E4,$86,$20,$E0,$01,$E4,$87,$20,$E8,$01,$E4,$88	
	db $20,$F0,$01,$E4,$89,$20,$F8,$01,$E4,$8A,$20,$00,$00,$E4,$8B,$20	
	db $08,$00,$E4,$8C,$20,$10,$00,$E4,$8D,$20,$18,$00,$E4,$8E,$20,$20
	db $00,$E4,$8F,$20,$D8,$01,$EC,$90,$20,$E0,$01,$EC,$91,$20,$E8,$01
	db $EC,$92,$20,$F0,$01,$EC,$93,$20,$F8,$01,$EC,$94,$20,$00,$00,$EC
	db $95,$20,$08,$00,$EC,$96,$20,$10,$00,$EC,$97,$20,$18,$00,$EC,$98
	db $20,$20,$00,$EC,$99,$20,$D8,$01,$F4,$9A,$20,$E0,$01,$F4,$9B,$20
	db $E8,$01,$F4,$9C,$20,$F0,$01,$F4,$9D,$20,$F8,$01,$F4,$9E,$20,$00
	db $00,$F4,$9F,$20,$08,$00,$F4,$A0,$20,$10,$00,$F4,$A1,$20,$18,$00
	db $F4,$A2,$20,$20,$00,$F4,$A3,$20,$D8,$01,$FC,$A4,$20,$E0,$01,$FC
	db $A5,$20,$E8,$01,$FC,$A6,$20,$F0,$01,$FC,$A7,$20,$F8,$01,$FC,$A8
	db $20,$00,$00,$FC,$A9,$20,$08,$00,$FC,$AA,$20,$10,$00,$FC,$AB,$20
	db $18,$00,$FC,$AC,$20,$20,$00,$FC,$AD,$20,$D8,$01,$04,$AE,$20,$E0
	db $01,$04,$AF,$20,$E8,$01,$04,$B0,$20,$F0,$01,$04,$B1,$20,$F8,$01
	db $04,$B2,$20,$00,$00,$04,$B3,$20,$08,$00,$04,$B4,$20,$10,$00,$04
	db $B5,$20,$18,$00,$04,$B6,$20,$20,$00,$04,$B7,$20,$D8,$01,$0C,$B8
	db $20,$E0,$01,$0C,$B9,$20,$E8,$01,$0C,$BA,$20,$F0,$01,$0C,$BB,$20
	db $F8,$01,$0C,$BC,$20,$00,$00,$0C,$BD,$20,$08,$00,$0C,$BE,$20,$10
	db $00,$0C,$BF,$20,$18,$00,$0C,$C0,$20,$20,$00,$0C,$C1,$20,$D8,$01
	db $14,$C2,$20,$E0,$01,$14,$C3,$20,$E8,$01,$14,$C4,$20,$F0,$01,$14
	db $C5,$20,$F8,$01,$14,$C6,$20,$00,$00,$14,$C7,$20,$08,$00,$14,$C8
	db $20,$10,$00,$14,$C9,$20,$18,$00,$14,$CA,$20,$20,$00,$14,$CB,$20

DATA_0DC2B6:
	db $46,$00,$D8,$01,$E4,$CC,$20,$E0,$01,$E4,$CD,$20,$E8,$01,$E4,$CE
	db $20,$F0,$01,$E4,$CF,$20,$F8,$01,$E4,$D0,$20,$00,$00,$E4,$D1,$20
	db $08,$00,$E4,$D2,$20,$10,$00,$E4,$D3,$20,$18,$00,$E4,$D4,$20,$20
	db $00,$E4,$D5,$20,$D8,$01,$EC,$D6,$20,$E0,$01,$EC,$D7,$20,$E8,$01
	db $EC,$D8,$20,$F0,$01,$EC,$D9,$20,$F8,$01,$EC,$DA,$20,$00,$00,$EC
	db $DB,$20,$08,$00,$EC,$DC,$20,$10,$00,$EC,$DD,$20,$18,$00,$EC,$DE
	db $20,$20,$00,$EC,$DF,$20,$D8,$01,$F4,$E0,$20,$E0,$01,$F4,$E1,$20
	db $E8,$01,$F4,$E2,$20,$F0,$01,$F4,$E3,$20,$F8,$01,$F4,$E4,$20,$00
	db $00,$F4,$E5,$20,$08,$00,$F4,$E6,$20,$10,$00,$F4,$E7,$20,$18,$00
	db $F4,$E8,$20,$20,$00,$F4,$E9,$20,$D8,$01,$FC,$EA,$20,$E0,$01,$FC
	db $EB,$20,$E8,$01,$FC,$EC,$20,$F0,$01,$FC,$ED,$20,$F8,$01,$FC,$EE
	db $20,$00,$00,$FC,$EF,$20,$08,$00,$FC,$F0,$20,$10,$00,$FC,$F1,$20
	db $18,$00,$FC,$F2,$20,$20,$00,$FC,$F3,$20,$D8,$01,$04,$F4,$20,$E0
	db $01,$04,$F5,$20,$E8,$01,$04,$F6,$20,$F0,$01,$04,$F7,$20,$F8,$01
	db $04,$F8,$20,$00,$00,$04,$F9,$20,$08,$00,$04,$FA,$20,$10,$00,$04
	db $FB,$20,$18,$00,$04,$FC,$20,$20,$00,$04,$FD,$20,$D8,$01,$0C,$FE
	db $20,$E0,$01,$0C,$FF,$20,$E8,$01,$0C,$00,$21,$F0,$01,$0C,$01,$21
	db $F8,$01,$0C,$02,$21,$00,$00,$0C,$03,$21,$08,$00,$0C,$04,$21,$10
	db $00,$0C,$05,$21,$18,$00,$0C,$06,$21,$20,$00,$0C,$07,$21,$D8,$01
	db $14,$08,$21,$E0,$01,$14,$09,$21,$E8,$01,$14,$0A,$21,$F0,$01,$14
	db $0B,$21,$F8,$01,$14,$0C,$21,$00,$00,$14,$0D,$21,$08,$00,$14,$0E
	db $21,$10,$00,$14,$0F,$21,$18,$00,$14,$10,$21,$20,$00,$14,$11,$21

DATA_0DC416:
	db $46,$00,$D8,$01,$E4,$12,$21,$E0,$01,$E4,$13,$21,$E8,$01,$E4,$14
	db $21,$F0,$01,$E4,$15,$21,$F8,$01,$E4,$16,$21,$00,$00,$E4,$17,$21
	db $08,$00,$E4,$18,$21,$10,$00,$E4,$19,$21,$18,$00,$E4,$1A,$21,$20
	db $00,$E4,$1B,$21,$D8,$01,$EC,$1C,$21,$E0,$01,$EC,$1D,$21,$E8,$01
	db $EC,$1E,$21,$F0,$01,$EC,$1F,$21,$F8,$01,$EC,$20,$21,$00,$00,$EC
	db $21,$21,$08,$00,$EC,$22,$21,$10,$00,$EC,$23,$21,$18,$00,$EC,$24
	db $21,$20,$00,$EC,$25,$21,$D8,$01,$F4,$26,$21,$E0,$01,$F4,$27,$21
	db $E8,$01,$F4,$28,$21,$F0,$01,$F4,$29,$21,$F8,$01,$F4,$2A,$21,$00
	db $00,$F4,$2B,$21,$08,$00,$F4,$2C,$21,$10,$00,$F4,$2D,$21,$18,$00
	db $F4,$2E,$21,$20,$00,$F4,$2F,$21,$D8,$01,$FC,$30,$21,$E0,$01,$FC
	db $31,$21,$E8,$01,$FC,$32,$21,$F0,$01,$FC,$33,$21,$F8,$01,$FC,$34
	db $21,$00,$00,$FC,$35,$21,$08,$00,$FC,$36,$21,$10,$00,$FC,$37,$21
	db $18,$00,$FC,$38,$21,$20,$00,$FC,$39,$21,$D8,$01,$04,$3A,$21,$E0
	db $01,$04,$3B,$21,$E8,$01,$04,$3C,$21,$F0,$01,$04,$3D,$21,$F8,$01
	db $04,$3E,$21,$00,$00,$04,$3F,$21,$08,$00,$04,$40,$21,$10,$00,$04
	db $41,$21,$18,$00,$04,$42,$21,$20,$00,$04,$43,$21,$D8,$01,$0C,$44
	db $21,$E0,$01,$0C,$45,$21,$E8,$01,$0C,$46,$21,$F0,$01,$0C,$47,$21
	db $F8,$01,$0C,$48,$21,$00,$00,$0C,$49,$21,$08,$00,$0C,$4A,$21,$10
	db $00,$0C,$4B,$21,$18,$00,$0C,$4C,$21,$20,$00,$0C,$4D,$21,$D8,$01
	db $14,$4E,$21,$E0,$01,$14,$4F,$21,$E8,$01,$14,$50,$21,$F0,$01,$14
	db $51,$21,$F8,$01,$14,$52,$21,$00,$00,$14,$53,$21,$08,$00,$14,$54
	db $21,$10,$00,$14,$55,$21,$18,$00,$14,$56,$21,$20,$00,$14,$57,$21

DATA_0DC576:
	db $46,$00,$D8,$01,$E4,$58,$21,$E0,$01,$E4,$59,$21,$E8,$01,$E4,$5A
	db $21,$F0,$01,$E4,$5B,$21,$F8,$01,$E4,$5C,$21,$00,$00,$E4,$5D,$21
	db $08,$00,$E4,$5E,$21,$10,$00,$E4,$5F,$21,$18,$00,$E4,$60,$21,$20
	db $00,$E4,$61,$21,$D8,$01,$EC,$62,$21,$E0,$01,$EC,$63,$21,$E8,$01
	db $EC,$64,$21,$F0,$01,$EC,$65,$21,$F8,$01,$EC,$66,$21,$00,$00,$EC
	db $67,$21,$08,$00,$EC,$68,$21,$10,$00,$EC,$69,$21,$18,$00,$EC,$6A
	db $21,$20,$00,$EC,$6B,$21,$D8,$01,$F4,$6C,$21,$E0,$01,$F4,$6D,$21
	db $E8,$01,$F4,$6E,$21,$F0,$01,$F4,$6F,$21,$F8,$01,$F4,$70,$21,$00
	db $00,$F4,$71,$21,$08,$00,$F4,$72,$21,$10,$00,$F4,$73,$21,$18,$00
	db $F4,$74,$21,$20,$00,$F4,$75,$21,$D8,$01,$FC,$76,$21,$E0,$01,$FC
	db $77,$21,$E8,$01,$FC,$78,$21,$F0,$01,$FC,$79,$21,$F8,$01,$FC,$7A
	db $21,$00,$00,$FC,$7B,$21,$08,$00,$FC,$7C,$21,$10,$00,$FC,$7D,$21
	db $18,$00,$FC,$7E,$21,$20,$00,$FC,$7F,$21,$D8,$01,$04,$80,$21,$E0
	db $01,$04,$81,$21,$E8,$01,$04,$82,$21,$F0,$01,$04,$83,$21,$F8,$01
	db $04,$84,$21,$00,$00,$04,$85,$21,$08,$00,$04,$86,$21,$10,$00,$04
	db $87,$21,$18,$00,$04,$88,$21,$20,$00,$04,$89,$21,$D8,$01,$0C,$8A
	db $21,$E0,$01,$0C,$8B,$21,$E8,$01,$0C,$8C,$21,$F0,$01,$0C,$8D,$21
	db $F8,$01,$0C,$8E,$21,$00,$00,$0C,$8F,$21,$08,$00,$0C,$90,$21,$10
	db $00,$0C,$91,$21,$18,$00,$0C,$92,$21,$20,$00,$0C,$93,$21,$D8,$01
	db $14,$94,$21,$E0,$01,$14,$95,$21,$E8,$01,$14,$96,$21,$F0,$01,$14
	db $97,$21,$F8,$01,$14,$98,$21,$00,$00,$14,$99,$21,$08,$00,$14,$9A
	db $21,$10,$00,$14,$9B,$21,$18,$00,$14,$9C,$21,$20,$00,$14,$9D,$21

DATA_0DC6D6:
	db $46,$00,$D8,$01,$E4,$9E,$21,$E0,$01,$E4,$9F,$21,$E8,$01,$E4,$A0
	db $21,$F0,$01,$E4,$A1,$21,$F8,$01,$E4,$A2,$21,$00,$00,$E4,$A3,$21
	db $08,$00,$E4,$A4,$21,$10,$00,$E4,$A5,$21,$18,$00,$E4,$A6,$21,$20
	db $00,$E4,$A7,$21,$D8,$01,$EC,$A8,$21,$E0,$01,$EC,$A9,$21,$E8,$01
	db $EC,$AA,$21,$F0,$01,$EC,$AB,$21,$F8,$01,$EC,$AC,$21,$00,$00,$EC
	db $AD,$21,$08,$00,$EC,$AE,$21,$10,$00,$EC,$AF,$21,$18,$00,$EC,$B0
	db $21,$20,$00,$EC,$B1,$21,$D8,$01,$F4,$B2,$21,$E0,$01,$F4,$B3,$21
	db $E8,$01,$F4,$B4,$21,$F0,$01,$F4,$B5,$21,$F8,$01,$F4,$B6,$21,$00
	db $00,$F4,$B7,$21,$08,$00,$F4,$B8,$21,$10,$00,$F4,$B9,$21,$18,$00
	db $F4,$BA,$21,$20,$00,$F4,$BB,$21,$D8,$01,$FC,$BC,$21,$E0,$01,$FC
	db $BD,$21,$E8,$01,$FC,$BE,$21,$F0,$01,$FC,$BF,$21,$F8,$01,$FC,$C0
	db $21,$00,$00,$FC,$C1,$21,$08,$00,$FC,$C2,$21,$10,$00,$FC,$C3,$21
	db $18,$00,$FC,$C4,$21,$20,$00,$FC,$C5,$21,$D8,$01,$04,$C6,$21,$E0
	db $01,$04,$C7,$21,$E8,$01,$04,$C8,$21,$F0,$01,$04,$C9,$21,$F8,$01
	db $04,$CA,$21,$00,$00,$04,$CB,$21,$08,$00,$04,$CC,$21,$10,$00,$04
	db $CD,$21,$18,$00,$04,$CE,$21,$20,$00,$04,$CF,$21,$D8,$01,$0C,$D0
	db $21,$E0,$01,$0C,$D1,$21,$E8,$01,$0C,$D2,$21,$F0,$01,$0C,$D3,$21
	db $F8,$01,$0C,$D4,$21,$00,$00,$0C,$D5,$21,$08,$00,$0C,$D6,$21,$10
	db $00,$0C,$D7,$21,$18,$00,$0C,$D8,$21,$20,$00,$0C,$D9,$21,$D8,$01
	db $14,$DA,$21,$E0,$01,$14,$DB,$21,$E8,$01,$14,$DC,$21,$F0,$01,$14
	db $DD,$21,$F8,$01,$14,$DE,$21,$00,$00,$14,$DF,$21,$08,$00,$14,$E0
	db $21,$10,$00,$14,$E1,$21,$18,$00,$14,$E2,$21,$20,$00,$14,$E3,$21

DATA_0DC836:
	db $46,$00,$D8,$01,$E4,$00,$21,$E0,$01,$E4,$01,$21,$E8,$01,$E4,$02
	db $21,$F0,$01,$E4,$03,$21,$F8,$01,$E4,$04,$21,$00,$00,$E4,$05,$21
	db $08,$00,$E4,$06,$21,$10,$00,$E4,$07,$21,$18,$00,$E4,$08,$21,$20
	db $00,$E4,$09,$21,$D8,$01,$EC,$0A,$21,$E0,$01,$EC,$0B,$21,$E8,$01
	db $EC,$0C,$21,$F0,$01,$EC,$0D,$21,$F8,$01,$EC,$0E,$21,$00,$00,$EC
	db $0F,$21,$08,$00,$EC,$10,$21,$10,$00,$EC,$11,$21,$18,$00,$EC,$12
	db $21,$20,$00,$EC,$13,$21,$D8,$01,$F4,$14,$21,$E0,$01,$F4,$15,$21
	db $E8,$01,$F4,$16,$21,$F0,$01,$F4,$17,$21,$F8,$01,$F4,$18,$21,$00
	db $00,$F4,$19,$21,$08,$00,$F4,$1A,$21,$10,$00,$F4,$1B,$21,$18,$00
	db $F4,$1C,$21,$20,$00,$F4,$1D,$21,$D8,$01,$FC,$1E,$21,$E0,$01,$FC
	db $1F,$21,$E8,$01,$FC,$20,$21,$F0,$01,$FC,$21,$21,$F8,$01,$FC,$22
	db $21,$00,$00,$FC,$23,$21,$08,$00,$FC,$24,$21,$10,$00,$FC,$25,$21
	db $18,$00,$FC,$26,$21,$20,$00,$FC,$27,$21,$D8,$01,$04,$28,$21,$E0
	db $01,$04,$29,$21,$E8,$01,$04,$2A,$21,$F0,$01,$04,$2B,$21,$F8,$01
	db $04,$2C,$21,$00,$00,$04,$2D,$21,$08,$00,$04,$2E,$21,$10,$00,$04
	db $2F,$21,$18,$00,$04,$30,$21,$20,$00,$04,$31,$21,$D8,$01,$0C,$32
	db $21,$E0,$01,$0C,$33,$21,$E8,$01,$0C,$34,$21,$F0,$01,$0C,$35,$21
	db $F8,$01,$0C,$36,$21,$00,$00,$0C,$37,$21,$08,$00,$0C,$38,$21,$10
	db $00,$0C,$39,$21,$18,$00,$0C,$3A,$21,$20,$00,$0C,$3B,$21,$D8,$01
	db $14,$3C,$21,$E0,$01,$14,$3D,$21,$E8,$01,$14,$3E,$21,$F0,$01,$14
	db $3F,$21,$F8,$01,$14,$40,$21,$00,$00,$14,$41,$21,$08,$00,$14,$42
	db $21,$10,$00,$14,$43,$21,$18,$00,$14,$44,$21,$20,$00,$14,$45,$21

DATA_0DC996:
	db $46,$00,$D8,$01,$E4,$46,$21,$E0,$01,$E4,$47,$21,$E8,$01,$E4,$48
	db $21,$F0,$01,$E4,$49,$21,$F8,$01,$E4,$4A,$21,$00,$00,$E4,$4B,$21
	db $08,$00,$E4,$4C,$21,$10,$00,$E4,$4D,$21,$18,$00,$E4,$4E,$21,$20
	db $00,$E4,$4F,$21,$D8,$01,$EC,$50,$21,$E0,$01,$EC,$51,$21,$E8,$01
	db $EC,$52,$21,$F0,$01,$EC,$53,$21,$F8,$01,$EC,$54,$21,$00,$00,$EC
	db $55,$21,$08,$00,$EC,$56,$21,$10,$00,$EC,$57,$21,$18,$00,$EC,$58
	db $21,$20,$00,$EC,$59,$21,$D8,$01,$F4,$5A,$21,$E0,$01,$F4,$5B,$21
	db $E8,$01,$F4,$5C,$21,$F0,$01,$F4,$5D,$21,$F8,$01,$F4,$5E,$21,$00
	db $00,$F4,$5F,$21,$08,$00,$F4,$60,$21,$10,$00,$F4,$61,$21,$18,$00
	db $F4,$62,$21,$20,$00,$F4,$63,$21,$D8,$01,$FC,$64,$21,$E0,$01,$FC
	db $65,$21,$E8,$01,$FC,$66,$21,$F0,$01,$FC,$67,$21,$F8,$01,$FC,$68
	db $21,$00,$00,$FC,$69,$21,$08,$00,$FC,$6A,$21,$10,$00,$FC,$6B,$21
	db $18,$00,$FC,$6C,$21,$20,$00,$FC,$6D,$21,$D8,$01,$04,$6E,$21,$E0
	db $01,$04,$6F,$21,$E8,$01,$04,$70,$21,$F0,$01,$04,$71,$21,$F8,$01
	db $04,$72,$21,$00,$00,$04,$73,$21,$08,$00,$04,$74,$21,$10,$00,$04
	db $75,$21,$18,$00,$04,$76,$21,$20,$00,$04,$77,$21,$D8,$01,$0C,$78
	db $21,$E0,$01,$0C,$79,$21,$E8,$01,$0C,$7A,$21,$F0,$01,$0C,$7B,$21
	db $F8,$01,$0C,$7C,$21,$00,$00,$0C,$7D,$21,$08,$00,$0C,$7E,$21,$10
	db $00,$0C,$7F,$21,$18,$00,$0C,$80,$21,$20,$00,$0C,$81,$21,$D8,$01
	db $14,$82,$21,$E0,$01,$14,$83,$21,$E8,$01,$14,$84,$21,$F0,$01,$14
	db $85,$21,$F8,$01,$14,$86,$21,$00,$00,$14,$87,$21,$08,$00,$14,$88
	db $21,$10,$00,$14,$89,$21,$18,$00,$14,$8A,$21,$20,$00,$14,$8B,$21

DATA_0DCAF6:
	db $46,$00,$D8,$01,$E4,$8C,$21,$E0,$01,$E4,$8D,$21,$E8,$01,$E4,$8E
	db $21,$F0,$01,$E4,$8F,$21,$F8,$01,$E4,$90,$21,$00,$00,$E4,$91,$21
	db $08,$00,$E4,$92,$21,$10,$00,$E4,$93,$21,$18,$00,$E4,$94,$21,$20
	db $00,$E4,$95,$21,$D8,$01,$EC,$96,$21,$E0,$01,$EC,$97,$21,$E8,$01
	db $EC,$98,$21,$F0,$01,$EC,$99,$21,$F8,$01,$EC,$9A,$21,$00,$00,$EC
	db $9B,$21,$08,$00,$EC,$9C,$21,$10,$00,$EC,$9D,$21,$18,$00,$EC,$9E
	db $21,$20,$00,$EC,$9F,$21,$D8,$01,$F4,$A0,$21,$E0,$01,$F4,$A1,$21
	db $E8,$01,$F4,$A2,$21,$F0,$01,$F4,$A3,$21,$F8,$01,$F4,$A4,$21,$00
	db $00,$F4,$A5,$21,$08,$00,$F4,$A6,$21,$10,$00,$F4,$A7,$21,$18,$00
	db $F4,$A8,$21,$20,$00,$F4,$A9,$21,$D8,$01,$FC,$AA,$21,$E0,$01,$FC
	db $AB,$21,$E8,$01,$FC,$AC,$21,$F0,$01,$FC,$AD,$21,$F8,$01,$FC,$AE
	db $21,$00,$00,$FC,$AF,$21,$08,$00,$FC,$B0,$21,$10,$00,$FC,$B1,$21
	db $18,$00,$FC,$B2,$21,$20,$00,$FC,$B3,$21,$D8,$01,$04,$B4,$21,$E0
	db $01,$04,$B5,$21,$E8,$01,$04,$B6,$21,$F0,$01,$04,$B7,$21,$F8,$01
	db $04,$B8,$21,$00,$00,$04,$B9,$21,$08,$00,$04,$BA,$21,$10,$00,$04
	db $BB,$21,$18,$00,$04,$BC,$21,$20,$00,$04,$BD,$21,$D8,$01,$0C,$BE
	db $21,$E0,$01,$0C,$BF,$21,$E8,$01,$0C,$C0,$21,$F0,$01,$0C,$C1,$21
	db $F8,$01,$0C,$C2,$21,$00,$00,$0C,$C3,$21,$08,$00,$0C,$C4,$21,$10
	db $00,$0C,$C5,$21,$18,$00,$0C,$C6,$21,$20,$00,$0C,$C7,$21,$D8,$01
	db $14,$C8,$21,$E0,$01,$14,$C9,$21,$E8,$01,$14,$CA,$21,$F0,$01,$14
	db $CB,$21,$F8,$01,$14,$CC,$21,$00,$00,$14,$CD,$21,$08,$00,$14,$CE
	db $21,$10,$00,$14,$CF,$21,$18,$00,$14,$D0,$21,$20,$00,$14,$D1,$21

DATA_0DCC56:
	db $03,$00,$08,$00,$10,$E1,$39,$00,$00,$10,$E0,$39,$00,$02,$00,$C0
	db $39

DATA_0DCC67:
	db $03,$00,$08,$00,$10,$E3,$39,$00,$00,$10,$E2,$39,$00,$02,$00,$C2
	db $39

DATA_0DCC78:
	db $03,$00,$08,$00,$10,$E5,$39,$00,$00,$10,$E4,$39,$00,$02,$00,$C4
	db $39

DATA_0DCC89:
	db $03,$00,$08,$00,$10,$E7,$39,$00,$00,$10,$E6,$39,$00,$02,$00,$C6
	db $39

DATA_0DCC9A:
	db $03,$00,$08,$00,$10,$E9,$39,$00,$00,$10,$E8,$39,$00,$02,$00,$C8
	db $39

DATA_0DCCAB:
	db $01,$00,$00,$02,$00,$8A,$38

DATA_0DCCB2:
	db $02,$00,$00,$02,$00,$8A,$38,$10,$02,$00,$8A,$38

DATA_0DCCBE:
	db $03,$00,$00,$02,$00,$8A,$38,$10,$02,$00,$8A,$38,$20,$02,$00,$8A
	db $38

DATA_0DCCCF:
	db $01,$00,$00,$02,$00,$8C,$38

DATA_0DCCD6:
	db $02,$00,$00,$02,$00,$8C,$38,$10,$02,$00,$8C,$38

DATA_0DCCE2:
	db $03,$00,$00,$02,$00,$8C,$38,$10,$02,$00,$8C,$38,$20,$02,$00,$8C
	db $38

DATA_0DCCF3:
	db $01,$00,$00,$02,$00,$8E,$38

DATA_0DCCFA:
	db $02,$00,$00,$02,$00,$8E,$38,$10,$02,$00,$8E,$38

DATA_0DCD06:
	db $03,$00,$00,$02,$00,$8E,$38,$10,$02,$00,$8E,$38,$20,$02,$00,$8E
	db $38

DATA_0DCD17:
	db $10,$00,$20,$02,$20,$CC,$3B,$00,$02,$20,$C8,$3B,$E0,$03,$20,$C4
	db $3B,$C0,$03,$20,$C0,$3B,$20,$02,$00,$8C,$3B,$00,$02,$00,$88,$3B
	db $E0,$03,$00,$84,$3B,$C0,$03,$00,$80,$3B,$20,$02,$E0,$4C,$3B,$00
	db $02,$E0,$48,$3B,$E0,$03,$E0,$44,$3B,$C0,$03,$E0,$40,$3B,$20,$02
	db $C0,$0C,$3B,$00,$02,$C0,$08,$3B,$E0,$03,$C0,$04,$3B,$C0,$03,$C0
	db $00,$3B

DATA_0DCD69:
	db $01,$00,$E0,$01,$18,$0A,$38

DATA_0DCD70:
	db $01,$00,$E0,$01,$18,$0B,$38

DATA_0DCD77:
	db $02,$00,$E8,$01,$18,$F0,$38,$E8,$01,$10,$E0,$38

DATA_0DCD83:
	db $01,$00,$E8,$01,$18,$E1,$38

DATA_0DCD8A:
	db $02,$00,$F0,$01,$18,$1B,$38,$E8,$01,$18,$1A,$38

DATA_0DCD96:
	db $04,$00,$08,$00,$08,$3A,$30,$00,$00,$08,$39,$30,$08,$00,$00,$2A
	db $30,$00,$00,$00,$29,$30

DATA_0DCDAC:
	db $04,$00,$08,$00,$08,$3C,$30,$00,$00,$08,$3B,$30,$08,$00,$00,$2C
	db $30,$00,$00,$00,$2B,$30

DATA_0DCDC2:
	db $04,$00,$08,$00,$08,$29,$30,$00,$00,$08,$2A,$30,$08,$00,$00,$39
	db $30,$00,$00,$00,$3A,$30

DATA_0DCDD8:
	db $04,$00,$08,$00,$08,$2A,$30,$00,$00,$08,$29,$30,$08,$00,$00,$3A
	db $30,$00,$00,$00,$39,$30

DATA_0DCDEE:
	db $01,$00,$DF,$01,$17,$E2,$30

DATA_0DCDF5:
	db $01,$00,$E5,$01,$17,$E3,$30

DATA_0DCDFC:
	db $01,$00,$EB,$01,$17,$F1,$30

DATA_0DCE03:
	db $01,$00,$F1,$01,$17,$F2,$30

DATA_0DCE0A:
	db $02,$00,$EF,$01,$19,$2D,$78,$E1,$01,$19,$2D,$38

DATA_0DCE16:
	db $02,$00,$EF,$01,$19,$2E,$78,$E1,$01,$19,$2E,$38

DATA_0DCE22:
	db $02,$00,$EF,$01,$19,$2F,$78,$E1,$01,$19,$2F,$38

DATA_0DCE2E:
	db $02,$00,$EF,$01,$19,$3D,$78,$E1,$01,$19,$3D,$38

DATA_0DCE3A:
	db $01,$00,$E0,$01,$18,$40,$30

DATA_0DCE41:
	db $01,$00,$E0,$01,$18,$41,$30

DATA_0DCE48:
	db $01,$00,$E0,$01,$18,$42,$30

DATA_0DCE4F:
	db $01,$00,$E0,$01,$18,$43,$30

DATA_0DCE56:
	db $01,$00,$E0,$01,$18,$44,$30

DATA_0DCE5D:
	db $01,$00,$E0,$01,$18,$45,$30

DATA_0DCE64:
	db $01,$00,$E0,$01,$18,$46,$30

DATA_0DCE6B:
	db $03,$00,$F0,$01,$18,$4C,$36,$E8,$01,$18,$4B,$36,$E0,$01,$18,$4A
	db $36

DATA_0DCE7C:
	db $03,$00,$F0,$01,$18,$4F,$36,$E8,$01,$18,$4E,$36,$E0,$01,$18,$4D
	db $36

DATA_0DCE8D:
	db $01,$00,$E0,$01,$18,$47,$34

DATA_0DCE94:
	db $01,$00,$E0,$01,$18,$48,$34

DATA_0DCE9B:
	db $01,$00,$E0,$01,$18,$49,$34

DATA_0DCEA2:
	db $04,$00,$08,$00,$08,$69,$30,$00,$00,$08,$68,$30,$08,$00,$00,$59
	db $30,$00,$00,$00,$58,$30

DATA_0DCEB8:
	db $04,$00,$08,$00,$08,$9B,$30,$00,$00,$08,$9A,$30,$08,$00,$00,$8B
	db $30,$00,$00,$00,$8A,$30

DATA_0DCECE:
	db $04,$00,$DC,$01,$00,$0F,$76,$DC,$01,$08,$1F,$76,$1C,$00,$00,$0F
	db $36,$1C,$00,$08,$1F,$36

DATA_0DCEE4:
	db $08,$00,$D4,$01,$00,$B9,$76,$DC,$01,$00,$B8,$76,$D4,$01,$08,$C9
	db $76,$DC,$01,$08,$C8,$76,$1C,$00,$00,$B8,$36,$24,$00,$00,$B9,$36
	db $1C,$00,$08,$C8,$36,$24,$00,$08,$C9,$36

DATA_0DCF0E:
	db $08,$00,$D4,$01,$00,$BB,$76,$DC,$01,$00,$BA,$76,$D4,$01,$08,$CB
	db $76,$DC,$01,$08,$CA,$76,$1C,$00,$00,$BA,$36,$24,$00,$00,$BB,$36
	db $1C,$00,$08,$CA,$36,$24,$00,$08,$CB,$36

DATA_0DCF38:
	db $08,$00,$D4,$01,$00,$BD,$76,$DC,$01,$00,$BC,$76,$D4,$01,$08,$CD
	db $76,$DC,$01,$08,$CC,$76,$1C,$00,$00,$BC,$36,$24,$00,$00,$BD,$36
	db $1C,$00,$08,$CC,$36,$24,$00,$08,$CD,$36

DATA_0DCF62:
	db $08,$00,$D4,$01,$00,$BF,$76,$DC,$01,$00,$BE,$76,$D4,$01,$08,$CF
	db $76,$DC,$01,$08,$CE,$76,$1C,$00,$00,$BE,$36,$24,$00,$00,$BF,$36
	db $1C,$00,$08,$CE,$36,$24,$00,$08,$CF,$36

DATA_0DCF8C:
	db $04,$00,$E8,$01,$18,$71,$36,$E0,$01,$18,$70,$36,$E8,$01,$10,$61
	db $36,$E0,$01,$10,$60,$36

DATA_0DCFA2:
	db $04,$00,$E8,$01,$18,$73,$36,$E0,$01,$18,$72,$36,$E8,$01,$10,$63
	db $36,$E0,$01,$10,$62,$36

DATA_0DCFB8:
	db $04,$00,$E8,$01,$18,$75,$36,$E0,$01,$18,$74,$36,$E8,$01,$10,$65
	db $36,$E0,$01,$10,$64,$36

DATA_0DCFCE:
	db $01,$00,$E0,$01,$10,$50,$30

DATA_0DCFD5:
	db $01,$00,$E0,$01,$10,$51,$30

DATA_0DCFDC:
	db $01,$00,$E0,$01,$10,$52,$30

DATA_0DCFE3:
	db $01,$00,$E0,$01,$10,$53,$30

DATA_0DCFEA:
	db $01,$00,$E0,$01,$18,$54,$30

DATA_0DCFF1:
	db $01,$00,$E0,$01,$18,$55,$30

DATA_0DCFF8:
	db $01,$00,$E0,$01,$18,$56,$30

DATA_0DCFFF:
	db $01,$00,$E0,$01,$18,$57,$30

DATA_0DD006:
	db $06,$00,$F0,$01,$18,$15,$38,$E8,$01,$18,$14,$38,$E0,$01,$18,$13
	db $38,$F0,$01,$10,$05,$38,$E8,$01,$10,$04,$38,$E0,$01,$10,$03,$38

DATA_0DD026:
	db $09,$00,$F0,$01,$18,$32,$38,$E8,$01,$18,$31,$38,$E0,$01,$18,$30
	db $38,$F0,$01,$10,$15,$38,$E8,$01,$10,$14,$38,$E0,$01,$10,$13,$38
	db $F0,$01,$08,$05,$38,$E8,$01,$08,$04,$38,$E0,$01,$08,$03,$38

DATA_0DD055:
	db $0C,$00,$F0,$01,$18,$32,$38,$E8,$01,$18,$31,$38,$E0,$01,$18,$30
	db $38,$F0,$01,$10,$22,$38,$E8,$01,$10,$21,$38,$E0,$01,$10,$20,$38
	db $F0,$01,$08,$12,$38,$E8,$01,$08,$11,$38,$E0,$01,$08,$10,$38,$F0
	db $01,$00,$02,$38,$E8,$01,$00,$01,$38,$E0,$01,$00,$00,$38

DATA_0DD093:
	db $0C,$00,$F0,$01,$08,$12,$38,$F0,$01,$00,$02,$38,$E0,$01,$08,$10
	db $38,$E0,$01,$00,$00,$38,$E8,$01,$08,$19,$38,$E8,$01,$00,$09,$38
	db $F0,$01,$18,$32,$38,$E8,$01,$18,$31,$38,$E0,$01,$18,$30,$38,$F0
	db $01,$10,$15,$38,$E8,$01,$10,$14,$38,$E0,$01,$10,$13,$38

DATA_0DD0D1:
	db $06,$00,$F0,$01,$18,$35,$34,$E8,$01,$18,$34,$34,$E0,$01,$18,$33
	db $34,$F0,$01,$10,$25,$34,$E8,$01,$10,$24,$34,$E0,$01,$10,$23,$34

DATA_0DD0F1:
	db $09,$00,$F0,$01,$18,$38,$34,$E8,$01,$18,$37,$34,$E0,$01,$18,$36
	db $34,$F0,$01,$10,$28,$34,$E8,$01,$10,$27,$34,$E0,$01,$10,$26,$34
	db $F0,$01,$08,$18,$34,$E8,$01,$08,$17,$34,$E0,$01,$08,$16,$34

DATA_0DD120:
	db $0B,$00,$F0,$01,$00,$08,$34,$E8,$01,$00,$07,$34,$F0,$01,$18,$38
	db $34,$E8,$01,$18,$37,$34,$E0,$01,$18,$36,$34,$F0,$01,$10,$28,$34
	db $E8,$01,$10,$27,$34,$E0,$01,$10,$26,$34,$F0,$01,$08,$18,$34,$E8
	db $01,$08,$17,$34,$E0,$01,$08,$16,$34

DATA_0DD159:
	db $0B,$00,$F0,$01,$00,$08,$34,$E8,$01,$00,$06,$34,$F0,$01,$18,$38
	db $34,$E8,$01,$18,$37,$34,$E0,$01,$18,$36,$34,$F0,$01,$10,$28,$34
	db $E8,$01,$10,$27,$34,$E0,$01,$10,$26,$34,$F0,$01,$08,$18,$34,$E8
	db $01,$08,$17,$34,$E0,$01,$08,$16,$34

DATA_0DD192:
	db $02,$00,$00,$00,$00,$66,$3A,$00,$00,$08,$67,$3A

DATA_0DD19E:
	db $04,$00,$00,$00,$00,$8C,$30,$08,$00,$00,$8D,$30,$00,$00,$08,$9C
	db $30,$08,$00,$08,$9D,$30

DATA_0DD1B4:
	db $04,$00,$00,$00,$00,$8E,$30,$08,$00,$00,$8F,$30,$00,$00,$08,$9E
	db $30,$08,$00,$08,$9F,$30

DATA_0DD1CA:
	db $09,$00,$00,$00,$00,$B0,$3C,$08,$00,$00,$B1,$3C,$10,$00,$00,$B2
	db $3C,$18,$00,$00,$B3,$3C,$00,$00,$08,$C0,$3C,$08,$00,$08,$C1,$3C
	db $10,$00,$08,$C2,$3C,$18,$00,$08,$C3,$3C,$20,$00,$08,$AA,$3C

DATA_0DD1F9:
	db $09,$00,$00,$00,$00,$B4,$3C,$08,$00,$00,$B5,$3C,$10,$00,$00,$B6
	db $3C,$18,$00,$00,$B7,$3C,$00,$00,$08,$C4,$3C,$08,$00,$08,$C5,$3C
	db $10,$00,$08,$C6,$3C,$18,$00,$08,$C7,$3C,$20,$00,$08,$AA,$3C

DATA_0DD228:
	db $01,$00,$00,$02,$00,$00,$30

DATA_0DD22F:
	db $01,$00,$00,$02,$00,$02,$30

DATA_0DD236:
	db $01,$00,$00,$02,$00,$04,$30

DATA_0DD23D:
	db $01,$00,$00,$02,$00,$06,$30

DATA_0DD244:
	db $01,$00,$00,$02,$00,$08,$30

DATA_0DD24B:
	db $01,$00,$00,$02,$00,$0A,$30

DATA_0DD252:
	db $01,$00,$00,$02,$00,$20,$30

DATA_0DD259:
	db $01,$00,$00,$02,$00,$22,$30

DATA_0DD260:
	db $01,$00,$00,$02,$00,$24,$30

DATA_0DD267:
	db $01,$00,$00,$02,$00,$26,$30

DATA_0DD26E:
	db $01,$00,$00,$02,$00,$28,$30

DATA_0DD275:
	db $01,$00,$00,$02,$00,$2A,$30

DATA_0DD27C:
	db $01,$00,$00,$02,$00,$2C,$30

DATA_0DD283:
	db $01,$00,$00,$02,$00,$2E,$30

DATA_0DD28A:
	db $03,$00,$00,$02,$00,$20,$32,$00,$00,$10,$40,$32,$08,$00,$10,$41
	db $32

DATA_0DD29B:
	db $03,$00,$00,$00,$01,$20,$32,$08,$00,$01,$21,$32,$00,$02,$08,$32
	db $32

DATA_0DD2AC:
	db $03,$00,$00,$02,$00,$24,$32,$00,$00,$10,$44,$32,$08,$00,$10,$45
	db $32

DATA_0DD2BD:
	db $03,$00,$00,$02,$01,$24,$32,$00,$00,$10,$22,$32,$08,$00,$10,$23
	db $32

DATA_0DD2CE:
	db $01,$00,$00,$00,$00,$2A,$3E

DATA_0DD2D5:
	db $02,$00,$00,$00,$00,$2A,$3E,$00,$00,$08,$2B,$3E

DATA_0DD2E1:
	db $03,$00,$00,$00,$00,$2A,$3E,$00,$00,$08,$2B,$3E,$00,$00,$10,$2D
	db $3E

DATA_0DD2F2:
	db $04,$00,$00,$00,$00,$2A,$3E,$00,$00,$08,$2B,$3E,$00,$00,$10,$2D
	db $3E,$F8,$01,$10,$2C,$3E

DATA_0DD308:
	db $05,$00,$00,$00,$00,$2A,$3E,$00,$00,$08,$2B,$3E,$00,$00,$10,$2D
	db $3E,$F8,$01,$10,$2C,$3E,$F8,$01,$18,$2E,$3E

DATA_0DD323:
	db $06,$00,$00,$00,$00,$2A,$3E,$00,$00,$08,$2B,$3E,$00,$00,$10,$2D
	db $3E,$F8,$01,$10,$2C,$3E,$F8,$01,$18,$2E,$3E,$F8,$01,$20,$2F,$3E

DATA_0DD343:
	db $07,$00,$00,$00,$00,$2A,$3E,$00,$00,$08,$2B,$3E,$00,$00,$10,$2D
	db $3E,$F8,$01,$10,$2C,$3E,$F8,$01,$18,$2E,$3E,$F8,$01,$20,$2F,$3E
	db $F8,$01,$28,$3A,$3E

DATA_0DD368:
	db $08,$00,$00,$00,$00,$2A,$3E,$00,$00,$08,$2B,$3E,$00,$00,$10,$2D
	db $3E,$F8,$01,$10,$2C,$3E,$F8,$01,$18,$2E,$3E,$F8,$01,$20,$2F,$3E
	db $F8,$01,$28,$3A,$3E,$00,$00,$28,$3B,$3E

DATA_0DD392:
	db $0A,$00,$00,$00,$00,$2A,$3E,$00,$00,$08,$2B,$3E,$00,$00,$10,$2D
	db $3E,$F8,$01,$10,$2C,$3E,$F8,$01,$18,$2E,$3E,$F8,$01,$20,$2F,$3E
	db $F8,$01,$28,$3A,$3E,$00,$00,$28,$3B,$3E,$08,$00,$28,$3C,$3E,$10
	db $00,$28,$3C,$3E

DATA_0DD3C6:
	db $03,$00,$00,$02,$00,$50,$36,$10,$00,$00,$52,$36,$10,$00,$08,$62
	db $36

DATA_0DD3D7:
	db $03,$00,$00,$02,$00,$53,$36,$10,$00,$00,$55,$36,$10,$00,$08,$65
	db $36

DATA_0DD3E8:
	db $03,$00,$00,$02,$00,$56,$36,$10,$00,$00,$58,$36,$10,$00,$08,$68
	db $36

DATA_0DD3F9:
	db $06,$00,$00,$02,$00,$26,$36,$10,$02,$00,$28,$36,$00,$00,$10,$46
	db $36,$08,$00,$10,$47,$36,$10,$00,$10,$48,$36,$18,$00,$10,$49,$36

DATA_0DD419:
	db $08,$00,$08,$00,$08,$3D,$36,$10,$00,$08,$3E,$36,$00,$02,$00,$26
	db $36,$10,$02,$00,$28,$36,$00,$00,$10,$46,$36,$08,$00,$10,$47,$36
	db $10,$00,$10,$48,$36,$18,$00,$10,$49,$36

DATA_0DD443:
	db $05,$00,$00,$02,$00,$02,$3E,$10,$02,$00,$04,$3E,$20,$02,$00,$06
	db $3E,$30,$00,$00,$08,$3E,$30,$00,$08,$18,$3E

DATA_0DD45E:
	db $05,$00,$00,$02,$00,$09,$3E,$10,$02,$00,$0B,$3E,$20,$02,$00,$0D
	db $3E,$30,$00,$00,$0F,$3E,$30,$00,$08,$1F,$3E

DATA_0DD479:
	db $02,$00,$00,$00,$00,$20,$3E,$00,$00,$08,$30,$3E

DATA_0DD485:
	db $02,$00,$00,$00,$00,$21,$3E,$00,$00,$08,$31,$3E

DATA_0DD491:
	db $02,$00,$00,$00,$00,$22,$3E,$00,$00,$08,$32,$3E

DATA_0DD49D:
	db $02,$00,$00,$00,$00,$23,$3E,$00,$00,$08,$33,$3E

DATA_0DD4A9:
	db $02,$00,$00,$00,$00,$24,$3E,$00,$00,$08,$34,$3E

DATA_0DD4B5:
	db $02,$00,$00,$00,$00,$25,$3E,$00,$00,$08,$35,$3E

DATA_0DD4C1:
	db $02,$00,$00,$00,$00,$26,$3E,$00,$00,$08,$36,$3E

DATA_0DD4CD:
	db $02,$00,$00,$00,$00,$27,$3E,$00,$00,$08,$37,$3E

DATA_0DD4D9:
	db $02,$00,$00,$00,$00,$28,$3E,$00,$00,$08,$38,$3E

DATA_0DD4E5:
	db $02,$00,$00,$00,$00,$29,$3E,$00,$00,$08,$39,$3E

DATA_0DD4F1:
	db $01,$00,$00,$00,$00,$76,$3A

DATA_0DD4F8:
	db $01,$00,$00,$00,$00,$77,$3A

DATA_0DD4FF:
	db $01,$00,$00,$00,$00,$78,$3A

DATA_0DD506:
	db $01,$00,$00,$00,$00,$79,$3A

DATA_0DD50D:
	db $01,$00,$00,$00,$00,$7A,$3A

DATA_0DD514:
	db $01,$00,$00,$00,$00,$7B,$3A

DATA_0DD51B:
	db $01,$00,$00,$00,$00,$7C,$3A

DATA_0DD522:
	db $01,$00,$00,$00,$00,$7D,$3A

DATA_0DD529:
	db $01,$00,$00,$00,$00,$7E,$3A

DATA_0DD530:
	db $01,$00,$00,$00,$00,$7F,$3A

DATA_0DD537:
	db $03,$00,$00,$02,$00,$E8,$3D,$10,$02,$00,$EA,$3D,$20,$00,$08,$FC
	db $3D

DATA_0DD548:
	db $03,$00,$00,$02,$00,$E0,$3D,$10,$02,$00,$E2,$3D,$20,$00,$08,$FC
	db $3D

DATA_0DD559:
	db $03,$00,$00,$02,$00,$E4,$3D,$10,$02,$00,$E6,$3D,$20,$00,$08,$FC
	db $3D

DATA_0DD56A:
	db $08,$00,$F0,$03,$10,$62,$3D,$E0,$03,$10,$60,$3D,$F0,$03,$00,$42
	db $3D,$E0,$03,$00,$40,$3D,$F0,$03,$F0,$22,$3D,$E0,$03,$F0,$20,$3D
	db $F0,$01,$E8,$12,$3D,$E8,$01,$E8,$11,$3D

DATA_0DD594:
	db $08,$00,$F0,$03,$10,$66,$3D,$E0,$03,$10,$64,$3D,$F0,$03,$00,$46
	db $3D,$E0,$03,$00,$44,$3D,$F0,$03,$F0,$26,$3D,$E0,$03,$F0,$24,$3D
	db $F0,$01,$E8,$16,$3D,$E8,$01,$E8,$15,$3D

DATA_0DD5BE:
	db $0B,$00,$F8,$01,$F0,$27,$3D,$E0,$01,$F0,$24,$3D,$F8,$01,$18,$7B
	db $3D,$F0,$01,$18,$7A,$3D,$E8,$01,$18,$79,$3D,$E0,$01,$18,$78,$3D
	db $F0,$03,$08,$5A,$3D,$E0,$03,$08,$58,$3D,$F0,$03,$F8,$3A,$3D,$E0
	db $03,$F8,$38,$3D,$E8,$03,$E8,$19,$3D

DATA_0DD5F7:
	db $02,$00,$E0,$01,$18,$28,$31,$E0,$01,$10,$18,$31

DATA_0DD603:
	db $02,$00,$E0,$01,$18,$17,$31,$E0,$01,$10,$07,$31

DATA_0DD60F:
	db $04,$00,$E8,$01,$18,$02,$31,$E8,$01,$10,$01,$31,$E0,$01,$18,$10
	db $31,$E0,$01,$10,$00,$31

DATA_0DD625:
	db $0D,$00,$59,$00,$0C,$0B,$31,$51,$00,$0C,$0A,$31,$59,$00,$04,$09
	db $31,$51,$00,$04,$08,$31,$40,$02,$FF,$6C,$39,$2E,$02,$07,$4C,$31
	db $1C,$02,$FD,$2C,$31,$10,$02,$05,$0C,$31,$08,$00,$10,$06,$31,$00
	db $00,$10,$05,$31,$08,$00,$08,$14,$31,$00,$00,$08,$13,$31,$08,$00
	db $00,$04,$31

DATA_0DD668:
	db $0B,$00,$1D,$02,$FD,$2E,$31,$11,$02,$08,$0E,$31,$52,$00,$0D,$2B
	db $31,$52,$00,$05,$1B,$31,$40,$02,$00,$6E,$39,$2E,$02,$08,$4E,$31
	db $08,$00,$10,$06,$31,$00,$00,$10,$05,$31,$08,$00,$08,$14,$31,$00
	db $00,$08,$13,$31,$08,$00,$00,$04,$31

DATA_0DD6A1:
	db $01,$00,$00,$02,$00,$00,$00

DATA_0DD6A8:
	db $04,$00,$00,$00,$00,$90,$33,$08,$02,$F8,$81,$33,$18,$02,$F8,$83
	db $33,$28,$02,$F8,$85,$33

DATA_0DD6BE:
	db $07,$00,$00,$00,$00,$A3,$33,$08,$00,$00,$A4,$33,$10,$00,$00,$A5
	db $33,$18,$00,$00,$A6,$33,$20,$00,$F8,$97,$33,$20,$00,$00,$A7,$33
	db $28,$02,$F8,$98,$33

DATA_0DD6E3:
	db $06,$00,$10,$00,$10,$AC,$39,$08,$00,$10,$AB,$39,$00,$00,$10,$AA
	db $39,$10,$00,$08,$9C,$39,$10,$00,$00,$8C,$39,$00,$02,$00,$8A,$39

DATA_0DD703:
	db $06,$00,$10,$00,$10,$AF,$39,$08,$00,$10,$AE,$39,$00,$00,$10,$AD
	db $39,$10,$00,$08,$9F,$39,$10,$00,$00,$8F,$39,$00,$02,$00,$8D,$39

DATA_0DD723:
	db $06,$00,$10,$00,$10,$B5,$39,$08,$00,$10,$B4,$39,$00,$00,$10,$B3
	db $39,$10,$00,$08,$C2,$39,$10,$00,$00,$B2,$39,$00,$02,$00,$B0,$39

DATA_0DD743:
	db $06,$00,$10,$00,$10,$AC,$39,$08,$00,$10,$AB,$39,$00,$00,$10,$AA
	db $39,$10,$00,$08,$C8,$39,$10,$00,$00,$B8,$39,$00,$02,$00,$B6,$39

DATA_0DD763:
	db $04,$00,$00,$00,$00,$7A,$3C,$08,$00,$00,$7B,$3C,$00,$00,$08,$8A
	db $3C,$08,$00,$08,$8B,$3C

DATA_0DD779:
	db $04,$00,$00,$00,$00,$7C,$3C,$08,$00,$00,$7D,$3C,$00,$00,$08,$8C
	db $3C,$08,$00,$08,$8D,$3C

DATA_0DD78F:
	db $04,$00,$00,$00,$00,$7E,$3C,$08,$00,$00,$7F,$3C,$00,$00,$08,$8E
	db $3C,$08,$00,$08,$8F,$3C

DATA_0DD7A5:
	db $04,$00,$00,$00,$00,$E4,$30,$08,$00,$00,$E5,$30,$00,$00,$08,$F4
	db $30,$08,$00,$08,$F5,$30

DATA_0DD7BB:
	db $04,$00,$00,$00,$00,$E6,$30,$08,$00,$00,$E7,$30,$00,$00,$08,$F6
	db $30,$08,$00,$08,$F7,$30

DATA_0DD7D1:
	db $04,$00,$00,$00,$00,$E8,$30,$08,$00,$00,$E9,$30,$00,$00,$08,$F8
	db $30,$08,$00,$08,$F9,$30

DATA_0DD7E7:
	db $04,$00,$00,$00,$00,$EA,$30,$08,$00,$00,$EB,$30,$00,$00,$08,$FA
	db $30,$08,$00,$08,$FB,$30

DATA_0DD7FD:
	db $04,$00,$00,$00,$00,$EC,$30,$08,$00,$00,$ED,$30,$00,$00,$08,$FC
	db $30,$08,$00,$08,$FD,$30

DATA_0DD813:
	db $04,$00,$00,$00,$00,$EE,$30,$08,$00,$00,$EF,$30,$00,$00,$08,$FE
	db $30,$08,$00,$08,$FF,$30

DATA_0DD829:
	db $04,$00,$00,$00,$10,$41,$32,$F8,$01,$10,$40,$32,$F8,$03,$00,$20
	db $32,$F8,$03,$F0,$00,$32

DATA_0DD83F:
	db $04,$00,$00,$00,$10,$43,$32,$F8,$01,$10,$42,$32,$F8,$03,$00,$22
	db $32,$F8,$03,$F0,$02,$32

DATA_0DD855:
	db $06,$00,$08,$00,$00,$27,$32,$00,$00,$00,$26,$32,$F8,$01,$00,$25
	db $32,$F0,$01,$00,$24,$32,$00,$02,$F0,$06,$32,$F0,$03,$F0,$04,$32

DATA_0DD875:
	db $06,$00,$08,$00,$00,$57,$32,$00,$00,$00,$56,$32,$F8,$01,$00,$55
	db $32,$F0,$01,$00,$54,$32,$00,$02,$F0,$36,$32,$F0,$03,$F0,$34,$32

DATA_0DD895:
	db $02,$00,$00,$02,$F8,$4E,$32,$F0,$03,$F8,$4C,$32

DATA_0DD8A1:
	db $04,$00,$04,$02,$12,$2A,$30,$F4,$03,$12,$28,$30,$04,$02,$02,$0A
	db $30,$F4,$03,$02,$08,$30

DATA_0DD8B7:
	db $01,$00,$F8,$03,$08,$0C,$30

DATA_0DD8BE:
	db $01,$00,$FD,$01,$0B,$2C,$30

DATA_0DD8C5:
	db $01,$00,$F8,$03,$F8,$60,$26

DATA_0DD8CC:
	db $01,$00,$F8,$03,$F8,$62,$26

DATA_0DD8D3:
	db $01,$00,$F8,$03,$F8,$64,$22

DATA_0DD8DA:
	db $01,$00,$F8,$03,$F8,$66,$22

DATA_0DD8E1:
	db $01,$00,$F8,$03,$F8,$68,$22

DATA_0DD8E8:
	db $01,$00,$F8,$03,$F8,$6A,$22

DATA_0DD8EF:
	db $01,$00,$F8,$03,$F8,$6C,$26

DATA_0DD8F6:
	db $01,$00,$F8,$03,$F8,$6E,$26

DATA_0DD8FD:
	db $01,$00,$F8,$03,$F8,$80,$26

DATA_0DD904:
	db $01,$00,$F8,$03,$F8,$82,$26

DATA_0DD90B:
	db $04,$00,$00,$00,$00,$94,$66,$00,$00,$F8,$84,$66,$F8,$01,$00,$94
	db $26,$F8,$01,$F8,$84,$26

DATA_0DD921:
	db $06,$00,$04,$00,$FC,$95,$66,$04,$00,$F4,$85,$66,$04,$00,$04,$87
	db $66,$FC,$01,$04,$97,$26,$F4,$01,$04,$87,$26,$F4,$03,$F4,$85,$26

DATA_0DD941:
	db $04,$00,$00,$02,$00,$8A,$66,$F0,$03,$00,$8A,$26,$00,$02,$F0,$88
	db $66,$F0,$03,$F0,$88,$26

DATA_0DD957:
	db $04,$00,$00,$02,$00,$8E,$66,$F0,$03,$00,$8E,$26,$00,$02,$F0,$8C
	db $66,$F0,$03,$F0,$8C,$26

DATA_0DD96D:
	db $01,$00,$FC,$01,$FC,$A2,$20

DATA_0DD974:
	db $01,$00,$FC,$01,$FC,$A3,$20

DATA_0DD97B:
	db $01,$00,$FC,$01,$FC,$A4,$20

DATA_0DD982:
	db $04,$00,$04,$00,$F8,$B3,$68,$F4,$01,$F8,$B3,$28,$FC,$01,$00,$B5
	db $28,$FC,$01,$F8,$A5,$28

DATA_0DD998:
	db $04,$00,$04,$00,$F8,$B4,$68,$F4,$01,$F8,$B4,$28,$FC,$01,$00,$B6
	db $28,$FC,$01,$F8,$A6,$28

DATA_0DD9AE:
	db $04,$00,$04,$00,$F8,$B3,$68,$F4,$01,$F8,$B3,$28,$FC,$01,$00,$B8
	db $28,$FC,$01,$F8,$A8,$28

DATA_0DD9C4:
	db $04,$00,$04,$00,$F8,$B4,$68,$F4,$01,$F8,$B4,$28,$FC,$01,$00,$B9
	db $28,$FC,$01,$F8,$A9,$28

DATA_0DD9DA:
	db $04,$00,$04,$00,$F8,$B3,$68,$F4,$01,$F8,$B3,$28,$FC,$01,$00,$B7
	db $28,$FC,$01,$F8,$A7,$28

DATA_0DD9F0:
	db $06,$00,$00,$00,$05,$B0,$2A,$F8,$01,$05,$B0,$6A,$04,$00,$F8,$B4
	db $68,$F4,$01,$F8,$B4,$28,$FC,$01,$00,$B6,$28,$FC,$01,$F8,$A6,$28

DATA_0DDA10:
	db $08,$00,$F0,$01,$06,$B2,$6A,$F8,$01,$06,$B1,$6A,$08,$00,$06,$B2
	db $2A,$00,$00,$06,$B1,$2A,$04,$00,$F8,$B4,$68,$F4,$01,$F8,$B4,$28
	db $FC,$01,$00,$B6,$28,$FC,$01,$F8,$A6,$28

DATA_0DDA3A:
	db $08,$00,$00,$00,$06,$A0,$2A,$F8,$01,$06,$A0,$6A,$08,$00,$06,$A1
	db $2A,$F0,$01,$06,$A1,$6A,$04,$00,$F8,$B4,$68,$F4,$01,$F8,$B4,$28
	db $FC,$01,$00,$B6,$28,$FC,$01,$F8,$A6,$28

DATA_0DDA64:
	db $01,$00,$F8,$03,$F8,$AC,$20

DATA_0DDA6B:
	db $01,$00,$F8,$03,$F8,$AE,$20

DATA_0DDA72:
	db $04,$00,$F1,$03,$00,$2E,$20,$F1,$03,$F0,$0E,$20,$FF,$03,$00,$2E
	db $60,$FF,$03,$F0,$0E,$60

DATA_0DDA88:
	db $04,$00,$F3,$03,$00,$2E,$20,$F3,$03,$F0,$0E,$20,$FE,$03,$00,$2E
	db $60,$FE,$03,$F0,$0E,$60

DATA_0DDA9E:
	db $04,$00,$EF,$03,$00,$2E,$20,$EF,$03,$F0,$0E,$20,$01,$02,$00,$2E
	db $60,$01,$02,$F0,$0E,$60

DATA_0DDAB4:
	db $05,$00,$12,$00,$0F,$52,$30,$0A,$00,$0F,$51,$30,$02,$00,$0F,$50
	db $30,$0A,$02,$FF,$4A,$30,$FA,$03,$FF,$48,$30

DATA_0DDACF:
	db $02,$00,$F8,$03,$F0,$E0,$31,$F8,$03,$E0,$C0,$31

DATA_0DDADB:
	db $02,$00,$F8,$03,$EF,$E2,$31,$F8,$03,$DF,$C2,$31

DATA_0DDAE7:
	db $02,$00,$F8,$03,$EF,$E4,$31,$F8,$03,$DF,$C4,$31

DATA_0DDAF3:
	db $02,$00,$F8,$03,$F0,$E8,$31,$F8,$03,$E0,$C8,$31

DATA_0DDAFF:
	db $02,$00,$F8,$03,$F0,$E6,$31,$F8,$03,$E0,$C6,$31

DATA_0DDB0B:
	db $02,$00,$F8,$03,$F0,$EA,$31,$F8,$03,$E0,$CA,$31

DATA_0DDB17:
	db $02,$00,$F8,$03,$F0,$EC,$31,$F8,$03,$E0,$CC,$31

DATA_0DDB23:
	db $02,$00,$F8,$03,$F0,$EE,$31,$F8,$03,$E0,$CE,$31

DATA_0DDB2F:
	db $01,$00,$F8,$03,$F0,$60,$31

DATA_0DDB36:
	db $02,$00,$EF,$03,$DF,$62,$21,$F8,$03,$EF,$64,$21

DATA_0DDB42:
	db $02,$00,$F8,$03,$F0,$66,$21,$EF,$03,$E0,$62,$21

DATA_0DDB4E:
	db $04,$00,$00,$00,$E7,$79,$21,$F8,$01,$E7,$78,$21,$F8,$01,$DF,$68
	db $21,$F8,$03,$EF,$6A,$21

DATA_0DDB64:
	db $04,$00,$00,$00,$E8,$79,$21,$F8,$01,$E8,$78,$21,$F8,$01,$E0,$68
	db $21,$F8,$03,$F0,$6C,$21

DATA_0DDB7A:
	db $01,$00,$F8,$03,$F0,$6E,$21

DATA_0DDB81:
	db $01,$00,$F8,$03,$F0,$80,$21

DATA_0DDB88:
	db $01,$00,$F8,$03,$F0,$86,$21

DATA_0DDB8F:
	db $01,$00,$F8,$03,$EF,$88,$21

DATA_0DDB96:
	db $01,$00,$F8,$03,$F0,$82,$21

DATA_0DDB9D:
	db $01,$00,$F8,$03,$F0,$84,$21

DATA_0DDBA4:
	db $03,$00,$00,$00,$F8,$AB,$21,$F8,$01,$F8,$AA,$21,$F8,$03,$E8,$8A
	db $21

DATA_0DDBB5:
	db $03,$00,$00,$00,$F8,$AD,$21,$F8,$01,$F8,$AC,$21,$F8,$03,$E8,$8C
	db $21

DATA_0DDBC6:
	db $03,$00,$00,$00,$F8,$AF,$21,$F8,$01,$F8,$AE,$21,$F8,$03,$E8,$8E
	db $21

DATA_0DDBD7:
	db $03,$00,$00,$00,$F8,$A9,$21,$F8,$01,$F8,$A8,$21,$F8,$03,$E8,$A0
	db $21

DATA_0DDBE8:
	db $03,$00,$00,$00,$F8,$B9,$21,$F8,$01,$F8,$B8,$21,$F8,$03,$E8,$A2
	db $21

DATA_0DDBF9:
	db $03,$00,$00,$00,$F8,$BB,$21,$F8,$01,$F8,$BA,$21,$F8,$03,$E8,$A4
	db $21

DATA_0DDC0A:
	db $03,$00,$00,$00,$F8,$BD,$21,$F8,$01,$F8,$BC,$21,$F8,$03,$E8,$A6
	db $21

DATA_0DDC1B:
	db $10,$00,$11,$02,$03,$CE,$66,$0C,$00,$FF,$E6,$66,$DF,$03,$03,$CE
	db $26,$EC,$01,$FF,$E6,$26,$00,$02,$E1,$C0,$66,$00,$02,$F1,$E0,$66
	db $F0,$03,$E1,$C0,$26,$F0,$03,$F1,$E0,$26,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DDC6D:
	db $10,$00,$11,$02,$03,$EE,$66,$0C,$00,$FF,$E6,$66,$DF,$03,$03,$EE
	db $26,$EC,$01,$FF,$E6,$26,$00,$02,$E1,$C0,$66,$00,$02,$F1,$E0,$66
	db $F0,$03,$E1,$C0,$26,$F0,$03,$F1,$E0,$26,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DDCBF:
	db $10,$00,$DC,$03,$FA,$0C,$27,$0C,$00,$FE,$F7,$66,$14,$02,$FA,$0C
	db $67,$EC,$01,$FE,$F7,$26,$00,$02,$E1,$C8,$66,$00,$02,$F1,$E8,$66
	db $F0,$03,$E1,$C8,$26,$F0,$03,$F1,$E8,$26,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DDD11:
	db $10,$00,$DC,$03,$FA,$0C,$27,$0C,$00,$FE,$F7,$66,$14,$02,$FA,$0C
	db $67,$EC,$01,$FE,$F7,$26,$00,$02,$E1,$2E,$67,$00,$02,$F1,$4E,$67
	db $F0,$03,$E1,$2E,$27,$F0,$03,$F1,$4E,$27,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DDD63:
	db $10,$00,$12,$02,$F3,$20,$67,$0C,$00,$FE,$F7,$66,$DE,$03,$F3,$20
	db $27,$EC,$01,$FE,$F7,$26,$00,$02,$E1,$C8,$66,$00,$02,$F1,$E8,$66
	db $F0,$03,$E1,$C8,$26,$F0,$03,$F1,$E8,$26,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DDDB5:
	db $10,$00,$13,$02,$FF,$CE,$66,$0D,$00,$FE,$F7,$66,$DD,$03,$FF,$CE
	db $26,$EB,$01,$FE,$F7,$26,$00,$02,$E1,$C0,$66,$00,$02,$F1,$E0,$66
	db $F0,$03,$E1,$C0,$26,$F0,$03,$F1,$E0,$26,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C6,$66,$00,$00,$1E,$E7,$66,$F0,$03,$0E,$C6,$26,$F8,$01,$1E
	db $E7,$26

DATA_0DDE07:
	db $10,$00,$11,$02,$FB,$CE,$66,$0D,$00,$FB,$F6,$66,$DF,$03,$FB,$CE
	db $26,$EB,$01,$FB,$F6,$26,$00,$02,$E1,$C0,$66,$00,$02,$F1,$E0,$66
	db $F0,$03,$E1,$C0,$26,$F0,$03,$F1,$E0,$26,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C6,$66,$00,$00,$1E,$E7,$66,$F0,$03,$0E,$C6,$26,$F8,$01,$1E
	db $E7,$26

DATA_0DDE59:
	db $10,$00,$14,$02,$FA,$0C,$67,$0C,$00,$FE,$F7,$66,$DC,$03,$FA,$0C
	db $27,$EC,$01,$FE,$F7,$26,$00,$02,$E1,$CA,$66,$00,$02,$F1,$EA,$66
	db $F0,$03,$E1,$CA,$26,$F0,$03,$F1,$EA,$26,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DDEAB:
	db $10,$00,$11,$02,$EF,$20,$67,$0D,$00,$FC,$F6,$66,$DF,$03,$EF,$20
	db $27,$EB,$01,$FC,$F6,$26,$00,$02,$E1,$CC,$66,$00,$02,$F1,$EC,$66
	db $F0,$03,$E1,$CC,$26,$F0,$03,$F1,$EC,$26,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C6,$66,$00,$00,$1E,$E7,$66,$F0,$03,$0E,$C6,$26,$F8,$01,$1E
	db $E7,$26

DATA_0DDEFD:
	db $10,$00,$11,$02,$03,$CE,$66,$0C,$00,$FF,$E6,$66,$DF,$03,$03,$CE
	db $26,$EC,$01,$FF,$E6,$26,$00,$02,$E1,$60,$67,$00,$02,$F1,$80,$67
	db $F0,$03,$E1,$60,$27,$F0,$03,$F1,$80,$27,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DDF4F:
	db $10,$00,$11,$02,$03,$EE,$66,$0C,$00,$FF,$E6,$66,$DF,$03,$03,$EE
	db $26,$EC,$01,$FF,$E6,$26,$00,$02,$E1,$62,$67,$00,$02,$F1,$82,$67
	db $F0,$03,$E1,$62,$27,$F0,$03,$F1,$82,$27,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DDFA1:
	db $10,$00,$11,$02,$03,$CE,$66,$0C,$00,$FF,$E6,$66,$DF,$03,$03,$CE
	db $26,$EC,$01,$FF,$E6,$26,$00,$02,$E1,$64,$67,$00,$02,$F1,$84,$67
	db $F0,$03,$E1,$64,$27,$F0,$03,$F1,$84,$27,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DDFF3:
	db $10,$00,$11,$02,$03,$EE,$66,$0C,$00,$FF,$E6,$66,$DF,$03,$03,$EE
	db $26,$EC,$01,$FF,$E6,$26,$00,$02,$E1,$66,$67,$00,$02,$F1,$86,$67
	db $F0,$03,$E1,$66,$27,$F0,$03,$F1,$86,$27,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DE045:
	db $10,$00,$11,$02,$03,$CE,$66,$0C,$00,$FF,$E6,$66,$DF,$03,$03,$CE
	db $26,$EC,$01,$FF,$E6,$26,$00,$02,$E1,$60,$67,$00,$02,$F1,$80,$67
	db $F0,$03,$E1,$60,$27,$F0,$03,$F1,$80,$27,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DE097:
	db $10,$00,$11,$02,$03,$EE,$66,$0C,$00,$FF,$E6,$66,$DF,$03,$03,$EE
	db $26,$EC,$01,$FF,$E6,$26,$00,$02,$E1,$68,$67,$00,$02,$F1,$88,$67
	db $F0,$03,$E1,$68,$27,$F0,$03,$F1,$88,$27,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DE0E9:
	db $10,$00,$11,$02,$03,$CE,$66,$0C,$00,$FF,$E6,$66,$DF,$03,$03,$CE
	db $26,$EC,$01,$FF,$E6,$26,$00,$02,$E1,$6A,$67,$00,$02,$F1,$8A,$67
	db $F0,$03,$E1,$6A,$27,$F0,$03,$F1,$8A,$27,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DE13B:
	db $10,$00,$11,$02,$03,$EE,$66,$0C,$00,$FF,$E6,$66,$DF,$03,$03,$EE
	db $26,$EC,$01,$FF,$E6,$26,$00,$02,$E3,$6A,$67,$00,$02,$F3,$8A,$67
	db $F0,$03,$E3,$6A,$27,$F0,$03,$F3,$8A,$27,$00,$02,$FA,$C2,$66,$00
	db $02,$0A,$E2,$66,$F0,$03,$FA,$C2,$26,$F0,$03,$0A,$E2,$26,$00,$02
	db $0E,$C4,$66,$00,$00,$1E,$E5,$66,$F0,$03,$0E,$C4,$26,$F8,$01,$1E
	db $E5,$26

DATA_0DE18D:
	db $04,$00,$18,$02,$F5,$02,$27,$08,$02,$F5,$00,$27,$D8,$03,$F5,$02
	db $67,$E8,$03,$F5,$00,$67

DATA_0DE1A3:
	db $04,$00,$18,$02,$F8,$06,$27,$08,$02,$F8,$04,$27,$D8,$03,$F8,$06
	db $67,$E8,$03,$F8,$04,$67

DATA_0DE1B9:
	db $04,$00,$18,$02,$FA,$0A,$27,$08,$02,$FA,$08,$27,$D8,$03,$FA,$0A
	db $67,$E8,$03,$FA,$08,$67

DATA_0DE1CF:
	db $01,$00,$F9,$03,$24,$46,$2B

DATA_0DE1D6:
	db $01,$00,$F9,$03,$24,$48,$2B

DATA_0DE1DD:
	db $01,$00,$F9,$03,$24,$4A,$2B

DATA_0DE1E4:
	db $01,$00,$FC,$01,$26,$25,$2D

DATA_0DE1EB:
	db $01,$00,$F8,$03,$26,$26,$2D

DATA_0DE1F2:
	db $01,$00,$F8,$03,$26,$28,$2D

DATA_0DE1F9:
	db $01,$00,$F8,$03,$26,$2A,$2D

DATA_0DE200:
	db $01,$00,$F8,$03,$26,$2C,$2D

DATA_0DE207:
	db $01,$00,$F8,$03,$26,$40,$2D

DATA_0DE20E:
	db $01,$00,$F8,$03,$26,$42,$2D

DATA_0DE215:
	db $01,$00,$F8,$03,$26,$44,$2D

DATA_0DE21C:
	db $01,$00,$FC,$01,$FC,$24,$2B

DATA_0DE223:
	db $01,$00,$FC,$01,$FC,$34,$2B

DATA_0DE22A:
	db $01,$00,$FC,$01,$FC,$35,$2B

DATA_0DE231:
	db $01,$00,$FD,$01,$25,$4C,$2F

DATA_0DE238:
	db $01,$00,$FD,$01,$25,$4D,$2F

DATA_0DE23F:
	db $01,$00,$FC,$01,$FC,$E4,$20

DATA_0DE246:
	db $01,$00,$FC,$01,$FC,$F4,$20

DATA_0DE24D:
	db $01,$00,$FC,$01,$FC,$F5,$20

DATA_0DE254:
	db $02,$00,$00,$02,$00,$0A,$27,$F0,$03,$00,$08,$27

DATA_0DE260:
	db $02,$00,$F0,$03,$00,$0A,$67,$00,$02,$00,$08,$67

DATA_0DE26C:
	db $02,$00,$FC,$03,$F0,$20,$67,$F8,$01,$FD,$F6,$66

DATA_0DE278:
	db $02,$00,$F4,$03,$F0,$20,$27,$00,$00,$FD,$F6,$26

DATA_0DE284:
	db $04,$00,$00,$02,$F0,$C2,$66,$F0,$03,$F0,$C2,$26,$00,$02,$00,$E2
	db $66,$F0,$03,$00,$E2,$26

DATA_0DE29A:
	db $04,$00,$00,$02,$00,$C6,$66,$F0,$03,$00,$C6,$26,$00,$00,$10,$E7
	db $66,$F8,$01,$10,$E7,$26

DATA_0DE2B0:
	db $04,$00,$00,$02,$F0,$CC,$66,$F0,$03,$F0,$CC,$26,$00,$02,$00,$EC
	db $66,$F0,$03,$00,$EC,$26

DATA_0DE2C6:
	db $03,$00,$00,$00,$F8,$AB,$21,$F8,$01,$F8,$AA,$21,$F8,$03,$E8,$A4
	db $21

DATA_0DE2D7:
	db $05,$00,$00,$00,$F7,$AD,$21,$F8,$01,$F7,$AC,$21,$F8,$03,$E7,$A4
	db $21,$F0,$01,$E7,$A6,$71,$F0,$01,$EF,$B6,$71

DATA_0DE2F2:
	db $04,$00,$00,$00,$01,$FB,$33,$08,$00,$01,$FC,$33,$00,$00,$09,$F0
	db $33,$08,$00,$09,$F1,$33

DATA_0DE308:
	db $04,$00,$00,$00,$00,$FB,$33,$08,$00,$00,$FC,$33,$00,$00,$08,$F2
	db $33,$08,$00,$08,$F3,$33

DATA_0DE31E:
	db $04,$00,$00,$00,$FA,$FB,$33,$08,$00,$FA,$FC,$33,$00,$00,$02,$F4
	db $33,$08,$00,$02,$F5,$33

DATA_0DE334:
	db $04,$00,$00,$00,$00,$FB,$33,$08,$00,$00,$FC,$33,$00,$00,$08,$F6
	db $33,$08,$00,$08,$F7,$33

DATA_0DE34A:
	db $04,$00,$00,$00,$00,$FB,$33,$08,$00,$00,$FC,$33,$00,$00,$08,$5C
	db $33,$08,$00,$08,$5D,$33

DATA_0DE360:
	db $02,$00,$04,$00,$00,$FD,$33,$04,$00,$08,$F8,$33

DATA_0DE36C:
	db $04,$00,$00,$00,$00,$FE,$33,$08,$00,$00,$FF,$33,$00,$00,$08,$F9
	db $33,$08,$00,$08,$FA,$33

DATA_0DE382:
	db $02,$00,$04,$00,$00,$FD,$63,$04,$00,$08,$F8,$73

DATA_0DE38E:
	db $01,$00,$00,$02,$00,$80,$31

DATA_0DE395:
	db $01,$00,$00,$02,$00,$82,$31

DATA_0DE39C:
	db $01,$00,$00,$02,$F8,$84,$31

DATA_0DE3A3:
	db $01,$00,$00,$02,$00,$84,$31

DATA_0DE3AA:
	db $01,$00,$00,$02,$00,$86,$31

DATA_0DE3B1:
	db $01,$00,$00,$02,$00,$88,$31

DATA_0DE3B8:
	db $01,$00,$00,$02,$00,$86,$71

DATA_0DE3BF:
	db $01,$00,$00,$02,$FB,$88,$B1

DATA_0DE3C6:
	db $01,$00,$F8,$03,$00,$8A,$39

DATA_0DE3CD:
	db $01,$00,$F8,$03,$00,$8C,$39

DATA_0DE3D4:
	db $01,$00,$F8,$03,$00,$8E,$39

DATA_0DE3DB:
	db $01,$00,$F8,$03,$00,$A0,$39

DATA_0DE3E2:
	db $01,$00,$F8,$03,$00,$A2,$39

DATA_0DE3E9:
	db $01,$00,$F8,$03,$00,$A4,$39

DATA_0DE3F0:
	db $01,$00,$F8,$03,$00,$A6,$39

DATA_0DE3F7:
	db $01,$00,$F8,$03,$00,$A8,$39

DATA_0DE3FE:
	db $01,$00,$F8,$03,$00,$AA,$39

DATA_0DE405:
	db $01,$00,$F8,$03,$00,$8E,$F9

DATA_0DE40C:
	db $01,$00,$F8,$03,$00,$AA,$F9

DATA_0DE413:
	db $01,$00,$00,$02,$00,$AC,$31

DATA_0DE41A:
	db $03,$00,$00,$02,$00,$AE,$35,$00,$00,$0C,$AE,$35,$08,$00,$0C,$AF
	db $35

DATA_0DE42B:
	db $01,$00,$00,$00,$00,$60,$21

DATA_0DE432:
	db $01,$00,$00,$00,$00,$61,$21

DATA_0DE439:
	db $01,$00,$00,$00,$00,$62,$21

DATA_0DE440:
	db $01,$00,$00,$00,$00,$63,$21

DATA_0DE447:
	db $01,$00,$00,$00,$00,$64,$21

DATA_0DE44E:
	db $01,$00,$00,$00,$00,$65,$21

DATA_0DE455:
	db $01,$00,$00,$00,$00,$66,$21

DATA_0DE45C:
	db $01,$00,$00,$00,$00,$67,$21

DATA_0DE463:
	db $01,$00,$00,$00,$00,$68,$21

DATA_0DE46A:
	db $01,$00,$00,$00,$00,$69,$21

DATA_0DE471:
	db $01,$00,$00,$00,$00,$6A,$21

DATA_0DE478:
	db $01,$00,$00,$00,$00,$6B,$21

DATA_0DE47F:
	db $01,$00,$00,$00,$00,$6C,$21

DATA_0DE486:
	db $01,$00,$00,$00,$00,$6D,$21

DATA_0DE48D:
	db $01,$00,$00,$00,$00,$6E,$21

DATA_0DE494:
	db $01,$00,$00,$00,$00,$6F,$21

DATA_0DE49B:
	db $01,$00,$00,$00,$00,$70,$21

DATA_0DE4A2:
	db $01,$00,$00,$00,$00,$71,$21

DATA_0DE4A9:
	db $01,$00,$00,$00,$00,$72,$21

DATA_0DE4B0:
	db $01,$00,$00,$00,$00,$73,$21

DATA_0DE4B7:
	db $01,$00,$00,$00,$00,$74,$21

DATA_0DE4BE:
	db $01,$00,$00,$00,$00,$75,$21

DATA_0DE4C5:
	db $01,$00,$00,$00,$00,$76,$21

DATA_0DE4CC:
	db $01,$00,$00,$00,$00,$77,$21

DATA_0DE4D3:
	db $01,$00,$00,$00,$00,$78,$21

DATA_0DE4DA:
	db $01,$00,$00,$00,$00,$79,$21

DATA_0DE4E1:
	db $01,$00,$00,$00,$00,$7A,$21

DATA_0DE4E8:
	db $01,$00,$00,$00,$00,$7B,$21

DATA_0DE4EF:
	db $01,$00,$00,$00,$00,$7C,$21

DATA_0DE4F6:
	db $01,$00,$00,$00,$00,$7D,$21

DATA_0DE4FD:
	db $01,$00,$00,$00,$00,$7E,$21

DATA_0DE504:
	db $01,$00,$00,$00,$00,$7F,$21

DATA_0DE50B:
	db $04,$00,$00,$00,$00,$31,$31,$F8,$01,$00,$30,$31,$00,$00,$F8,$21
	db $31,$F8,$01,$F8,$20,$31

DATA_0DE521:
	db $04,$00,$00,$00,$00,$33,$31,$F8,$01,$00,$32,$31,$00,$00,$F8,$23
	db $31,$F8,$01,$F8,$22,$31

DATA_0DE537:
	db $04,$00,$00,$00,$00,$35,$31,$F8,$01,$00,$34,$31,$00,$00,$F8,$25
	db $31,$F8,$01,$F8,$24,$31

DATA_0DE54D:
	db $02,$00,$00,$00,$00,$36,$31,$00,$00,$F8,$26,$31

DATA_0DE559:
	db $04,$00,$00,$00,$00,$38,$31,$F8,$01,$00,$37,$31,$00,$00,$F8,$28
	db $31,$F8,$01,$F8,$27,$31

DATA_0DE56F:
	db $04,$00,$00,$00,$00,$3A,$31,$F8,$01,$00,$39,$31,$00,$00,$F8,$2A
	db $31,$F8,$01,$F8,$29,$31

DATA_0DE585:
	db $04,$00,$00,$00,$00,$3C,$31,$F8,$01,$00,$3B,$31,$00,$00,$F8,$2C
	db $31,$F8,$01,$F8,$2B,$31

DATA_0DE59B:
	db $04,$00,$00,$00,$00,$3E,$31,$F8,$01,$00,$3D,$31,$00,$00,$F8,$2E
	db $31,$F8,$01,$F8,$2D,$31

DATA_0DE5B1:
	db $01,$00,$00,$00,$00,$2F,$31

DATA_0DE5B8:
	db $01,$00,$00,$00,$00,$3F,$31

DATA_0DE5BF:
	db $01,$00,$00,$00,$00,$40,$31

DATA_0DE5C6:
	db $01,$00,$00,$00,$00,$41,$31

DATA_0DE5CD:
	db $01,$00,$00,$00,$00,$58,$31

DATA_0DE5D4:
	db $01,$00,$00,$00,$00,$57,$31

DATA_0DE5DB:
	db $01,$00,$00,$00,$00,$59,$31

DATA_0DE5E2:
	db $01,$00,$00,$00,$00,$5A,$31

DATA_0DE5E9:
	db $01,$00,$00,$00,$00,$5C,$31

DATA_0DE5F0:
	db $01,$00,$00,$00,$00,$5D,$31

DATA_0DE5F7:
	db $04,$00,$00,$00,$00,$4B,$31,$F8,$01,$00,$4A,$31,$00,$00,$F8,$49
	db $31,$F8,$01,$F8,$48,$31

DATA_0DE60D:
	db $04,$00,$00,$00,$00,$4B,$31,$F8,$01,$00,$4A,$31,$00,$00,$F8,$4D
	db $31,$F8,$01,$F8,$4C,$31

DATA_0DE623:
	db $04,$00,$00,$00,$00,$4F,$31,$F8,$01,$00,$4E,$31,$00,$00,$F8,$49
	db $31,$F8,$01,$F8,$48,$31

DATA_0DE639:
	db $04,$00,$00,$00,$00,$51,$31,$F8,$01,$00,$50,$31,$00,$00,$F8,$49
	db $31,$F8,$01,$F8,$48,$31

DATA_0DE64F:
	db $05,$00,$FB,$01,$F2,$52,$31,$00,$00,$00,$38,$31,$F8,$01,$00,$37
	db $31,$00,$00,$F8,$28,$31,$F8,$01,$F8,$27,$31

DATA_0DE66A:
	db $05,$00,$FB,$01,$F2,$53,$31,$00,$00,$00,$38,$31,$F8,$01,$00,$37
	db $31,$00,$00,$F8,$28,$31,$F8,$01,$F8,$27,$31

DATA_0DE685:
	db $05,$00,$FB,$01,$F2,$54,$31,$00,$00,$00,$38,$31,$F8,$01,$00,$37
	db $31,$00,$00,$F8,$28,$31,$F8,$01,$F8,$27,$31

DATA_0DE6A0:
	db $05,$00,$FB,$01,$F2,$55,$31,$00,$00,$00,$38,$31,$F8,$01,$00,$37
	db $31,$00,$00,$F8,$28,$31,$F8,$01,$F8,$27,$31

DATA_0DE6BB:
	db $01,$00,$F8,$03,$F8,$50,$20

DATA_0DE6C2:
	db $01,$00,$F8,$03,$F8,$52,$20

DATA_0DE6C9:
	db $01,$00,$F8,$03,$F8,$54,$20

DATA_0DE6D0:
	db $01,$00,$F8,$03,$F8,$56,$20

DATA_0DE6D7:
	db $01,$00,$F8,$03,$F8,$58,$20

DATA_0DE6DE:
	db $01,$00,$F8,$03,$F8,$5A,$20

DATA_0DE6E5:
	db $01,$00,$F8,$03,$F8,$5C,$20

DATA_0DE6EC:
	db $01,$00,$F8,$03,$F8,$5E,$20

DATA_0DE6F3:
	db $01,$00,$F8,$03,$F8,$08,$20

DATA_0DE6FA:
	db $01,$00,$F8,$03,$F8,$0A,$20

DATA_0DE701:
	db $01,$00,$F8,$03,$F8,$0C,$20

DATA_0DE708:
	db $01,$00,$F8,$03,$F8,$0E,$20

DATA_0DE70F:
	db $01,$00,$F8,$03,$F8,$7A,$20

DATA_0DE716:
	db $01,$00,$F8,$03,$F8,$7C,$20

DATA_0DE71D:
	db $01,$00,$F8,$03,$F8,$7E,$20

DATA_0DE724:
	db $01,$00,$F8,$03,$F8,$90,$20

DATA_0DE72B:
	db $01,$00,$F8,$03,$F8,$92,$20

DATA_0DE732:
	db $01,$00,$F8,$03,$F8,$94,$20

DATA_0DE739:
	db $01,$00,$F8,$03,$F8,$96,$20

DATA_0DE740:
	db $01,$00,$F8,$03,$F8,$98,$20

DATA_0DE747:
	db $01,$00,$F8,$03,$F8,$9A,$20

DATA_0DE74E:
	db $01,$00,$F8,$03,$F8,$9C,$20

DATA_0DE755:
	db $01,$00,$F8,$03,$F8,$9E,$20

DATA_0DE75C:
	db $01,$00,$F8,$03,$F8,$B0,$20

DATA_0DE763:
	db $01,$00,$F8,$03,$F8,$B2,$20

DATA_0DE76A:
	db $01,$00,$F8,$03,$F8,$B4,$20

DATA_0DE771:
	db $01,$00,$F8,$03,$F8,$B6,$20

DATA_0DE778:
	db $01,$00,$F8,$03,$F8,$B8,$20

DATA_0DE77F:
	db $01,$00,$F8,$03,$F8,$BA,$20

DATA_0DE786:
	db $01,$00,$F8,$03,$F8,$BC,$20

DATA_0DE78D:
	db $01,$00,$F8,$03,$F8,$BE,$20

DATA_0DE794:
	db $01,$00,$FF,$03,$FF,$70,$30

DATA_0DE79B:
	db $05,$00,$13,$00,$10,$78,$30,$0B,$00,$10,$77,$30,$03,$00,$10,$76
	db $30,$0B,$02,$00,$74,$30,$FB,$03,$00,$72,$30

DATA_0DE7B6:
	db $01,$00,$00,$00,$00,$56,$31

DATA_0DE7BD:
	db $02,$00,$00,$00,$F8,$5E,$31,$00,$00,$00,$5F,$31

DATA_0DE7C9:
	db $19,$00,$18,$00,$F8,$B7,$20,$10,$00,$F8,$B6,$20,$08,$00,$F8,$B5
	db $20,$F8,$01,$F0,$A3,$20,$F0,$01,$F0,$A2,$20,$F8,$01,$E8,$93,$20
	db $F0,$01,$E8,$92,$20,$F8,$01,$F8,$B3,$20,$F0,$01,$F8,$B2,$20,$E8
	db $01,$F8,$B1,$20,$18,$00,$00,$C7,$20,$10,$00,$00,$C6,$20,$08,$00
	db $00,$C5,$20,$00,$00,$00,$C4,$20,$F8,$01,$00,$C3,$20,$F0,$01,$00
	db $C2,$20,$E8,$01,$00,$C1,$20,$18,$00,$08,$D7,$20,$10,$00,$08,$D6
	db $20,$08,$00,$08,$D5,$20,$00,$00,$08,$D4,$20,$F8,$01,$08,$D3,$20
	db $F0,$01,$08,$D2,$20,$E8,$01,$08,$D1,$20,$E0,$01,$08,$D0,$20

DATA_0DE848:
	db $1F,$00,$28,$00,$00,$CC,$20,$20,$00,$08,$DB,$20,$20,$00,$00,$CB
	db $20,$28,$00,$F8,$BC,$20,$20,$00,$F8,$BB,$20,$28,$00,$F0,$AC,$20
	db $20,$00,$F0,$AB,$20,$18,$00,$08,$DA,$20,$10,$00,$08,$D9,$20,$08
	db $00,$08,$D8,$20,$18,$00,$00,$CA,$20,$10,$00,$00,$C9,$20,$08,$00
	db $00,$C8,$20,$10,$00,$F8,$B9,$20,$08,$00,$F8,$B8,$20,$00,$00,$08
	db $D4,$20,$00,$00,$00,$C4,$20,$F8,$01,$F0,$A3,$20,$F0,$01,$F0,$A2
	db $20,$F8,$01,$E8,$93,$20,$F0,$01,$E8,$92,$20,$F8,$01,$F8,$B3,$20
	db $F0,$01,$F8,$B2,$20,$E8,$01,$F8,$B1,$20,$F8,$01,$00,$C3,$20,$F0
	db $01,$00,$C2,$20,$E8,$01,$00,$C1,$20,$F8,$01,$08,$D3,$20,$F0,$01
	db $08,$D2,$20,$E8,$01,$08,$D1,$20,$E0,$01,$08,$D0,$20

DATA_0DE8E5:
	db $1E,$00,$10,$00,$F8,$91,$20,$08,$00,$F8,$90,$20,$30,$00,$08,$A9
	db $20,$28,$00,$08,$A8,$20,$20,$00,$08,$A7,$20,$18,$00,$08,$A6,$20
	db $10,$00,$08,$A5,$20,$08,$00,$08,$A4,$20,$30,$00,$00,$99,$20,$28
	db $00,$00,$98,$20,$20,$00,$00,$97,$20,$18,$00,$00,$96,$20,$10,$00
	db $00,$95,$20,$08,$00,$00,$94,$20,$00,$00,$08,$D4,$20,$00,$00,$00
	db $C4,$20,$F8,$01,$F0,$A3,$20,$F0,$01,$F0,$A2,$20,$F8,$01,$E8,$93
	db $20,$F0,$01,$E8,$92,$20,$F8,$01,$F8,$B3,$20,$F0,$01,$F8,$B2,$20
	db $E8,$01,$F8,$B1,$20,$F8,$01,$00,$C3,$20,$F0,$01,$00,$C2,$20,$E8
	db $01,$00,$C1,$20,$F8,$01,$08,$D3,$20,$F0,$01,$08,$D2,$20,$E8,$01
	db $08,$D1,$20,$E0,$01,$08,$D0,$20

DATA_0DE97D:
	db $1A,$00,$F8,$01,$F8,$7F,$20,$F0,$01,$F8,$7E,$20,$08,$00,$E8,$87
	db $20,$00,$00,$E8,$86,$20,$00,$00,$F0,$89,$20,$F8,$01,$F0,$88,$20
	db $20,$00,$08,$9C,$20,$18,$00,$08,$9B,$20,$10,$00,$08,$9A,$20,$20
	db $00,$00,$8C,$20,$18,$00,$00,$8B,$20,$10,$00,$00,$8A,$20,$20,$00
	db $F8,$7C,$20,$18,$00,$F8,$7B,$20,$10,$00,$F8,$7A,$20,$F0,$01,$F0
	db $A2,$20,$F8,$01,$E8,$93,$20,$F0,$01,$E8,$92,$20,$F8,$01,$08,$B0
	db $20,$F8,$01,$00,$A1,$20,$F0,$01,$00,$A0,$20,$E8,$01,$00,$C1,$20
	db $E8,$01,$F8,$B1,$20,$F0,$01,$08,$D2,$20,$E8,$01,$08,$D1,$20,$E0
	db $01,$08,$D0,$20

DATA_0DEA01:
	db $1A,$00,$28,$00,$08,$79,$20,$28,$00,$00,$B4,$20,$28,$00,$F8,$C0
	db $20,$20,$00,$08,$DF,$20,$20,$00,$00,$CF,$20,$20,$00,$F8,$BF,$20
	db $18,$00,$08,$AF,$20,$18,$00,$00,$9F,$20,$18,$00,$F8,$8F,$20,$F8
	db $01,$F8,$7F,$20,$F0,$01,$F8,$7E,$20,$08,$00,$E8,$87,$20,$00,$00
	db $E8,$86,$20,$00,$00,$F0,$89,$20,$F8,$01,$F0,$88,$20,$F0,$01,$F0
	db $A2,$20,$F8,$01,$E8,$93,$20,$F0,$01,$E8,$92,$20,$F8,$01,$08,$B0
	db $20,$F8,$01,$00,$A1,$20,$F0,$01,$00,$A0,$20,$E8,$01,$00,$C1,$20
	db $E8,$01,$F8,$B1,$20,$F0,$01,$08,$D2,$20,$E8,$01,$08,$D1,$20,$E0
	db $01,$08,$D0,$20

DATA_0DEA85:
	db $1F,$00,$20,$00,$08,$AD,$20,$18,$00,$08,$AA,$20,$20,$00,$00,$DE
	db $20,$18,$00,$00,$DD,$20,$F8,$01,$F8,$7F,$20,$F0,$01,$F8,$7E,$20
	db $08,$00,$E8,$87,$20,$00,$00,$E8,$86,$20,$00,$00,$F0,$89,$20,$F8
	db $01,$F0,$88,$20,$20,$00,$F8,$CE,$20,$20,$00,$F0,$BE,$20,$20,$00
	db $E8,$AE,$20,$20,$00,$E0,$9E,$20,$20,$00,$D8,$8E,$20,$18,$00,$F8
	db $CD,$20,$18,$00,$F0,$BD,$20,$18,$00,$E0,$9D,$20,$18,$00,$D8,$8D
	db $20,$18,$00,$D0,$7D,$20,$F0,$01,$F0,$A2,$20,$F8,$01,$E8,$93,$20
	db $F0,$01,$E8,$92,$20,$F8,$01,$08,$B0,$20,$F8,$01,$00,$A1,$20,$F0
	db $01,$00,$A0,$20,$E8,$01,$00,$C1,$20,$E8,$01,$F8,$B1,$20,$F0,$01
	db $08,$D2,$20,$E8,$01,$08,$D1,$20,$E0,$01,$08,$D0,$20

DATA_0DEB22:
	db $80,$41,$00,$26,$0C

DATA_0DEB27:					; Note: Something related to sprites
	db $FF,$FF,$00,$00,$31,$00,$55,$00,$FF,$0C,$00,$00,$32,$00,$75,$13
	db $FF,$19,$00,$00,$32,$00,$9B,$17,$FF,$05,$00,$80,$24,$00,$57,$18
	db $FF,$07,$00,$80,$24,$00,$77,$18,$FF,$07,$00,$80,$24,$00,$98,$18
	db $FF,$07,$00,$00,$44,$00,$60,$08,$FF,$05,$00,$00,$44,$00,$80,$09
	db $FF,$05,$00,$00,$44,$00,$A0,$0A,$FF,$05,$00,$80,$28,$00,$4C,$18
	db $FF,$07,$00,$80,$28,$00,$74,$18,$FF,$07,$00,$80,$5B,$00,$47,$7F
	db $FF,$09,$00,$00,$5B,$00,$6E,$83,$FF,$09,$00,$80,$4B,$00,$5D,$46
	db $FF,$09,$00,$00,$3C,$00,$8A,$4B,$FF,$06,$00,$80,$45,$00,$8A,$4F
	db $FF,$05,$00,$00,$4A,$00,$2B,$53,$FF,$06,$00,$00,$4C,$00,$38,$5F
	db $FF,$03,$00,$00,$4E,$00,$24,$61,$FF,$05,$00,$00,$39,$00,$6A,$6F
	db $FF,$04,$00,$80,$34,$00,$88,$72,$FF,$0F,$00,$00,$67,$00,$22,$58
	db $FF,$0C,$00,$00,$67,$00,$32,$58,$FF,$2C,$00,$00,$50,$00,$07,$8E
	db $FF,$03,$00,$00,$40,$00,$44,$66,$FF,$07,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$80,$24,$00,$30,$18,$FF,$07,$00,$80,$24,$00,$50,$18
	db $FF,$07,$00,$80,$24,$00,$70,$18,$FF,$07,$00,$00,$69,$00,$47,$18
	db $FF,$07,$00,$80,$68,$00,$80,$A8,$FF,$0A,$00,$00,$67,$00,$68,$A4
	db $FF,$1E,$00,$80,$38,$00,$A0,$18,$FF,$07,$00,$00,$44,$00,$9F,$B4
	db $FF,$03,$00,$80,$04,$00,$30,$33,$FF,$07,$00,$80,$04,$00,$50,$33
	db $FF,$07,$00,$80,$04,$00,$0C,$79,$FF,$21,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$28,$00,$9C,$18
	db $FF,$07,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3A,$00,$64,$87
	db $FF,$06,$00,$00,$3A,$00,$84,$87,$FF,$06,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$03,$00,$88,$F4
	db $FF,$03,$00,$80,$6C,$00,$50,$18,$FF,$07,$00,$80,$6C,$00,$98,$18
	db $FF,$07,$00,$80,$2C,$00,$A0,$18,$FF,$07,$00,$80,$2C,$00,$40,$18
	db $FF,$07,$00,$80,$2C,$00,$60,$18,$FF,$07,$00,$80,$2C,$00,$80,$18
	db $FF,$07,$00,$00,$38,$00,$7F,$FD,$FF,$03,$00,$00,$42,$00,$4E,$00
	db $FF,$03,$00,$00,$24,$00,$30,$F7,$FF,$04,$00,$00,$26,$00,$1C,$FA
	db $FF,$FF,$00,$00,$2A,$00,$1C,$FB,$FF,$FF,$00,$00,$2C,$00,$1C,$FC
	db $FF,$FF,$00,$00,$3B,$00,$60,$03,$FF,$21,$00,$80,$49,$00,$60,$05
	db $FF,$24,$00,$00,$58,$00,$60,$04,$FF,$27,$00,$00,$48,$00,$A0,$7C
	db $FF,$04,$00,$00,$64,$00,$B0,$F4,$FF,$03,$00

DATA_0DED92:					; Note: Something related to the mouse speed menu.
	dw DATA_0DEE32,DATA_0DEE44,DATA_0DEE86,DATA_0DEEFC,DATA_0DEF22,DATA_0DEF22,DATA_0DEF22,DATA_0DF014
	dw DATA_0DF03A,DATA_0DF060,DATA_0DEF22,DATA_0DEF22,DATA_0DF086,DATA_0DF0BC,DATA_0DF0F2,DATA_0DF134
	dw DATA_0DF17E,DATA_0DF1A4,DATA_0DF1DE,DATA_0DF208,DATA_0DF22E,DATA_0DF264,DATA_0DF2B2,DATA_0DF2F4
	dw DATA_0DF3B6,DATA_0DF3D4,DATA_0DEE32,DATA_0DEF22,DATA_0DEF22,DATA_0DEF22,DATA_0DEF22,DATA_0DF402
	dw DATA_0DF43C,DATA_0DEF22,DATA_0DF4C6,DATA_0DEF50,DATA_0DEF50,DATA_0DEF7E,DATA_0DEE32,DATA_0DEE32
	dw DATA_0DEE32,DATA_0DEE32,DATA_0DEE32,DATA_0DEE32,DATA_0DEE32,DATA_0DEE32,DATA_0DEE32,DATA_0DEE32
	dw DATA_0DEF22,DATA_0DEE32,DATA_0DEE32,DATA_0DEE32,DATA_0DEE32,DATA_0DEE32,DATA_0DEE32,DATA_0DEE32
	dw DATA_0DEF22,DATA_0DEF22,DATA_0DEE32,DATA_0DEE32,DATA_0DF4E4,DATA_0DEF22,DATA_0DEF22,DATA_0DEF22
	dw DATA_0DEF22,DATA_0DEF22,DATA_0DEF22,DATA_0DF502,DATA_0DF520,DATA_0DF53E,DATA_0DF560,DATA_0DF5BA
	dw DATA_0DF610,DATA_0DF66A,DATA_0DF66A,DATA_0DF66A,DATA_0DF718,DATA_0DF4E4,DATA_0DEE32,DATA_0DEE32

DATA_0DEE32:
	dw $0000,$0000,$0000,$0000,$100C,$0000,$100D,$FFFF
	dw $FFFF

DATA_0DEE44:
	dw $0000,$0000,$0000,$0000,$7000,$0000,$3001,$0000
	dw $5002,$0000,$3003,$0000,$2004,$0000,$2005,$0000
	dw $2006,$0000,$9007,$0000,$2006,$0000,$2005,$0000
	dw $2004,$FFFF,$FFFF,$0000,$0000,$0000,$0800,$FFFF
	dw $FFFF

DATA_0DEE86:
	dw $0000,$0000,$0000,$0000,$100E,$0000,$100F,$0000
	dw $1010,$0000,$100E,$0000,$100F,$0000,$1010,$0000
	dw $100E,$0000,$100F,$0000,$1010,$0000,$100E,$0000
	dw $100F,$0000,$1010,$0000,$100E,$0000,$100F,$0000
	dw $1010,$0000,$100E,$0000,$100F,$0000,$1010,$0000
	dw $1511,$0000,$2012,$0000,$1013,$0000,$1012,$0000
	dw $1013,$0000,$1012,$FFFF,$FFFF,$0000,$0000,$0000
	dw $0813,$FFFF,$FFFF

DATA_0DEEFC:
	dw $0000,$0000,$0000,$0000,$0714,$0000,$0715,$0000
	dw $0716,$0000,$0717,$FFFF,$FFFF,$0000,$0000,$0000
	dw $0817,$FFFF,$FFFF

DATA_0DEF22:
	dw $0000,$0000,$0818,$0000,$0819,$0000,$0000,$0000
	dw $081A,$0000,$071B,$0000,$071C,$FFFF,$FFFF,$0000
	dw $0819,$0000,$0000,$0000,$0818,$FFFF,$FFFF

DATA_0DEF50:
	dw $0000,$0000,$0833,$0000,$0834,$0000,$0000,$0000
	dw $0835,$0000,$0736,$0000,$0737,$FFFF,$FFFF,$0000
	dw $0834,$0000,$0000,$0000,$0833,$FFFF,$FFFF

DATA_0DEF7E:
	dw $0100,$0000,$0000,$0000,$0F79,$0000,$0F7A,$0000
	dw $0F79,$0000,$0F7A,$0000,$0F79,$0000,$0F7A,$0000
	dw $0F79,$0000,$0F7A,$0000,$0F79,$0000,$0F7A,$0000
	dw $0F79,$0000,$0F7A,$0000,$0F7B,$0000,$0F7A,$0000
	dw $0F7B,$0000,$0F7A,$0000,$0F7B,$0000,$0F7C,$0000
	dw $0F7D,$0000,$0F7C,$0000,$0F7D,$0000,$0F7C,$0000
	dw $0F7D,$0000,$0F7C,$0000,$0F7D,$0000,$1F79,$0000
	dw $047D,$0000,$047E,$0000,$047F,$0000,$0480,$0000
	dw $047D,$0000,$047F,$FFFF,$FFFF,$0000,$0000,$0000
	dw $1079,$FFFF,$FFFF

DATA_0DF014:
	dw $0000,$0000,$0000,$0000,$0808,$0000,$083C,$0000
	dw $083F,$0000,$0842,$FFFF,$FFFF,$0000,$0000,$0000
	dw $0808,$FFFF,$FFFF

DATA_0DF03A:
	dw $0000,$0000,$0000,$0000,$0409,$0000,$043D,$0000
	dw $0440,$0000,$0443,$FFFF,$FFFF,$0000,$0000,$0000
	dw $0409,$FFFF,$FFFF

DATA_0DF060:
	dw $0000,$0000,$0000,$0000,$020A,$0000,$023E,$0000
	dw $0241,$0000,$0244,$FFFF,$FFFF,$0000,$0000,$0000
	dw $020A,$FFFF,$FFFF

DATA_0DF086:
	dw $0000,$0000,$207F,$0000,$1080,$0000,$0000,$0000
	dw $0681,$0000,$0882,$0000,$0681,$0000,$0882,$0000
	dw $4081,$0000,$F081,$FFFF,$FFFF,$0000,$0000,$0000
	dw $207F,$FFFF,$FFFF

DATA_0DF0BC:
	dw $0000,$0000,$2083,$0000,$1084,$0000,$0000,$0000
	dw $0685,$0000,$0886,$0000,$0685,$0000,$0886,$0000
	dw $4085,$0000,$F085,$FFFF,$FFFF,$0000,$0000,$0000
	dw $2083,$FFFF,$FFFF

DATA_0DF0F2:
	dw $0000,$0000,$0000,$0000,$0846,$0000,$0847,$0000
	dw $0848,$0000,$0849,$0000,$084A,$0000,$0849,$0000
	dw $0848,$0000,$0847,$FFFF,$FFFF,$0000,$0000,$0000
	dw $0846,$FFFF,$FFFF,$0000,$0000,$0000,$08FF,$FFFF
	dw $FFFF

DATA_0DF134:
	dw $0000,$0000,$0000,$0000,$054B,$0000,$054C,$0000
	dw $054E,$0000,$054D,$0000,$064C,$FFFF,$FFFF,$0000
	dw $0000,$0000,$05FF,$FFFF,$FFFF,$0000,$0000,$0000
	dw $088E,$0000,$088F,$FFFF,$FFFF,$0000,$0000,$0000
	dw $0864,$0000,$0865,$FFFF,$FFFF

DATA_0DF17E:
	dw $0000,$0000,$0000,$0000,$104F,$0000,$1050,$0000
	dw $1051,$0000,$1052,$FFFF,$FFFF,$0000,$0000,$0000
	dw $05FF,$FFFF,$FFFF

DATA_0DF1A4:
	dw $0000,$0000,$0000,$0000,$10FF,$0000,$1053,$0000
	dw $1054,$0000,$1055,$0000,$1054,$FFFF,$FFFF,$0000
	dw $0000,$0000,$08FF,$FFFF,$FFFF,$0000,$0000,$0000
	dw $0856,$0000,$08FF,$FFFF,$FFFF

DATA_0DF1DE:
	dw $0000,$0000,$0000,$0000,$105F,$0000,$1060,$FFFF
	dw $FFFF,$0000,$0000,$0000,$055F,$FFFF,$FFFF,$0000
	dw $0000,$0000,$0560,$FFFF,$FFFF

DATA_0DF208:
	dw $0000,$0000,$0000,$0000,$03FF,$0000,$0361,$0000
	dw $0362,$0000,$0363,$FFFF,$FFFF,$0000,$0000,$0000
	dw $03FF,$FFFF,$FFFF

DATA_0DF22E:
	dw $0000,$0000,$0000,$0000,$0870,$0000,$406F,$0000
	dw $F06F,$FFFF,$FFFF,$0000,$0000,$0000,$1071,$FFFF
	dw $FFFF,$0000,$0000,$0000,$0870,$0000,$4071,$0000
	dw $F071,$FFFF,$FFFF

DATA_0DF264:
	dw $0000,$0000,$0000,$0000,$1072,$0000,$0873,$0000
	dw $0574,$0000,$0475,$FB00,$0476,$FE00,$0477,$0100
	dw $0478,$0400,$0479,$0700,$0476,$0A00,$0477,$0D00
	dw $0478,$1000,$0479,$0000,$01FF,$0000,$01FF,$FFFF
	dw $FFFF,$0000,$0000,$0000,$10FF,$FFFF,$FFFF

DATA_0DF2B2:
	dw $0000,$0000,$0000,$0000,$0258,$0200,$0259,$0400
	dw $025A,$0600,$025B,$0800,$025C,$0A00,$025D,$0C00
	dw $025E,$0E00,$0258,$0000,$14FF,$0000,$20FF,$0000
	dw $20FF,$FFFF,$FFFF,$0000,$0000,$0000,$10FF,$FFFF
	dw $FFFF

DATA_0DF2F4:
	dw $0000,$0000,$0000,$0000,$10FF,$0000,$0259,$0200
	dw $025A,$0400,$025B,$0600,$025C,$0800,$025D,$0A00
	dw $025E,$0C00,$0258,$0E00,$0259,$1000,$025A,$1200
	dw $025B,$1400,$025C,$1600,$025D,$1800,$025E,$1A00
	dw $0258,$1C00,$0259,$1E00,$025A,$2000,$025B,$2200
	dw $025C,$2400,$025D,$2600,$025E,$2800,$0258,$2A00
	dw $0259,$2C00,$025A,$2E00,$025B,$3000,$025C,$3200
	dw $025D,$3400,$025E,$3600,$0258,$3800,$0259,$3A00
	dw $025A,$3C00,$025B,$3E00,$025C,$4000,$025D,$4200
	dw $025E,$43FF,$0258,$43FD,$0259,$43FB,$025A,$43F9
	dw $025B,$43F7,$025C,$43F5,$025D,$43F3,$025E,$43F1
	dw $0258,$FFFF,$FFFF,$0000,$0000,$0000,$10FF,$FFFF
	dw $FFFF

DATA_0DF3B6:
	dw $0000,$0000,$0000,$0000,$088E,$0000,$088F,$FFFF
	dw $FFFF,$0000,$0000,$0000,$10FF,$FFFF,$FFFF

DATA_0DF3D4:
	dw $0000,$0000,$0000,$0000,$0866,$0000,$0867,$0000
	dw $0868,$0000,$0869,$0000,$086A,$0000,$20FF,$FFFF
	dw $FFFF,$0000,$0000,$0000,$10FF,$FFFF,$FFFF

DATA_0DF402:
	dw $0000,$0000,$04A8,$0000,$04A9,$0000,$04AA,$0000
	dw $04AB,$0000,$04AC,$0000,$04AD,$0000,$04AE,$0000
	dw $04AF,$0000,$0000,$0000,$04B0,$FFFF,$FFFF,$0000
	dw $0000,$0000,$07FF,$FFFF,$FFFF

DATA_0DF43C:
	dw $0000,$0000,$24A4,$0000,$02A4,$0400,$05A5,$0400
	dw $02A4,$0800,$05A5,$0800,$02A4,$0C00,$05A5,$0CFF
	dw $02A4,$10FE,$05A5,$10FE,$02A4,$14FC,$05A5,$14FA
	dw $02A4,$18F8,$05A5,$18F7,$02A4,$1CF6,$05A5,$1CF5
	dw $02A4,$20F5,$05A5,$20F5,$02A4,$24F6,$05A5,$24F8
	dw $02A4,$26F9,$02A6,$29FB,$05A7,$28FD,$02A6,$2AFF
	dw $05A7,$2901,$02A6,$2B03,$05A7,$2A05,$02A6,$2C07
	dw $05A7,$0000,$0000,$2C07,$08A7,$FFFF,$FFFF,$0000
	dw $0000,$0000,$07A4,$FFFF,$FFFF

DATA_0DF4C6:
	dw $0000,$0000,$0000,$0000,$06B4,$0000,$06B5,$FFFF
	dw $FFFF,$0000,$0000,$0000,$06B4,$FFFF,$FFFF

DATA_0DF4E4:
	dw $0000,$0000,$08F5,$0000,$01F6,$0000,$0BF6,$0000
	dw $08F5,$0000,$0000,$0000,$05F4,$FFFF,$FFFF

DATA_0DF502:
	dw $0000,$0000,$0000,$0000,$10FD,$0000,$10FE,$FFFF
	dw $FFFF,$0000,$0000,$0000,$10FD,$FFFF,$FFFF

DATA_0DF520:
	dw $0100,$0000,$0000,$0000,$1000,$0000,$1001,$FFFF
	dw $FFFF,$0000,$0000,$0000,$1000,$FFFF,$FFFF

DATA_0DF53E:
	dw $0000,$0000,$0000,$0000,$07F7,$0000,$08F8,$0000
	dw $07F9,$FFFF,$FFFF,$0000,$0000,$0000,$07F7,$FFFF
	dw $FFFF

DATA_0DF560:
	dw $0000,$0000,$0000,$0000,$07FF,$FFFF,$FFFF,$0000
	dw $0000,$0000,$10FF,$FF00,$07FA,$FEFF,$07FA,$FDFF
	dw $07FA,$FCFF,$07FA,$FBFE,$07FA,$FAFD,$07FA,$F9FC
	dw $07FA,$F8FB,$07FA,$F7FB,$07FA,$F6FB,$07FA,$F5FA
	dw $07FA,$F4F9,$07FA,$F3F8,$07FA,$F2F7,$07FA,$F1F7
	dw $07FA,$F0F7,$07FA,$FFFF,$FFFF

DATA_0DF5BA:
	dw $0000,$0000,$0000,$0000,$07FF,$FFFF,$FFFF,$0000
	dw $0000,$FF00,$07FB,$FEFF,$07FB,$FDFE,$07FB,$FCFD
	dw $07FB,$FBFD,$07FB,$FAFE,$07FB,$F9FF,$07FB,$F800
	dw $07FB,$F701,$07FB,$F602,$07FB,$F503,$07FB,$F403
	dw $07FB,$F302,$07FB,$F201,$07FB,$F100,$07FB,$F000
	dw $07FB,$FFFF,$FFFF

DATA_0DF610:
	dw $0000,$0000,$0000,$0000,$07FF,$FFFF,$FFFF,$0000
	dw $0000,$0000,$20FF,$FF00,$07FC,$FE01,$07FC,$FD01
	dw $07FC,$FC01,$07FC,$FB02,$07FC,$FA03,$07FC,$F904
	dw $07FC,$F805,$07FC,$F705,$07FC,$F605,$07FC,$F506
	dw $07FC,$F407,$07FC,$F308,$07FC,$F209,$07FC,$F109
	dw $07FC,$F009,$07FC,$FFFF,$FFFF

DATA_0DF66A:
	dw $0100,$0000,$0000,$0000,$0702,$0000,$0703,$0000
	dw $0702,$0000,$0703,$0000,$0702,$0000,$0703,$0000
	dw $0702,$0000,$0703,$0000,$0702,$0000,$0703,$0000
	dw $1002,$0000,$1004,$0000,$1002,$0000,$1004,$0000
	dw $1002,$0000,$1004,$0000,$0802,$0000,$0803,$0000
	dw $0802,$0000,$0803,$0000,$0802,$0000,$0803,$0000
	dw $0802,$0000,$0803,$0000,$4002,$0000,$1005,$0000
	dw $1002,$0000,$1005,$0000,$1002,$0000,$1005,$0000
	dw $1002,$0000,$1005,$FFFF,$FFFF,$0000,$0000,$0000
	dw $1003,$FFFF,$FFFF,$0000,$0000,$0000,$1005,$FFFF
	dw $FFFF,$0000,$0000,$0000,$1004,$FFFF,$FFFF

DATA_0DF718:
	dw $0000,$0000,$077C,$0000,$077D,$0000,$0000,$0000
	dw $077E,$FFFF,$FFFF,$0000,$0000,$0000,$077C,$FFFF
	dw $FFFF

	%FREE_BYTES(NULLROM, 2246, $00)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank0EMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

%FREE_BYTES(NULLROM, 8192, $00)

DATA_0EA000:
	incbin "Graphics/GFX_0EA000.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank0FMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_0F8000:					; Note: Sprite related data
	dw DATA_0F8060,DATA_0F8454,DATA_0F84B4,DATA_0F851C,DATA_0F8548,DATA_0F8568,DATA_0F8618,DATA_0F8624
	dw DATA_0F8638,DATA_0F8650,DATA_0F866C,DATA_0F868C,DATA_0F8700,DATA_0F8748,DATA_0F8780,DATA_0F8838
	dw DATA_0F88F0,DATA_0F89A8,DATA_0F8A60,DATA_0F8B18,DATA_0F8BD0,DATA_0F8C88,DATA_0F8D40,DATA_0F8DF8
	dw DATA_0F8EB0,DATA_0F8F48,DATA_0F8FE0,DATA_0F9078,DATA_0F9110,DATA_0F91A8,DATA_0F9240,DATA_0F92D8
	dw DATA_0F9370,DATA_0F9408,DATA_0F94A0,DATA_0F9538,DATA_0F95D0,DATA_0F9668,DATA_0F9700,DATA_0F9788
	dw DATA_0F9A20,DATA_0F8060,DATA_0F8060,DATA_0F8060,DATA_0F8060,DATA_0F8060,DATA_0F8060,DATA_0F8060

DATA_0F8060:
	dw $3780,$FF31,$0181,$FF00,$0281,$FF00,$0381,$FF40
	dw $0000,$0000,$0382,$FF04,$0287,$8300,$0187,$1000
	dw $FE03,$8000,$FE03,$8100,$FE03,$8200,$D09E,$0D01
	dw $F09E,$1801,$409E,$0600,$C09E,$1E00,$0683,$FFFF
	dw $0203,$8000,$0203,$8100,$0203,$8200,$30A0,$1501
	dw $10A0,$1B01,$409E,$0600,$C09E,$1E00,$0683,$FFFF
	dw $A003,$0000,$A003,$0000,$0683,$FFFF,$6003,$0000
	dw $6003,$0000,$0683,$FFFF,$00AE,$00FF,$0084,$22AA
	dw $609E,$2200,$A09E,$2700,$00AE,$003F,$0084,$2C06
	dw $0084,$4D0C,$0084,$6610,$0683,$FFFF,$00AE,$003F
	dw $0084,$6907,$0084,$6C0F,$0084,$7017,$0683,$FFFF
	dw $0187,$3D00,$FE02,$83FC,$FF00,$03FF,$FF00,$03FE
	dw $FE05,$83FE,$FF00,$0300,$FF00,$03FF,$FE02,$8300
	dw $FF00,$0301,$FE02,$8300,$FE02,$8302,$FF00,$0300
	dw $FF00,$0302,$FE02,$8302,$FE02,$8304,$FF00,$0301
	dw $7383,$FFFF,$0202,$83FC,$0100,$03FF,$0100,$03FE
	dw $0205,$83FE,$0100,$0300,$0100,$03FF,$0202,$8300
	dw $0100,$0301,$0202,$8300,$0202,$8302,$0100,$0300
	dw $0100,$0302,$0202,$8302,$0202,$8304,$0100,$0301
	dw $7383,$FFFF,$0187,$5A00,$0007,$0400,$3780,$FF71
	dw $0181,$FF01,$0003,$0000,$0203,$8100,$0302,$8200
	dw $0401,$8000,$0401,$8000,$0401,$8100,$0401,$8200
	dw $10A0,$7301,$5583,$FFFF,$0007,$0400,$3780,$FF31
	dw $0181,$FF00,$0003,$0000,$FE03,$8100,$FD02,$8200
	dw $FC01,$8000,$FC01,$8000,$FC01,$8100,$FC01,$8200
	dw $10A0,$7301,$6183,$FFFF,$0008,$0000,$007F,$0800
	dw $7383,$FFFF,$0008,$0000,$0040,$0500,$7383,$FFFF
	dw $0008,$0000,$007F,$0600,$007F,$0600,$7383,$FFFF
	dw $0008,$0000,$0004,$0500,$007F,$0700,$0381,$FF04
	dw $0187,$7C00,$FE03,$8000,$FE03,$8100,$FE03,$8200
	dw $D09E,$7A01,$F09E,$1801,$0382,$FF74,$0683,$FFFF
	dw $0203,$8000,$0203,$8100,$0203,$8200,$30A0,$8101
	dw $10A0,$1B01,$0382,$FF74,$0683,$FFFF,$0006,$0000
	dw $0002,$1300,$0005,$0000,$0003,$1300,$0004,$0000
	dw $0004,$1300,$0003,$0000,$0005,$1300,$0002,$0000
	dw $0006,$1300,$0001,$0000,$0007,$1300,$0286,$F000
	dw $0187,$9800,$FD03,$1300,$FD03,$1400,$D09E,$9501
	dw $F09E,$9F01,$409E,$8F00,$C09E,$A500,$8F83,$FFFF
	dw $0303,$1300,$0303,$1400,$30A0,$9C01,$10A0,$A201
	dw $409E,$8F00,$C09E,$A500,$8F83,$FFFF,$A003,$1300
	dw $A003,$1300,$8F83,$FFFF,$6003,$1300,$6003,$1300
	dw $8F83,$FFFF,$00AE,$00FF,$0084,$A9AA,$609E,$A900
	dw $A09E,$AD00,$00AE,$003F,$0084,$B206,$0084,$C10C
	dw $8F83,$FFFF,$00AE,$003F,$0084,$D807,$0084,$DB0F
	dw $0084,$DF17,$8F83,$FFFF,$0187,$BA00,$FD03,$16FB
	dw $FD03,$16FD,$FD03,$16FF,$FD03,$1601,$FD03,$1603
	dw $FD03,$1605,$E283,$FFFF,$0303,$16FB,$0303,$16FD
	dw $0303,$16FF,$0303,$1601,$0303,$1603,$0303,$1605
	dw $E283,$FFFF,$0187,$CD00,$0007,$1500,$3780,$FF71
	dw $0181,$FF01,$0003,$1300,$0202,$1400,$0302,$1300
	dw $0401,$1400,$0502,$1300,$0502,$1400,$10A0,$E201
	dw $C983,$FFFF,$0007,$1500,$3780,$FF31,$0181,$FF00
	dw $0003,$1300,$FE02,$1400,$FD02,$1300,$FC01,$1400
	dw $FB02,$1300,$FB02,$1400,$10A0,$E201,$D483,$FFFF
	dw $0008,$1300,$0040,$1700,$E283,$FFFF,$0008,$1300
	dw $007F,$1800,$007F,$1800,$E283,$FFFF,$0008,$1300
	dw $0004,$1700,$007F,$1900,$0381,$FF04,$0187,$EA00
	dw $FD03,$1300,$FD03,$1400,$D09E,$E801,$F09E,$9F01
	dw $0382,$FFE3,$8F83,$FFFF,$0303,$1300,$0303,$1400
	dw $30A0,$EE01,$10A0,$A201,$0382,$FFE3,$8F83,$FFFF
	dw $0006,$1300,$0002,$0000,$0005,$1300,$0003,$0000
	dw $0004,$1300,$0004,$0000,$0003,$1300,$0005,$0000
	dw $0002,$1300,$0006,$0000,$0001,$1300,$0007,$0000
	dw $0683,$FFFF

DATA_0F8454:
	dw $CC80,$FF00,$0481,$FF00,$0001,$0100,$0001,$0101
	dw $0001,$0103,$0001,$0105,$0001,$0107,$0001,$0109
	dw $0001,$010B,$0001,$010D,$0001,$010F,$0001,$0111
	dw $0001,$0113,$0001,$0115,$0001,$0117,$0001,$0119
	dw $0000,$0101,$007F,$0100,$007F,$0100,$0000,$0102
	dw $48A5,$1300,$0481,$FF01,$0000,$0100,$1683,$FFFF

DATA_0F84B4:
	dw $CC80,$FF00,$0581,$FF00,$0010,$1200,$0010,$1300
	dw $0010,$1200,$0010,$1300,$0010,$1200,$0010,$1300
	dw $0001,$1201,$0001,$1203,$0001,$1205,$0001,$1207
	dw $0001,$1209,$0001,$120B,$A3A5,$0D00,$0404,$1400
	dw $0405,$1500,$10A4,$0F01,$7000,$1400,$7000,$14A5
	dw $0404,$1400,$0405,$1500,$60A4,$1400,$0581,$FF01
	dw $0000,$0200,$1883,$FFFF

DATA_0F851C:
	dw $CC80,$FF00,$0681,$FF00,$0781,$FF08,$0004,$1600
	dw $0004,$1700,$0004,$1800,$0004,$1900,$0782,$FF03
	dw $0681,$FF01,$0000,$0400,$0983,$FFFF

DATA_0F8548:
	dw $E680,$FF00,$0881,$FF00,$0004,$0500,$0882,$FF02
	dw $FC00,$0504,$F0A5,$0400,$3000,$0500,$0183,$FFFF

DATA_0F8568:
	dw $E680,$FF00,$0AAE,$013F,$0101,$0200,$0A82,$FF02
	dw $09AE,$003F,$0984,$0F0F,$0984,$1D1F,$0984,$242F
	dw $0AAE,$013F,$FF01,$02FF,$189F,$0F00,$0A82,$FF09
	dw $09AE,$003F,$0984,$010F,$0984,$161F,$0AAE,$013F
	dw $FF01,$0201,$88A1,$0800,$0A82,$FF10,$09AE,$003F
	dw $0984,$010F,$0984,$081F,$0AAE,$013F,$FF01,$0200
	dw $0A82,$FF17,$09AE,$003F,$0984,$080F,$0984,$0F1F
	dw $0984,$242F,$0AAE,$013F,$0101,$02FF,$189F,$2400
	dw $0A82,$FF1E,$09AE,$003F,$0984,$010F,$0984,$161F
	dw $0AAE,$013F,$0101,$0201,$88A1,$1D00,$0A82,$FF25
	dw $09AE,$003F,$0984,$160F,$0984,$1D1F,$0183,$FFFF

DATA_0F8618:
	dw $E680,$FF00,$FF04,$0300,$0183,$FFFF

DATA_0F8624:
	dw $E680,$FF00,$FF02,$0000,$FF02,$00FF,$FF02,$0001
	dw $0183,$FFFF

DATA_0F8638:
	dw $E680,$FF00,$FF02,$0100,$FF02,$0100,$FF02,$01FF
	dw $FF02,$0101,$0183,$FFFF

DATA_0F8650:
	dw $E680,$FF00,$FF02,$0100,$FF02,$0100,$FF02,$0100
	dw $FF02,$01FF,$FF02,$0101,$0183,$FFFF

DATA_0F866C:
	dw $E680,$FF00,$FF02,$0100,$FF02,$0100,$FF02,$0100
	dw $FF02,$0100,$FF02,$01FF,$FF02,$0101,$0183,$FFFF

DATA_0F868C:
	dw $E680,$FF70,$0CAE,$017F,$0101,$0600,$0C82,$FF02
	dw $0BAE,$003F,$0B84,$0D1F,$0102,$0600,$0103,$0600
	dw $0104,$0600,$0CAE,$017F,$0104,$0600,$0C82,$FF0A
	dw $1983,$FFFF,$0102,$0600,$0103,$0600,$0104,$0600
	dw $0105,$0600,$0106,$0600,$0107,$0600,$0CAE,$013F
	dw $0004,$0600,$0C82,$FF14,$0107,$0600,$0106,$0600
	dw $0105,$0600,$0104,$0600,$0103,$0600,$0103,$0600
	dw $0183,$FFFF

DATA_0F8700:
	dw $E680,$FF70,$0EAE,$0807,$0103,$04FD,$0103,$04FF
	dw $0103,$0401,$0103,$0403,$0E82,$FF02,$0C83,$FFFF
	dw $0EAE,$0303,$0103,$04FF,$0103,$0401,$0E82,$FF09
	dw $0EAE,$201F,$0002,$0400,$0E82,$FF0D,$0DAE,$003F
	dw $0D84,$081F,$0183,$FFFF

DATA_0F8748:
	dw $3780,$FF01,$0F81,$FF00,$FE00,$0900,$FE00,$0900
	dw $FE00,$0900,$FE00,$0900,$FE00,$0A00,$FE00,$0A00
	dw $FE00,$0A00,$FE00,$0A00,$F0A4,$0201,$0F81,$FF01
	dw $0000,$0900,$0C83,$FFFF

DATA_0F8780:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$11AE,$013F,$FF01,$0000,$0101,$0000
	dw $0101,$0000,$FF01,$0000,$1182,$FF06,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $0001,$00FF,$0001,$0001,$0001,$0001,$0001,$00FF
	dw $1182,$FF10,$10AE,$003F,$1084,$050F,$1084,$0F1F
	dw $1084,$232F,$11AE,$013F,$FF01,$00FF,$0101,$0001
	dw $0101,$0001,$FF01,$00FF,$1182,$FF1A,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $FF01,$0001,$0101,$00FF,$0101,$00FF,$FF01,$0001
	dw $1182,$FF24,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$0583,$FFFF

DATA_0F8838:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$11AE,$013F,$FF01,$0100,$0101,$0100
	dw $0101,$0100,$FF01,$0100,$1182,$FF06,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $0001,$01FF,$0001,$0101,$0001,$0101,$0001,$01FF
	dw $1182,$FF10,$10AE,$003F,$1084,$050F,$1084,$0F1F
	dw $1084,$232F,$11AE,$013F,$FF01,$01FF,$0101,$0101
	dw $0101,$0101,$FF01,$01FF,$1182,$FF1A,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $FF01,$0101,$0101,$01FF,$0101,$01FF,$FF01,$0101
	dw $1182,$FF24,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$0583,$FFFF

DATA_0F88F0:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$11AE,$013F,$FF01,$0200,$0101,$0200
	dw $0101,$0200,$FF01,$0200,$1182,$FF06,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $0001,$02FF,$0001,$0201,$0001,$0201,$0001,$02FF
	dw $1182,$FF10,$10AE,$003F,$1084,$050F,$1084,$0F1F
	dw $1084,$232F,$11AE,$013F,$FF01,$02FF,$0101,$0201
	dw $0101,$0201,$FF01,$02FF,$1182,$FF1A,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $FF01,$0201,$0101,$02FF,$0101,$02FF,$FF01,$0201
	dw $1182,$FF24,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$0583,$FFFF

DATA_0F89A8:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$11AE,$013F,$FF01,$0300,$0101,$0300
	dw $0101,$0300,$FF01,$0300,$1182,$FF06,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $0001,$03FF,$0001,$0301,$0001,$0301,$0001,$03FF
	dw $1182,$FF10,$10AE,$003F,$1084,$050F,$1084,$0F1F
	dw $1084,$232F,$11AE,$013F,$FF01,$03FF,$0101,$0301
	dw $0101,$0301,$FF01,$03FF,$1182,$FF1A,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $FF01,$0301,$0101,$03FF,$0101,$03FF,$FF01,$0301
	dw $1182,$FF24,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$0583,$FFFF

DATA_0F8A60:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$11AE,$013F,$FF01,$0400,$0101,$0400
	dw $0101,$0400,$FF01,$0400,$1182,$FF06,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $0001,$04FF,$0001,$0401,$0001,$0401,$0001,$04FF
	dw $1182,$FF10,$10AE,$003F,$1084,$050F,$1084,$0F1F
	dw $1084,$232F,$11AE,$013F,$FF01,$04FF,$0101,$0401
	dw $0101,$0401,$FF01,$04FF,$1182,$FF1A,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $FF01,$0401,$0101,$04FF,$0101,$04FF,$FF01,$0401
	dw $1182,$FF24,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$0583,$FFFF

DATA_0F8B18:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$11AE,$013F,$FF01,$0500,$0101,$0500
	dw $0101,$0500,$FF01,$0500,$1182,$FF06,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $0001,$05FF,$0001,$0501,$0001,$0501,$0001,$05FF
	dw $1182,$FF10,$10AE,$003F,$1084,$050F,$1084,$0F1F
	dw $1084,$232F,$11AE,$013F,$FF01,$05FF,$0101,$0501
	dw $0101,$0501,$FF01,$05FF,$1182,$FF1A,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $FF01,$0501,$0101,$05FF,$0101,$05FF,$FF01,$0501
	dw $1182,$FF24,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$0583,$FFFF

DATA_0F8BD0:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$11AE,$013F,$FF01,$0100,$0101,$0100
	dw $0101,$0100,$FF01,$0100,$1182,$FF06,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $0001,$01FF,$0001,$0101,$0001,$0101,$0001,$01FF
	dw $1182,$FF10,$10AE,$003F,$1084,$050F,$1084,$0F1F
	dw $1084,$232F,$11AE,$013F,$FF01,$01FF,$0101,$0101
	dw $0101,$0101,$FF01,$01FF,$1182,$FF1A,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $FF01,$0101,$0101,$01FF,$0101,$01FF,$FF01,$0101
	dw $1182,$FF24,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$0583,$FFFF

DATA_0F8C88:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$11AE,$013F,$FF01,$0300,$0101,$0300
	dw $0101,$0300,$FF01,$0300,$1182,$FF06,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $0001,$03FF,$0001,$0301,$0001,$0301,$0001,$03FF
	dw $1182,$FF10,$10AE,$003F,$1084,$050F,$1084,$0F1F
	dw $1084,$232F,$11AE,$013F,$FF01,$03FF,$0101,$0301
	dw $0101,$0301,$FF01,$03FF,$1182,$FF1A,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $FF01,$0301,$0101,$03FF,$0101,$03FF,$FF01,$0301
	dw $1182,$FF24,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$0583,$FFFF

DATA_0F8D40:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$11AE,$013F,$FF01,$0600,$0101,$0600
	dw $0101,$0600,$FF01,$0600,$1182,$FF06,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $0001,$06FF,$0001,$0601,$0001,$0601,$0001,$06FF
	dw $1182,$FF10,$10AE,$003F,$1084,$050F,$1084,$0F1F
	dw $1084,$232F,$11AE,$013F,$FF01,$06FF,$0101,$0601
	dw $0101,$0601,$FF01,$06FF,$1182,$FF1A,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $FF01,$0601,$0101,$06FF,$0101,$06FF,$FF01,$0601
	dw $1182,$FF24,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$0583,$FFFF

DATA_0F8DF8:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$11AE,$013F,$FF01,$0700,$0101,$0700
	dw $0101,$0700,$FF01,$0700,$1182,$FF06,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $0001,$07FF,$0001,$0701,$0001,$0701,$0001,$07FF
	dw $1182,$FF10,$10AE,$003F,$1084,$050F,$1084,$0F1F
	dw $1084,$232F,$11AE,$013F,$FF01,$07FF,$0101,$0701
	dw $0101,$0701,$FF01,$07FF,$1182,$FF1A,$10AE,$003F
	dw $1084,$050F,$1084,$191F,$1084,$232F,$11AE,$013F
	dw $FF01,$0701,$0101,$07FF,$0101,$07FF,$FF01,$0701
	dw $1182,$FF24,$10AE,$003F,$1084,$0F0F,$1084,$191F
	dw $1084,$232F,$0583,$FFFF

DATA_0F8EB0:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0800,$0103,$0800
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$08FF,$0003,$0801
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$08FF,$0103,$0801
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0801,$0103,$08FF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F8F48:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0900,$0103,$0900
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$09FF,$0003,$0901
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$09FF,$0103,$0901
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0901,$0103,$09FF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F8FE0:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0A00,$0103,$0A00
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$0AFF,$0003,$0A01
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0AFF,$0103,$0A01
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0A01,$0103,$0AFF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F9078:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0A00,$0103,$0A00
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$0AFF,$0003,$0A01
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0AFF,$0103,$0A01
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0A01,$0103,$0AFF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F9110:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0B00,$0103,$0B00
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$0BFF,$0003,$0B01
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0BFF,$0103,$0B01
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0B01,$0103,$0BFF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F91A8:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$2400,$0103,$2400
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$24FF,$0003,$2401
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$24FF,$0103,$2401
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$2401,$0103,$24FF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F9240:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0D00,$0103,$0D00
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$0DFF,$0003,$0D01
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0DFF,$0103,$0D01
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0D01,$0103,$0DFF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F92D8:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0C00,$0103,$0C00
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$0CFF,$0003,$0C01
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0CFF,$0103,$0C01
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0C01,$0103,$0CFF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F9370:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0E00,$0103,$0E00
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$0EFF,$0003,$0E01
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0EFF,$0103,$0E01
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0E01,$0103,$0EFF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F9408:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0F00,$0103,$0F00
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$0FFF,$0003,$0F01
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0FFF,$0103,$0F01
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0F01,$0103,$0FFF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F94A0:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0C00,$0103,$0C00
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$0CFF,$0003,$0C01
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0CFF,$0103,$0C01
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$0C01,$0103,$0CFF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F9538:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$1000,$0103,$1000
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$10FF,$0003,$1001
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$10FF,$0103,$1001
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$1001,$0103,$10FF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F95D0:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$1100,$0103,$1100
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$11FF,$0003,$1101
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$11FF,$0103,$1101
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$1101,$0103,$11FF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F9668:
	dw $CC80,$FF00,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$2500,$0103,$2500
	dw $1182,$FF06,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$0003,$25FF,$0003,$2501
	dw $1182,$FF0E,$10AE,$003F,$1084,$050F,$1084,$0D1F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$25FF,$0103,$2501
	dw $1182,$FF16,$10AE,$003F,$1084,$050F,$1084,$151F
	dw $1084,$1D2F,$11AE,$013F,$FF03,$2501,$0103,$25FF
	dw $1182,$FF1E,$10AE,$003F,$1084,$0D0F,$1084,$151F
	dw $1084,$1D2F,$0583,$FFFF

DATA_0F9700:
	dw $8180,$FF01,$000F,$0000,$000F,$0100,$000F,$0000
	dw $000F,$0100,$000F,$0000,$000F,$0100,$000F,$0000
	dw $000F,$0200,$000F,$0000,$000F,$0200,$000F,$0000
	dw $000F,$0000,$000F,$0200,$0014,$0300,$0004,$0400
	dw $0004,$0500,$0004,$0600,$0004,$0300,$0004,$0400
	dw $0004,$0500,$0004,$0600,$000F,$0000,$000F,$0200
	dw $002F,$0000,$0007,$0200,$0008,$0700,$0008,$0300
	dw $0003,$0000,$0006,$0100,$000F,$0300,$003F,$0000
	dw $000F,$0100,$0183,$FFFF

DATA_0F9788:
	dw $8980,$FF01,$1581,$FF00,$1481,$FF00,$1681,$FF01
	dw $0008,$0000,$0008,$0100,$0008,$0200,$1083,$FFFF
	dw $0008,$0200,$0008,$0100,$0008,$0000,$8980,$FF41
	dw $1481,$FF01,$0008,$0100,$0008,$0200,$8B83,$FFFF
	dw $13AE,$0307,$FC03,$0200,$FC03,$0300,$1586,$9401
	dw $4F9E,$0800,$1382,$FF11,$8283,$FFFF,$13AE,$0101
	dw $0007,$0200,$0003,$0400,$1586,$9401,$1382,$FF18
	dw $8283,$FFFF,$0010,$0200,$13AE,$603F,$0000,$0500
	dw $1586,$9401,$1382,$FF1F,$8283,$FFFF,$13AE,$0407
	dw $0005,$0200,$0004,$0600,$1586,$9401,$1382,$FF24
	dw $8283,$FFFF,$13AE,$0101,$0007,$0500,$0002,$0700
	dw $1586,$9401,$1382,$FF2A,$8283,$FFFF,$679E,$8200
	dw $FE04,$0200,$FE04,$0AFB,$FE04,$0AFD,$FE04,$09FF
	dw $FE04,$0901,$FE04,$0803,$FE04,$0805,$FE04,$0200
	dw $1586,$9401,$8283,$FFFF,$BFA0,$8200,$0204,$0200
	dw $0204,$08FB,$0204,$08FD,$0204,$09FF,$0204,$0901
	dw $0204,$0A03,$0204,$0A05,$0204,$0200,$1586,$9401
	dw $8283,$FFFF,$0008,$0200,$0008,$0100,$0008,$0000
	dw $8980,$FF01,$1481,$FF00,$0008,$0100,$0008,$0200
	dw $8283,$FFFF,$13AE,$0307,$0403,$0200,$0403,$0300
	dw $1586,$9401,$D7A0,$4500,$1382,$FF4E,$8B83,$FFFF
	dw $13AE,$0101,$0007,$0200,$0003,$0400,$1586,$9401
	dw $1382,$FF55,$8B83,$FFFF,$0010,$0200,$13AE,$603F
	dw $0000,$0500,$1586,$9401,$1382,$FF5C,$8B83,$FFFF
	dw $13AE,$0407,$0005,$0200,$0004,$0600,$1586,$9401
	dw $1382,$FF61,$8B83,$FFFF,$13AE,$0101,$0007,$0500
	dw $0002,$0700,$1586,$9401,$1382,$FF67,$8B83,$FFFF
	dw $BFA0,$8B00,$0204,$0200,$0204,$0AFB,$0204,$0AFD
	dw $0204,$09FF,$0204,$0901,$0204,$0803,$0204,$0805
	dw $0204,$0200,$1586,$9401,$8B83,$FFFF,$679E,$8B00
	dw $FE04,$0200,$FE04,$08FB,$FE04,$08FD,$FE04,$09FF
	dw $FE04,$0901,$FE04,$0A03,$FE04,$0A05,$FE04,$0200
	dw $1586,$9401,$8B83,$FFFF,$13AE,$00FF,$1384,$0820
	dw $1384,$1040,$1384,$1760,$1384,$1D80,$1384,$23A0
	dw $1384,$29C0,$1384,$2FE0,$3A83,$FFFF,$13AE,$00FF
	dw $1384,$4520,$1384,$4D40,$1384,$5460,$1384,$5A80
	dw $1384,$60A0,$1384,$66C0,$1384,$6CE0,$7783,$FFFF
	dw $1486,$9B01,$0008,$0200,$0008,$0100,$0008,$0000
	dw $8980,$FF41,$0008,$0100,$0008,$0200,$0801,$0200
	dw $DFA2,$9F00,$0801,$0300,$DFA4,$9B00,$0008,$0200
	dw $0008,$0100,$0008,$0000,$1581,$FF00,$1681,$FF00
	dw $0008,$0000,$A483,$FFFF

DATA_0F9A20:
	dw $9680,$FF01,$1881,$FF00,$1781,$FF04,$000F,$0000
	dw $000F,$0100,$000F,$0200,$000F,$0100,$1782,$FF03
	dw $000F,$0300,$0011,$0400,$1881,$FF01,$000F,$0500
	dw $0B83,$FFFF

	%FREE_BYTES(NULLROM, 9644, $00)

;--------------------------------------------------------------------

CODE_0FC000:
	LDA.l !RAM_MPAINT_Global_DemoActiveFlag
	ASL
	TAX
	JMP.w (DATA_0FC009,x)

DATA_0FC009:
	dw CODE_0FC00D
	dw CODE_0FC03D

;--------------------------------------------------------------------

CODE_0FC00D:
	RTL

;--------------------------------------------------------------------

CODE_0FC00E:
	LDA.w #$0000
	STA.l $000002
	STA.l $0004E8
	STA.l $0004EA
	LDA.l $000008
	ASL
	TAX
	LDA.l DATA_0FC033,x
	STA.l $0004E6
	LDA.w #$0001
	STA.l !RAM_MPAINT_Global_DemoActiveFlag
	RTL

DATA_0FC033:
	dw DATA_108000-DATA_108000
	dw DATA_109937-DATA_108000
	dw DATA_10B630-DATA_108000
	dw DATA_10D6CC-DATA_108000
	dw DATA_10DB4C-DATA_108000

;--------------------------------------------------------------------

CODE_0FC03D:
	PHP
	PHD
	LDA.l $0004C6
	ORA.l $0004C8
	ORA.l $0004CA
	BEQ.b CODE_0FC050
	JMP.w CODE_0FC0EE

CODE_0FC050:
	LDA.w #DATA_108000>>16
	CLC
	ADC.l $0004E8
	PHA
	PEA.w DATA_108000
	LDA.w #DATA_118000>>16
	CLC
	ADC.l $0004E8
	PHA
	PEA.w DATA_118000
	LDA.w #DATA_128000>>16
	CLC
	ADC.l $0004E8
	PHA
	PEA.w DATA_128000
	TSC
	TCD
	LDA.l $0004EA
	BNE.b CODE_0FC0BA
	LDA.l $0004E6
	TAY
	SEP.b #$20
	LDA.b [$01],y
	BMI.b CODE_0FC099
	STA.l $0004CA
	LDA.b [$05],y
	STA.l $0004C8
	LDA.b [$09],y
	STA.l $0004C6
	BRA.b CODE_0FC0B3

CODE_0FC099:
	LDA.b [$05],y
	STA.l $0004EB
	LDA.b [$09],y
	STA.l $0004EA
	LDA.b #$00
	STA.l $0004CA
	STA.l $0004C8
	STA.l $0004C6
CODE_0FC0B3:
	REP.b #$20
	JSR.w CODE_0FC118
	BRA.b CODE_0FC0D5

CODE_0FC0BA:
	SEP.b #$20
	LDA.b #$00
	STA.l $0004CA
	STA.l $0004C8
	STA.l $0004C6
	REP.b #$20
	LDA.l $0004EA
	DEC
	STA.l $0004EA
CODE_0FC0D5:
	LDA.l $000008
	ASL
	TAX
	LDA.l $0004E6
	CMP.l DATA_0FC10E,x
	BEQ.b CODE_0FC0EE
	TSC
	CLC
	ADC.w #$000C
	TCS
	PLD
	PLP
	RTL

CODE_0FC0EE:
	LDA.l $000008
	INC
	CMP.w #$0005
	BNE.b CODE_0FC0FB
	LDA.w #$0000
CODE_0FC0FB:
	STA.l $000008
	LDA.w #$0000
	STA.l !RAM_MPAINT_Global_DemoActiveFlag
	JSL.l CODE_01E7C9
	JML.l CODE_0082B8

DATA_0FC10E:
	dw $1938,$3631,$56CD,$5B4D,$7E4D

CODE_0FC118:
	LDA.l $0004E6
	INC
	AND.w #$7FFF
	BNE.b CODE_0FC12F
	PHA
	LDA.l $0004E8
	EOR.w #$0003
	STA.l $0004E8
	PLA
CODE_0FC12F:
	STA.l $0004E6
	RTS

	%FREE_BYTES(NULLROM, 16076, $00)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank10Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_108000:
	incbin "UnsortedData/Demo1Data_1.bin"

DATA_109937:
	incbin "UnsortedData/Demo2Data_1.bin"

DATA_10B630:
	incbin "UnsortedData/Demo3Data_1.bin"

DATA_10D6CC:
	incbin "UnsortedData/Demo4Data_1.bin"

DATA_10DB4C:
	incbin "UnsortedData/Demo5Data_1.bin"

	%FREE_BYTES(NULLROM, 175, $00)

DATA_10DC4C:
	incbin "UnsortedData/Demo6Data_1.bin"

	%FREE_BYTES(NULLROM, 435, $00)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank11Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_118000:
	incbin "UnsortedData/Demo1Data_2.bin"

DATA_119937:
	incbin "UnsortedData/Demo2Data_2.bin"

DATA_11B630:
	incbin "UnsortedData/Demo3Data_2.bin"

DATA_11D6CC:
	incbin "UnsortedData/Demo4Data_2.bin"

DATA_11DB4C:
	incbin "UnsortedData/Demo5Data_2.bin"

	%FREE_BYTES(NULLROM, 175, $00)

DATA_11DC4C:
	incbin "UnsortedData/Demo6Data_2.bin"

	%FREE_BYTES(NULLROM, 435, $00)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank12Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_128000:
	incbin "UnsortedData/Demo1Data_3.bin"

DATA_129937:
	incbin "UnsortedData/Demo2Data_3.bin"

DATA_12B630:
	incbin "UnsortedData/Demo3Data_3.bin"

DATA_12D6CC:
	incbin "UnsortedData/Demo4Data_3.bin"

DATA_12DB4C:
	incbin "UnsortedData/Demo5Data_3.bin"

	%FREE_BYTES(NULLROM, 175, $00)

DATA_12DC4C:
	incbin "UnsortedData/Demo6Data_3.bin"

	%FREE_BYTES(NULLROM, 435, $00)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank13Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

%FREE_BYTES(NULLROM, 8192, $00)

DATA_13A000:
	incbin "Graphics/GFX_13A000.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank14Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

%FREE_BYTES(NULLROM, 8192, $00)

DATA_14A000:
	incbin "Graphics/GFX_14A000.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank15Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

%FREE_BYTES(NULLROM, 8192, $00)

DATA_15A000:
	incbin "Graphics/GFX_15A000.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank16Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_168000:
	incbin "SPC700/ChantingSampleBank.bin":-(($010000-DATA_168000)&$00FFFF)
.End:

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank17Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_178000:
	incbin "SPC700/ChantingSampleBank.bin":(DATA_168000_End-DATA_168000)-
.End:

UNK_178D52:
	%InsertGarbageData(NULLROM, incbin, UNK_178D52.bin)

DATA_179000:
	incbin "SPC700/AudienceSampleBank.bin"

UNK_17E7BA:
	%InsertGarbageData(NULLROM, incbin, UNK_17E7BA.bin)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank18Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_188000:								;\ Note: These files must be inserted one after the other.
	incbin "SPC700/Engine.bin"					;/ The only reason they're separate is because some genious thought it'd be a good idea to have duplicate SPC data blocks with the same base address.

DATA_18B1BE:
	incbin "SPC700/TitleScreenSampleBank.bin":0-(($010000-DATA_18B1BE)&$00FFFF)
.End:

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank19Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_198000:
	incbin "SPC700/TitleScreenSampleBank.bin":(DATA_18B1BE_End-DATA_18B1BE)-

UNK_19B22A:
	%InsertGarbageData(NULLROM, incbin, UNK_19B22A.bin)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank1AMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_1A8000:
	incbin "SPC700/MainSampleBank.bin":0-(($010000-DATA_1A8000)&$00FFFF)
.End:

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank1BMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_1B8000:
	incbin "SPC700/MainSampleBank.bin":(DATA_1A8000_End-DATA_1A8000)-

UNK_1BA8E8:
	%InsertGarbageData(NULLROM, incbin, UNK_1BA8E8.bin)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank1CMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_1C8000:
	incbin "SPC700/MusicToolSampleBank.bin":0-(($010000-DATA_1C8000)&$00FFFF)
.End:

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank1DMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_1D8000:
	incbin "SPC700/MusicToolSampleBank.bin":(DATA_1C8000_End-DATA_1C8000)-

UNK_1D9076:
	%InsertGarbageData(NULLROM, incbin, UNK_1D9076.bin)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank1EMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_1E8000:
	incbin "SPC700/FlySwattingSampleBank.bin":0-(($010000-DATA_1E8000)&$00FFFF)
.End:

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro MPAINTBank1FMacros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_1F8000:
	incbin "SPC700/FlySwattingSampleBank.bin":(DATA_1E8000_End-DATA_1E8000)-

UNK_1FAAC4:							; Note: Seems to be sample data, since some of the samples from the fly swatting sample bank matched with data in this file.
	%InsertGarbageData(NULLROM, incbin, UNK_1FAAC4.bin)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################
