
; Note:
; Pointer table start address (ignoring header) = $179042
; Pointer table end address (ignoring header) = $179062
; Start of sample data (ignoring header) = $179066
; Size of sample data (ignoring header) = $5750

%SPCDataBlockStart(6E00)
DATA_6E00:
	db $00,$FF,$EC,$B8,$01,$30,$01,$FF,$EF,$B8,$02,$B0,$02,$FF,$EE,$B8
	db $08,$30,$03,$FF,$E0,$B8,$03,$20,$04,$FF,$E0,$B8,$01,$00
%SPCDataBlockEnd(6E00)

%SPCDataBlockStart(6F00)
DATA_6F00:
	db $32,$65,$7F,$98,$B2,$CB,$E5,$FC,$19,$32,$4C,$65,$72,$7F,$8C,$98
	db $A5,$B2,$BF,$CB,$D8,$E5,$F2,$FC
%SPCDataBlockEnd(6F00)

%SPCDataBlockStart(6C00)
DATA_6C00:
	dw DATA_7000	:	dw DATA_7000+$077D
	dw DATA_7F8A	:	dw DATA_7F8A+$085E
	dw DATA_96D9	:	dw DATA_96D9+$045C
	dw DATA_A80A	:	dw DATA_A80A+$1F26
	dw DATA_C730	:	dw DATA_C730+$0012
	dw $FFFF	:	dw $FFFF
	dw $FFFF	:	dw $FFFF
	dw $FFFF	:	dw $FFFF
%SPCDataBlockEnd(6C00)

%SPCDataBlockStart(7000)
DATA_7000:
	incbin "Samples/Audience/00.brr"

DATA_7F8A:
	incbin "Samples/Audience/01.brr"

DATA_96D9:
	incbin "Samples/Audience/02.brr"

DATA_A80A:
	incbin "Samples/Audience/03.brr"

DATA_C730:
	incbin "Samples/Audience/04.brr"
%SPCDataBlockEnd(7000)

%EndSPCUploadAndJumpToEngine($0800)
