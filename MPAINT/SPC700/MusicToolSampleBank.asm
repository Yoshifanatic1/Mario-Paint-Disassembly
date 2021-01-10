
; Note:
; Pointer table start address (ignoring header) = $1C80AE
; Pointer table end address (ignoring header) = $1C810E
; Start of sample data (ignoring header) = $1C8112
; Size of sample data (ignoring header) = $8F60

%SPCDataBlockStart(6E00)
DATA_6E00:
	db $00,$FF,$F4,$B8,$07,$A0,$01,$8F,$E0,$B8,$07,$A0,$02,$FF,$E0,$B8
	db $07,$A0,$03,$FF,$E0,$B8,$03,$20,$04,$FF,$F5,$B8,$03,$00,$05,$8F
	db $E0,$B8,$09,$F0,$06,$FF,$F1,$B8,$05,$F0,$07,$FF,$E0,$B8,$03,$E0
	db $08,$FF,$E7,$B8,$04,$F0,$09,$8F,$F1,$B8,$07,$A0,$0A,$FF,$F1,$B8
	db $1F,$F0,$0B,$FF,$E0,$B8,$01,$00,$0C,$8F,$F5,$B8,$03,$00,$0D,$FF
	db $F4,$B8,$01,$60,$0E,$FF,$E0,$B8,$07,$10,$0F,$FF,$E0,$B8,$07,$A0
	db $10,$FF,$E0,$B8,$03,$10,$11,$FF,$E0,$B8,$01,$00,$12,$FF,$E0,$B8
	db $04,$50,$13,$FF,$E0,$B8,$02,$30,$14,$FF,$E0,$B8,$01,$00,$15,$FF
	db $E0,$B8,$01,$00,$16,$FF,$E0,$B8,$04,$80
%SPCDataBlockEnd(6E00)

%SPCDataBlockStart(6F00)
DATA_6F00:
	db $32,$65,$7F,$98,$B2,$CB,$E5,$FC,$19,$32,$4C,$65,$72,$7F,$8C,$98
	db $A5,$B2,$BF,$CB,$D8,$E5,$F2,$FC
%SPCDataBlockEnd(6F00)

%SPCDataBlockStart(6C00)
DATA_6C00:
	dw DATA_7000	:	dw DATA_7000+$04C8
	dw DATA_74C8	:	dw DATA_74C8+$09E1
	dw DATA_7EA9	:	dw DATA_7EA9+$14E2
	dw DATA_938B	:	dw DATA_938B+$03D5
	dw DATA_9760	:	dw DATA_9760+$0480
	dw DATA_9BFB	:	dw DATA_9BFB+$005A
	dw DATA_9CAF	:	dw DATA_9CAF+$073E
	dw DATA_A423	:	dw DATA_A423+$0306
	dw DATA_A729	:	dw DATA_A729+$0087
	dw DATA_A7DD	:	dw DATA_A7DD+$1194
	dw DATA_B971	:	dw DATA_B971+$08AF
	dw DATA_C340	:	dw DATA_C340+$0012
	dw DATA_C35B	:	dw DATA_C35B+$0522
	dw DATA_C898	:	dw DATA_C898+$01D4
	dw DATA_CB05	:	dw DATA_CB05+$1692
	dw DATA_E197	:	dw DATA_E197+$0A7A
	dw DATA_EC11	:	dw DATA_EC11+$0597
	dw DATA_F1A8	:	dw DATA_F1A8+$0012
	dw DATA_F1C3	:	dw DATA_F1C3+$01DD
	dw DATA_F3A0	:	dw DATA_F3A0+$05C4
	dw DATA_F964	:	dw DATA_F964+$0012
	dw DATA_F97F	:	dw DATA_F97F+$0012
	dw DATA_F99A	:	dw DATA_F99A+$05C4
	dw $FFFF	:	dw $FFFF
%SPCDataBlockEnd(6C00)

%SPCDataBlockStart(7000)
DATA_7000:
	incbin "Samples/MusicTool/00.brr"

DATA_74C8:
	incbin "Samples/MusicTool/01.brr"

DATA_7EA9:
	incbin "Samples/MusicTool/02.brr"

DATA_938B:
	incbin "Samples/MusicTool/03.brr"

DATA_9760:
	incbin "Samples/MusicTool/04.brr"

DATA_9BFB:
	incbin "Samples/MusicTool/05.brr"

DATA_9CAF:
	incbin "Samples/MusicTool/06.brr"

DATA_A423:
	incbin "Samples/MusicTool/07.brr"

DATA_A729:
	incbin "Samples/MusicTool/08.brr"

DATA_A7DD:
	incbin "Samples/MusicTool/09.brr"

DATA_B971:
	incbin "Samples/MusicTool/0A.brr"

DATA_C340:
	incbin "Samples/MusicTool/0B.brr"

DATA_C35B:
	incbin "Samples/MusicTool/0C.brr"

DATA_C898:
	incbin "Samples/MusicTool/0D.brr"

DATA_CB05:
	incbin "Samples/MusicTool/0E.brr"

DATA_E197:
	incbin "Samples/MusicTool/0F.brr"

DATA_EC11:
	incbin "Samples/MusicTool/10.brr"

DATA_F1A8:
	incbin "Samples/MusicTool/11.brr"

DATA_F1C3:
	incbin "Samples/MusicTool/12.brr"

DATA_F3A0:
	incbin "Samples/MusicTool/13.brr"

DATA_F964:
	incbin "Samples/MusicTool/14.brr"

DATA_F97F:
	incbin "Samples/MusicTool/15.brr"

DATA_F99A:
	incbin "Samples/MusicTool/16.brr"
%SPCDataBlockEnd(7000)

%EndSPCUploadAndJumpToEngine($0800)
