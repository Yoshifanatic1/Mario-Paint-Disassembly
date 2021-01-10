
; Note:
; Pointer table start address (ignoring header) = $1AA710
; Pointer table end address (ignoring header) = $1AA7A0
; Start of sample data (ignoring header) = $1AA7A4
; Size of sample data (ignoring header) = $8140

%SPCDataBlockStart(3000)
DATA_3000:
	incbin "Music/MainGameMusicData.bin"
%SPCDataBlockEnd(3000)

%SPCDataBlockStart(6E00)
DATA_6E00:
	db $00,$FF,$EB,$B8,$1D,$F0,$01,$FF,$F2,$B8,$03,$00,$02,$FF,$E0,$B8
	db $01,$30,$03,$FF,$E9,$B8,$06,$F0,$04,$FF,$E0,$B8,$07,$A0,$05,$FF
	db $E0,$B8,$07,$A0,$06,$FF,$E0,$B8,$06,$F0,$07,$FF,$E0,$B8,$02,$00
	db $08,$FF,$E0,$B8,$02,$80,$09,$FF,$E0,$B8,$07,$A0,$0A,$FF,$E0,$B8
	db $07,$A0,$0B,$FF,$E0,$B8,$09,$F0,$0C,$FF,$E7,$B8,$04,$F0,$0D,$FF
	db $E0,$B8,$01,$00,$0E,$FF,$E0,$B8,$02,$10,$0F,$FF,$E0,$B8,$07,$A0
	db $10,$FF,$E0,$B8,$07,$A0,$11,$FF,$E0,$B8,$07,$A0,$12,$FF,$E0,$B8
	db $01,$30,$13,$FF,$F2,$B8,$01,$20,$14,$FF,$E0,$B8,$04,$50,$15,$FF
	db $E0,$B8,$04,$10,$16,$8F,$E0,$B8,$07,$A0,$17,$FF,$F5,$B8,$03,$F0
	db $18,$FF,$E0,$B8,$05,$60,$19,$FF,$E0,$B8,$04,$D0,$1A,$FF,$E0,$B8
	db $03,$30,$1B,$FF,$E0,$B8,$07,$A0,$1C,$FF,$E0,$B8,$02,$90,$1D,$FF
	db $F9,$B8,$04,$50,$1E,$FF,$E0,$B8,$02,$30,$1F,$FF,$E0,$B8,$07,$A0
	db $20,$FF,$E0,$B8,$03,$30,$21,$8F,$E0,$B8,$05,$50
%SPCDataBlockEnd(6E00)

%SPCDataBlockStart(6F00)
DATA_6F00:
	db $32,$65,$7F,$98,$B2,$CB,$E5,$FC,$19,$32,$4C,$65,$72,$7F,$8C,$98
	db $A5,$B2,$BF,$CB,$D8,$E5,$F2,$FC
%SPCDataBlockEnd(6F00)

%SPCDataBlockStart(6C00)
DATA_6C00:
	dw DATA_7000	:	dw DATA_7000+$0237
	dw DATA_7345	:	dw DATA_7345+$0237
	dw DATA_7597	:	dw DATA_7597+$03D5
	dw DATA_7B6D	:	dw DATA_7B6D+$0291
	dw DATA_7E3D	:	dw DATA_7E3D+$0249
	dw DATA_8086	:	dw DATA_8086+$00A2
	dw DATA_8128	:	dw DATA_8128+$034E
	dw DATA_84B5	:	dw DATA_84B5+$00B4
	dw DATA_857B	:	dw DATA_857B+$014D
	dw DATA_86F5	:	dw DATA_86F5+$018C
	dw DATA_8881	:	dw DATA_8881+$0264
	dw DATA_8AE5	:	dw DATA_8AE5+$0372
	dw DATA_8EB1	:	dw DATA_8EB1+$0087
	dw DATA_8F65	:	dw DATA_8F65+$0012
	dw DATA_8F80	:	dw DATA_8F80+$0117
	dw DATA_9556	:	dw DATA_9556+$0201
	dw DATA_9757	:	dw DATA_9757+$06ED
	dw DATA_9E44	:	dw DATA_9E44+$0489
	dw DATA_A2CD	:	dw DATA_A2CD+$01DD
	dw DATA_A4AA	:	dw DATA_A4AA+$0546
	dw DATA_AA41	:	dw DATA_AA41+$01DD
	dw DATA_AC1E	:	dw DATA_AC1E+$017A
	dw DATA_AD98	:	dw DATA_AD98+$0D2F
	dw DATA_BAC7	:	dw DATA_BAC7+$0129
	dw DATA_BC14	:	dw DATA_BC14+$05C4
	dw DATA_C1D8	:	dw DATA_C1D8+$0132
	dw DATA_C30A	:	dw DATA_C30A+$017A
	dw DATA_C484	:	dw DATA_C484+$0639
	dw DATA_CABD	:	dw DATA_CABD+$07BC
	dw DATA_D279	:	dw DATA_D279+$00AB
	dw DATA_D45F	:	dw DATA_D45F+$05C4
	dw DATA_DA23	:	dw DATA_DA23+$0693
	dw DATA_E0B6	:	dw DATA_E0B6+$05C4
	dw DATA_E67A	:	dw DATA_E67A+$0AC2
	dw $FFFF	:	dw $FFFF
	dw $FFFF	:	dw $FFFF
%SPCDataBlockEnd(6C00)

%SPCDataBlockStart(7000)
DATA_7000:
	incbin "Samples/Main/00.brr"

DATA_7345:
	incbin "Samples/Main/01.brr"

DATA_7597:
	incbin "Samples/Main/02.brr"

DATA_7B6D:
	incbin "Samples/Main/03.brr"

DATA_7E3D:
	incbin "Samples/Main/04.brr"

DATA_8086:
	incbin "Samples/Main/05.brr"

DATA_8128:
	incbin "Samples/Main/06.brr"

DATA_84B5:
	incbin "Samples/Main/07.brr"

DATA_857B:
	incbin "Samples/Main/08.brr"

DATA_86F5:
	incbin "Samples/Main/09.brr"

DATA_8881:
	incbin "Samples/Main/0A.brr"

DATA_8AE5:
	incbin "Samples/Main/0B.brr"

DATA_8EB1:
	incbin "Samples/Main/0C.brr"

DATA_8F65:
	incbin "Samples/Main/0D.brr"

DATA_8F80:
	incbin "Samples/Main/0E.brr"

DATA_9556:
	incbin "Samples/Main/0F.brr"

DATA_9757:
	incbin "Samples/Main/10.brr"

DATA_9E44:
	incbin "Samples/Main/11.brr"

DATA_A2CD:
	incbin "Samples/Main/12.brr"

DATA_A4AA:
	incbin "Samples/Main/13.brr"

DATA_AA41:
	incbin "Samples/Main/14.brr"

DATA_AC1E:
	incbin "Samples/Main/15.brr"

DATA_AD98:
	incbin "Samples/Main/16.brr"

DATA_BAC7:
	incbin "Samples/Main/17.brr"

DATA_BC14:
	incbin "Samples/Main/18.brr"

DATA_C1D8:
	incbin "Samples/Main/19.brr"

DATA_C30A:
	incbin "Samples/Main/1A.brr"

DATA_C484:
	incbin "Samples/Main/1B.brr"

DATA_CABD:
	incbin "Samples/Main/1C.brr"

DATA_D279:
	incbin "Samples/Main/1D.brr"

DATA_D45F:
	incbin "Samples/Main/1E.brr"

DATA_DA23:
	incbin "Samples/Main/1F.brr"

DATA_E0B6:
	incbin "Samples/Main/20.brr"

DATA_E67A:
	incbin "Samples/Main/21.brr"
%SPCDataBlockEnd(7000)

%EndSPCUploadAndJumpToEngine($0800)
