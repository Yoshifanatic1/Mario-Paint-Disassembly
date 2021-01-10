; Note: This file is used by the ExtractAssets.bat batch script to define where each file is, how large they are, and their filenames.

lorom
;!ROMVer = $0000						; Note: This is set within the batch script
!MPAINT_JU = $0001
!MPAINT_E = $0002

org $008000
MainPointerTableStart:
	dl MainPointerTableStart,MainPointerTableEnd-MainPointerTableStart
	dl GFXPointersStart,(GFXPointersEnd-GFXPointersStart)/$0C
	dl MusicToolDataPointersStart,(MusicToolDataPointersEnd-MusicToolDataPointersStart)/$0C
	dl UnknownDataPointersStart,(UnknownDataPointersEnd-UnknownDataPointersStart)/$0C
	dl MusicPointersStart,(MusicPointersEnd-MusicPointersStart)/$0C
	dl AudienceBRRPointersStart,(AudienceBRRPointersEnd-AudienceBRRPointersStart)/$0C
	dl ChantingBRRPointersStart,(ChantingBRRPointersEnd-ChantingBRRPointersStart)/$0C
	dl FlySwattingBRRPointersStart,(FlySwattingBRRPointersEnd-FlySwattingBRRPointersStart)/$0C
	dl MainBRRPointersStart,(MainBRRPointersEnd-MainBRRPointersStart)/$0C
	dl MusicToolBRRPointersStart,(MusicToolBRRPointersEnd-MusicToolBRRPointersStart)/$0C
	dl TitleScreenBRRPointersStart,(TitleScreenBRRPointersEnd-TitleScreenBRRPointersStart)/$0C
MainPointerTableEnd:

;--------------------------------------------------------------------

GFXPointersStart:
	dl $038000,$03EC00,GFX_038000,GFX_038000End
	dl $03FC00,$048000,GFX_03FC00,GFX_03FC00End
	dl $048000,$048800,GFX_048000,GFX_048000End
	dl $048800,$049000,GFX_048800,GFX_048800End
	dl $049000,$049800,GFX_049000,GFX_049000End
	dl $049800,$04A000,GFX_049800,GFX_049800End
	dl $04A000,$04B000,GFX_04A000,GFX_04A000End
	dl $04B000,$04C000,GFX_04B000,GFX_04B000End
	dl $04C000,$04D000,GFX_04C000,GFX_04C000End
	dl $04D000,$04EA00,GFX_04D000,GFX_04D000End
	dl $04EA00,$04FA00,GFX_04EA00,GFX_04EA00End
	dl $04FA00,$058000,GFX_04FA00,GFX_04FA00End
	dl $058000,$068000,GFX_058000,GFX_058000End
	dl $068000,$078000,GFX_068000,GFX_068000End
	dl $078000,$088000,GFX_078000,GFX_078000End
	dl $088000,$089000,GFX_088000,GFX_088000End
	dl $089000,$089C00,GFX_089000,GFX_089000End
	dl $089C00,$08A000,GFX_089C00,GFX_089C00End
	dl $08A000,$08B000,GFX_08A000,GFX_08A000End
	dl $08B000,$08C000,GFX_08B000,GFX_08B000End
	dl $08C000,$08D000,GFX_08C000,GFX_08C000End
	dl $08D000,$08E000,GFX_08D000,GFX_08D000End
	dl $08E000,$08E600,GFX_08E000,GFX_08E000End
	dl $08E600,$08EE00,GFX_08E600,GFX_08E600End
	dl $08EE00,$08F200,GFX_08EE00,GFX_08EE00End
	dl $08F200,$08FC00,GFX_08F200,GFX_08F200End
	dl $08FC00,$098000,GFX_08FC00,GFX_08FC00End
	dl $098000,$099000,GFX_098000,GFX_098000End
	dl $099000,$09A000,GFX_099000,GFX_099000End
	dl $09A000,$09B000,GFX_09A000,GFX_09A000End
	dl $09B000,$09C000,GFX_09B000,GFX_09B000End
	dl $09C000,$09EC00,GFX_09C000,GFX_09C000End
	dl $09EC00,$09F000,GFX_09EC00,GFX_09EC00End
	dl $09F000,$0A8000,GFX_09F000,GFX_09F000End
	dl $0A8000,$0AC000,GFX_0A8000,GFX_0A8000End
	dl $0AC000,$0B8000,GFX_0AC000,GFX_0AC000End
	dl $0B8000,$0C8000,GFX_0B8000,GFX_0B8000End
	dl $0C8000,$0CE800,GFX_0C8000,GFX_0C8000End
	dl $0D8000,$0DAC00,GFX_0D8000,GFX_0D8000End
	dl $0DAC00,$0DAE00,GFX_0DAC00,GFX_0DAC00End
	dl $0EA000,$0F8000,GFX_0EA000,GFX_0EA000End
	dl $13A000,$148000,GFX_13A000,GFX_13A000End
	dl $14A000,$158000,GFX_14A000,GFX_14A000End
	dl $15A000,$168000,GFX_15A000,GFX_15A000End
GFXPointersEnd:

;--------------------------------------------------------------------

MusicToolDataPointersStart:
	dl $02F310,$02F560,PreComposedMusicToolSong1,PreComposedMusicToolSong1End
	dl $02F560,$02F7B0,PreComposedMusicToolSong2,PreComposedMusicToolSong2End
	dl $02F7B0,$02FA00,PreComposedMusicToolSong3,PreComposedMusicToolSong3End
MusicToolDataPointersEnd:

;--------------------------------------------------------------------

UnknownDataPointersStart:
	dl $178D52,$179000,UNK_178D52,UNK_178D52End
	dl $17E7BA,$188000,UNK_17E7BA,UNK_17E7BAEnd
	dl $19B22A,$1A8000,UNK_19B22A,UNK_19B22AEnd
	dl $1BA8E8,$1C8000,UNK_1BA8E8,UNK_1BA8E8End
	dl $1D9076,$1E8000,UNK_1D9076,UNK_1D9076End
	dl $1FAAC4,$208000,UNK_1FAAC4,UNK_1FAAC4End
UnknownDataPointersEnd:

;--------------------------------------------------------------------

MusicPointersStart:
	dl $18A304,$18B1BE,TitleScreenMusicData,TitleScreenMusicDataEnd
	dl $1A8004,$1AA620,MainGameMusicData,MainGameMusicDataEnd
	dl $1E8004,$1E9ECE,FlySwattingMusicData,FlySwattingMusicDataEnd
MusicPointersEnd:

;--------------------------------------------------------------------

AudienceBRRPointersStart:
	dl $179066,$179FF0,AudienceBRRFile00,AudienceBRRFile00End
	dl $179FF0,$17B73F,AudienceBRRFile01,AudienceBRRFile01End
	dl $17B73F,$17C870,AudienceBRRFile02,AudienceBRRFile02End
	dl $17C870,$17E796,AudienceBRRFile03,AudienceBRRFile03End
	dl $17E796,$17E7B6,AudienceBRRFile04,AudienceBRRFile04End
AudienceBRRPointersEnd:

;--------------------------------------------------------------------

ChantingBRRPointersStart:
	dl $16803E,$178D4E,ChantingBRRFile00,ChantingBRRFile00End
ChantingBRRPointersEnd:

;--------------------------------------------------------------------

FlySwattingBRRPointersStart:
	dl $1EA030,$1EA375,FlySwattingBRRFile00,FlySwattingBRRFile00End
	dl $1EA375,$1EA5C7,FlySwattingBRRFile01,FlySwattingBRRFile01End
	dl $1EA5C7,$1EAB9D,FlySwattingBRRFile02,FlySwattingBRRFile02End
	dl $1EAB9D,$1EAE6D,FlySwattingBRRFile03,FlySwattingBRRFile03End
	dl $1EAE6D,$1EB0B6,FlySwattingBRRFile04,FlySwattingBRRFile04End
	dl $1EB0B6,$1EB158,FlySwattingBRRFile05,FlySwattingBRRFile05End
	dl $1EB158,$1EB4E5,FlySwattingBRRFile06,FlySwattingBRRFile06End
	dl $1EB4E5,$1EB5AB,FlySwattingBRRFile07,FlySwattingBRRFile07End
	dl $1EB5AB,$1EB725,FlySwattingBRRFile08,FlySwattingBRRFile08End
	dl $1EB725,$1EB8B1,FlySwattingBRRFile09,FlySwattingBRRFile09End
	dl $1EB8B1,$1EBB15,FlySwattingBRRFile0A,FlySwattingBRRFile0AEnd
	dl $1EBB15,$1EBEE1,FlySwattingBRRFile0B,FlySwattingBRRFile0BEnd
	dl $1EBEE1,$1EBF95,FlySwattingBRRFile0C,FlySwattingBRRFile0CEnd
	dl $1EBF95,$1EBFB0,FlySwattingBRRFile0D,FlySwattingBRRFile0DEnd
	dl $1EBFB0,$1EBFCB,FlySwattingBRRFile0E,FlySwattingBRRFile0EEnd
	dl $1EBFCB,$1EBFE6,FlySwattingBRRFile0F,FlySwattingBRRFile0FEnd
	dl $1EBFE6,$1EC3BB,FlySwattingBRRFile10,FlySwattingBRRFile10End
	dl $1EC3BB,$1ECB77,FlySwattingBRRFile11,FlySwattingBRRFile11End
	dl $1ECB77,$1ED13B,FlySwattingBRRFile12,FlySwattingBRRFile12End
	dl $1ED13B,$1ED441,FlySwattingBRRFile13,FlySwattingBRRFile13End
	dl $1ED441,$1ED747,FlySwattingBRRFile14,FlySwattingBRRFile14End
	dl $1ED747,$1EDB7F,FlySwattingBRRFile15,FlySwattingBRRFile15End
	dl $1EDB7F,$1EE722,FlySwattingBRRFile16,FlySwattingBRRFile16End
	dl $1EE722,$1EF6B5,FlySwattingBRRFile17,FlySwattingBRRFile17End
	dl $1EF6B5,$1EFC4C,FlySwattingBRRFile18,FlySwattingBRRFile18End
	dl $1EFC4C,$1F8126,FlySwattingBRRFile19,FlySwattingBRRFile19End
	dl $1F8126,$1F8258,FlySwattingBRRFile1A,FlySwattingBRRFile1AEnd
	dl $1F8258,$1F8C39,FlySwattingBRRFile1B,FlySwattingBRRFile1BEnd
	dl $1F8C39,$1F97DC,FlySwattingBRRFile1C,FlySwattingBRRFile1CEnd
	dl $1F97DC,$1FA6DF,FlySwattingBRRFile1D,FlySwattingBRRFile1DEnd
	dl $1FA6DF,$1FAAC0,FlySwattingBRRFile1E,FlySwattingBRRFile1EEnd
FlySwattingBRRPointersEnd:

;--------------------------------------------------------------------

MainBRRPointersStart:
	dl $1AA7A4,$1AAAE9,MainBRRFile00,MainBRRFile00End
	dl $1AAAE9,$1AAD3B,MainBRRFile01,MainBRRFile01End
	dl $1AAD3B,$1AB311,MainBRRFile02,MainBRRFile02End
	dl $1AB311,$1AB5E1,MainBRRFile03,MainBRRFile03End
	dl $1AB5E1,$1AB82A,MainBRRFile04,MainBRRFile04End
	dl $1AB82A,$1AB8CC,MainBRRFile05,MainBRRFile05End
	dl $1AB8CC,$1ABC59,MainBRRFile06,MainBRRFile06End
	dl $1ABC59,$1ABD1F,MainBRRFile07,MainBRRFile07End
	dl $1ABD1F,$1ABE99,MainBRRFile08,MainBRRFile08End
	dl $1ABE99,$1AC025,MainBRRFile09,MainBRRFile09End
	dl $1AC025,$1AC289,MainBRRFile0A,MainBRRFile0AEnd
	dl $1AC289,$1AC655,MainBRRFile0B,MainBRRFile0BEnd
	dl $1AC655,$1AC709,MainBRRFile0C,MainBRRFile0CEnd
	dl $1AC709,$1AC724,MainBRRFile0D,MainBRRFile0DEnd
	dl $1AC724,$1ACCFA,MainBRRFile0E,MainBRRFile0EEnd
	dl $1ACCFA,$1ACEFB,MainBRRFile0F,MainBRRFile0FEnd
	dl $1ACEFB,$1AD5E8,MainBRRFile10,MainBRRFile10End
	dl $1AD5E8,$1ADA71,MainBRRFile11,MainBRRFile11End
	dl $1ADA71,$1ADC4E,MainBRRFile12,MainBRRFile12End
	dl $1ADC4E,$1AE1E5,MainBRRFile13,MainBRRFile13End
	dl $1AE1E5,$1AE3C2,MainBRRFile14,MainBRRFile14End
	dl $1AE3C2,$1AE53C,MainBRRFile15,MainBRRFile15End
	dl $1AE53C,$1AF26B,MainBRRFile16,MainBRRFile16End
	dl $1AF26B,$1AF3B8,MainBRRFile17,MainBRRFile17End
	dl $1AF3B8,$1AF97C,MainBRRFile18,MainBRRFile18End
	dl $1AF97C,$1AFAAE,MainBRRFile19,MainBRRFile19End
	dl $1AFAAE,$1AFC28,MainBRRFile1A,MainBRRFile1AEnd
	dl $1AFC28,$1B8261,MainBRRFile1B,MainBRRFile1BEnd
	dl $1B8261,$1B8A1D,MainBRRFile1C,MainBRRFile1CEnd
	dl $1B8A1D,$1B8C03,MainBRRFile1D,MainBRRFile1DEnd
	dl $1B8C03,$1B91C7,MainBRRFile1E,MainBRRFile1EEnd
	dl $1B91C7,$1B985A,MainBRRFile1F,MainBRRFile1FEnd
	dl $1B985A,$1B9E1E,MainBRRFile20,MainBRRFile20End
	dl $1B9E1E,$1BA8E4,MainBRRFile21,MainBRRFile21End
MainBRRPointersEnd:

;--------------------------------------------------------------------

MusicToolBRRPointersStart:
	dl $1C8112,$1C85DA,MusicToolBRRFile00,MusicToolBRRFile00End
	dl $1C85DA,$1C8FBB,MusicToolBRRFile01,MusicToolBRRFile01End
	dl $1C8FBB,$1CA49D,MusicToolBRRFile02,MusicToolBRRFile02End
	dl $1CA49D,$1CA872,MusicToolBRRFile03,MusicToolBRRFile03End
	dl $1CA872,$1CAD0D,MusicToolBRRFile04,MusicToolBRRFile04End
	dl $1CAD0D,$1CADC1,MusicToolBRRFile05,MusicToolBRRFile05End
	dl $1CADC1,$1CB535,MusicToolBRRFile06,MusicToolBRRFile06End
	dl $1CB535,$1CB83B,MusicToolBRRFile07,MusicToolBRRFile07End
	dl $1CB83B,$1CB8EF,MusicToolBRRFile08,MusicToolBRRFile08End
	dl $1CB8EF,$1CCA83,MusicToolBRRFile09,MusicToolBRRFile09End
	dl $1CCA83,$1CD452,MusicToolBRRFile0A,MusicToolBRRFile0AEnd
	dl $1CD452,$1CD46D,MusicToolBRRFile0B,MusicToolBRRFile0BEnd
	dl $1CD46D,$1CD9AA,MusicToolBRRFile0C,MusicToolBRRFile0CEnd
	dl $1CD9AA,$1CDC17,MusicToolBRRFile0D,MusicToolBRRFile0DEnd
	dl $1CDC17,$1CF2A9,MusicToolBRRFile0E,MusicToolBRRFile0EEnd
	dl $1CF2A9,$1CFD23,MusicToolBRRFile0F,MusicToolBRRFile0FEnd
	dl $1CFD23,$1D82BA,MusicToolBRRFile10,MusicToolBRRFile10End
	dl $1D82BA,$1D82D5,MusicToolBRRFile11,MusicToolBRRFile11End
	dl $1D82D5,$1D84B2,MusicToolBRRFile12,MusicToolBRRFile12End
	dl $1D84B2,$1D8A76,MusicToolBRRFile13,MusicToolBRRFile13End
	dl $1D8A76,$1D8A91,MusicToolBRRFile14,MusicToolBRRFile14End
	dl $1D8A91,$1D8AAC,MusicToolBRRFile15,MusicToolBRRFile15End
	dl $1D8AAC,$1D9072,MusicToolBRRFile16,MusicToolBRRFile16End
MusicToolBRRPointersEnd:

;--------------------------------------------------------------------

TitleScreenBRRPointersStart:
	dl $18B326,$18B341,TitleScreenBRRFile00,TitleScreenBRRFile00End
	dl $18B341,$18B6CE,TitleScreenBRRFile01,TitleScreenBRRFile01End
	dl $18B6CE,$18B770,TitleScreenBRRFile02,TitleScreenBRRFile02End
	dl $18B770,$18B9DD,TitleScreenBRRFile03,TitleScreenBRRFile03End
	dl $18B9DD,$18BA91,TitleScreenBRRFile04,TitleScreenBRRFile04End
	dl $18BA91,$18BF59,TitleScreenBRRFile05,TitleScreenBRRFile05End
	dl $18BF59,$18C433,TitleScreenBRRFile06,TitleScreenBRRFile06End
	dl $18C433,$18C44E,TitleScreenBRRFile07,TitleScreenBRRFile07End
	dl $18C44E,$18C469,TitleScreenBRRFile08,TitleScreenBRRFile08End
	dl $18C469,$18C484,TitleScreenBRRFile09,TitleScreenBRRFile09End
	dl $18C484,$18C49F,TitleScreenBRRFile0A,TitleScreenBRRFile0AEnd
	dl $18C49F,$18C4BA,TitleScreenBRRFile0B,TitleScreenBRRFile0BEnd
	dl $18C4BA,$18C4D5,TitleScreenBRRFile0C,TitleScreenBRRFile0CEnd
	dl $18C4D5,$18C4F0,TitleScreenBRRFile0D,TitleScreenBRRFile0DEnd
	dl $18C4F0,$18C50B,TitleScreenBRRFile0E,TitleScreenBRRFile0EEnd
	dl $18C50B,$18C526,TitleScreenBRRFile0F,TitleScreenBRRFile0FEnd
	dl $18C526,$18D2B8,TitleScreenBRRFile10,TitleScreenBRRFile10End
	dl $18D2B8,$18D68D,TitleScreenBRRFile11,TitleScreenBRRFile11End
	dl $18D68D,$18D954,TitleScreenBRRFile12,TitleScreenBRRFile12End
	dl $18D954,$18EB39,TitleScreenBRRFile13,TitleScreenBRRFile13End
	dl $18EB39,$18F088,TitleScreenBRRFile14,TitleScreenBRRFile14End
	dl $18F088,$18F988,TitleScreenBRRFile15,TitleScreenBRRFile15End
	dl $18F988,$18FC8E,TitleScreenBRRFile16,TitleScreenBRRFile16End
	dl $18FC8E,$198090,TitleScreenBRRFile17,TitleScreenBRRFile17End
	dl $198090,$1982D0,TitleScreenBRRFile18,TitleScreenBRRFile18End
	dl $1982D0,$198AEF,TitleScreenBRRFile19,TitleScreenBRRFile19End
	dl $198AEF,$199A67,TitleScreenBRRFile1A,TitleScreenBRRFile1AEnd
	dl $199A67,$19A61C,TitleScreenBRRFile1B,TitleScreenBRRFile1BEnd
	dl $19A61C,$19A757,TitleScreenBRRFile1C,TitleScreenBRRFile1CEnd
	dl $19A757,$19A78D,TitleScreenBRRFile1D,TitleScreenBRRFile1DEnd
	dl $19A78D,$19B207,TitleScreenBRRFile1E,TitleScreenBRRFile1EEnd
	dl $19B207,$19B226,TitleScreenBRRFile1F,TitleScreenBRRFile1FEnd
TitleScreenBRRPointersEnd:

;--------------------------------------------------------------------

GFX_038000:
	db "GFX_038000.bin"
GFX_038000End:
GFX_03FC00:
	db "GFX_03FC00.bin"
GFX_03FC00End:
GFX_048000:
	db "GFX_048000.bin"
GFX_048000End:
GFX_048800:
	db "GFX_048800.bin"
GFX_048800End:
GFX_049000:
	db "GFX_049000.bin"
GFX_049000End:
GFX_049800:
	db "GFX_049800.bin"
GFX_049800End:
GFX_04A000:
	db "GFX_04A000.bin"
GFX_04A000End:
GFX_04B000:
	db "GFX_04B000.bin"
GFX_04B000End:
GFX_04C000:
	db "GFX_04C000.bin"
GFX_04C000End:
GFX_04D000:
	db "GFX_04D000.bin"
GFX_04D000End:
GFX_04EA00:
	db "GFX_04EA00.bin"
GFX_04EA00End:
GFX_04FA00:
	db "GFX_04FA00.bin"
GFX_04FA00End:
GFX_058000:
	db "GFX_058000.bin"
GFX_058000End:
GFX_068000:
	db "GFX_068000.bin"
GFX_068000End:
GFX_078000:
	db "GFX_078000.bin"
GFX_078000End:
GFX_088000:
	db "GFX_088000.bin"
GFX_088000End:
GFX_089000:
	db "GFX_089000.bin"
GFX_089000End:
GFX_089C00:
	db "GFX_089C00.bin"
GFX_089C00End:
GFX_08A000:
	db "GFX_08A000.bin"
GFX_08A000End:
GFX_08B000:
	db "GFX_08B000.bin"
GFX_08B000End:
GFX_08C000:
	db "GFX_08C000.bin"
GFX_08C000End:
GFX_08D000:
	db "GFX_08D000.bin"
GFX_08D000End:
GFX_08E000:
	db "GFX_08E000.bin"
GFX_08E000End:
GFX_08E600:
	db "GFX_08E600.bin"
GFX_08E600End:
GFX_08EE00:
	db "GFX_08EE00.bin"
GFX_08EE00End:
GFX_08F200:
	db "GFX_08F200.bin"
GFX_08F200End:
GFX_08FC00:
	db "GFX_08FC00.bin"
GFX_08FC00End:
GFX_098000:
	db "GFX_098000.bin"
GFX_098000End:
GFX_099000:
	db "GFX_099000.bin"
GFX_099000End:
GFX_09A000:
	db "GFX_09A000.bin"
GFX_09A000End:
GFX_09B000:
	db "GFX_09B000.bin"
GFX_09B000End:
GFX_09C000:
	db "GFX_09C000.bin"
GFX_09C000End:
GFX_09EC00:
	db "GFX_09EC00.bin"
GFX_09EC00End:
GFX_09F000:
	db "GFX_09F000.bin"
GFX_09F000End:
GFX_0A8000:
	db "GFX_0A8000.bin"
GFX_0A8000End:
GFX_0AC000:
	db "GFX_0AC000.bin"
GFX_0AC000End:
GFX_0B8000:
	db "GFX_0B8000.bin"
GFX_0B8000End:
GFX_0C8000:
	db "GFX_0C8000.bin"
GFX_0C8000End:
GFX_0D8000:
	db "GFX_0D8000.bin"
GFX_0D8000End:
GFX_0DAC00:
	db "GFX_0DAC00.bin"
GFX_0DAC00End:
GFX_0EA000:
	db "GFX_0EA000.bin"
GFX_0EA000End:
GFX_13A000:
	db "GFX_13A000.bin"
GFX_13A000End:
GFX_14A000:
	db "GFX_14A000.bin"
GFX_14A000End:
GFX_15A000:
	db "GFX_15A000.bin"
GFX_15A000End:

;--------------------------------------------------------------------

PreComposedMusicToolSong1:
	db "PreComposedMusicToolSong1.bin"
PreComposedMusicToolSong1End:
PreComposedMusicToolSong2:
	db "PreComposedMusicToolSong2.bin"
PreComposedMusicToolSong2End:
PreComposedMusicToolSong3:
	db "PreComposedMusicToolSong3.bin"
PreComposedMusicToolSong3End:

;--------------------------------------------------------------------

UNK_178D52:
	db "UNK_178D52.bin"
UNK_178D52End:
UNK_17E7BA:
	db "UNK_17E7BA.bin"
UNK_17E7BAEnd:
UNK_19B22A:
	db "UNK_19B22A.bin"
UNK_19B22AEnd:
UNK_1BA8E8:
	db "UNK_1BA8E8.bin"
UNK_1BA8E8End:
UNK_1D9076:
	db "UNK_1D9076.bin"
UNK_1D9076End:
UNK_1FAAC4:
	db "UNK_1FAAC4.bin"
UNK_1FAAC4End:

;--------------------------------------------------------------------

TitleScreenMusicData:
	db "TitleScreenMusicData.bin"
TitleScreenMusicDataEnd:
MainGameMusicData:
	db "MainGameMusicData.bin"
MainGameMusicDataEnd:
FlySwattingMusicData:
	db "FlySwattingMusicData.bin"
FlySwattingMusicDataEnd:

;--------------------------------------------------------------------

AudienceBRRFile00:
	db "00.brr"
AudienceBRRFile00End:
AudienceBRRFile01:
	db "01.brr"
AudienceBRRFile01End:
AudienceBRRFile02:
	db "02.brr"
AudienceBRRFile02End:
AudienceBRRFile03:
	db "03.brr"
AudienceBRRFile03End:
AudienceBRRFile04:
	db "04.brr"
AudienceBRRFile04End:

;--------------------------------------------------------------------

ChantingBRRFile00:
	db "00.brr"
ChantingBRRFile00End:

;--------------------------------------------------------------------

FlySwattingBRRFile00:
	db "00.brr"
FlySwattingBRRFile00End:
FlySwattingBRRFile01:
	db "01.brr"
FlySwattingBRRFile01End:
FlySwattingBRRFile02:
	db "02.brr"
FlySwattingBRRFile02End:
FlySwattingBRRFile03:
	db "03.brr"
FlySwattingBRRFile03End:
FlySwattingBRRFile04:
	db "04.brr"
FlySwattingBRRFile04End:
FlySwattingBRRFile05:
	db "05.brr"
FlySwattingBRRFile05End:
FlySwattingBRRFile06:
	db "06.brr"
FlySwattingBRRFile06End:
FlySwattingBRRFile07:
	db "07.brr"
FlySwattingBRRFile07End:
FlySwattingBRRFile08:
	db "08.brr"
FlySwattingBRRFile08End:
FlySwattingBRRFile09:
	db "09.brr"
FlySwattingBRRFile09End:
FlySwattingBRRFile0A:
	db "0A.brr"
FlySwattingBRRFile0AEnd:
FlySwattingBRRFile0B:
	db "0B.brr"
FlySwattingBRRFile0BEnd:
FlySwattingBRRFile0C:
	db "0C.brr"
FlySwattingBRRFile0CEnd:
FlySwattingBRRFile0D:
	db "0D.brr"
FlySwattingBRRFile0DEnd:
FlySwattingBRRFile0E:
	db "0E.brr"
FlySwattingBRRFile0EEnd:
FlySwattingBRRFile0F:
	db "0F.brr"
FlySwattingBRRFile0FEnd:
FlySwattingBRRFile10:
	db "10.brr"
FlySwattingBRRFile10End:
FlySwattingBRRFile11:
	db "11.brr"
FlySwattingBRRFile11End:
FlySwattingBRRFile12:
	db "12.brr"
FlySwattingBRRFile12End:
FlySwattingBRRFile13:
	db "13.brr"
FlySwattingBRRFile13End:
FlySwattingBRRFile14:
	db "14.brr"
FlySwattingBRRFile14End:
FlySwattingBRRFile15:
	db "15.brr"
FlySwattingBRRFile15End:
FlySwattingBRRFile16:
	db "16.brr"
FlySwattingBRRFile16End:
FlySwattingBRRFile17:
	db "17.brr"
FlySwattingBRRFile17End:
FlySwattingBRRFile18:
	db "18.brr"
FlySwattingBRRFile18End:
FlySwattingBRRFile19:
	db "19.brr"
FlySwattingBRRFile19End:
FlySwattingBRRFile1A:
	db "1A.brr"
FlySwattingBRRFile1AEnd:
FlySwattingBRRFile1B:
	db "1B.brr"
FlySwattingBRRFile1BEnd:
FlySwattingBRRFile1C:
	db "1C.brr"
FlySwattingBRRFile1CEnd:
FlySwattingBRRFile1D:
	db "1D.brr"
FlySwattingBRRFile1DEnd:
FlySwattingBRRFile1E:
	db "1E.brr"
FlySwattingBRRFile1EEnd:

;--------------------------------------------------------------------

MainBRRFile00:
	db "00.brr"
MainBRRFile00End:
MainBRRFile01:
	db "01.brr"
MainBRRFile01End:
MainBRRFile02:
	db "02.brr"
MainBRRFile02End:
MainBRRFile03:
	db "03.brr"
MainBRRFile03End:
MainBRRFile04:
	db "04.brr"
MainBRRFile04End:
MainBRRFile05:
	db "05.brr"
MainBRRFile05End:
MainBRRFile06:
	db "06.brr"
MainBRRFile06End:
MainBRRFile07:
	db "07.brr"
MainBRRFile07End:
MainBRRFile08:
	db "08.brr"
MainBRRFile08End:
MainBRRFile09:
	db "09.brr"
MainBRRFile09End:
MainBRRFile0A:
	db "0A.brr"
MainBRRFile0AEnd:
MainBRRFile0B:
	db "0B.brr"
MainBRRFile0BEnd:
MainBRRFile0C:
	db "0C.brr"
MainBRRFile0CEnd:
MainBRRFile0D:
	db "0D.brr"
MainBRRFile0DEnd:
MainBRRFile0E:
	db "0E.brr"
MainBRRFile0EEnd:
MainBRRFile0F:
	db "0F.brr"
MainBRRFile0FEnd:
MainBRRFile10:
	db "10.brr"
MainBRRFile10End:
MainBRRFile11:
	db "11.brr"
MainBRRFile11End:
MainBRRFile12:
	db "12.brr"
MainBRRFile12End:
MainBRRFile13:
	db "13.brr"
MainBRRFile13End:
MainBRRFile14:
	db "14.brr"
MainBRRFile14End:
MainBRRFile15:
	db "15.brr"
MainBRRFile15End:
MainBRRFile16:
	db "16.brr"
MainBRRFile16End:
MainBRRFile17:
	db "17.brr"
MainBRRFile17End:
MainBRRFile18:
	db "18.brr"
MainBRRFile18End:
MainBRRFile19:
	db "19.brr"
MainBRRFile19End:
MainBRRFile1A:
	db "1A.brr"
MainBRRFile1AEnd:
MainBRRFile1B:
	db "1B.brr"
MainBRRFile1BEnd:
MainBRRFile1C:
	db "1C.brr"
MainBRRFile1CEnd:
MainBRRFile1D:
	db "1D.brr"
MainBRRFile1DEnd:
MainBRRFile1E:
	db "1E.brr"
MainBRRFile1EEnd:
MainBRRFile1F:
	db "1F.brr"
MainBRRFile1FEnd:
MainBRRFile20:
	db "20.brr"
MainBRRFile20End:
MainBRRFile21:
	db "21.brr"
MainBRRFile21End:

;--------------------------------------------------------------------

MusicToolBRRFile00:
	db "00.brr"
MusicToolBRRFile00End:
MusicToolBRRFile01:
	db "01.brr"
MusicToolBRRFile01End:
MusicToolBRRFile02:
	db "02.brr"
MusicToolBRRFile02End:
MusicToolBRRFile03:
	db "03.brr"
MusicToolBRRFile03End:
MusicToolBRRFile04:
	db "04.brr"
MusicToolBRRFile04End:
MusicToolBRRFile05:
	db "05.brr"
MusicToolBRRFile05End:
MusicToolBRRFile06:
	db "06.brr"
MusicToolBRRFile06End:
MusicToolBRRFile07:
	db "07.brr"
MusicToolBRRFile07End:
MusicToolBRRFile08:
	db "08.brr"
MusicToolBRRFile08End:
MusicToolBRRFile09:
	db "09.brr"
MusicToolBRRFile09End:
MusicToolBRRFile0A:
	db "0A.brr"
MusicToolBRRFile0AEnd:
MusicToolBRRFile0B:
	db "0B.brr"
MusicToolBRRFile0BEnd:
MusicToolBRRFile0C:
	db "0C.brr"
MusicToolBRRFile0CEnd:
MusicToolBRRFile0D:
	db "0D.brr"
MusicToolBRRFile0DEnd:
MusicToolBRRFile0E:
	db "0E.brr"
MusicToolBRRFile0EEnd:
MusicToolBRRFile0F:
	db "0F.brr"
MusicToolBRRFile0FEnd:
MusicToolBRRFile10:
	db "10.brr"
MusicToolBRRFile10End:
MusicToolBRRFile11:
	db "11.brr"
MusicToolBRRFile11End:
MusicToolBRRFile12:
	db "12.brr"
MusicToolBRRFile12End:
MusicToolBRRFile13:
	db "13.brr"
MusicToolBRRFile13End:
MusicToolBRRFile14:
	db "14.brr"
MusicToolBRRFile14End:
MusicToolBRRFile15:
	db "15.brr"
MusicToolBRRFile15End:
MusicToolBRRFile16:
	db "16.brr"
MusicToolBRRFile16End:

;--------------------------------------------------------------------

TitleScreenBRRFile00:
	db "00.brr"
TitleScreenBRRFile00End:
TitleScreenBRRFile01:
	db "01.brr"
TitleScreenBRRFile01End:
TitleScreenBRRFile02:
	db "02.brr"
TitleScreenBRRFile02End:
TitleScreenBRRFile03:
	db "03.brr"
TitleScreenBRRFile03End:
TitleScreenBRRFile04:
	db "04.brr"
TitleScreenBRRFile04End:
TitleScreenBRRFile05:
	db "05.brr"
TitleScreenBRRFile05End:
TitleScreenBRRFile06:
	db "06.brr"
TitleScreenBRRFile06End:
TitleScreenBRRFile07:
	db "07.brr"
TitleScreenBRRFile07End:
TitleScreenBRRFile08:
	db "08.brr"
TitleScreenBRRFile08End:
TitleScreenBRRFile09:
	db "09.brr"
TitleScreenBRRFile09End:
TitleScreenBRRFile0A:
	db "0A.brr"
TitleScreenBRRFile0AEnd:
TitleScreenBRRFile0B:
	db "0B.brr"
TitleScreenBRRFile0BEnd:
TitleScreenBRRFile0C:
	db "0C.brr"
TitleScreenBRRFile0CEnd:
TitleScreenBRRFile0D:
	db "0D.brr"
TitleScreenBRRFile0DEnd:
TitleScreenBRRFile0E:
	db "0E.brr"
TitleScreenBRRFile0EEnd:
TitleScreenBRRFile0F:
	db "0F.brr"
TitleScreenBRRFile0FEnd:
TitleScreenBRRFile10:
	db "10.brr"
TitleScreenBRRFile10End:
TitleScreenBRRFile11:
	db "11.brr"
TitleScreenBRRFile11End:
TitleScreenBRRFile12:
	db "12.brr"
TitleScreenBRRFile12End:
TitleScreenBRRFile13:
	db "13.brr"
TitleScreenBRRFile13End:
TitleScreenBRRFile14:
	db "14.brr"
TitleScreenBRRFile14End:
TitleScreenBRRFile15:
	db "15.brr"
TitleScreenBRRFile15End:
TitleScreenBRRFile16:
	db "16.brr"
TitleScreenBRRFile16End:
TitleScreenBRRFile17:
	db "17.brr"
TitleScreenBRRFile17End:
TitleScreenBRRFile18:
	db "18.brr"
TitleScreenBRRFile18End:
TitleScreenBRRFile19:
	db "19.brr"
TitleScreenBRRFile19End:
TitleScreenBRRFile1A:
	db "1A.brr"
TitleScreenBRRFile1AEnd:
TitleScreenBRRFile1B:
	db "1B.brr"
TitleScreenBRRFile1BEnd:
TitleScreenBRRFile1C:
	db "1C.brr"
TitleScreenBRRFile1CEnd:
TitleScreenBRRFile1D:
	db "1D.brr"
TitleScreenBRRFile1DEnd:
TitleScreenBRRFile1E:
	db "1E.brr"
TitleScreenBRRFile1EEnd:
TitleScreenBRRFile1F:
	db "1F.brr"
TitleScreenBRRFile1FEnd:

;--------------------------------------------------------------------
