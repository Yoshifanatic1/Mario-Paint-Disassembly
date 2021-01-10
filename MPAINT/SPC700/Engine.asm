
%SPCDataBlockStart(6E00)
DATA_6E00:
	db $00,$FF,$E0,$B8,$01,$00,$01,$FF,$E0,$B8,$06,$F0,$02,$FF,$E0,$B8
	db $07,$A0,$03,$FF,$F4,$B8,$01,$60,$04,$FF,$E7,$B8,$04,$F0,$05,$FF
	db $F4,$B8,$07,$A0,$06,$8F,$F0,$B8,$02,$00,$07,$FF,$E0,$B8,$01,$00
	db $08,$FF,$E0,$B8,$01,$00,$09,$FF,$E0,$B8,$01,$00,$0A,$FF,$E0,$B8
	db $01,$00,$0B,$FF,$E0,$B8,$01,$00,$0C,$FF,$E0,$B8,$01,$00,$0D,$FF
	db $E0,$B8,$01,$00,$0E,$FF,$E0,$B8,$01,$00,$0F,$FF,$E0,$B8,$01,$00
	db $10,$FF,$E0,$B8,$02,$C0,$11,$FF,$E0,$B8,$03,$30,$12,$FF,$E0,$B8
	db $00,$D0,$13,$FF,$E0,$B8,$07,$A0,$14,$FF,$F9,$B8,$0D,$F0,$15,$FF
	db $E0,$B8,$07,$A0,$16,$FF,$E0,$B8,$07,$A0,$17,$FF,$EE,$B8,$08,$10
	db $18,$FF,$E0,$B8,$05,$A0,$19,$FF,$E0,$B8,$07,$A0,$1A,$FF,$EE,$B8
	db $01,$60,$1B,$FF,$EE,$B8,$01,$80,$1C,$8F,$F8,$B8,$04,$70,$1D,$8F
	db $E0,$B8,$04,$70,$1E,$FF,$E0,$B8,$07,$A0,$1F,$FF,$E0,$B8,$01,$00
%SPCDataBlockEnd(6E00)

%SPCDataBlockStart(6F00)
DATA_6F00:
	db $32,$65,$7F,$98,$B2,$CB,$E5,$FC,$19,$32,$4C,$65,$72,$7F,$8C,$98
	db $A5,$B2,$BF,$CB,$D8,$E5,$F2,$FC
%SPCDataBlockEnd(6F00)

%SPCDataBlockStart(0500)
SPC700_Engine:
	CLRP
	MOV X, #$CF
	MOV SP, X
	MOV A, #$00
	MOV X, A
CODE_0507:
	MOV (X+), A
	CMP X, #$E0
	BNE CODE_0507
	CALL CODE_1430
	MOV A, #$55
	MOV $18, A
	MOV $19, A
	INC A
	CALL CODE_0AEA
	SET5 $48
	MOV A, #$70
	MOV Y, #$0C
	CALL CODE_074F
	MOV Y, #$1C
	CALL CODE_074F
	MOV A, #$6C
	MOV Y, #$5D
	CALL CODE_074F
	MOV A, #$F0
	MOV $00F1, A
	MOV A, #$10
	MOV $00FA, A
	MOV $53, A
	MOV A, #$01
	MOV $00F1, A
	BNE CODE_0544
CODE_0541:
	JMP CODE_05EC

CODE_0544:
	MOV A, $1B
	BNE CODE_0541
	MOV Y, #$0A
CODE_054A:
	CMP Y, #$05
	BEQ CODE_0555
	BCS CODE_0558
	CMP $4C, $4D
	BNE CODE_0566
CODE_0555:
	BBS7 $4C, CODE_0566
CODE_0558:
	MOV A, DATA_0E65+y
	MOV $00F2, A
	MOV A, DATA_0E6F+y
	MOV X, A
	MOV A, (X)
	MOV $00F3, A
CODE_0566:
	DBNZ Y, CODE_054A
	MOV $45, Y
	MOV $46, Y
	MOV A, $18
	EOR A, $19
	LSR A
	LSR A
	NOTC
	ROR $18
	ROR $19
CODE_0577:
	MOV Y, $00FD
	BEQ CODE_0577
	PUSH Y
	MOV A, #$20
	MUL YA
	CLRC
	ADC A, $43
	MOV $43, A
	BCC CODE_05E1
	JMP CODE_0594

CODE_058A:
	MOV A, $04B1
	CMP A, #$AA
	BNE CODE_0594
	CALL CODE_0612
CODE_0594:
	CALL CODE_1395
	MOV A, $04
	CMP A, #$01
	BNE CODE_05B9
	CALL CODE_248F
	MOV X, #$01
	CALL CODE_063B
	MOV $04B1, A
	CALL CODE_24A0
	MOV X, #$02
	CALL CODE_063B
	MOV $04B2, A
	CALL CODE_244B
	JMP CODE_05D2

CODE_05B9:
	CALL CODE_10CF
	MOV X, #$01
	CALL CODE_063B
	MOV $04B1, A
	CALL CODE_10E3
	MOV X, #$02
	CALL CODE_063B
	MOV $04B2, A
	CALL CODE_10F7
CODE_05D2:
	MOV X, #$03
	CALL CODE_063B
	MOV $04B3, A
	CMP $4C, $4D
	BEQ CODE_05E1
	INC $4C
CODE_05E1:
	MOV A, $53
	POP Y
	MUL YA
	CLRC
	ADC A, $51
	MOV $51, A
	BCC CODE_05F6
CODE_05EC:
	CALL CODE_07CD
	MOV X, #$00
	CALL CODE_063B
	BRA CODE_060F

CODE_05F6:
	MOV A, $04
	BEQ CODE_060C
	MOV X, #$00
	MOV $47, #$01
CODE_05FF:
	MOV A, $31+x
	BEQ CODE_0606
	CALL CODE_0D8E
CODE_0606:
	INC X
	INC X
	ASL $47
	BNE CODE_05FF
CODE_060C:
	JMP CODE_0544

CODE_060F:
	JMP CODE_0544

;--------------------------------------------------------------------

CODE_0612:
	MOV A, #$00
	MOV Y, #$2C
	CALL CODE_074F
	MOV Y, #$3C
	CALL CODE_074F
	MOV A, #$FF
	MOV Y, #$5C
	CALL CODE_074F
	MOV A, #$00
	MOV Y, #$4D
	CALL CODE_074F
	MOV A, #$20
	MOV Y, #$6C
	CALL CODE_074F
	MOV A, #$80
	MOV $00F1, A
	JMP !REGISTER_SPC700_IPLROMLoc

;--------------------------------------------------------------------

CODE_063B:
	MOV A, $04A4+x
	MOV $20, A
CODE_0640:
	MOV A, $00F4+x
	CMP A, $00F4+x
	BNE CODE_0640
	MOV $00+x, A
	MOV $00F4+x, A
	MOV $04A4+x, A
	CMP A, $20
	BNE CODE_0656
	MOV A, #$00
CODE_0656:
	MOV $04A0+x, A
CODE_0659:
	RET

;--------------------------------------------------------------------

CODE_065A:
	CMP Y, #$CA
	BCC CODE_0663
	CALL CODE_093B
	MOV Y, #$A4
CODE_0663:
	CMP Y, #$C8
	BCS CODE_0659
	MOV A, $1A
	AND A, $47
	BNE CODE_0659
	MOV A, Y
	AND A, #$7F
	CLRC
	ADC A, $50
	CLRC
	ADC A, $02F0+x
	MOV $0361+x, A
	MOV A, $0381+x
	MOV $0360+x, A
	MOV A, $02B1+x
	LSR A
	MOV A, #$00
	ROR A
	MOV $02A0+x, A
	MOV A, #$00
	MOV $B0+x, A
	MOV $0100+x, A
	MOV $02D0+x, A
	MOV $C0+x, A
	OR $5E, $47
	OR $45, $47
	MOV A, $0280+x
	MOV $A0+x, A
	BEQ CODE_06C1
	MOV A, $0281+x
	MOV $A1+x, A
	MOV A, $0290+x
	BNE CODE_06B7
	MOV A, $0361+x
	SETC
	SBC A, $0291+x
	MOV $0361+x, A
CODE_06B7:
	MOV A, $0291+x
	CLRC
	ADC A, $0361+x
	CALL CODE_0B62
CODE_06C1:
	CALL CODE_0B7A
CODE_06C4:
	MOV Y, #$00
	MOV A, $11
	SETC
	SBC A, #$34
	BCS CODE_06D6
	MOV A, $11
	SETC
	SBC A, #$13
	BCS CODE_06DA
	DEC Y
	ASL A
CODE_06D6:
	ADDW YA, $10
	MOVW $10, YA
CODE_06DA:
	PUSH X
	MOV A, $11
	ASL A
	MOV Y, #$00
	MOV X, #$18
	DIV YA, X
	MOV X, A
	MOV A, DATA_0E7A+$01+y
	MOV $15, A
	MOV A, DATA_0E7A+y
	MOV $14, A
	MOV A, DATA_0E7A+$03+y
	PUSH A
	MOV A, DATA_0E7A+$02+y
	POP Y
	SUBW YA, $14
	MOV Y, $10
	MUL YA
	MOV A, Y
	MOV Y, #$00
	ADDW YA, $14
	MOV $15, Y
	ASL A
	ROL $15
	MOV $14, A
	BRA CODE_070D

CODE_0709:
	LSR $15
	ROR A
	INC X
CODE_070D:
	CMP X, #$06
	BNE CODE_0709
	MOV $14, A
	POP X
	MOV A, $0220+x
	MOV Y, $15
	MUL YA
	MOVW $16, YA
	MOV A, $0220+x
	MOV Y, $14
	MUL YA
	PUSH Y
	MOV A, $0221+x
	MOV Y, $14
	MUL YA
	ADDW YA, $16
	MOVW $16, YA
	MOV A, $0221+x
	MOV Y, $15
	MUL YA
	MOV Y, A
	POP A
	ADDW YA, $16
	MOVW $16, YA
	MOV A, X
	XCN A
	LSR A
	OR A, #$02
	MOV Y, A
	MOV A, $16
	CALL CODE_0747
	INC Y
	MOV A, $17
CODE_0747:
	PUSH A
	MOV A, $47
	AND A, $1A
	POP A
	BNE CODE_0755
CODE_074F:
	MOV $00F2, Y
	MOV $00F3, A
CODE_0755:
	RET

;--------------------------------------------------------------------

CODE_0756:
	MOV Y, #$00
	MOV A, ($40)+y
	INCW $40
	PUSH A
	MOV A, ($40)+y
	INCW $40
	MOV Y, A
	POP A
	RET

;--------------------------------------------------------------------

CODE_0764:
	CALL CODE_11FE
	CALL CODE_0E9F
	MOV $08, A
CODE_076C:
	MOV $04, A
	ASL A
	MOV X, A
	MOV A, $26C2+x
	MOV Y, A
	MOV A, $26C1+x
	MOVW $40, YA
	MOV $0C, #$02
CODE_077C:
	MOV A, $1A
	EOR A, #$FF
	TSET $0046, A
	RET

;--------------------------------------------------------------------

CODE_0784:
	MOV X, #$0E
	MOV $47, #$80
CODE_0789:
	MOV A, #$FF
	MOV $0301+x, A
	MOV A, #$0A
	CALL CODE_0994
	MOV $0211+x, A
	MOV $0381+x, A
	MOV $02F0+x, A
	MOV $0280+x, A
	MOV $0400+x, A
	MOV $B1+x, A
	MOV $C1+x, A
	DEC X
	DEC X
	LSR $47
	BNE CODE_0789
	MOV $5A, A
	MOV $68, A
	MOV $54, A
	MOV $50, A
	MOV $42, A
	MOV $5F, A
	MOV $59, #$C0
	MOV $53, #$20
CODE_07BE:
	RET

;--------------------------------------------------------------------

CODE_07BF:
	JMP CODE_0764

CODE_07C2:
	JMP CODE_076C

CODE_07C5:
	JMP CODE_076C

CODE_07C8:
	MOV A, $08
	BMI CODE_07DB
	RET

CODE_07CD:
	MOV Y, $08
	MOV A, $00
	MOV $08, A
	MOV $00F4, A
	CMP A, $04D4
	BCS CODE_07C8
CODE_07DB:
	CMP A, #$F0
	BEQ CODE_077C
	CMP A, #$F1
	BEQ CODE_07EB
	CMP A, #$FF
	BEQ CODE_07BF
	CMP Y, $00
	BNE CODE_07C2
CODE_07EB:
	MOV A, $04
	BEQ CODE_07BE
	MOV A, $0C
	BEQ CODE_084D
	DBNZ $0C, CODE_0784
CODE_07F6:
	CALL CODE_0756
	BNE CODE_081D
	MOV Y, A
	BEQ CODE_07C5
	CMP A, #$80
	BEQ CODE_0808
	CMP A, #$81
	BNE CODE_080C
	MOV A, #$00
CODE_0808:
	MOV $1B, A
	BRA CODE_07F6

CODE_080C:
	DEC $42
	BPL CODE_0812
	MOV $42, A
CODE_0812:
	CALL CODE_0756
	MOV X, $42
	BEQ CODE_07F6
	MOVW $40, YA
	BRA CODE_07F6

CODE_081D:
	MOVW $16, YA
	MOV Y, #$0F
CODE_0821:
	MOV A, ($16)+y
	MOV $0030+y, A
	DEC Y
	BPL CODE_0821
	MOV X, #$00
	MOV $47, #$01
CODE_082E:
	MOV A, $31+x
	BEQ CODE_083C
	MOV A, $0211+x
	BNE CODE_083C
	MOV A, #$00
	CALL CODE_093B
CODE_083C:
	MOV A, #$00
	MOV $80+x, A
	MOV $90+x, A
	MOV $91+x, A
	INC A
	MOV $70+x, A
	INC X
	INC X
	ASL $47
	BNE CODE_082E
CODE_084D:
	MOV X, #$00
	MOV $5E, X
	MOV $47, #$01
CODE_0854:
	MOV $44, X
	MOV A, $31+x
	BEQ CODE_08CC
	DEC $70+x
	BNE CODE_08C2
CODE_085E:
	CALL CODE_0931
	BNE CODE_087A
	MOV A, $80+x
	BEQ CODE_07F6
	CALL CODE_0A82
	DEC $80+x
	BNE CODE_085E
	MOV A, $0230+x
	MOV $30+x, A
	MOV A, $0231+x
	MOV $31+x, A
	BRA CODE_085E

CODE_087A:
	BMI CODE_089C
	MOV $0200+x, A
	CALL CODE_0931
	BMI CODE_089C
	PUSH A
	XCN A
	AND A, #$07
	MOV Y, A
	MOV A, $6F00+y
	MOV $0201+x, A
	POP A
	AND A, #$0F
	MOV Y, A
	MOV A, $6F08+y
	MOV $0210+x, A
	CALL CODE_0931
CODE_089C:
	CMP A, #$E0
	BCC CODE_08A5
	CALL CODE_091F
	BRA CODE_085E

CODE_08A5:
	MOV A, $0400+x
	OR A, $1B
	BNE CODE_08B0
	MOV A, Y
	CALL CODE_065A
CODE_08B0:
	MOV A, $0200+x
	MOV $70+x, A
	MOV Y, A
	MOV A, $0201+x
	MUL YA
	MOV A, Y
	BNE CODE_08BE
	INC A
CODE_08BE:
	MOV $71+x, A
	BRA CODE_08C9

CODE_08C2:
	MOV A, $1B
	BNE CODE_08CC
	CALL CODE_0CB5
CODE_08C9:
	CALL CODE_0B42
CODE_08CC:
	INC X
	INC X
	ASL $47
	BNE CODE_0854
	MOV A, $54
	BEQ CODE_08E1
	MOVW YA, $56
	ADDW YA, $52
	DBNZ $54, CODE_08DF
	MOVW YA, $54
CODE_08DF:
	MOVW $52, YA
CODE_08E1:
	MOV A, $68
	BEQ CODE_08FA
	MOVW YA, $64
	ADDW YA, $60
	MOVW $60, YA
	MOVW YA, $66
	ADDW YA, $62
	DBNZ $68, CODE_08F8
	MOVW YA, $68
	MOVW $60, YA
	MOV Y, $6A
CODE_08F8:
	MOVW $62, YA
CODE_08FA:
	MOV A, $5A
	BEQ CODE_090C
	MOVW YA, $5C
	ADDW YA, $58
	DBNZ $5A, CODE_0907
	MOVW YA, $5A
CODE_0907:
	MOVW $58, YA
	MOV $5E, #$FF
CODE_090C:
	MOV X, #$00
	MOV $47, #$01
CODE_0911:
	MOV A, $31+x
	BEQ CODE_0918
	CALL CODE_0BFE
CODE_0918:
	INC X
	INC X
	ASL $47
	BNE CODE_0911
	RET

;--------------------------------------------------------------------

CODE_091F:
	ASL A
	MOV Y, A
	MOV A, DATA_0BA1-$BF+y
	PUSH A
	MOV A, DATA_0BA1-$C0+y
	PUSH A
	MOV A, Y
	LSR A
	MOV Y, A
	MOV A, DATA_0BDF-$60+y
	BEQ CODE_0939
CODE_0931:
	MOV A, ($30+x)
CODE_0933:
	INC $30+x
	BNE CODE_0939
	INC $31+x
CODE_0939:
	MOV Y, A
	RET

;--------------------------------------------------------------------

CODE_093B:
	MOV $0211+x, A
CODE_093E:
	MOV Y, A
	BPL CODE_0947
	SETC
	SBC A, #$CA
	CLRC
	ADC A, $5F
CODE_0947:
	MOV Y, #$06
	MUL YA
	MOVW $14, YA
	CLRC
	ADC $14, #$00
	ADC $15, #$6E
	MOV A, $1A
	AND A, $47
	BNE CODE_0993
	PUSH X
	MOV A, X
	XCN A
	LSR A
	OR A, #$04
	MOV X, A
	MOV Y, #$00
	MOV A, ($14)+y
	BPL CODE_0974
	AND A, #$1F
	AND $48, #$20
	TSET $0048, A
	OR $49, $47
	MOV A, Y
	BRA CODE_097B

CODE_0974:
	MOV A, $47
	TCLR $0049, A
CODE_0979:
	MOV A, ($14)+y
CODE_097B:
	MOV $00F2, X
	MOV $00F3, A
	INC X
	INC Y
	CMP Y, #$04
	BNE CODE_0979
	POP X
	MOV A, ($14)+y
	MOV $0221+x, A
	INC Y
	MOV A, ($14)+y
	MOV $0220+x, A
CODE_0993:
	RET

;--------------------------------------------------------------------

CODE_0994:
	MOV $0351+x, A
	AND A, #$1F
	MOV $0331+x, A
	MOV A, #$00
	MOV $0330+x, A
	RET

;--------------------------------------------------------------------

CODE_09A2:
	MOV $91+x, A
	PUSH A
	CALL CODE_0931
CODE_09A8:
	MOV $0350+x, A
	SETC
	SBC A, $0331+x
	POP X
	CALL CODE_0B85
	MOV $0340+x, A
	MOV A, Y
	MOV $0341+x, A
	RET

;--------------------------------------------------------------------

CODE_09BB:
	MOV $02B0+x, A
	CALL CODE_0931
	MOV $02A1+x, A
	CALL CODE_0931
CODE_09C7:
	MOV $B1+x, A
	MOV $02C1+x, A
	MOV A, #$00
	MOV $02B1+x, A
	RET

;--------------------------------------------------------------------

CODE_09D2:
	MOV $02B1+x, A
	PUSH A
	MOV Y, #$00
	MOV A, $B1+x
	POP X
	DIV YA, X
	MOV X, $44
	MOV $02C0+x, A
	RET

;--------------------------------------------------------------------

CODE_09E2:
	MOV A, #$00
	MOVW $58, YA
	RET

;--------------------------------------------------------------------

CODE_09E7:
	MOV $5A, A
	CALL CODE_0931
	MOV $5B, A
CODE_09EE:
	SETC
	SBC A, $59
	MOV X, $5A
	CALL CODE_0B85
	MOVW $5C, YA
	RET

;--------------------------------------------------------------------

CODE_09F9:
	MOV A, #$00
	MOVW $52, YA
	RET

;--------------------------------------------------------------------

CODE_09FE:
	MOV $54, A
	CALL CODE_0931
	MOV $55, A
CODE_0A05:
	SETC
	SBC A, $53
	MOV X, $54
	CALL CODE_0B85
	MOVW $56, YA
	RET

;--------------------------------------------------------------------

CODE_0A10:
	MOV $50, A
	RET

;--------------------------------------------------------------------

CODE_0A13:
	MOV $02F0+x, A
	RET

;--------------------------------------------------------------------

CODE_0A17:
	MOV $02E0+x, A
	CALL CODE_0931
	MOV $02D1+x, A
	CALL CODE_0931
CODE_0A23:
	MOV $C1+x, A
	RET

;--------------------------------------------------------------------

CODE_0A26:
	MOV A, #$01
	BRA CODE_0A2C

CODE_0A2A:
	MOV A, #$00
CODE_0A2C:
	MOV $0290+x, A
	MOV A, Y
	MOV $0281+x, A
	CALL CODE_0931
	MOV $0280+x, A
	CALL CODE_0931
	MOV $0291+x, A
	RET

;--------------------------------------------------------------------

CODE_0A40:
	MOV $0280+x, A
	RET

;--------------------------------------------------------------------

CODE_0A44:
	MOV $0301+x, A
	MOV A, #$00
	MOV $0300+x, A
	RET

;--------------------------------------------------------------------

CODE_0A4D:
	MOV $90+x, A
	PUSH A
	CALL CODE_0931
CODE_0A53:
	MOV $0320+x, A
	SETC
	SBC A, $0301+x
	POP X
	CALL CODE_0B85
	MOV $0310+x, A
	MOV A, Y
	MOV $0311+x, A
	RET

;--------------------------------------------------------------------

CODE_0A66:
	MOV $0381+x, A
	RET

;--------------------------------------------------------------------

CODE_0A6A:
	MOV $0240+x, A
	CALL CODE_0931
	MOV $0241+x, A
	CALL CODE_0931
	MOV $80+x, A
	MOV A, $30+x
	MOV $0230+x, A
	MOV A, $31+x
	MOV $0231+x, A
CODE_0A82:
	MOV A, $0240+x
	MOV $30+x, A
	MOV A, $0241+x
	MOV $31+x, A
	RET

;--------------------------------------------------------------------

CODE_0A8D:
	MOV $4A, A
	CALL CODE_0931
	MOV A, #$00
	MOVW $60, YA
	CALL CODE_0931
	MOV A, #$00
	MOVW $62, YA
	CLR5 $48
	RET

;--------------------------------------------------------------------

CODE_0AA0:
	MOV $68, A
	CALL CODE_0931
	MOV $69, A
	SETC
	SBC A, $61
	MOV X, $68
	CALL CODE_0B85
	MOVW $64, YA
	CALL CODE_0931
	MOV $6A, A
	SETC
	SBC A, $63
	MOV X, $68
	CALL CODE_0B85
	MOVW $66, YA
	RET

;--------------------------------------------------------------------

CODE_0AC1:
	MOVW $60, YA
	MOVW $62, YA
	SET5 $48
	RET

;--------------------------------------------------------------------

CODE_0AC8:
	CALL CODE_0AEA
	CALL CODE_0931
	MOV $4E, A
	CALL CODE_0931
	MOV Y, #$08
	MUL YA
	MOV X, A
	MOV Y, #$0F
CODE_0AD9:
	MOV A, DATA_0E46+x
	CALL CODE_074F
	INC X
	MOV A, Y
	CLRC
	ADC A, #$10
	MOV Y, A
	BPL CODE_0AD9
	MOV X, $44
	RET

;--------------------------------------------------------------------

CODE_0AEA:
	MOV $4D, A
	MOV Y, #$7D
	MOV $00F2, Y
	MOV A, $00F3
	CMP A, $4D
	BEQ CODE_0B23
	AND A, #$0F
	EOR A, #$FF
	BBC7 $4C, CODE_0B02
CODE_0AFF:
	CLRC
	ADC A, $4C
CODE_0B02:
	MOV $4C, A
	MOV Y, #$04
CODE_0B06:
	MOV A, DATA_0E65+y
	MOV $00F2, A
	MOV A, #$00
	MOV $00F3, A
	DBNZ Y, CODE_0B06
	MOV A, $48
	OR A, #$20
	MOV Y, #$6C
	CALL CODE_074F
	MOV A, $4D
	MOV Y, #$7D
	CALL CODE_074F
CODE_0B23:
	ASL A
	ASL A
	ASL A
	EOR A, #$FF
	SETC
	ADC A, #$6C
	MOV Y, #$6D
	JMP CODE_074F

;--------------------------------------------------------------------

CODE_0B30:
	MOV $5F, A
	RET

;--------------------------------------------------------------------

CODE_0B33:
	CALL CODE_0933
	RET

;--------------------------------------------------------------------

CODE_0B37:
	INC A
	MOV $0400+x, A
	RET

;--------------------------------------------------------------------

CODE_0B3C:
	INC A
CODE_0B3D:
	MOV $1B, A
	JMP CODE_077C

;--------------------------------------------------------------------

CODE_0B42:
	MOV A, $A0+x
	BNE CODE_0B79
	MOV A, ($30+x)
	CMP A, #$F9
	BNE CODE_0B79
	CALL CODE_0933
	CALL CODE_0931
CODE_0B52:
	MOV $A1+x, A
	CALL CODE_0931
	MOV $A0+x, A
	CALL CODE_0931
	CLRC
	ADC A, $50
	ADC A, $02F0+x
CODE_0B62:
	AND A, #$7F
	MOV $0380+x, A
	SETC
	SBC A, $0361+x
	MOV Y, $A0+x
	PUSH Y
	POP X
	CALL CODE_0B85
	MOV $0370+x, A
	MOV A, Y
	MOV $0371+x, A
CODE_0B79:
	RET

;--------------------------------------------------------------------

CODE_0B7A:
	MOV A, $0361+x
	MOV $11, A
	MOV A, $0360+x
	MOV $10, A
	RET

;--------------------------------------------------------------------

CODE_0B85:
	NOTC
	ROR $12
	BPL CODE_0B8D
	EOR A, #$FF
	INC A
CODE_0B8D:
	MOV Y, #$00
	DIV YA, X
	PUSH A
	MOV A, #$00
	DIV YA, X
	POP Y
	MOV X, $44
CODE_0B97:
	BBC7 $12, CODE_0BA0
	MOVW $14, YA
	MOVW YA, $0E
	SUBW YA, $14
CODE_0BA0:
	RET

;--------------------------------------------------------------------

DATA_0BA1:
	dw CODE_093B
	dw CODE_0994
	dw CODE_09A2
	dw CODE_09BB
	dw CODE_09C7
	dw CODE_09E2
	dw CODE_09E7
	dw CODE_09F9
	dw CODE_09FE
	dw CODE_0A10
	dw CODE_0A13
	dw CODE_0A17
	dw CODE_0A23
	dw CODE_0A44
	dw CODE_0A4D
	dw CODE_0A6A
	dw CODE_09D2
	dw CODE_0A26
	dw CODE_0A2A
	dw CODE_0A40
	dw CODE_0A66
	dw CODE_0A8D
	dw CODE_0AC1
	dw CODE_0AC8
	dw CODE_0AA0
	dw CODE_0B52
	dw CODE_0B30
	dw CODE_0B33
	dw CODE_0B37
	dw CODE_0B3C
	dw CODE_0B3D

DATA_0BDF:
	db $01,$01,$02,$03,$00,$01,$02,$01
	db $02,$01,$01,$03,$00,$01,$02,$03
	db $01,$03,$03,$00,$01,$03,$00,$03
	db $03,$03,$01,$02,$00,$00,$00

;--------------------------------------------------------------------

CODE_0BFE:
	MOV A, $90+x
	BEQ CODE_0C0B
	MOV A, #$00
	MOV Y, #$03
	DEC $90+x
	CALL CODE_0C91
CODE_0C0B:
	MOV Y, $C1+x
	BEQ CODE_0C32
	MOV A, $02E0+x
	CBNE $0C0+x, CODE_0C30
	OR $5E, $47
	MOV A, $02D0+x
	BPL CODE_0C24
	INC Y
	BNE CODE_0C24
	MOV A, #$80
	BRA CODE_0C28

CODE_0C24:
	CLRC
	ADC A, $02D1+x
CODE_0C28:
	MOV $02D0+x, A
	CALL CODE_0E14
	BRA CODE_0C37

CODE_0C30:
	INC $C0+x
CODE_0C32:
	MOV A, #$FF
	CALL CODE_0E1F
CODE_0C37:
	MOV A, $91+x
	BEQ CODE_0C44
	MOV A, #$30
	MOV Y, #$03
	DEC $91+x
	CALL CODE_0C91
CODE_0C44:
	MOV A, $47
	AND A, $5E
	BEQ CODE_0C90
	MOV A, $0331+x
	MOV Y, A
	MOV A, $0330+x
	MOVW $10, YA
CODE_0C53:
	MOV A, X
	XCN A
	LSR A
	MOV $12, A
CODE_0C58:
	MOV Y, $11
	MOV A, DATA_0E31+$01+y
	SETC
	SBC A, DATA_0E31+y
	MOV Y, $10
	MUL YA
	MOV A, Y
	MOV Y, $11
	CLRC
	ADC A, DATA_0E31+y
	MOV Y, A
	MOV A, $0321+x
	MUL YA
	MOV A, $0351+x
	ASL A
	BBC0 $12, CODE_0C78
	ASL A
CODE_0C78:
	MOV A, Y
	BCC CODE_0C7E
	EOR A, #$FF
	INC A
CODE_0C7E:
	MOV Y, $12
	CALL CODE_0747
	MOV Y, #$14
	MOV A, #$00
	SUBW YA, $10
	MOVW $10, YA
	INC $12
	BBC1 $12, CODE_0C58
CODE_0C90:
	RET

;--------------------------------------------------------------------

CODE_0C91:
	OR $5E, $47
CODE_0C94:
	MOVW $14, YA
	MOVW $16, YA
	PUSH X
	POP Y
	CLRC
	BNE CODE_0CA7
	ADC $16, #$1F
	MOV A, #$00
	MOV ($14)+y, A
	INC Y
	BRA CODE_0CB0

CODE_0CA7:
	ADC $16, #$10
	CALL CODE_0CAE
	INC Y
CODE_0CAE:
	MOV A, ($14)+y
CODE_0CB0:
	ADC A, ($16)+y
	MOV ($14)+y, A
	RET

;--------------------------------------------------------------------

CODE_0CB5:
	MOV A, $71+x
	BEQ CODE_0D1E
	DEC $71+x
	BEQ CODE_0CC2
	MOV A, #$02
	CBNE $070+x, CODE_0D1E
CODE_0CC2:
	MOV A, $80+x
	MOV $17, A
	MOV A, $30+x
	MOV Y, $31+x
CODE_0CCA:
	MOVW $14, YA
	MOV Y, #$00
CODE_0CCE:
	MOV A, ($14)+y
	BEQ CODE_0CF0
	BMI CODE_0CDB
CODE_0CD4:
	INC Y
	BMI CODE_0D17
	MOV A, ($14)+y
	BPL CODE_0CD4
CODE_0CDB:
	CMP A, #$C8
	BEQ CODE_0D1E
	CMP A, #$EF
	BEQ CODE_0D0C
	CMP A, #$E0
	BCC CODE_0D17
	PUSH Y
	MOV Y, A
	POP A
	ADC A, CODE_0AFF+y
	MOV Y, A
	BRA CODE_0CCE

CODE_0CF0:
	MOV A, $17
	BEQ CODE_0D17
	DEC $17
	BNE CODE_0D02
	MOV A, $0231+x
	PUSH A
	MOV A, $0230+x
	POP Y
	BRA CODE_0CCA

CODE_0D02:
	MOV A, $0241+x
	PUSH A
	MOV A, $0240+x
	POP Y
	BRA CODE_0CCA

CODE_0D0C:
	INC Y
	MOV A, ($14)+y
	PUSH A
	INC Y
	MOV A, ($14)+y
	MOV Y, A
	POP A
	BRA CODE_0CCA

CODE_0D17:
	MOV A, $47
	MOV Y, #$5C
	CALL CODE_0747
CODE_0D1E:
	CLR7 $13
	MOV A, $A0+x
	BEQ CODE_0D37
	MOV A, $A1+x
	BEQ CODE_0D2C
	DEC $A1+x
	BRA CODE_0D37

CODE_0D2C:
	SET7 $13
	MOV A, #$60
	MOV Y, #$03
	DEC $A0+x
	CALL CODE_0C94
CODE_0D37:
	CALL CODE_0B7A
	MOV A, $B1+x
	BEQ CODE_0D8A
	MOV A, $02B0+x
	CBNE $0B0+x, CODE_0D88
	MOV A, $0100+x
	CMP A, $02B1+x
	BNE CODE_0D51
	MOV A, $02C1+x
	BRA CODE_0D5E

CODE_0D51:
	SETP
	INC $00+x
	CLRP
	MOV Y, A
	BEQ CODE_0D5A
	MOV A, $B1+x
CODE_0D5A:
	CLRC
	ADC A, $02C0+x
CODE_0D5E:
	MOV $B1+x, A
	MOV A, $02A0+x
	CLRC
	ADC A, $02A1+x
	MOV $02A0+x, A
CODE_0D6A:
	MOV $12, A
	ASL A
	ASL A
	BCC CODE_0D72
	EOR A, #$FF
CODE_0D72:
	MOV Y, A
	MOV A, $B1+x
	CMP A, #$F1
	BCC CODE_0D7E
	AND A, #$0F
	MUL YA
	BRA CODE_0D82

CODE_0D7E:
	MUL YA
	MOV A, Y
	MOV Y, #$00
CODE_0D82:
	CALL CODE_0DFF
CODE_0D85:
	JMP CODE_06C4

;--------------------------------------------------------------------

CODE_0D88:
	INC $B0+x
CODE_0D8A:
	BBS7 $13, CODE_0D85
	RET

CODE_0D8E:
	CLR7 $13
	MOV A, $C1+x
	BEQ CODE_0D9D
	MOV A, $02E0+x
	CBNE $0C0+x, CODE_0D9D
	CALL CODE_0E07
CODE_0D9D:
	MOV A, $0331+x
	MOV Y, A
	MOV A, $0330+x
	MOVW $10, YA
	MOV A, $91+x
	BEQ CODE_0DB4
	MOV A, $0341+x
	MOV Y, A
	MOV A, $0340+x
	CALL CODE_0DE9
CODE_0DB4:
	BBC7 $13, CODE_0DBA
	CALL CODE_0C53
CODE_0DBA:
	CLR7 $13
	CALL CODE_0B7A
	MOV A, $A0+x
	BEQ CODE_0DD1
	MOV A, $A1+x
	BNE CODE_0DD1
	MOV A, $0371+x
	MOV Y, A
	MOV A, $0370+x
	CALL CODE_0DE9
CODE_0DD1:
	MOV A, $B1+x
	BEQ CODE_0D8A
	MOV A, $02B0+x
	CBNE $0B0+x, CODE_0D8A
	MOV Y, $51
	MOV A, $02A1+x
	MUL YA
	MOV A, Y
	CLRC
	ADC A, $02A0+x
	JMP CODE_0D6A

;--------------------------------------------------------------------

CODE_0DE9:
	SET7 $13
	MOV $12, Y
	CALL CODE_0B97
	PUSH Y
	MOV Y, $51
	MUL YA
	MOV $14, Y
	MOV $15, #$00
	MOV Y, $51
	POP A
	MUL YA
	ADDW YA, $14
CODE_0DFF:
	CALL CODE_0B97
	ADDW YA, $10
	MOVW $10, YA
	RET

;--------------------------------------------------------------------

CODE_0E07:
	SET7 $13
	MOV Y, $51
	MOV A, $02D1+x
	MUL YA
	MOV A, Y
	CLRC
	ADC A, $02D0+x
CODE_0E14:
	ASL A
	BCC CODE_0E19
	EOR A, #$FF
CODE_0E19:
	MOV Y, $C1+x
	MUL YA
	MOV A, Y
	EOR A, #$FF
CODE_0E1F:
	MOV Y, $59
	MUL YA
	MOV A, $0210+x
	MUL YA
	MOV A, $0301+x
	MUL YA
	MOV A, Y
	MUL YA
	MOV A, Y
	MOV $0321+x, A
	RET

;--------------------------------------------------------------------

DATA_0E31:
	db $00,$01,$03,$07,$0D,$15,$1E,$29
	db $34,$42,$51,$5E,$67,$6E,$73,$77
	db $7A,$7C,$7D,$7E,$7F

DATA_0E46:
	db $7F,$00,$00,$00,$00,$00,$00,$00
	db $58,$BF,$DB,$F0,$FE,$07,$0C,$0C
	db $0C,$21,$2B,$2B,$13,$FE,$F3,$F9
	db $34,$33,$00,$D9,$E5,$01,$FC

DATA_0E65:
	db $EB,$2C,$3C,$0D,$4D,$6C,$4C,$5C
	db $3D,$2D

DATA_0E6F:
	db $5C,$61,$63,$4E,$4A,$48,$45,$0E
	db $49,$4B,$46

DATA_0E7A:
	db $5F,$08,$DE,$08,$65,$09,$F4,$09
	db $8C,$0A,$2C,$0B,$D6,$0B,$8B,$0C
	db $4A,$0D,$14,$0E,$EA,$0E,$CD,$0F
	db $BE,$10,$2A,$56,$65,$72,$20,$53
	db $31,$2E,$32,$30,$2A

;--------------------------------------------------------------------

CODE_0E9F:
	MOV A, #$AA
	MOV $00F4, A
	MOV A, #$BB
	MOV $00F5, A
CODE_0EA9:
	MOV A, $00F4
	CMP A, #$CC
	BNE CODE_0EA9
	BRA CODE_0ED2

CODE_0EB2:
	MOV Y, $00F4
	BNE CODE_0EB2
CODE_0EB7:
	CMP Y, $00F4
	BNE CODE_0ECB
	MOV A, $00F5
	MOV $00F4, Y
	MOV ($14)+y, A
	INC Y
	BNE CODE_0EB7
	INC $15
	BRA CODE_0EB7

CODE_0ECB:
	BPL CODE_0EB7
	CMP Y, $00F4
	BPL CODE_0EB7
CODE_0ED2:
	MOV A, $00F6
	MOV Y, $00F7
	MOVW $14, YA
	MOV Y, $00F4
	MOV A, $00F5
	MOV $00F4, Y
	BNE CODE_0EB2
	MOV X, #$31
	MOV $00F1, X
	RET

;--------------------------------------------------------------------

CODE_0EEB:
	MOVW $20, YA
	MOV Y, #$00
CODE_0EEF:
	MOV A, ($20)+y
	MOV $04D8+y, A
	INC Y
	CMP Y, #$07
	BNE CODE_0EEF
	RET

;--------------------------------------------------------------------

CODE_0EFA:
	MOVW $20, YA
	MOV Y, #$00
CODE_0EFE:
	MOV A, ($20)+y
	MOV $04DA+y, A
	INC Y
	CMP Y, #$03
	BNE CODE_0EFE
	RET

;--------------------------------------------------------------------

CODE_0F09:
	CALL CODE_0EFA
	MOV X, $2F
	MOV A, $20
	MOV $0480+x, A
	MOV A, $21
	INC X
	MOV $0480+x, A
	MOV A, #$00
	MOV $04DE, A
	MOV X, $2E
	MOV A, #$00
	MOV $04C8+x, A
	MOV Y, #$03
	MOV A, ($20)+y
	MOV $22, A
	INC Y
	MOV A, ($20)+y
	MOV $04DD, A
	CMP A, #$C9
	BNE CODE_0F38
	MOV $04C8+x, A
CODE_0F38:
	CALL CODE_0F42
	MOV A, #$D8
	MOV Y, #$04
	JMP CODE_12B6

CODE_0F42:
	MOV A, $22
	LSR A
	LSR A
	LSR A
	LSR A
	MOV Y, A
	MOV A, DATA_1005+y
	MOV $04D8, A
	MOV A, $22
	AND A, #$0F
	DEC A
	MOV Y, A
	MOV A, DATA_100D+y
	MOV $04D9, A
	RET

;--------------------------------------------------------------------

CODE_0F5C:
	CALL CODE_118F
	BEQ CODE_0F62
	RET

;--------------------------------------------------------------------

CODE_0F62:
	MOV A, $2A
	INC A
	INC A
	MOV Y, $2B
	CALL CODE_0EFA
CODE_0F6B:
	MOV A, $D0+x
	CLRC
	ADC A, #$05
	MOV Y, A
	INC $D0+x
	MOV X, $2F
	MOV A, $0480+x
	MOV $20, A
	INC X
	MOV A, $0480+x
	MOV $21, A
	MOV A, ($20)+y
	MOV $22, A
	BEQ CODE_0FA8
	MOV X, $2E
	AND A, #$80
	BEQ CODE_0FAB
	MOV A, $22
	CMP A, #$E0
	BEQ CODE_0FBD
	CMP A, #$C9
	BEQ CODE_1001
	CMP A, #$E1
	BEQ CODE_0FC9
	CMP A, #$ED
	BEQ CODE_0FF5
	MOV Y, $22
	MOV A, #$00
	MOV $04C8+x, A
	JMP CODE_1046

CODE_0FA8:
	JMP CODE_1260

CODE_0FAB:
	CALL CODE_0F42
	MOV A, $04D8
	MOV $04BC+x, A
	MOV A, $04D9
	MOV $04C0+x, A
	JMP CODE_0F6B

CODE_0FBD:
	INC Y
	MOV A, ($20)+y
	CALL CODE_108F
	MOV X, $2E
CODE_0FC5:
	INC $D0+x
	BNE CODE_0F6B
CODE_0FC9:
	INC Y
	MOV A, ($20)+y
	MOV $23, A
	MOV A, $04DB
	MOV $22, A
CODE_0FD3:
	MOV A, $04DF
	MOV X, A
	CALL CODE_101C
	MOV Y, $2E
	MOV A, #$08
	MUL YA
	MOV X, A
	MOV A, $23
	MOV $0464+x, A
	MOV $04DC, A
	MOV A, $22
	MOV $0463+x, A
	MOV $04DB, A
	MOV X, $2E
	JMP CODE_0FC5

CODE_0FF5:
	INC Y
	MOV A, ($20)+y
	MOV $22, A
	MOV A, $04DC
	MOV $23, A
	BNE CODE_0FD3
CODE_1001:
	MOV $04C8+x, A
	RET

DATA_1005:
	db $FF,$03,$06,$0C,$18,$02,$0C,$18

DATA_100D:
	db $01,$01,$01,$02,$03,$04,$04,$08
	db $0A,$05,$10,$16,$01,$01,$01

;--------------------------------------------------------------------

CODE_101C:
	MOV A, $22
	MOV $0321+x, A
	MOV A, #$C0
	MOV $0351+x, A
	MOV $11, $23
	MOV $10, #$00
	MOV A, $47
	AND A, $04D6
	MOV $47, A
	JMP CODE_0C53

;--------------------------------------------------------------------

CODE_1036:
	MOV A, #$00
CODE_1038:
	PUSH X
	SET7 $45
	CLR7 $47
	MOV X, #$0E
	MOVW $10, YA
	CALL CODE_06DA
	POP X
	RET

;--------------------------------------------------------------------

CODE_1046:
	PUSH X
	PUSH A
	MOV A, $47
	AND A, $04D6
	MOV $47, A
	MOV A, $04DF
	MOV X, A
	POP A
	MOVW $10, YA
	CALL CODE_06DA
	POP X
	RET

;--------------------------------------------------------------------

CODE_105B:
	MOV X, $2F
	MOV $0458+x, A
	MOV A, Y
	MOV $0459+x, A
	MOV X, $2E
	MOV A, #$01
	MOV $0454+x, A
	RET

;--------------------------------------------------------------------

CODE_106C:
	PUSH Y
	PUSH A
	MOV A, $04D5
	CLRC
	ADC A, #$05
	MOV Y, A
	MOV $20, A
	POP A
	CALL CODE_074F
	POP Y
	MOV A, Y
	MOV Y, $20
	INC Y
	JMP CODE_074F

;--------------------------------------------------------------------

CODE_1083:
	PUSH A
	MOV A, $04D5
	CLRC
	ADC A, #$07
	MOV Y, A
	POP A
	JMP CODE_074F

;--------------------------------------------------------------------

CODE_108F:
	PUSH X
	PUSH A
	MOV A, $49
	AND A, $04D6
	MOV $49, A
	MOV A, $04DF
	MOV X, A
	POP A
	MOV $47, #$00
	CALL CODE_093E
	POP X
	RET

;--------------------------------------------------------------------

CODE_10A5:
	PUSH A
	MOV A, $04D5
	MOV Y, A
	POP A
	CALL CODE_074F
	INC Y
	CALL CODE_074F
	RET

;--------------------------------------------------------------------

DATA_10B3:
	db $0E,$00,$02,$04,$06,$08,$0A,$0C

CODE_10BB:
	MOV $2A, #$60
	MOV $2B, #$04
	MOV X, #$00
	MOV A, #$EF
	MOV Y, #$10
	MOV $20, #$08
	MOV $21, #$40
	BNE CODE_1109					; Note: This will always branch.

CODE_10CF:
	MOV $2A, #$68
	MOV $2B, #$04
	MOV X, #$01
	MOV A, #$DF
	MOV Y, #$20
	MOV $20, #$0A
	MOV $21, #$50
	BNE CODE_1109					; Note: This will always branch.

CODE_10E3:
	MOV $2A, #$70
	MOV $2B, #$04
	MOV X, #$02
	MOV A, #$BF
	MOV Y, #$40
	MOV $20, #$0C
	MOV $21, #$60
	BNE CODE_1109					; Note: This will always branch.

CODE_10F7:
	MOV $2A, #$78
	MOV $2B, #$04
	MOV X, #$03
	MOV A, #$7F
	MOV Y, #$80
	MOV $20, #$0E
	MOV $21, #$70
CODE_1109:
	MOV $04D6, A
	MOV A, Y
	MOV $04D7, A
	MOV A, $20
	MOV $04DF, A
	MOV A, $21
	MOV $04D5, A
	MOV A, X
	MOV $2E, A
	ASL A
	MOV $2F, A
	MOV A, $04B0+x
	MOV $20, A
	MOV $2D, A
	BEQ CODE_1140
	CMP A, $04D0+x
	BCS CODE_1140
	CALL CODE_1170
	CMP A, #$03
	BEQ CODE_115E
	CMP A, #$02
	BEQ CODE_1161
	CMP A, #$01
	BEQ CODE_1164
	JMP (CODE_1702+x)

CODE_1140:
	MOV A, $04B4+x
	MOV $20, A
	BEQ CODE_1182
	CMP A, $04D0+x
	BCS CODE_1182
	CALL CODE_1170
	CMP A, #$03
	BEQ CODE_1167
	CMP A, #$02
	BEQ CODE_116A
	CMP A, #$01
	BEQ CODE_116D
	JMP (CODE_1702+x)

CODE_115E:
	JMP (DATA_149A+x)

CODE_1161:
	JMP (DATA_168E+x)

CODE_1164:
	JMP (DATA_16CA+x)

CODE_1167:
	JMP (DATA_1594+x)

CODE_116A:
	JMP (DATA_16AC+x)

CODE_116D:
	JMP (DATA_16E6+x)

;--------------------------------------------------------------------

CODE_1170:
	AND A, #$07
	MOV Y, A
	MOV A, DATA_10B3+y
	DEC $20
	AND $20, #$F8
	ASL $20
	OR A, $20
	MOV X, A
	MOV A, $2E
CODE_1182:
	RET

;--------------------------------------------------------------------

CODE_1183:
	MOV $049C+x, A
	RET

;--------------------------------------------------------------------

CODE_1187:
	MOV $04BC+x, A
	MOV A, Y
	MOV $04C0+x, A
	RET

;--------------------------------------------------------------------

CODE_118F:
	MOV X, $2E
	MOV A, $04B8+x
	INC A
	MOV $04B8+x, A
	CMP A, #$01
	BEQ CODE_11C7
	CMP A, $04BC+x
	BEQ CODE_11B6
	CMP A, $04C0+x
	BNE CODE_11C3
	MOV A, $049C+x
	AND A, #$01
	BNE CODE_11C3
	MOV A, $46
	OR A, $04D7
	MOV $46, A
	BNE CODE_11C3
CODE_11B6:
	CMP A, #$FF
	BNE CODE_11BE
	MOV A, #$FE
	BNE CODE_11C0
CODE_11BE:
	MOV A, #$00
CODE_11C0:
	MOV $04B8+x, A
CODE_11C3:
	MOV A, $04B8+x
	RET

CODE_11C7:
	MOV A, $049C+x
	AND A, #$02
	BNE CODE_11C3
	MOV A, $0450+x
	BNE CODE_11ED
	INC A
	MOV $0450+x, A
	CALL CODE_1311
	MOV X, $2E
	MOV A, $0454+x
	BEQ CODE_11ED
	MOV X, $2F
	MOV A, $0459+x
	MOV Y, A
	MOV A, $0458+x
	CALL CODE_106C
CODE_11ED:
	MOV X, $2E
	MOV A, $04C8+x
	BNE CODE_11C3
	MOV A, $45
	OR A, $04D7
	MOV $45, A
	JMP CODE_11C3

;--------------------------------------------------------------------

CODE_11FE:
	CALL CODE_1211
	MOV $0491, A
	MOV $04C8, A
	MOV $04C9, A
	MOV $04CA, A
	MOV $04CB, A
	RET

;--------------------------------------------------------------------

CODE_1211:
	MOV A, #$00
	MOV $04B4, A
	MOV $04B5, A
	MOV $04B6, A
	MOV $04B7, A
	MOV $04B0, A
	MOV $04B1, A
	MOV $04B2, A
	MOV $04B3, A
	RET

;--------------------------------------------------------------------

CODE_122C:
	CALL CODE_1236
	CALL CODE_1244
	CALL CODE_1252
	RET

CODE_1236:
	CLR5 $1A
	SET5 $46
	SET5 $47
	SET5 $5E
	MOV A, #$00
	MOV $04B5, A
	RET

CODE_1244:
	CLR6 $1A
	SET6 $46
	SET6 $47
	SET6 $5E
	MOV A, #$00
	MOV $04B6, A
	RET

CODE_1252:
	CLR7 $1A
	SET7 $46
	SET7 $47
	SET7 $5E
	MOV A, #$00
	MOV $04B7, A
	RET

;--------------------------------------------------------------------

CODE_1260:
	MOV A, $04DF
	MOV X, A
	MOV A, $1A
	AND A, $04D6
	MOV $1A, A
	MOV A, $46
	OR A, $04D7
	MOV $46, A
	MOV A, $47
	OR A, $04D7
	MOV $47, A
	MOV A, $5E
	OR A, $04D7
	MOV $5E, A
	MOV A, $04E0+x
	MOV $0321+x, A
	MOV A, $04F0+x
	MOV $0351+x, A
	CALL CODE_0C44
	MOV A, $0211+x
	CALL CODE_093E
	MOV X, $2E
	MOV A, #$00
	MOV $04B4+x, A
	MOV $04C8+x, A
	RET

;--------------------------------------------------------------------

CODE_12A0:
	MOVW $22, YA
	MOV A, #$00
	MOV X, $2E
	MOV $04CC+x, A
	MOV $04C8+x, A
	JMP CODE_12BF

CODE_12AF:
	MOVW $22, YA
	MOV A, X
	MOV $48, A
	BNE CODE_12BA
CODE_12B6:
	MOVW $22, YA
	MOV A, #$00
CODE_12BA:
	MOV X, $2E
	MOV $04CC+x, A
CODE_12BF:
	CALL CODE_1301
	MOV $20, $2A
	MOV $21, $2B
	MOV Y, #$00
CODE_12CA:
	MOV A, ($22)+y
	MOV ($20)+y, A
	INC Y
	CMP Y, #$07
	BNE CODE_12CA
	MOV A, $1A
	OR A, $04D7
	MOV $1A, A
	MOV A, $46
	OR A, $04D7
	MOV $46, A
	MOV A, $04D7
	MOV A, #$00
	MOV $04B8+x, A
	MOV $D0+x, A
	MOV $D4+x, A
	MOV $D8+x, A
	MOV $049C+x, A
	MOV $04B0+x, A
	MOV $0450+x, A
	MOV $0454+x, A
	MOV A, $2D
	MOV $04B4+x, A
	RET

;--------------------------------------------------------------------

CODE_1301:
	MOV Y, #$00
	MOV A, ($22)+y
	MOV $04BC+x, A
	INC Y
	MOV A, ($22)+y
	MOV $21, A
	MOV $04C0+x, A
	RET

;--------------------------------------------------------------------

CODE_1311:
	MOV A, $2A
	INC A
	INC A
	MOV Y, $2B
	MOVW $22, YA
	MOV Y, #$00
	MOV A, $04CC+x
	BEQ CODE_1329
	MOV A, $49
	OR A, $04D7
	MOV $49, A
	BNE CODE_1330
CODE_1329:
	MOV A, $49
	AND A, $04D6
	MOV $49, A
CODE_1330:
	MOV A, $47
	AND A, $04D6
	MOV $47, A
	MOV X, $04DF
	MOV A, $0321+x
	MOV $04E0+x, A
	MOV A, $0351+x
	MOV $04F0+x, A
	MOV A, ($22)+y
	PUSH Y
	CALL CODE_093E
	POP Y
	INC Y
	MOV A, ($22)+y
	INC Y
	MOV $0321+x, A
	MOV A, ($22)+y
	AND A, #$C0
	MOV $0351+x, A
	MOV A, ($22)+y
	INC Y
	AND A, #$3F
	MOV $11, A
	MOV $10, #$00
	PUSH Y
	CALL CODE_0C53
	POP Y
	MOV A, ($22)+y
	INC Y
	MOV $11, A
	MOV A, ($22)+y
	MOV $10, A
	JMP CODE_06DA

;--------------------------------------------------------------------

CODE_1376:
	MOV A, #$02
	MOV $0492, A
	MOV A, #$70
	MOV $0491, A
	BNE CODE_138C
CODE_1382:
	MOV A, #$01
	MOV $0492, A
	MOV A, #$10
	MOV $0491, A
CODE_138C:
	MOV $5A, A
	MOV A, #$10
	MOV $5B, A
	JMP CODE_09EE

;--------------------------------------------------------------------

CODE_1395:
	MOV A, $0491
	CMP A, #$00
	BEQ CODE_13BC
	DEC A
	MOV $0491, A
	BNE CODE_13BC
	MOV A, $0492
	CMP A, #$02
	BNE CODE_13B1
	MOV A, #$02
	CALL CODE_076C
	JMP CODE_13BC

CODE_13B1:
	MOV A, #$31
	MOV $00F1, A
	CALL CODE_1211
	CALL CODE_122C
CODE_13BC:
	RET

;--------------------------------------------------------------------

CODE_13BD:
	MOV Y, A
	MOV A, $53
	MOV $0493, A
CODE_13C3:
	JMP CODE_09F9

;--------------------------------------------------------------------

CODE_13C6:
	MOV A, $0493
	MOV Y, A
	BNE CODE_13C3
	MOV $54, A
	MOV A, $20
	MOV $55, A
	JMP CODE_0A05

;--------------------------------------------------------------------

CODE_13D5:
	MOV $02B0+x, A
	MOV A, $20
	MOV $02A1+x, A
	MOV A, $21
CODE_13DF:
	MOV $B1+x, A
	MOV $02C1+x, A
	MOV A, #$00
	MOV $02B1+x, A
	RET

;--------------------------------------------------------------------

CODE_13EA:
	MOV A, #$00
	BEQ CODE_13DF
CODE_13EE:
	MOV $50, A
	RET

;--------------------------------------------------------------------

CODE_13F1:
	MOV $02F0+x, A
	RET

;--------------------------------------------------------------------

CODE_13F5:
	CALL CODE_0A44
	RET

;--------------------------------------------------------------------

CODE_13F9:
	MOV $44, X
	MOV $90+x, A
	PUSH A
	MOV A, $20
	JMP CODE_0A53

;--------------------------------------------------------------------

CODE_1403:
	PUSH A
	MOV A, #$01
	BRA CODE_140B

CODE_1408:
	PUSH A
	MOV A, #$00
CODE_140B:
	MOV $0290+x, A
	POP A
	MOV $0281+x, A
	MOV A, $20
	MOV $0280+x, A
	MOV A, $21
	MOV $0291+x, A
	RET

;--------------------------------------------------------------------

CODE_141D:
	MOV A, #$00
	MOV $0280+x, A
	RET

;--------------------------------------------------------------------

CODE_1423:
	JMP CODE_0994

;--------------------------------------------------------------------

CODE_1426:
	MOV $44, X
	MOV $91+x, A
	PUSH A
	MOV A, $20
	JMP CODE_09A8

;--------------------------------------------------------------------

CODE_1430:
	MOV X, #$80
CODE_1432:
	MOV $0400+x, A
	INC X
	CMP X, #$00
	BNE CODE_1432
	CALL CODE_2707
	RET

;--------------------------------------------------------------------

CODE_143E:
	MOV A, #DATA_1445
	MOV Y, #DATA_1445>>8
	JMP CODE_0F09

DATA_1445:
	db $03,$FF,$C1,$4B,$B0,$E0,$04,$ED
	db $28,$E1,$12,$B2,$E1,$0A,$B4,$ED
	db $FA,$E1,$01,$B5,$00,$A6,$B0,$C9
	db $B0,$E1,$14,$B0,$B0,$E1,$02,$A6
	db $B0,$E1,$0A,$B0,$B0,$A6,$B0,$ED
	db $50,$B0,$B2,$B4,$B5,$B7,$B9,$ED
	db $FF,$B0,$B2,$B4,$B5,$B7,$B9,$A4
	db $A8,$AB,$B0,$AB,$38,$A0,$A4,$A7
	db $AC,$A7,$AC,$B0,$B3,$B8,$B3,$4B
	db $E0,$05,$A2,$A6,$A9,$AE,$A9,$AE
	db $B2,$B5,$BA,$B5,$00

;--------------------------------------------------------------------

DATA_149A:
	dw CODE_1C01,CODE_1C0F,CODE_1C1D,CODE_1C2B,CODE_1C39,CODE_1C47,CODE_1C55,CODE_1C63
	dw CODE_1C71,CODE_1C7F,CODE_1C8D,CODE_1C9B,CODE_1CA9,CODE_1CB7,CODE_1CC5,CODE_1CD3
	dw CODE_1CE1,CODE_1D2B,CODE_1D39,CODE_1D47,CODE_1D55,CODE_1D63,CODE_1D71,CODE_19C6
	dw CODE_1D91,CODE_1D9F,CODE_1DAD,CODE_1DD4,CODE_1DE9,CODE_1DF7,CODE_1E05,CODE_1DBB
	dw CODE_1E13,CODE_1E21,CODE_1E2F,CODE_1DBB,CODE_1E3D,CODE_1E4B,CODE_1E59,CODE_1E67
	dw CODE_1E75,CODE_1E83,CODE_1E91,CODE_1E91,CODE_1E91,CODE_1E91,CODE_1E91,CODE_1E91
	dw CODE_1EAD,CODE_1EBB,CODE_1EDF,CODE_1EF3,CODE_1F57,CODE_1FB8,CODE_2401,CODE_2033
	dw CODE_2053,CODE_2073,CODE_2082,CODE_2090,CODE_209E,CODE_20AC,CODE_20BA,CODE_1702
	dw CODE_20D6,CODE_20E9,CODE_20F7,CODE_2105,CODE_2113,CODE_2121,CODE_212F,CODE_213D
	dw CODE_214B,CODE_2159,CODE_2167,CODE_2175,CODE_218A,CODE_21BB,CODE_2212,CODE_222E
	dw CODE_225C,CODE_226A,CODE_2271,CODE_22B0,CODE_22DF,CODE_231F,CODE_2327,CODE_232F
	dw CODE_2335,CODE_233F,CODE_2349,CODE_2380,CODE_23B4,CODE_23BA,CODE_23D7,CODE_23F6
	dw CODE_1702,CODE_1A2D,CODE_1A3B,CODE_1A49,CODE_1A57,CODE_1A65,CODE_1A73,CODE_1A81
	dw CODE_1A8F,CODE_1A9D,CODE_1AAB,CODE_1AB9,CODE_1AC7,CODE_1AD5,CODE_1AE3,CODE_1AF1
	dw CODE_1AFF,CODE_1B0D,CODE_143E,CODE_1B1B,CODE_1B36,CODE_1B4A,CODE_1B5B,CODE_1B9E
	dw CODE_1BC6,CODE_1BF3,CODE_2426,CODE_2434,CODE_172E

DATA_1594:
	dw CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442
	dw CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442
	dw CODE_1CEF,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_1702
	dw CODE_1D8D,CODE_1D8D,CODE_1D8D,CODE_1DE4,CODE_2442,CODE_2442,CODE_2442,CODE_1DCB
	dw CODE_2442,CODE_2442,CODE_2442,CODE_1DCB,CODE_2442,CODE_2442,CODE_2442,CODE_2442
	dw CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442
	dw CODE_2442,CODE_2442,CODE_0F5C,CODE_1F13,CODE_1F77,CODE_1FD9,CODE_0F5C,CODE_2442
	dw CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442
	dw CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442
	dw CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_0F5C,CODE_0F5C,CODE_0F5C,CODE_0F5C
	dw CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_22ED,CODE_2442,CODE_2442,CODE_2442
	dw CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2397,CODE_2442,CODE_23DD,CODE_2442
	dw CODE_1702,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442
	dw CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442,CODE_2442
	dw CODE_2442,CODE_2442,CODE_0F5C,CODE_0F5C,CODE_0F5C,CODE_0F5C,CODE_0F5C,CODE_0F5C
	dw CODE_0F5C,CODE_2442,CODE_2442,CODE_2442,CODE_2442

DATA_168E:
	dw CODE_19C5,CODE_1382,CODE_1376,CODE_1A1F,CODE_1985,CODE_1987,CODE_143E,CODE_1A03
	dw CODE_1A11,CODE_19F5,CODE_1702,CODE_1702,CODE_1702,CODE_1702,CODE_1702

DATA_16AC:
	dw CODE_1702,CODE_1702,CODE_1702,CODE_19EC,CODE_1986,CODE_0F5C,CODE_0F5C,CODE_19EC
	dw CODE_19EC,CODE_19EC,CODE_1702,CODE_1702,CODE_1702,CODE_1702,CODE_1702

DATA_16CA:
	dw CODE_1712,CODE_1720,CODE_173C,CODE_179B,CODE_18AE,CODE_18D8,CODE_18EC,CODE_18FF
	dw CODE_18AE,CODE_1912,CODE_1925,CODE_1938,CODE_17E8,CODE_1858

DATA_16E6:
	dw CODE_1709,CODE_1709,CODE_177F,CODE_177F,CODE_1709,CODE_1709,CODE_1709,CODE_1709
	dw CODE_1709,CODE_1709,CODE_1709,CODE_0F5C,CODE_1805,CODE_186E

;--------------------------------------------------------------------

CODE_1702:
	RET

;--------------------------------------------------------------------

CODE_1703:
	MOV A, $04B5
CODE_1706:
	CMP A, #$01
	RET

;--------------------------------------------------------------------

CODE_1709:
	CALL CODE_118F
	BEQ CODE_170F
	RET

CODE_170F:
	JMP CODE_1260

;--------------------------------------------------------------------

CODE_1712:
	MOV A, #DATA_1719
	MOV Y, #DATA_1719>>8
	JMP CODE_12A0

DATA_1719:
	db $32,$30,$18,$FF,$CA,$B4,$00

;--------------------------------------------------------------------

CODE_1720:
	MOV A, #DATA_1727
	MOV Y, #DATA_1727>>8
	JMP CODE_12A0

DATA_1727:
	db $16,$14,$05,$FF,$D2,$A4,$00

;--------------------------------------------------------------------

CODE_172E:
	MOV A, #DATA_1735
	MOV Y, #DATA_1735>>8
	JMP CODE_12A0

DATA_1735:
	db $16,$14,$05,$FF,$C2,$A6,$00

;--------------------------------------------------------------------

CODE_173C:
	CALL CODE_1703
	BEQ CODE_177E
	MOV A, #DATA_1748
	MOV Y, #DATA_1748>>8
	JMP CODE_0F09

DATA_1748:
	db $16,$FA,$CC,$25,$A1,$A4,$12,$A1
	db $AB,$AA,$B0,$B2,$E0,$07,$25,$A7
	db $AC,$B1,$B6,$E1,$08,$99,$9E,$A3
	db $A8,$E0,$16,$12,$98,$9C,$9F,$A4
	db $AA,$E0,$07,$E1,$0E,$25,$9A,$9F
	db $A4,$A9,$E1,$04,$E0,$16,$12,$93
	db $A1,$98,$9C,$A9,$AE,$00

;--------------------------------------------------------------------

CODE_177E:
	RET

CODE_177F:
	MOV A, $04
	CMP A, #$1A
	BEQ CODE_1798
	CMP A, #$1E
	BEQ CODE_1798
	CMP A, #$1F
	BEQ CODE_1798
	CMP A, #$0F
	BEQ CODE_1798
	CMP A, #$0E
	BEQ CODE_1798
	JMP CODE_0F5C

CODE_1798:
	JMP CODE_1260

;--------------------------------------------------------------------

CODE_179B:
	CALL CODE_1703
	BEQ CODE_177E
	MOV A, #DATA_17A7
	MOV Y, #DATA_17A7>>8
	JMP CODE_0F09

DATA_17A7:
	db $14,$BE,$CC,$25,$A4,$A6,$E1,$06
	db $A8,$A9,$ED,$DC,$E1,$0E,$A6,$A8
	db $E1,$06,$ED,$FA,$A9,$AB,$C9,$E0
	db $14,$12,$E1,$0A,$AD,$AE,$AF,$B0
	db $B2,$B4,$ED,$A0,$E1,$11,$AD,$AE
	db $AF,$B0,$B2,$B4,$ED,$64,$E1,$03
	db $AD,$AE,$AF,$B0,$B2,$B4,$ED,$32
	db $E1,$11,$AD,$AE,$AF,$B0,$B2,$B4
	db $00

;--------------------------------------------------------------------

CODE_17E8:
	CALL CODE_1703
	BEQ CODE_177E
	MOV A, #DATA_17FD
	MOV Y, #DATA_17FD>>8
	MOV X, #$3F
CODE_17F3:
	CALL CODE_12AF
	MOV A, #$00
	MOV Y, #$00
	JMP CODE_105B

DATA_17FD:
	db $72,$70,$06,$40,$CA,$B4,$00

;--------------------------------------------------------------------

CODE_1804:
	RET

CODE_1805:
	CALL CODE_118F
	BEQ CODE_181D
	INC $D4+x
	MOV A, $D4+x
	AND A, #$01
	BEQ CODE_1804
	MOV A, $D0+x
	MOV Y, A
	INC $D0+x
	MOV A, DATA_1820+y
	JMP CODE_1083

CODE_181D:
	JMP CODE_1260

DATA_1820:
	db $03,$05,$08,$10,$15,$19,$22,$24
	db $28,$2A,$2D,$2F,$32,$34,$37,$3A
	db $3B,$3F,$41,$48,$4A,$4F,$50,$52
	db $55,$60,$70,$60,$50,$40,$30,$20
	db $10,$20,$30,$40,$50,$60,$70,$80
	db $70,$60,$50,$40,$30,$20,$10,$20
	db $30,$40,$50,$60,$70,$50,$30,$10

;--------------------------------------------------------------------

CODE_1858:
	CALL CODE_1703
	BEQ CODE_186D
	MOV A, #DATA_1866
	MOV Y, #DATA_1866>>8
	MOV X, #$33
	JMP CODE_17F3

DATA_1866:
	db $52,$50,$06,$60,$CA,$B4,$00

;--------------------------------------------------------------------

CODE_186D:
	RET

CODE_186E:
	CALL CODE_118F
	BEQ CODE_181D
	INC $D4+x
	MOV A, $D4+x
	AND A, #$01
	BEQ CODE_186D
	MOV A, $D0+x
	MOV Y, A
	INC $D0+x
	MOV A, DATA_1886+y
	JMP CODE_1083

DATA_1886:
	db $01,$04,$08,$0C,$12,$19,$17,$22
	db $18,$2A,$2D,$2F,$32,$34,$37,$3A
	db $3B,$3F,$41,$48,$4A,$4F,$50,$52
	db $55,$01,$70,$09,$50,$40,$30,$20
	db $20,$20,$20,$20,$20,$20,$20,$20

;--------------------------------------------------------------------

CODE_18AE:
	CALL CODE_1703
	BEQ CODE_18E4
	MOV A, #DATA_18D1
	MOV Y, #DATA_18D1>>8
CODE_18B7:
	CALL CODE_0EEB
	MOV A, $18
	AND A, #$0F
	MOV $20, A
	MOV A, $19
	AND A, #$03
	CLRC
	ADC A, $20
	MOV $04DC, A
CODE_18CA:
	MOV A, #$04D8
	MOV Y, #$04D8>>8
	JMP CODE_12A0

DATA_18D1:
	db $12,$10,$1B,$70,$CA,$B4,$00

;--------------------------------------------------------------------

CODE_18D8:
	CALL CODE_1703
	BEQ CODE_18E4
	MOV A, #DATA_18E5
	MOV Y, #DATA_18E5>>8
	JMP CODE_18B7

CODE_18E4:
	RET

DATA_18E5:
	db $16,$14,$1B,$A0,$CA,$A1,$00

;--------------------------------------------------------------------

CODE_18EC:
	CALL CODE_1703
	BEQ CODE_18E4
	MOV A, #DATA_18F8
	MOV Y, #DATA_18F8>>8
	JMP CODE_18B7

DATA_18F8:
	db $19,$17,$1B,$E0,$CA,$9C,$00

;--------------------------------------------------------------------

CODE_18FF:
	CALL CODE_1703
	BEQ CODE_18E4
	MOV A, #DATA_190B
	MOV Y, #DATA_190B>>8
	JMP CODE_18B7

DATA_190B:
	db $1D,$18,$1B,$FF,$CA,$8E,$00

;--------------------------------------------------------------------

CODE_1912:
	CALL CODE_1703
	BEQ CODE_18E4
	MOV A, #DATA_191E
	MOV Y, #DATA_191E>>8
	JMP CODE_12A0

DATA_191E:
	db $35,$32,$1E,$FF,$CA,$91,$00

;--------------------------------------------------------------------

CODE_1925:
	CALL CODE_1703
	BEQ CODE_18E4
	MOV A, #DATA_1931
	MOV Y, #DATA_1931>>8
	JMP CODE_12A0

DATA_1931:
	db $25,$22,$1E,$FF,$CA,$9F,$00

;--------------------------------------------------------------------

CODE_1938:
	CALL CODE_1703
	BEQ CODE_18E4
	MOV A, #DATA_1944
	MOV Y, #DATA_1944>>8
	JMP CODE_0F09

DATA_1944:
	db $14,$C8,$CA,$12,$AB,$AD,$AF,$B0
	db $ED,$B4,$B2,$B4,$B5,$B7,$B9,$BB
	db $E1,$0F,$ED,$78,$AB,$AD,$AF,$B0
	db $E1,$02,$ED,$5A,$B2,$B4,$B5,$B7
	db $B9,$BB,$E1,$0F,$ED,$50,$B2,$B4
	db $B5,$B7,$B9,$BB,$E1,$01,$ED,$3C
	db $B2,$B4,$B5,$B7,$B9,$BB,$E1,$13
	db $ED,$32,$B2,$B4,$B5,$B7,$B9,$BB
	db $00

;--------------------------------------------------------------------

CODE_1985:
	RET

;--------------------------------------------------------------------

CODE_1986:
	RET

;--------------------------------------------------------------------

CODE_1987:
	MOV A, #$02
	MOV $04B1, A
	MOV A, #$7D
	MOV $04B3, A
	MOV X, #$02
	MOV A, #$00
	CALL CODE_13F5
	MOV X, #$04
	MOV A, #$00
	CALL CODE_13F5
	MOV X, #$06
	MOV A, #$00
	CALL CODE_13F5
	MOV A, #DATA_19AD
	MOV Y, #DATA_19AD>>8
	JMP CODE_0F09

DATA_19AD:
	db $19,$FF,$CA,$4B,$9D,$E0,$19,$25
	db $ED,$5A,$B5,$E1,$03,$B0,$E1,$12
	db $AF,$E1,$03,$A4,$E1,$12,$9F,$00

;--------------------------------------------------------------------

CODE_19C5:
	RET

CODE_19C6:
	MOV A, $04B7
	CMP A, #$29
	BEQ CODE_19C5
	CMP A, #$21
	BEQ CODE_19C5
	MOV A, #$01
	MOV Y, #$70
	CALL CODE_074F
	INC Y
	CALL CODE_074F
	CLR7 $1A
	SET7 $46
	SET7 $47
	SET7 $5E
	MOV X, $2E
	MOV A, #$00
	MOV $04B7, A
	RET

;--------------------------------------------------------------------

CODE_19EC:
	CALL CODE_118F
	BEQ CODE_19F2
	RET

CODE_19F2:
	JMP CODE_1260

;--------------------------------------------------------------------

CODE_19F5:
	MOV A, #DATA_19FC
	MOV Y, #DATA_19FC>>8
	JMP CODE_12A0

DATA_19FC:
	db $23,$20,$1E,$90,$CA,$B5,$00

;--------------------------------------------------------------------

CODE_1A03:
	MOV A, #DATA_1A0A
	MOV Y, #DATA_1A0A>>8
	JMP CODE_12A0

DATA_1A0A:
	db $12,$10,$10,$40,$CA,$A1,$00

;--------------------------------------------------------------------

CODE_1A11:
	MOV A, #DATA_1A18
	MOV Y, #DATA_1A18>>8
	JMP CODE_12A0

DATA_1A18:
	db $A2,$A0,$17,$FF,$CA,$A8,$00

;--------------------------------------------------------------------

CODE_1A1F:
	MOV A, #DATA_1A26
	MOV Y, #DATA_1A26>>8
	JMP CODE_12A0

DATA_1A26:
	db $3E,$36,$21,$F0,$CD,$8C,$00

;--------------------------------------------------------------------

CODE_1A2D:
	MOV A, #DATA_1834
	MOV Y, #DATA_1834>>8
	JMP CODE_12A0

DATA_1834:
	db $07,$05,$16,$FF,$C7,$A1,$00

;--------------------------------------------------------------------

CODE_1A3B:
	MOV A, #DATA_1A42
	MOV Y, #DATA_1A42>>8
	JMP CODE_12A0

DATA_1A42:
	db $07,$05,$16,$FF,$CD,$A3,$00

;--------------------------------------------------------------------

CODE_1A49:
	MOV A, #DATA_1A50
	MOV Y, #DATA_1A50>>8
	JMP CODE_12A0

DATA_1A50:
	db $07,$05,$16,$FF,$C7,$A5,$00

;--------------------------------------------------------------------

CODE_1A57:
	MOV A, #DATA_1A5E
	MOV Y, #DATA_1A5E>>8
	JMP CODE_12A0

DATA_1A5E:
	db $07,$05,$16,$FF,$CD,$A6,$00

;--------------------------------------------------------------------

CODE_1A65:
	MOV A, #DATA_1A6C
	MOV Y, #DATA_1A6C>>8
	JMP CODE_12A0

DATA_1A6C:
	db $07,$05,$16,$FF,$C7,$A8,$00

;--------------------------------------------------------------------

CODE_1A73:
	MOV A, #DATA_1A7A
	MOV Y, #DATA_1A7A>>8
	JMP CODE_12A0

DATA_1A7A:
	db $07,$05,$16,$FF,$CD,$AA,$00

;--------------------------------------------------------------------

CODE_1A81:
	MOV A, #DATA_1A88
	MOV Y, #DATA_1A88>>8
	JMP CODE_12A0

DATA_1A88:
	db $07,$05,$16,$FF,$C7,$AC,$00

;--------------------------------------------------------------------

CODE_1A8F:
	MOV A, #DATA_1A96
	MOV Y, #DATA_1A96>>8
	JMP CODE_12A0

DATA_1A96:
	db $07,$05,$16,$FF,$CD,$AD,$00

;--------------------------------------------------------------------

CODE_1A9D:
	MOV A, #DATA_1AA4
	MOV Y, #DATA_1AA4>>8
	JMP CODE_12A0

DATA_1AA4:
	db $07,$05,$16,$FF,$C7,$AF,$00

;--------------------------------------------------------------------

CODE_1AAB:
	MOV A, #DATA_1AB2
	MOV Y, #DATA_1AB2>>8
	JMP CODE_12A0

DATA_1AB2:
	db $07,$05,$16,$FF,$CD,$B1,$00

;--------------------------------------------------------------------

CODE_1AB9:
	MOV A, #DATA_1AC0
	MOV Y, #DATA_1AC0>>8
	JMP CODE_12A0

DATA_1AC0:
	db $07,$05,$16,$FF,$C7,$B2,$00

;--------------------------------------------------------------------

CODE_1AC7:
	MOV A, #DATA_1ACE
	MOV Y, #DATA_1ACE>>8
	JMP CODE_12A0

DATA_1ACE:
	db $07,$05,$16,$FF,$CD,$B4,$00

;--------------------------------------------------------------------

CODE_1AD5:
	MOV A, #DATA_1ADC
	MOV Y, #DATA_1ADC>>8
	JMP CODE_12A0

DATA_1ADC:
	db $07,$05,$16,$FF,$C7,$B6,$00

;--------------------------------------------------------------------

CODE_1AE3:
	MOV A, #DATA_1AEA
	MOV Y, #DATA_1AEA>>8
	JMP CODE_12A0

DATA_1AEA:
	db $07,$05,$16,$FF,$CD,$B8,$00

;--------------------------------------------------------------------

CODE_1AF1:
	MOV A, #DATA_1AF8
	MOV Y, #DATA_1AF8>>8
	JMP CODE_12A0

DATA_1AF8:
	db $07,$05,$16,$FF,$C7,$B9,$00

;--------------------------------------------------------------------

CODE_1AFF:
	MOV A, #DATA_1B06
	MOV Y, #DATA_1B06>>8
	JMP CODE_12A0

DATA_1B06:
	db $07,$05,$16,$FF,$C7,$A4,$00

;--------------------------------------------------------------------

CODE_1B0D:
	MOV A, #DATA_1B14
	MOV Y, #DATA_1B14>>8
	JMP CODE_12A0

DATA_1B14:
	db $1D,$18,$1C,$FF,$CA,$9F,$00

;--------------------------------------------------------------------

CODE_1B1B:
	MOV A, #DATA_1B22
	MOV Y, #DATA_1B22>>8
	JMP CODE_0F09

DATA_1B22:
	db $13,$E0,$C8,$38,$A4,$A4,$E1,$0E
	db $A5,$C9,$E1,$0C,$B0,$4B,$C9,$E1
	db $04,$C9,$9F,$00

;--------------------------------------------------------------------

CODE_1B36:
	MOV A, #DATA_1B3D
	MOV Y, #DATA_1B3D>>8
	JMP CODE_0F09

DATA_1B3D:
	db $15,$E3,$CC,$38,$98,$9C,$E1,$07
	db $A4,$E1,$09,$B0,$00

;--------------------------------------------------------------------

CODE_1B4A:
	MOV A, #DATA_1B51
	MOV Y, #DATA_1B51>>8
	JMP CODE_0F09

DATA_1B51:
	db $14,$FF,$CB,$38,$98,$98,$E1,$08
	db $98,$00

;--------------------------------------------------------------------

CODE_1B5B:
	MOV A, $18
	AND A, #$03
	CMP A, #$01
	BEQ CODE_1B6E
	CMP A, #$02
	BEQ CODE_1B75
	MOV A, #DATA_1B7C
	MOV Y, #DATA_1B7C>>8
	JMP CODE_0F09

CODE_1B6E:
	MOV A, #DATA_1B87
	MOV Y, #DATA_1B87>>8
	JMP CODE_0F09

CODE_1B75:
	MOV A, #DATA_1B92
	MOV Y, #DATA_1B92>>8
	JMP CODE_0F09

DATA_1B7C:
	db $19,$E0,$CB,$4B,$98,$97,$E1,$05
	db $C9,$9C,$00

DATA_1B87:
	db $19,$D8,$C9,$4B,$95,$C9,$E1,$0C
	db $9D,$9A,$00

DATA_1B92:
	db $19,$DD,$CF,$38,$93,$98,$4B,$E1
	db $08,$A4,$9F,$00

;--------------------------------------------------------------------

CODE_1B9E:
	MOV A, $18
	AND A, #$01
	BNE CODE_1BAB
	MOV A, #DATA_1BB2
	MOV Y, #DATA_1BB2>>8
	JMP CODE_0F09

CODE_1BAB:
	MOV A, #DATA_1BBC
	MOV Y, #DATA_1BBC>>8
	JMP CODE_0F09

DATA_1BB2:
	db $10,$B2,$C6,$38,$A9,$AA,$E1,$0C
	db $A8,$00

DATA_1BBC:
	db $10,$C1,$CE,$38,$9D,$9F,$E1,$08
	db $A1,$00

;--------------------------------------------------------------------

CODE_1BC6:
	MOV A, $18
	AND A, #$01
	BNE CODE_1BD3
	MOV A, #DATA_1BDA
	MOV Y, #DATA_1BDA>>8
	JMP CODE_0F09

CODE_1BD3:
	MOV A, #DATA_1BE7
	MOV Y, #DATA_1BE7>>8
	JMP CODE_0F09

DATA_1BDA:
	db $18,$90,$CC,$38,$9C,$9D,$4B,$C9
	db $E1,$08,$98,$9A,$00

DATA_1BE7:
	db $18,$80,$C9,$38,$98,$C9,$18,$9C
	db $E1,$0D,$99,$00

;--------------------------------------------------------------------

CODE_1BF3:
	MOV A, #DATA_1BFA
	MOV Y, #DATA_1BFA>>8
	JMP CODE_12A0

DATA_1BFA:
	db $30,$2D,$1E,$FF,$CA,$90,$00

;--------------------------------------------------------------------

CODE_1C01:
	MOV A, #DATA_1C08
	MOV Y, #DATA_1C08>>8
	JMP CODE_12A0

DATA_1C08:
	db $07,$04,$14,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1C0F:
	MOV A, #DATA_1C16
	MOV Y, #DATA_1C16>>8
	JMP CODE_12A0

DATA_1C16:
	db $07,$04,$14,$FF,$CA,$98,$00

;--------------------------------------------------------------------

CODE_1C1D:
	MOV A, #DATA_1C24
	MOV Y, #DATA_1C24>>8
	JMP CODE_12A0

DATA_1C24:
	db $10,$0C,$16,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1C2B:
	MOV A, #DATA_1C32
	MOV Y, #DATA_1C32>>8
	JMP CODE_12A0

DATA_1C32:
	db $0E,$09,$1A,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1C39:
	MOV A, #DATA_1C40
	MOV Y, #DATA_1C40>>8
	JMP CODE_12A0

DATA_1C40:
	db $10,$0D,$16,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1C47:
	MOV A, #DATA_1C4E
	MOV Y, #DATA_1C4E>>8
	JMP CODE_12A0

DATA_1C4E:
	db $0E,$09,$14,$FF,$FA,$A6,$00

;--------------------------------------------------------------------

CODE_1C55:
	MOV A, #DATA_1C5C
	MOV Y, #DATA_1C5C>>8
	JMP CODE_12A0

DATA_1C5C:
	db $12,$0D,$1D,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1C63:
	MOV A, #DATA_1C6A
	MOV Y, #DATA_1C6A>>8
	JMP CODE_12A0

DATA_1C6A:
	db $15,$12,$15,$FF,$CA,$A1,$00

;--------------------------------------------------------------------

CODE_1C71:
	MOV A, #DATA_1C78
	MOV Y, #DATA_1C78>>8
	JMP CODE_12A0

DATA_1C78:
	db $15,$12,$1E,$FF,$CA,$B7,$00

;--------------------------------------------------------------------

CODE_1C7F:
	MOV A, #DATA_1C86
	MOV Y, #DATA_1C86>>8
	JMP CODE_12A0

DATA_1C86:
	db $18,$15,$14,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1C8D:
	MOV A, #DATA_1C94
	MOV Y, #DATA_1C94>>8
	JMP CODE_12A0

DATA_1C94:
	db $19,$15,$14,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1C9B:
	MOV A, #DATA_1CA2
	MOV Y, #DATA_1CA2>>8
	JMP CODE_12A0

DATA_1CA2:
	db $15,$10,$14,$FF,$CA,$9F,$00

;--------------------------------------------------------------------

CODE_1CA9:
	MOV A, #DATA_1CB0
	MOV Y, #DATA_1CB0>>8
	JMP CODE_12A0

DATA_1CB0:
	db $15,$12,$1D,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1CB7:
	MOV A, #DATA_1CBE
	MOV Y, #DATA_1CBE>>8
	JMP CODE_12A0

DATA_1CBE:
	db $15,$12,$19,$FF,$CA,$9F,$00

;--------------------------------------------------------------------

CODE_1CC5:
	MOV A, #DATA_1CCC
	MOV Y, #DATA_1CCC>>8
	JMP CODE_12A0

DATA_1CCC:
	db $15,$09,$1D,$FF,$CA,$98,$00

;--------------------------------------------------------------------

CODE_1CD3:
	MOV A, #DATA_1CDA
	MOV Y, #DATA_1CDA>>8
	JMP CODE_12A0

DATA_1CDA:
	db $15,$12,$14,$FF,$CA,$9F,$00

;--------------------------------------------------------------------

CODE_1CE1:
	MOV A, #DATA_1CE8
	MOV Y, #DATA_1CE8>>8
	JMP CODE_12A0

DATA_1CE8:
	db $09,$06,$15,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1CEF:
	CALL CODE_118F
	BEQ CODE_1CF5
	RET

CODE_1CF5:
	MOV Y, $D0+x
	MOV A, DATA_1D10+y
	CMP A, #$00
	BNE CODE_1D01
	JMP CODE_1260

CODE_1D01:
	MOV $20, A
	INC Y
	MOV A, DATA_1D10+y
	INC Y
	MOV $D0+x, Y
	MOV Y, $20
	CALL CODE_1038
	RET

DATA_1D10:
	db $AB,$00,$B0,$00,$AB,$00,$B4,$00
	db $B5,$00,$A4,$00,$9F,$00,$A4,$00
	db $9F,$00,$A4,$00,$9F,$00,$A4,$00
	db $9F,$00,$00

;--------------------------------------------------------------------

CODE_1D2B:
	MOV A, #DATA_1D32
	MOV Y, #DATA_1D32>>8
	JMP CODE_12A0

DATA_1D32:
	db $0E,$09,$1D,$FF,$CA,$B0,$00

;--------------------------------------------------------------------

CODE_1D39:
	MOV A, #DATA_1D40
	MOV Y, #DATA_1D40>>8
	JMP CODE_12A0

DATA_1D40:
	db $15,$12,$14,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1D47:
	MOV A, #DATA_1D4E
	MOV Y, #DATA_1D4E>>8
	JMP CODE_12A0

DATA_1D4E:
	db $15,$12,$14,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1D55:
	MOV A, #DATA_1D5C
	MOV Y, #DATA_1D5C>>8
	JMP CODE_12A0

DATA_1D5C:
	db $15,$10,$14,$FF,$CA,$A6,$00

;--------------------------------------------------------------------

CODE_1D63:
	MOV A, #DATA_1D6A
	MOV Y, #DATA_1D6A>>8
	JMP CODE_12A0

DATA_1D6A:
	db $15,$10,$14,$FF,$CA,$A8,$00

;--------------------------------------------------------------------

CODE_1D71:
	MOV A, #DATA_1D78
	MOV Y, #DATA_1D78>>8
	JMP CODE_12A0

DATA_1D78:
	db $1D,$18,$14,$FF,$CA,$9A,$00

;--------------------------------------------------------------------

CODE_1D7F:
	MOV A, #DATA_1D86
	MOV Y, #DATA_1D86>>8
	JMP CODE_12A0

DATA_1D86:
	db $1D,$18,$15,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1D8D:
	CALL CODE_118F
	RET

;--------------------------------------------------------------------

CODE_1D91:
	MOV A, #DATA_1D98
	MOV Y, #DATA_1D98>>8
	JMP CODE_12A0

DATA_1D98:
	db $FF,$00,$0E,$D0,$CA,$A9,$00

;--------------------------------------------------------------------

CODE_1D9F:
	MOV A, #DATA_1DA6
	MOV Y, #DATA_1DA6>>8
	JMP CODE_12A0

DATA_1DA6:
	db $FF,$00,$0E,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1DAD:
	MOV A, #DATA_1DB4
	MOV Y, #DATA_1DB4>>8
	JMP CODE_12A0

DATA_1DB4:
	db $FF,$00,$0E,$FF,$CA,$9C,$00

;--------------------------------------------------------------------

CODE_1DBB:
	MOV A, #DATA_1DC4
	MOV Y, #DATA_1DC4>>8
	MOV X, #$3F
	JMP CODE_12AF

DATA_1DC4:
	db $12,$10,$08,$30,$CA,$B9,$00

;--------------------------------------------------------------------

CODE_1DCB:
	CALL CODE_118F
	BEQ CODE_1DD1
	RET

CODE_1DD1:
	JMP CODE_1260

;--------------------------------------------------------------------

CODE_1DD4:
	MOV A, #DATA_1DDD
	MOV Y, #DATA_1DDD>>8
	MOV X, #$3F
	JMP CODE_12AF

DATA_1DDD:
	db $FF,$00,$08,$30,$CA,$BB,$00

;--------------------------------------------------------------------

CODE_1DE4:
	CALL CODE_118F
	RET

;--------------------------------------------------------------------

CODE_1DE8:
	RET

;--------------------------------------------------------------------

CODE_1DE9:
	MOV A, #DATA_1DF0
	MOV Y, #DATA_1DF0>>8
	JMP CODE_12A0

DATA_1DF0:
	db $1D,$18,$11,$80,$CA,$A3,$00

;--------------------------------------------------------------------

CODE_1DF7:
	MOV A, #DATA_1DFE
	MOV Y, #DATA_1DFE>>8
	JMP CODE_12A0

DATA_1DFE:
	db $1D,$18,$11,$80,$CA,$98,$00

;--------------------------------------------------------------------

CODE_1E05:
	MOV A, #DATA_1E0C
	MOV Y, #DATA_1E0C>>8
	JMP CODE_12A0

DATA_1E0C:
	db $1D,$18,$11,$80,$CA,$90,$00

;--------------------------------------------------------------------

CODE_1E13:
	MOV A, #DATA_1E1A
	MOV Y, #DATA_1E1A>>8
	JMP CODE_12A0

DATA_1E1A:
	db $1D,$18,$11,$80,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1E21:
	MOV A, #DATA_1E28
	MOV Y, #DATA_1E28>>8
	JMP CODE_12A0

DATA_1E28:
	db $1D,$18,$11,$80,$CA,$98,$00

;--------------------------------------------------------------------

CODE_1E2F:
	MOV A, #DATA_1E36
	MOV Y, #DATA_1E36>>8
	JMP CODE_12A0

DATA_1E36:
	db $1D,$18,$11,$80,$CA,$93,$00

;--------------------------------------------------------------------

CODE_1E3D:
	MOV A, #DATA_1E44
	MOV Y, #DATA_1E44>>8
	JMP CODE_12A0

DATA_1E44:
	db $1D,$18,$0F,$60,$CA,$98,$00

;--------------------------------------------------------------------

CODE_1E4B:
	MOV A, #DATA_1E52
	MOV Y, #DATA_1E52>>8
	JMP CODE_12A0

DATA_1E52:
	db $1D,$18,$18,$D0,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1E59:
	MOV A, #DATA_1E60
	MOV Y, #DATA_1E60>>8
	JMP CODE_12A0

DATA_1E60:
	db $1D,$18,$18,$FF,$CA,$98,$00

;--------------------------------------------------------------------

CODE_1E67:
	MOV A, #DATA_1E6E
	MOV Y, #DATA_1E6E>>8
	JMP CODE_12A0

DATA_1E6E:
	db $1D,$18,$0F,$60,$CA,$98,$00

;--------------------------------------------------------------------

CODE_1E75:
	MOV A, #DATA_1E7C
	MOV Y, #DATA_1E7C>>8
	JMP CODE_12A0

DATA_1E7C:
	db $10,$08,$0F,$FF,$CA,$9D,$00

;--------------------------------------------------------------------

CODE_1E83:
	MOV A, #DATA_1E8A
	MOV Y, #DATA_1E8A>>8
	JMP CODE_12A0

DATA_1E8A:
 	db $1D,$18,$1F,$A0,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1E91:
	MOV A, #DATA_1E98
	MOV Y, #DATA_1E98>>8
	JMP CODE_12A0

DATA_1E98:
	db $20,$1D,$0F,$A0,$CA,$93,$00

;--------------------------------------------------------------------

CODE_1E9F:
	MOV A, #DATA_1EA6
	MOV Y, #DATA_1EA6>>8
	JMP CODE_12A0

DATA_1EA6:
	db $1D,$18,$0C,$FF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1EAD:
	MOV A, #DATA_1EB4
	MOV Y, #DATA_1EB4>>8
	JMP CODE_12A0

DATA_1EB4:
	db $1D,$18,$0E,$FF,$CA,$98,$00

;--------------------------------------------------------------------

CODE_1EBB:
	MOV A, #DATA_1EC2
	MOV Y, #DATA_1EC2>>8
	JMP CODE_12A0

DATA_1EC2:
	db $1D,$18,$0F,$FF,$CA,$98,$00

;--------------------------------------------------------------------

CODE_1EC9:
	MOV A, #DATA_1ED8
	MOV Y, #DATA_1ED8>>8
	CALL CODE_0EEB
	MOV A, $18
	MOV $04DE, A
	JMP CODE_18CA

DATA_1ED8:
	db $19,$17,$12,$FF,$CA,$9F,$00

;--------------------------------------------------------------------

CODE_1EDF:
	MOV A, #DATA_1EEC
	MOV Y, #DATA_1EEC>>8
	CALL CODE_0F09
	MOV A, $18
	MOV $047E, A
	RET

DATA_1EEC:
	db $12,$FF,$CA,$38,$C9,$9F,$00

;--------------------------------------------------------------------

CODE_1EF3:
	MOV A, #DATA_1F0C
	MOV Y, #DATA_1F0C>>8
	CALL CODE_0EEB
	CLRC
	MOV A, $18
	AND A, #$03
	ADC A, #$A5
	MOV $04DD, A
	MOV A, $19
	MOV $04DE, A
	JMP CODE_18CA

DATA_1F0C:
	db $0F,$0D,$13,$90,$CA,$A6,$00

;--------------------------------------------------------------------

CODE_1F13:
	CALL CODE_118F
	BEQ CODE_1F19
	RET

CODE_1F19:
	INC $D0+x
	MOV A, $D0+x
	CMP A, #$01
	BEQ CODE_1F32
	CMP A, #$04
	BEQ CODE_1F42
CODE_1F25:
	MOV Y, A
	DEC Y
	MOV A, DATA_1F4E+y
	BEQ CODE_1F4B
	MOV Y, A
	MOV A, #$00
	JMP CODE_1046

CODE_1F32:
	MOV A, #$05
	MOV Y, #$03
	CALL CODE_1187
	MOV A, #$10
	CALL CODE_10A5
	MOV A, #$01
	BNE CODE_1F25
CODE_1F42:
	MOV A, #$08
	CALL CODE_10A5
	MOV A, #$04
	BNE CODE_1F25
CODE_1F4B:
	JMP CODE_1260

DATA_1F4E:
	db $A4,$A8,$A2,$A6,$A0,$A4,$9A,$9E
	db $00

;--------------------------------------------------------------------

CODE_1F57:
	MOV A, #DATA_1F70
	MOV Y, #DATA_1F70>>8
	CALL CODE_0EEB
	CLRC
	MOV A, $18
	AND A, #$03
	ADC A, #$A3
	MOV $04DD, A
	MOV A, $18
	MOV $04DE, A
	JMP CODE_18CA

DATA_1F70:
	db $0F,$0D,$14,$DF,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1F77:
	CALL CODE_118F
	BEQ CODE_1F7D
	RET

CODE_1F7D:
	INC $D0+x
	MOV A, $D0+x
	CMP A, #$01
	BEQ CODE_1F96
	CMP A, #$04
	BEQ CODE_1FA6
CODE_1F89:
	MOV Y, A
	DEC Y
	MOV A, DATA_1FB2+y
	BEQ CODE_1FAF
	MOV Y, A
	MOV A, #$00
	JMP CODE_1046

CODE_1F96:
	MOV A, #$06
	MOV Y, #$04
	CALL CODE_1187
	MOV A, #$12
	CALL CODE_10A5
	MOV A, #$01
	BNE CODE_1F89
CODE_1FA6:
	MOV A, #$08
	CALL CODE_10A5
	MOV A, #$04
	BNE CODE_1F89
CODE_1FAF:
	JMP CODE_1260

DATA_1FB2:
	db $9F,$9A,$95,$90,$8E,$00

;--------------------------------------------------------------------

CODE_1FB8:
	MOV A, #DATA_1FD2
	MOV Y, #DATA_1FD2>>8
	CALL CODE_0EEB
	MOV A, $18
	AND A, #$0F
	MOV $20, A
	MOV A, $19
	AND A, #$03
	CLRC
	ADC A, $20
	MOV $04DC, A
	JMP CODE_18CA

DATA_1FD2:
	db $06,$04,$15,$C0,$CA,$A4,$00

;--------------------------------------------------------------------

CODE_1FD9:
	CALL CODE_118F
	BEQ CODE_1FE3
	MOV A, $D0+x
	BNE CODE_1FFB
	RET

CODE_1FE3:
	MOV A, $D0+x
	BEQ CODE_1FEA
CODE_1FE7:
	JMP CODE_1260

CODE_1FEA:
	MOV A, #$24
	MOV Y, #$21
	CALL CODE_1187
	MOV A, #$0F
	CALL CODE_108F
	MOV A, #$1A
	CALL CODE_10A5
CODE_1FFB:
	MOV X, $2E
	INC $D0+x
	MOV A, $D0+x
	MOV Y, A
	MOV A, DATA_200D+y
	BEQ CODE_1FE7
	MOV Y, A
	MOV A, #$00
	JMP CODE_1046

DATA_200D:
	db $C3,$C2,$C1,$C0,$BF,$BE,$BD,$BC
	db $BA,$B9,$B8,$B7,$B6,$B5,$B4,$B3
	db $B2,$B1,$B0,$AE,$AD,$AC,$AB,$AA
	db $A9,$A8,$A7,$A6,$A5,$A4,$A3,$A2
	db $A1,$A0,$9F,$9E,$9D,$00

;--------------------------------------------------------------------

CODE_2033:
	MOV A, #DATA_204C
	MOV Y, #DATA_204C>>8
	CALL CODE_0EEB
	CLRC
	MOV A, $18
	AND A, #$03
	ADC A, #$9B
	MOV $04DD, A
	MOV A, $18
	MOV $04DE, A
	JMP CODE_18CA

DATA_204C:
	db $A2,$A0,$16,$AF,$CA,$9C,$00

;--------------------------------------------------------------------

CODE_2053:
	MOV A, #DATA_206C
	MOV Y, #DATA_206C>>8
	CALL CODE_0EEB
	CLRC
	MOV A, $18
	AND A, #$03
	ADC A, #$96
	MOV $04DD, A
	MOV A, $18
	MOV $04DE, A
	JMP CODE_18CA

DATA_206C:
	db $A2,$A0,$1C,$FF,$CA,$98,$00

;--------------------------------------------------------------------

CODE_2073:
	MOV A, #DATA_207A
	MOV Y, #DATA_207A>>8
	JMP CODE_12A0

DATA_207A:
	db $1D,$18,$11,$FF,$CA,$90,$00

;--------------------------------------------------------------------

CODE_2081:
	RET

;--------------------------------------------------------------------

CODE_2082:
	MOV A, #DATA_2089
	MOV Y, #DATA_2089>>8
	JMP CODE_12A0

DATA_2089:
	db $1D,$18,$1A,$30,$3A,$98,$00

;--------------------------------------------------------------------

CODE_2090:
	MOV A, #DATA_2097
	MOV Y, #DATA_2097>>8
	JMP CODE_12A0

DATA_2097:
	db $22,$20,$19,$FF,$CA,$AB,$00

;--------------------------------------------------------------------

CODE_209E:
	MOV A, #DATA_20A5
	MOV Y, #DATA_20A5>>8
	JMP CODE_12A0

DATA_20A5:
	db $1D,$18,$02,$FF,$CA,$AB,$00

;--------------------------------------------------------------------

CODE_20AC:
	MOV A, #DATA_20B3
	MOV Y, #DATA_20B3>>8
	JMP CODE_12A0

DATA_20B3:
	db $1D,$18,$18,$FF,$CA,$B0,$00

;--------------------------------------------------------------------

CODE_20BA:
	MOV A, #DATA_20C1
	MOV Y, #DATA_20C1>>8
	JMP CODE_12A0

DATA_20C1:
	db $1D,$18,$0A,$FF,$CA,$AB,$00

;--------------------------------------------------------------------

CODE_20C8:
	MOV A, #DATA_20CF
	MOV Y, #DATA_20CF>>8
	JMP CODE_12A0

DATA_20CF:
	db $1D,$18,$1B,$FF,$CA,$90,$00

;--------------------------------------------------------------------

CODE_20D6:
	MOV A, #$04
	MOV $04B2, A
	MOV A, #DATA_20E2
	MOV Y, #DATA_20E2>>8
	JMP CODE_12A0

DATA_20E2:
	db $35,$33,$21,$FF,$CA,$8C,$00

;--------------------------------------------------------------------

CODE_20E9:
	MOV A, #DATA_20F0
	MOV Y, #DATA_20F0>>8
	JMP CODE_12A0

DATA_20F0:
	db $1D,$18,$14,$FF,$CA,$AB,$00

;--------------------------------------------------------------------

CODE_20F7:
	MOV A, #DATA_20FE
	MOV Y, #DATA_20FE>>8
	JMP CODE_12A0

DATA_20FE:
	db $1D,$18,$14,$FF,$CA,$A3,$00

;--------------------------------------------------------------------

CODE_2105:
	MOV A, #DATA_210C
	MOV Y, #DATA_210C>>8
	JMP CODE_12A0

DATA_210C:
	db $1D,$18,$14,$FF,$CA,$A6,$00

;--------------------------------------------------------------------

CODE_2113:
	MOV A, #DATA_211A
	MOV Y, #DATA_211A>>8
	JMP CODE_12A0

DATA_211A:
	db $1D,$18,$14,$FF,$CA,$9D,$00

;--------------------------------------------------------------------

CODE_2121:
	MOV A, #DATA_2128
	MOV Y, #DATA_2128>>8
	JMP CODE_12A0

DATA_2128:
	db $1D,$18,$14,$FF,$CA,$A1,$00

;--------------------------------------------------------------------

CODE_212F:
	MOV A, #DATA_2136
	MOV Y, #DATA_2136>>8
	JMP CODE_12A0

DATA_2136:
	db $1D,$18,$1F,$70,$CA,$A3,$00

;--------------------------------------------------------------------

CODE_213D:
	MOV A, #DATA_2144
	MOV Y, #DATA_2144>>8
	JMP CODE_12A0

DATA_2144:
	db $1D,$18,$1F,$70,$CA,$A8,$00

;--------------------------------------------------------------------

CODE_214B:
	MOV A, #DATA_2152
	MOV Y, #DATA_2152>>8
	JMP CODE_12A0

DATA_2152:
	db $1D,$18,$1F,$70,$CA,$AB,$00

;--------------------------------------------------------------------

CODE_2159:
	MOV A, #DATA_2160
	MOV Y, #DATA_2160>>8
	JMP CODE_12A0

DATA_2160:
	db $1D,$18,$1F,$70,$CA,$B0,$00

;--------------------------------------------------------------------

CODE_2167:
	MOV A, #DATA_216E
	MOV Y, #DATA_216E>>8
	JMP CODE_12A0

DATA_216E:
	db $1D,$18,$1F,$70,$CA,$B4,$00

;--------------------------------------------------------------------

CODE_2175:
	MOV A, #DATA_217C
	MOV Y, #DATA_217C>>8
	JMP CODE_12A0

DATA_217C:
	db $1D,$18,$1F,$70,$CA,$B7,$00

DATA_2183:
	db $20,$18,$11,$FF,$CA,$A3,$00

;--------------------------------------------------------------------

CODE_218A:
	MOV A, #DATA_2198
	MOV Y, #DATA_2198>>8
	CALL CODE_0F09
	MOV A, #$FE
	MOV Y, #$11
	JMP CODE_105B

DATA_2198:
	db $1C,$FF,$CA,$5D,$98,$9C,$9F,$A4
	db $9F,$A4,$A8,$AB,$B0,$AB,$A0,$A4
	db $A7,$AC,$A7,$AC,$B0,$B3,$B8,$B3
	db $A2,$A6,$A9,$AE,$A9,$AE,$B2,$B5
	db $BA,$B5,$00

;--------------------------------------------------------------------

CODE_21BB:
	MOV A, #DATA_21C9
	MOV Y, #DATA_21C9>>8
	CALL CODE_0F09
	MOV A, #$FE
	MOV Y, #$6A
	JMP CODE_105B

DATA_21C9:
	db $1D,$78,$D4,$5D,$A1,$9F,$ED,$50
	db $E1,$0F,$9C,$98,$ED,$28,$E1,$0A
	db $97,$93,$ED,$1E,$E1,$05,$91,$8E
	db $ED,$78,$E1,$01,$A1,$9F,$ED,$50
	db $E1,$05,$9C,$98,$ED,$28,$E1,$0A
	db $97,$93,$ED,$1E,$E1,$0F,$91,$8E
	db $ED,$64,$E1,$14,$A1,$9F,$ED,$46
	db $E1,$0F,$9C,$98,$ED,$28,$E1,$0A
	db $97,$93,$ED,$14,$E1,$05,$91,$8E
	db $00

;--------------------------------------------------------------------

CODE_2212:
	MOV A, #DATA_2219
	MOV Y, #DATA_2219>>8
	JMP CODE_0F09

DATA_2219:
	db $11,$FA,$CA,$38,$B0,$ED,$B4,$12
	db $E0,$05,$B0,$AF,$AE,$AD,$AC,$AB
	db $A9,$A8,$A7,$A6,$00

;--------------------------------------------------------------------

CODE_222E:
	MOV X, #$02
	MOV A, #$5A
	CALL CODE_13F5
	MOV X, #$04
	MOV A, #$82
	CALL CODE_13F5
	MOV X, #$06
	MOV A, #$32
	CALL CODE_13F5
	MOV A, #DATA_224A
	MOV Y, #DATA_224A>>8
	JMP CODE_0F09

DATA_224A:
	db $11,$FF,$CA,$38,$B0,$AD,$25,$A9
	db $A8,$A6,$00

;--------------------------------------------------------------------

CODE_2255:
	MOV A, #DATA_2183
	MOV Y, #DATA_2183>>8
	JMP CODE_12A0

;--------------------------------------------------------------------

CODE_225C:
	MOV A, #DATA_2263
	MOV Y, #DATA_2263>>8
	JMP CODE_12A0

DATA_2263:
	db $22,$20,$10,$FF,$CA,$A9,$00

CODE_226A:
	MOV A, #DATA_2263
	MOV Y, #DATA_2263>>8
	JMP CODE_12A0

;--------------------------------------------------------------------

CODE_2271:
	MOV $47, #$00
	AND $49, #$FE
	MOV X, #$00
	MOV A, #$11
	CALL CODE_093E
	MOV X, #$00
	MOV A, #$22
	CALL CODE_13F1
	MOV X, #$0A
	MOV A, #$22
	CALL CODE_13F1
	MOV X, #$02
	MOV A, #$FB
	CALL CODE_13F1
	MOV X, #$04
	MOV A, #$01
	MOV $20, #$06
	MOV $21, #$03
	CALL CODE_1403
	MOV X, #$06
	MOV A, #$01
	MOV $20, #$06
	MOV $21, #$03
	CALL CODE_1408
	JMP CODE_2255

CODE_22B0:
	MOV $47, #$00
	AND $49, #$FE
	MOV X, #$00
	MOV A, #$02
	CALL CODE_093E
	MOV X, #$00
	MOV A, #$00
	CALL CODE_13F1
	MOV X, #$02
	MOV A, #$00
	CALL CODE_13F1
	MOV X, #$0A
	MOV A, #$00
	CALL CODE_13F1
	MOV X, #$04
	CALL CODE_141D
	MOV X, #$06
	CALL CODE_141D
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_22DF:
	MOV A, #DATA_22E6
	MOV Y, #DATA_22E6>>8
	JMP CODE_12A0

DATA_22E6:
	db $12,$10,$12,$FF,$CA,$C5,$00

;--------------------------------------------------------------------

CODE_22ED:
	CALL CODE_118F
	BNE CODE_230C
	MOV Y, $D0+x
	MOV A, DATA_230D+y
	CMP A, #$00
	BNE CODE_22FE
	JMP CODE_1260

CODE_22FE:
	MOV $20, A
	INC Y
	MOV A, DATA_230D+y
	INC Y
	MOV $D0+x, Y
	MOV Y, $20
	CALL CODE_1038
CODE_230C:
	RET

DATA_230D:
	db $C5,$00,$C5,$00,$C5,$00,$C5,$00
	db $C5,$00,$C5,$00,$C5,$00,$C5,$00
	db $00

;--------------------------------------------------------------------

CODE_231E:
	RET

;--------------------------------------------------------------------

CODE_231F:
	MOV A, #$1C
	CALL CODE_076C
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_2327:
	MOV A, #$1B
	CALL CODE_076C
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_232F:
	CALL CODE_1376
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_2335:
	MOV X, #$08
	MOV A, #$FA
	CALL CODE_13F5
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_233F:
	MOV X, #$08
	MOV A, #$01
	CALL CODE_13F5
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_2349:
	MOV X, #$04
	MOV A, #$01
	MOV $20, #$1A
	MOV $21, #$F2
	CALL CODE_13D5
	MOV X, #$02
	MOV A, #$02
	MOV $20, #$1D
	MOV $21, #$F2
	CALL CODE_13D5
	MOV X, #$06
	MOV A, #$01
	MOV $20, #$20
	MOV $21, #$F4
	CALL CODE_13D5
	MOV X, #$0A
	MOV A, #$01
	MOV $20, #$22
	MOV $21, #$F4
	CALL CODE_13D5
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_2380:
	MOV X, #$02
	CALL CODE_13EA
	MOV X, #$04
	CALL CODE_13EA
	MOV X, #$06
	CALL CODE_13EA
	MOV X, #$0A
	CALL CODE_13EA
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_2397:
	CALL CODE_118F
	CMP A, #$00
	BEQ CODE_23A3
	CMP A, #$04
	BEQ CODE_23A6
	RET

CODE_23A3:
	JMP CODE_1260

CODE_23A6:
	MOV X, #$0A
	MOV A, #$C8
	CALL CODE_13F5
	MOV X, #$0C
	MOV A, #$C8
	JMP CODE_13F5

;--------------------------------------------------------------------

CODE_23B4:
	CALL CODE_23CB
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_23BA:
	MOV X, #$0A
	MOV A, #$00
	CALL CODE_13F5
	MOV X, #$0C
	MOV A, #$00
	CALL CODE_13F5
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_23CB:
	MOV A, $04
	CMP A, #$1C
	BNE CODE_23D6
	MOV A, #$02
	CALL CODE_076C
CODE_23D6:
	RET

CODE_23D7:
	CALL CODE_23CB
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_23DD:
	CALL CODE_118F
	CMP A, #$00
	BEQ CODE_23E9
	CMP A, #$03
	BEQ CODE_23EC
	RET

CODE_23E9:
	JMP CODE_1260

CODE_23EC:
	MOV A, #$F9
	CALL CODE_13EE
	MOV A, #$0C
	JMP CODE_13BD

;--------------------------------------------------------------------

CODE_23F6:
	MOV A, #$00
	CALL CODE_13EE
	CALL CODE_13C6
	JMP CODE_2255

;--------------------------------------------------------------------

CODE_2401:
	MOV A, $18
	AND A, #$01
	BEQ CODE_2411
	JMP CODE_1EDF

;--------------------------------------------------------------------

CODE_240A:
	MOV A, #$04D8
	MOV Y, #$04D8>>8
	JMP CODE_12A0

;--------------------------------------------------------------------

CODE_2411:
	MOV A, #DATA_241E
	MOV Y, #DATA_241E>>8
	CALL CODE_0F09
	MOV A, $18
	MOV $047E, A
	RET

DATA_241E:
	db $1D,$77,$CA,$38,$C9,$4B,$9A,$00

;--------------------------------------------------------------------

CODE_2426:
	MOV A, #DATA_242D
	MOV Y, #DATA_242D>>8
	JMP CODE_12A0

DATA_242D:
	db $20,$1D,$1B,$FF,$CA,$90,$00

;--------------------------------------------------------------------

CODE_2434:
	MOV A, #DATA_243B
	MOV Y, #DATA_243B>>8
	JMP CODE_12A0

DATA_243B:
	db $35,$33,$21,$D0,$CA,$84,$00

;--------------------------------------------------------------------

CODE_2442:
	CALL CODE_118F
	BEQ CODE_2448
	RET

CODE_2448:
	JMP CODE_1260

;--------------------------------------------------------------------

CODE_244B:
	MOV $2A, #$0478
	MOV $2B, #$0478>>8
	MOV X, #$03
	MOV A, #$7F
	MOV Y, #$80
	MOV $20, #$0E
CODE_245A:
	MOV $04D6, A
	MOV A, Y
	MOV $04D7, A
	MOV A, $20
	MOV $04DF, A
	MOV $2E, X
	MOV A, $04B0+x
	MOV $2D, A
	BEQ CODE_247E
	MOV $04B4+x, A
	MOV $20, A
	MOV A, $2A
	MOV Y, $2B
	CALL CODE_24B1
	JMP CODE_12A0

CODE_247E:
	MOV A, $04B4+x
	CMP A, #$00
	BNE CODE_2486
	RET

CODE_2486:
	CALL CODE_118F
	BEQ CODE_248C
	RET

CODE_248C:
	JMP CODE_1260

CODE_248F:
	MOV $2A, #$0468
	MOV $2B, #$0468>>8
	MOV X, #$01
	MOV A, #$DF
	MOV Y, #$20
	MOV $20, #$0A
	BNE CODE_245A				; Note: This will always branch.

CODE_24A0:
	MOV $2A, #$0470
	MOV $2B, #$0470>>8
	MOV X, #$02
	MOV A, #$BF
	MOV Y, #$40
	MOV $20, #$0C
	BNE CODE_245A				; Note: This will always branch.

;--------------------------------------------------------------------

CODE_24B1:
	PUSH A
	PUSH X
	PUSH Y
	MOVW $22, YA
	MOV A, #$00
	MOV $04AF, A
	MOV Y, #$02
	MOV A, $20
	LSR A
	LSR A
	LSR A
	LSR A
	MOV X, A
	CMP A, #$00
	BNE CODE_24DB
	MOV A, $20
	CLRC
	ADC A, #$0F
	MOV X, A
	MOV $04AF, A
	CMP A, #$0C
	BNE CODE_24DB
	CALL CODE_1244
	CALL CODE_1236
CODE_24DB:
	DEC X
	MOV $28, X
	MOV A, DATA_254C+x
	MOV ($22)+y, A
	INC Y
	MOV A, DATA_256A+x
	MOV ($22)+y, A
	INC Y
	MOV A, DATA_2588+x
	MOV ($22)+y, A
	INC Y
	MOV A, DATA_25A6+x
	MOV $21, A
	MOV A, $20
	AND A, #$0F
	MOV X, A
	DEC X
	MOV $29, A
	MOV A, X
	CLRC
	ADC A, $21
	MOV X, A
	MOV A, DATA_25C4+x
	MOV ($22)+y, A
	INC Y
	MOV X, $28
	MOV A, DATA_2687+x
	MOV ($22)+y, A
	CMP X, #$0C
	BNE CODE_251F
	MOV A, $29
	CMP A, #$07
	BCC CODE_251F
	MOV A, #$10
	MOV Y, #$02
	MOV ($22)+y, A
CODE_251F:
	MOV Y, #$00
	MOV A, $04AF
	BNE CODE_2534
	MOV A, #$32
CODE_2528:
	MOV ($22)+y, A
	INC Y
	MOV A, DATA_26A5+x
	MOV ($22)+y, A
	POP Y
	POP X
	POP A
	RET

CODE_2534:
	CMP A, #$1E
	BEQ CODE_2544
	CMP A, #$10
	BEQ CODE_2548
	CMP A, #$1B
	BEQ CODE_2548
	MOV A, #$19
	BNE CODE_2528				; Note: This will always branch.

CODE_2544:
	MOV A, #$30
	BNE CODE_2528				; Note: This will always branch.

CODE_2548:
	MOV A, #$30
	BNE CODE_2528				; Note: This will always branch.

DATA_254C:
	db $0D,$01,$0F,$04,$0C,$08,$03,$02
	db $07,$09,$0E,$06,$00,$05,$0A,$10
	db $12,$16,$13,$16,$12,$12,$12,$12
	db $12,$16,$10,$12,$12,$16

DATA_256A:
	db $FF,$E0,$FF,$80,$C0,$80,$FF,$EE
	db $D8,$FF,$D0,$E0,$FF,$50,$F8,$FF
	db $FF,$E0,$FF,$FF,$FF,$FF,$FF,$FF
	db $FF,$B0,$FF,$FF,$FF,$E0

DATA_2588:
	db $CA,$CD,$CA,$CA,$CA,$CA,$CA,$CA
	db $CA,$CA,$CA,$CA,$C7,$CA,$CA,$CA
	db $CA,$CA,$CA,$CA,$CA,$CA,$CA,$CA
	db $CA,$CA,$CA,$CA,$CA,$CA

DATA_25A6:
	db $27,$41,$00,$82,$1A,$1A,$0D,$4E
	db $0D,$1A,$8F,$0D,$68,$0D,$00,$00
	db $5B,$1A,$5B,$5B,$5B,$5B,$1A,$5B
	db $5B,$75,$9C,$5B,$5B,$00

DATA_25C4:
	db $8B,$8C,$8E,$90,$91,$93,$95,$97
	db $98,$9A,$9C,$9D,$9F,$97,$98,$9A
	db $9C,$9D,$9F,$A1,$A3,$A4,$A6,$A8
	db $A9,$AB,$A3,$A4,$A6,$A8,$A9,$AB
	db $AD,$AF,$B0,$B2,$B4,$B5,$B7,$AF
	db $B0,$B2,$B4,$B5,$B7,$B9,$BB,$BC
	db $BE,$C0,$C1,$C3,$BB,$BC,$BE,$C0
	db $C1,$C3,$C5,$C7,$BC,$BE,$C0,$C1
	db $8C,$8B,$8C,$8E,$90,$93,$97,$9A
	db $9D,$A1,$A4,$AB,$B0,$BC,$A1,$A2
	db $A4,$A6,$A7,$A9,$AB,$AD,$AE,$B0
	db $B2,$B3,$B5,$AB,$B9,$AD,$B7,$B5
	db $B0,$B2,$B0,$B5,$B0,$B5,$AB,$AB
	db $A1,$A4,$A6,$A8,$A9,$AB,$93,$98
	db $9F,$A4,$A8,$AB,$B0,$BE,$A9,$AB
	db $AD,$AE,$B0,$B2,$B4,$B5,$B7,$B9
	db $C7,$BC,$A8,$A9,$AB,$AD,$AE,$B0
	db $B2,$B4,$B5,$B7,$B9,$BA,$BC,$9B
	db $9C,$9E,$A0,$A1,$A3,$A5,$A7,$A8
	db $AA,$AC,$AD,$AF,$C5,$93,$95,$97
	db $98,$9A,$9C,$9D,$9F,$A1,$A3,$8C
	db $A6,$C5,$B7,$B9,$BB,$BC,$BE,$C0
	db $C1,$C3,$C5,$C7,$BC,$BE,$C5,$B5
	db $B7,$B9,$BB,$BC,$BE,$C0,$C1,$C3
	db $C5,$C7,$BC

DATA_2687:
	db $80,$00,$00,$00,$00,$20,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$F0,$00
	db $00,$00,$F0,$00,$00,$00

DATA_26A5:
	db $0D,$2D,$2F,$20,$0D,$09,$2D,$2D
	db $2D,$2D,$2D,$2D,$20,$25,$20,$33
	db $12,$33,$12,$12,$12,$12,$12,$12
	db $12,$12,$30,$12,$12,$23,$00,$30
	db $00,$30,$89,$30,$05,$36,$96,$3E
	db $F2,$43,$40,$46,$00,$30,$5C,$38
	db $0B,$3C,$C1,$40,$C1,$40,$C1,$40
	db $95,$46,$3A,$47,$0A,$49,$8B,$4A
	db $D3,$4B,$B6,$4C,$BB,$4E,$8C,$50
	db $E3,$51,$90,$53,$C9,$54,$F4,$54
	db $3A,$49,$15,$38,$C2,$39,$C8,$55
	db $03,$4C,$3A,$47,$6C,$3B,$EA,$3C
	db $18,$3E

;--------------------------------------------------------------------

CODE_2707:
	MOV A, #$7E
	MOV $04D3, A
	MOV A, #$10
	MOV $04D2, A
	MOV A, #$0F
	MOV $04D1, A
	MOV A, #$23
	MOV $04D4, A
	RET
%SPCDataBlockEnd(0500)

%SPCDataBlockStart(3000)
DATA_3000:
	incbin "Music/TitleScreenMusicData.bin"
%SPCDataBlockEnd(3000)

;%EndSPCUploadAndJumpToEngine($0500)
