
; Note:
; Pointer table start address (ignoring header) = $1E9FAC
; Pointer table end address (ignoring header) = $1EA02C
; Start of sample data (ignoring header) = $1EA030
; Size of sample data (ignoring header) = $8A90

%SPCDataBlockStart(3000)
DATA_3000:
	incbin "Music/FlySwattingMusicData.bin"
%SPCDataBlockEnd(3000)

%SPCDataBlockStart(6E00)
DATA_6E00:
	db $00,$FF,$EB,$B8,$1D,$F0,$01,$FF,$F2,$B8,$03,$00,$02,$FF,$E0,$B8
	db $01,$30,$03,$FF,$E9,$B8,$06,$F0,$04,$FF,$E0,$B8,$07,$A0,$05,$FF
	db $E0,$B8,$07,$A0,$06,$FF,$E0,$B8,$06,$F0,$07,$FF,$E0,$B8,$02,$00
	db $08,$FF,$E0,$B8,$02,$80,$09,$FF,$E0,$B8,$07,$A0,$0A,$FF,$E0,$B8
	db $07,$A0,$0B,$FF,$E0,$B8,$09,$F0,$0C,$FF,$E7,$B8,$04,$F0,$0D,$FF
	db $E0,$B8,$01,$00,$0E,$FF,$E0,$B8,$01,$00,$0F,$FF,$E0,$B8,$01,$00
	db $10,$FF,$E0,$B8,$04,$60,$11,$FF,$E0,$B8,$04,$70,$12,$FF,$E0,$B8
	db $04,$E0,$13,$FF,$E0,$B8,$03,$B0,$14,$FF,$E0,$B8,$05,$40,$15,$FF
	db $E0,$B8,$07,$A0,$16,$FF,$E0,$B8,$03,$90,$17,$FF,$E0,$B8,$01,$E0
	db $18,$FF,$F2,$B8,$01,$20,$19,$FF,$F1,$B8,$03,$F0,$1A,$FF,$E0,$B8
	db $04,$D0,$1B,$8F,$E0,$B8,$07,$A0,$1C,$FF,$E0,$B8,$02,$F0,$1D,$FF
	db $E0,$B8,$07,$A0,$1E,$8F,$E0,$B8,$01,$E0
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
	dw DATA_8F80	:	dw DATA_8F80+$0012
	dw DATA_8F9B	:	dw DATA_8F9B+$0012
	dw DATA_8FB6	:	dw DATA_8FB6+$03D5
	dw DATA_938B	:	dw DATA_938B+$07BC
	dw DATA_9B47	:	dw DATA_9B47+$05C4
	dw DATA_A10B	:	dw DATA_A10B+$0306
	dw DATA_A411	:	dw DATA_A411+$0306
	dw DATA_A717	:	dw DATA_A717+$0438
	dw DATA_AB4F	:	dw DATA_AB4F+$0BA3
	dw DATA_B6F2	:	dw DATA_B6F2+$0F93
	dw DATA_C685	:	dw DATA_C685+$0546
	dw DATA_CC1C	:	dw DATA_CC1C+$04B6
	dw DATA_D0F6	:	dw DATA_D0F6+$0132
	dw DATA_D228	:	dw DATA_D228+$09E1
	dw DATA_DC09	:	dw DATA_DC09+$0BA3
	dw DATA_E7AC	:	dw DATA_E7AC+$0F03
	dw DATA_F6AF	:	dw DATA_F6AF+$03D5
	dw $FFFF	:	dw $FFFF
%SPCDataBlockEnd(6C00)

%SPCDataBlockStart(7000)
DATA_7000:
	incbin "Samples/FlySwatting/00.brr"

DATA_7345:
	incbin "Samples/FlySwatting/01.brr"

DATA_7597:
	incbin "Samples/FlySwatting/02.brr"

DATA_7B6D:
	incbin "Samples/FlySwatting/03.brr"

DATA_7E3D:
	incbin "Samples/FlySwatting/04.brr"

DATA_8086:
	incbin "Samples/FlySwatting/05.brr"

DATA_8128:
	incbin "Samples/FlySwatting/06.brr"

DATA_84B5:
	incbin "Samples/FlySwatting/07.brr"

DATA_857B:
	incbin "Samples/FlySwatting/08.brr"

DATA_86F5:
	incbin "Samples/FlySwatting/09.brr"

DATA_8881:
	incbin "Samples/FlySwatting/0A.brr"

DATA_8AE5:
	incbin "Samples/FlySwatting/0B.brr"

DATA_8EB1:
	incbin "Samples/FlySwatting/0C.brr"

DATA_8F65:
	incbin "Samples/FlySwatting/0D.brr"

DATA_8F80:
	incbin "Samples/FlySwatting/0E.brr"

DATA_8F9B:
	incbin "Samples/FlySwatting/0F.brr"

DATA_8FB6:
	incbin "Samples/FlySwatting/10.brr"

DATA_938B:
	incbin "Samples/FlySwatting/11.brr"

DATA_9B47:
	incbin "Samples/FlySwatting/12.brr"

DATA_A10B:
	incbin "Samples/FlySwatting/13.brr"

DATA_A411:
	incbin "Samples/FlySwatting/14.brr"

DATA_A717:
	incbin "Samples/FlySwatting/15.brr"

DATA_AB4F:
	incbin "Samples/FlySwatting/16.brr"

DATA_B6F2:
	incbin "Samples/FlySwatting/17.brr"

DATA_C685:
	incbin "Samples/FlySwatting/18.brr"

DATA_CC1C:
	incbin "Samples/FlySwatting/19.brr"

DATA_D0F6:
	incbin "Samples/FlySwatting/1A.brr"

DATA_D228:
	incbin "Samples/FlySwatting/1B.brr"

DATA_DC09:
	incbin "Samples/FlySwatting/1C.brr"

DATA_E7AC:
	incbin "Samples/FlySwatting/1D.brr"

DATA_F6AF:
	incbin "Samples/FlySwatting/1E.brr"
%SPCDataBlockEnd(7000)

%EndSPCUploadAndJumpToEngine($0800)
