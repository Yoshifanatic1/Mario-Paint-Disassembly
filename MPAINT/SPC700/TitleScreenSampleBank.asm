
; Note:
; Pointer table start address (ignoring header) = $18B2A2
; Pointer table end address (ignoring header) = $18B322
; Start of sample data (ignoring header) = $18B326
; Size of sample data (ignoring header) = $7F00

%SPCDataBlockStart(6E00)
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
	db $32,$65,$7F,$98,$B2,$CB,$E5,$FC,$19,$32,$4C,$65,$72,$7F,$8C,$98
	db $A5,$B2,$BF,$CB,$D8,$E5,$F2,$FC
%SPCDataBlockEnd(6F00)

%SPCDataBlockStart(6C00)
DATA_6C00:
	dw DATA_7000	:	dw DATA_7000+$0012
	dw DATA_701B	:	dw DATA_701B+$034E
	dw DATA_73A8	:	dw DATA_73A8+$00A2
	dw DATA_744A	:	dw DATA_744A+$01D4
	dw DATA_76B7	:	dw DATA_76B7+$0087
	dw DATA_776B	:	dw DATA_776B+$04C8
	dw DATA_7C33	:	dw DATA_7C33+$04C8
	dw DATA_810D	:	dw DATA_810D+$0012
	dw DATA_8128	:	dw DATA_8128+$0012
	dw DATA_8143	:	dw DATA_8143+$0012
	dw DATA_815E	:	dw DATA_815E+$0012
	dw DATA_8179	:	dw DATA_8179+$0012
	dw DATA_8194	:	dw DATA_8194+$0012
	dw DATA_81AF	:	dw DATA_81AF+$0012
	dw DATA_81CA	:	dw DATA_81CA+$0012
	dw DATA_81E5	:	dw DATA_81E5+$0012
	dw DATA_8200	:	dw DATA_8200+$0D92
	dw DATA_8F92	:	dw DATA_8F92+$03D5
	dw DATA_9367	:	dw DATA_9367+$0171
	dw DATA_962E	:	dw DATA_962E+$11E5
	dw DATA_A813	:	dw DATA_A813+$04D1
	dw DATA_AD62	:	dw DATA_AD62+$0900
	dw DATA_B662	:	dw DATA_B662+$0306
	dw DATA_B968	:	dw DATA_B968+$00D8
	dw DATA_BD6A	:	dw DATA_BD6A+$0240
	dw DATA_BFAA	:	dw DATA_BFAA+$081F
	dw DATA_C7C9	:	dw DATA_C7C9+$0E4F
	dw DATA_D741	:	dw DATA_D741+$0900
	dw DATA_E2F6	:	dw DATA_E2F6+$0120
	dw DATA_E431	:	dw DATA_E431+$001B
	dw DATA_E467	:	dw DATA_E467+$0A7A
	dw DATA_EEE1	:	dw DATA_EEE1+$0012
%SPCDataBlockEnd(6C00)

%SPCDataBlockStart(7000)
DATA_7000:
	incbin "Samples/TitleScreen/00.brr"

DATA_701B:
	incbin "Samples/TitleScreen/01.brr"

DATA_73A8:
	incbin "Samples/TitleScreen/02.brr"

DATA_744A:
	incbin "Samples/TitleScreen/03.brr"

DATA_76B7:
	incbin "Samples/TitleScreen/04.brr"

DATA_776B:
	incbin "Samples/TitleScreen/05.brr"

DATA_7C33:
	incbin "Samples/TitleScreen/06.brr"

DATA_810D:
	incbin "Samples/TitleScreen/07.brr"

DATA_8128:
	incbin "Samples/TitleScreen/08.brr"

DATA_8143:
	incbin "Samples/TitleScreen/09.brr"

DATA_815E:
	incbin "Samples/TitleScreen/0A.brr"

DATA_8179:
	incbin "Samples/TitleScreen/0B.brr"

DATA_8194:
	incbin "Samples/TitleScreen/0C.brr"

DATA_81AF:
	incbin "Samples/TitleScreen/0D.brr"

DATA_81CA:
	incbin "Samples/TitleScreen/0E.brr"

DATA_81E5:
	incbin "Samples/TitleScreen/0F.brr"

DATA_8200:
	incbin "Samples/TitleScreen/10.brr"

DATA_8F92:
	incbin "Samples/TitleScreen/11.brr"

DATA_9367:
	incbin "Samples/TitleScreen/12.brr"

DATA_962E:
	incbin "Samples/TitleScreen/13.brr"

DATA_A813:
	incbin "Samples/TitleScreen/14.brr"

DATA_AD62:
	incbin "Samples/TitleScreen/15.brr"

DATA_B662:
	incbin "Samples/TitleScreen/16.brr"

DATA_B968:
	incbin "Samples/TitleScreen/17.brr"

DATA_BD6A:
	incbin "Samples/TitleScreen/18.brr"

DATA_BFAA:
	incbin "Samples/TitleScreen/19.brr"

DATA_C7C9:
	incbin "Samples/TitleScreen/1A.brr"

DATA_D741:
	incbin "Samples/TitleScreen/1B.brr"

DATA_E2F6:
	incbin "Samples/TitleScreen/1C.brr"

DATA_E431:
	incbin "Samples/TitleScreen/1D.brr"

DATA_E467:
	incbin "Samples/TitleScreen/1E.brr"

DATA_EEE1:
	incbin "Samples/TitleScreen/1F.brr"
%SPCDataBlockEnd(7000)

%EndSPCUploadAndJumpToEngine($0500)
