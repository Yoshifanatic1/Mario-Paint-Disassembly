
macro MPAINT_GameSpecificAssemblySettings()
	!ROM_MPAINT_JU = $0001							;\ These defines assign each ROM version with a different bit so version difference checks will work. Do not touch them!
	!ROM_MPAINT_E = $0002							;/

	%SetROMToAssembleForHack(MPAINT_U, !ROMID)
endmacro

macro MPAINT_LoadGameSpecificMainSNESFiles()
	incsrc ../Misc_Defines_MPAINT.asm
	incsrc ../RAM_Map_MPAINT.asm
	incsrc ../Routine_Macros_MPAINT.asm
	incsrc ../SNES_Macros_MPAINT.asm
endmacro

macro MPAINT_LoadGameSpecificMainSPC700Files()
	incsrc ../SPC700/ARAM_Map_MPAINT.asm
	incsrc ../Misc_Defines_MPAINT.asm
	incsrc ../SPC700/SPC700_Macros_MPAINT.asm
endmacro

macro MPAINT_LoadGameSpecificMainExtraHardwareFiles()
endmacro

macro MPAINT_LoadGameSpecificMSU1Files()
endmacro

macro MPAINT_GlobalAssemblySettings()
	!Define_Global_ApplyAsarPatches = !FALSE
	!Define_Global_InsertRATSTags = !TRUE
	!Define_Global_IgnoreCodeAlignments = !FALSE
	!Define_Global_IgnoreOriginalFreespace = !FALSE
	!Define_Global_CompatibleControllers = !Controller_StandardJoypad|!Controller_Mouse
	!Define_Global_DisableROMMirroring = !FALSE
	!Define_Global_CartridgeHeaderVersion = $00
	!Define_Global_FixIncorrectChecksumHack = !FALSE
	!Define_Global_ROMFrameworkVer = 1
	!Define_Global_ROMFrameworkSubVer = 0
	!Define_Global_ROMFrameworkSubSubVer = 0
	!Define_Global_AsarChecksum = $0000
	!Define_Global_LicenseeName = "Nintendo"
	!Define_Global_DeveloperName = "Nintendo R&D1 / Intelligent Systems"
	!Define_Global_ReleaseDate = "July 14, 1992 (JP)/August 1, 1992 (US)"
	!Define_Global_BaseROMMD5Hash = "881d3772a3eb37a8a0fb254e940c6767"

	!Define_Global_MakerCode = "01"
	!Define_Global_GameCode = "Axxx"
	!Define_Global_ReservedSpace = $00,$00,$00,$00,$00,$00
	!Define_Global_ExpansionFlashSize = !ExpansionMemorySize_0KB
	!Define_Global_ExpansionRAMSize = !ExpansionMemorySize_32KB
	!Define_Global_IsSpecialVersion = $00
	!Define_Global_InternalName = "MARIOPAINT            "
	!Define_Global_ROMLayout = !ROMLayout_LoROM
	!Define_Global_ROMType = !ROMType_ROM_RAM_SRAM
	!Define_Global_CustomChip = !Chip_None
	!Define_Global_ROMSize = !ROMSize_1MB
	!Define_Global_SRAMSize = !SRAMSize_32KB
	!Define_Global_Region = !Region_Japan
	!Define_Global_LicenseeID = $01
	!Define_Global_VersionNumber = $00
	!Define_Global_ChecksumCompliment = !Define_Global_Checksum^$FFFF
	!Define_Global_Checksum = $4B9E
	!UnusedNativeModeVector1 = $0000
	!UnusedNativeModeVector2 = $0000
	!NativeModeCOPVector = CODE_0080AE
	!NativeModeBRKVector = $0000
	!NativeModeAbortVector = $0000
	!NativeModeNMIVector = CODE_0080D4
	!NativeModeResetVector = $0000
	!NativeModeIRQVector = CODE_0080AF
	!UnusedEmulationModeVector1 = $0000
	!UnusedEmulationModeVector2 = $0000
	!EmulationModeCOPVector = $0000
	!EmulationModeBRKVector = $0000
	!EmulationModeAbortVector = $0000
	!EmulationModeNMIVector = $0000
	!EmulationModeResetVector = CODE_008000
	!EmulationModeIRQVector = $0000
	%LoadExtraRAMFile("SRAM_Map_MPAINT.asm")
endmacro

macro MPAINT_LoadROMMap()
	%MPAINTBank00Macros(!BANK_00, !BANK_00)
	%MPAINTBank01Macros(!BANK_01, !BANK_01)
	%MPAINTBank02Macros(!BANK_02, !BANK_02)
	%MPAINTBank03Macros(!BANK_03, !BANK_03)
	%MPAINTBank04Macros(!BANK_04, !BANK_04)
	%MPAINTBank05Macros(!BANK_05, !BANK_05)
	%MPAINTBank06Macros(!BANK_06, !BANK_06)
	%MPAINTBank07Macros(!BANK_07, !BANK_07)
	%MPAINTBank08Macros(!BANK_08, !BANK_08)
	%MPAINTBank09Macros(!BANK_09, !BANK_09)
	%MPAINTBank0AMacros(!BANK_0A, !BANK_0A)
	%MPAINTBank0BMacros(!BANK_0B, !BANK_0B)
	%MPAINTBank0CMacros(!BANK_0C, !BANK_0C)
	%MPAINTBank0DMacros(!BANK_0D, !BANK_0D)
	%MPAINTBank0EMacros(!BANK_0E, !BANK_0E)
	%MPAINTBank0FMacros(!BANK_0F, !BANK_0F)
	%MPAINTBank10Macros(!BANK_10, !BANK_10)
	%MPAINTBank11Macros(!BANK_11, !BANK_11)
	%MPAINTBank12Macros(!BANK_12, !BANK_12)
	%MPAINTBank13Macros(!BANK_13, !BANK_13)
	%MPAINTBank14Macros(!BANK_14, !BANK_14)
	%MPAINTBank15Macros(!BANK_15, !BANK_15)
	%MPAINTBank16Macros(!BANK_16, !BANK_16)
	%MPAINTBank17Macros(!BANK_17, !BANK_17)
	%MPAINTBank18Macros(!BANK_18, !BANK_18)
	%MPAINTBank19Macros(!BANK_19, !BANK_19)
	%MPAINTBank1AMacros(!BANK_1A, !BANK_1A)
	%MPAINTBank1BMacros(!BANK_1B, !BANK_1B)
	%MPAINTBank1CMacros(!BANK_1C, !BANK_1C)
	%MPAINTBank1DMacros(!BANK_1D, !BANK_1D)
	%MPAINTBank1EMacros(!BANK_1E, !BANK_1E)
	%MPAINTBank1FMacros(!BANK_1F, !BANK_1F)
endmacro
