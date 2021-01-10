
!RAM_MPAINT_Canvas_CurrentPaletteRowLo = $0000A6
!RAM_MPAINT_Canvas_CurrentPaletteRowHi = !RAM_MPAINT_Canvas_CurrentPaletteRowLo+$001

; $0000B8 - Spray Can Tool Selected

!RAM_MPAINT_Global_HeldButtonsLoP1 = $000132
!RAM_MPAINT_Global_HeldButtonsHiP1 = !RAM_MPAINT_Global_HeldButtonsLoP1+$01
!RAM_MPAINT_Global_HeldButtonsLoP2 = $000134
!RAM_MPAINT_Global_HeldButtonsHiP2 = !RAM_MPAINT_Global_HeldButtonsLoP2+$01

!RAM_MPAINT_Global_PressedButtonsLoP1 = $00013A
!RAM_MPAINT_Global_PressedButtonsHiP1 = !RAM_MPAINT_Global_HeldButtonsLoP1+$01
!RAM_MPAINT_Global_PressedButtonsLoP2 = $00013C
!RAM_MPAINT_Global_PressedButtonsHiP2 = !RAM_MPAINT_Global_PressedButtonsLoP2+$01

!RAM_MPAINT_Global_DisableButtonsLoP1 = $00014A
!RAM_MPAINT_Global_DisableButtonsHiP1 = !RAM_MPAINT_Global_DisableButtonsLoP1+$01
!RAM_MPAINT_Global_DisableButtonsLoP2 = $00014C
!RAM_MPAINT_Global_DisableButtonsHiP2 = !RAM_MPAINT_Global_DisableButtonsLoP2+$01

; $000182 = DMA table

!RAM_MPAINT_Global_OAMBuffer = $000226

!RAM_MPAINT_Global_MouseXDisplacementLo = $0004C6
!RAM_MPAINT_Global_MouseXDisplacementHi = !RAM_MPAINT_Global_MouseXDisplacementLo+$01
!RAM_MPAINT_Global_MouseYDisplacementLo = $0004C8
!RAM_MPAINT_Global_MouseYDisplacementHi = !RAM_MPAINT_Global_MouseYDisplacementLo+$01


!RAM_MPAINT_Global_CursorXPosLo = $0004DC
!RAM_MPAINT_Global_CursorXPosHi = !RAM_MPAINT_Global_CursorXPosLo+$01
!RAM_MPAINT_Global_CursorYPosLo = $0004DE
!RAM_MPAINT_Global_CursorYPosHi = !RAM_MPAINT_Global_CursorYPosLo+$01

!RAM_MPAINT_Global_DemoActiveFlag = $0004E2

; $0009A7 = Something related to the clock cursor.

!RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top = $000F44
!RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Bottom = !RAM_MPAINT_Global_SelectedTilePreviewGFXBuffer_Top+$60

!RAM_MPAINT_SpecialStamps_StampGFXBuffer = $00101C

!RAM_MPAINT_Global_CustomStampDisplayGFXBuffer = $001144

!RAM_MPAINT_Canvas_EraseToolSelected = $001992

!RAM_MPAINT_Canvas_EraseToolSize = $001994

!RAM_MPAINT_Canvas_AnimationCellGFXBuffer = $7E4000
!RAM_MPAINT_Canvas_CanvasGFXBuffer = $7EA000

!RAM_MPAINT_TitleScreen_CreditsLineIndex = $7F020D

!RAM_MPAINT_TitleScreen_WaitBeforeDisplayingNextCreditsLine = $7F020F

!RAM_MPAINT_TitleScreen_WaitBeforeStartingDemo = $7F0411

struct MPAINT_Global_OAMBuffer !RAM_MPAINT_Global_OAMBuffer
	.XDisp: skip $01
	.YDisp: skip $01
	.Tile: skip $01
	.Prop: skip $01
endstruct align $04

struct MPAINT_Global_UpperOAMBuffer !RAM_MPAINT_Global_OAMBuffer+$0200
	.Slot: skip $01
endstruct align $01
