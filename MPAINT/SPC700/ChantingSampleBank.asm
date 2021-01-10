
; Note:
; Pointer table start address (ignoring header) = $16802A
; Pointer table end address (ignoring header) = $16803A
; Start of sample data (ignoring header) = $16803E
; Size of sample data (ignoring header) = $8D10

%SPCDataBlockStart(6E00)
DATA_6E00:
	db $00,$FF,$E0,$B8,$01,$E0
%SPCDataBlockEnd(6E00)

%SPCDataBlockStart(6F00)
DATA_6F00:
	db $32,$65,$7F,$98,$B2,$CB,$E5,$FC,$19,$32,$4C,$65,$72,$7F,$8C,$98
	db $A5,$B2,$BF,$CB,$D8,$E5,$F2,$FC
%SPCDataBlockEnd(6F00)

%SPCDataBlockStart(6C00)
DATA_6C00:
	dw DATA_7000	:	dw DATA_7000+$8D0C
	dw $FFFF	:	dw $FFFF
	dw $FFFF	:	dw $FFFF
	dw $FFFF	:	dw $FFFF
%SPCDataBlockEnd(6C00)

%SPCDataBlockStart(7000)
DATA_7000:
	incbin "Samples/Chanting/00.brr"
%SPCDataBlockEnd(7000)

%EndSPCUploadAndJumpToEngine($0800)
