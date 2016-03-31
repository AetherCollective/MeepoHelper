#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=meepo.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Opt("SendKeyDownDelay", 5)
Opt("SendKeyDelay", 5)
ProcessSetPriority("MeepoHelper.exe", 5)
ProcessSetPriority("AutoIt3.exe", 5)
ProcessSetPriority("AutoIt3_x64.exe", 5)
ProcessSetPriority("dota2.exe", 3)
FileChangeDir(@ScriptDir)
If Not FileExists("MeepoHelper.ini") Then Setup()
Global $NumberOfMeepos = 1, $NumberOfMeepos
Global $PoofQuickCastKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "PoofQuickCastKey", "w")
Global $BlinkQuickCastKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "BlinkQuickCastKey", "x")
Global $VeilOfDiscordQuickCastKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "VeilOfDiscordQuickCastKey", "c")
Global $ControlGroupTabKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "ControlGroupTabKey", "q")
Global $SelectAllUnitsKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "SelectAllUnitsKey", "{Numpad0}")
Global $SelectAllOtherUnitsKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "SelectAllOtherUnitsKey", "{Numpad7}")
Global $SelectHeroKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "SelectHeroKey", "{f1}")
Global $BlinkPoofKey = IniRead("MeepoHelper.ini", "MeepoHelper", "BlinkPoofKey", "5")
Global $PoofMeeposKey = IniRead("MeepoHelper.ini", "MeepoHelper", "PoofMeepos", "6")
Global $NumberofMeeposSetKey = IniRead("MeepoHelper.ini", "MeepoHelper", "NumberofMeeposSetAndCheckKey", "9")
Global $NumberofMeeposCheckKey = IniRead("MeepoHelper.ini", "MeepoHelper", "NumberofMeeposCheckKey", "0")
Global $Safety = IniRead("MeepoHelper.ini", "MeepoHelper", "Safety", False)
HotkeysOn()
standby()
Func standby()
	While 1
		checkchatmode()
		Sleep(15)
	WEnd
EndFunc   ;==>standby
Func Setup()
	Global $iHandle = FileOpen("MeepoHelper.ini", 2)
	FileWriteLine("MeepoHelper.ini", "[MeepoHelper]")
	FileWriteLine("MeepoHelper.ini", "BlinkPoofKey			=")
	FileWriteLine("MeepoHelper.ini", "PoofMeeposKey			=")
	FileWriteLine("MeepoHelper.ini", "NumberofMeeposSetAndCheckKey	=")
	FileWriteLine("MeepoHelper.ini", "NumberofMeeposCheckKey		=")
	FileWriteLine("MeepoHelper.ini", "[Dota2Bindings]")
	FileWriteLine("MeepoHelper.ini", "SelectHeroKey			=")
	FileWriteLine("MeepoHelper.ini", "SelectAllOtherUnitsKey		=")
	FileWriteLine("MeepoHelper.ini", "SelectAllUnitsKey		=")
	FileWriteLine("MeepoHelper.ini", "ControlGroupTabKey		=")
	FileWriteLine("MeepoHelper.ini", "BlinkQuickCastKey		=")
	FileWriteLine("MeepoHelper.ini", "VeilOfDiscordQuickCastKey	=")
	FileWriteLine("MeepoHelper.ini", "PoofQuickCastKey		=")
	FileWriteLine("MeepoHelper.ini", "Safety				=True")
	FileWriteLine("MeepoHelper.ini", " ")
	FileWriteLine("MeepoHelper.ini", "[Notes]")
	FileWriteLine("MeepoHelper.ini", 'Instructions="Read Readme.txt"')
	FileWriteLine("MeepoHelper.ini", 'Notes="Do not use Multiple Keys as a keybind(with the exception of Chatkey)"')
	FileWriteLine("MeepoHelper.ini", 'Buttons="All buttons can be found here https://www.autoitscript.com/autoit3/docs/functions/Send.htm "')
	FileClose($iHandle)
	MsgBox(64, "MeepoHelper", "Default Settings Loaded at MeepoHelper.ini. Please Configure your keybinds on the next pages.")
	InputBox("Instructions", "Go to the link below to see what keybinds you can use. DO NOT USE multiple keys as keybind (such as alt+f4, or !{f4}). Also, never reuse a keybind that is already bound to this script or Dota 2 unless specified otherwise.", "https://www.autoitscript.com/autoit3/docs/functions/Send.htm")
	IniWrite("MeepoHelper.ini", "MeepoHelper", "BlinkPoofKey", InputBox("MeepoHelper Keybind Config", "Please set the keybind for BlinkPoof.", "", " M"))
	IniWrite("MeepoHelper.ini", "MeepoHelper", "PoofMeeposKey", InputBox("MeepoHelper Keybind Config", "Please set the keybind for PoofMeepos.", "", " M"))
	IniWrite("MeepoHelper.ini", "MeepoHelper", "NumberofMeeposSetAndCheckKey", InputBox("MeepoHelper Keybind Config", "Please set the keybind for setting the number of Meepos to be used during BlinkPoof and PoofMeepos. (Great for leaving a Meepo to poof to at base, though you will have to manually unselect him after the poof. You can not choose what Meepo to leave at base.)", "", " M"))
	IniWrite("MeepoHelper.ini", "MeepoHelper", "NumberofMeeposCheckKey", InputBox("MeepoHelper Keybind Config", "Please set the keybind for checking the number of Meepos to be used during BlinkPoof and PoofMeepos.", "", " M"))
	MsgBox(0, "Instructions", "From this point forward, you will need to match your keybinds to what is set in Dota 2.")
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "SelectHeroKey", InputBox("MeepoHelper Keybind Config", "What is Select Hero currently bound to?", "", " M"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "SelectAllOtherUnitsKey", InputBox("MeepoHelper Keybind Config", "What is Select All Other Units currently bound to?", "", " M"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "SelectAllUnitsKey", InputBox("MeepoHelper Keybind Config", "What is Select All Units currently bound to?", "", " M"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "ControlGroupTabKey", InputBox("MeepoHelper Keybind Config", "What is Control Group Tab currently bound to?", "", " M"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "BlinkQuickCastKey", InputBox("MeepoHelper Keybind Config", "What is Blink currently bound to? (Must be QuickCast)(Determine what key you always put Blink on and set it to this key.)", "", " M"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "VeilOfDiscordQuickCastKey", InputBox("MeepoHelper Keybind Config", "What is Veil of Discord currently bound to? (Must be QuickCast)(Determine what key you always put Veil of Discord on and set it to this key.)(If you dont use Veils, then put Agh Sceptor in this slot)", "", " M"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "PoofQuickCastKey", InputBox("MeepoHelper Keybind Config", "What is Poof currently bound to? (Must be QuickCast)", "", " M"))
	$SafetyFlag = MsgBox(64 + 4, "MeepoHelper - Safety", "This script can make Blink Poof more reliable by disabling input at specific timings during the blink poof." & @CRLF & "Users that are not confortable with control temporarily being disable may wish to disable this feature." & @CRLF & "Would you like to disable this feature?")
	If $SafetyFlag = 6 Then
		$SafetyFlag = False
	Else
		$SafetyFlag = True
	EndIf
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "Safety", $SafetyFlag)
EndFunc   ;==>Setup
Func BlinkPoof()
	HotkeysOff()
	If $NumberOfMeepos = 1 Then standby()
	If $Safety = True Then BlockInput(1)
	Send("{esc}")
	Send($SelectAllOtherUnitsKey)
	For $i = 1 To $NumberOfMeepos
		Send($PoofQuickCastKey)
		Send($ControlGroupTabKey)
	Next
	Send($SelectHeroKey)
	If $Safety = True Then BlockInput(0)
	Sleep(1000)
	If $Safety = True Then BlockInput(1)
	Send($BlinkQuickCastKey)
	Sleep(50)
	Send($VeilOfDiscordQuickCastKey)
	Sleep(300)
	If $Safety = True Then BlockInput(0)
	Send($SelectAllUnitsKey)
	HotkeysOn()
EndFunc   ;==>BlinkPoof
Func Poof()
	HotkeysOff()
	For $i = 1 To $NumberOfMeepos
		Send($PoofQuickCastKey)
		Send($ControlGroupTabKey)
	Next
	HotkeysOn()
EndFunc   ;==>Poof
Func NumberOfMeeposSet()
	$NumberOfMeepos += 1
	If $NumberOfMeepos > 5 Then $NumberOfMeepos = 1
	NumberOfMeeposCheck()
EndFunc   ;==>NumberOfMeeposSet
Func NumberOfMeeposCheck()
	For $i = 1 To $NumberOfMeepos
		Beep($i * 100 + 400, 50)
	Next
EndFunc   ;==>NumberOfMeeposCheck
Func checkchatmode()
	Select
		Case WinActive("Dota 2") = 0
			HotkeysOff()
		Case PixelSearch(@DesktopWidth * 0.3557291666666667, @DesktopHeight * 0.7157407407407407, @DesktopWidth * 0.3567708333333333, @DesktopHeight * 0.7175925925925926, 0xFFFFFF, 3) = "0"
			HotkeysOn()
		Case Else
			HotkeysOff()
	EndSelect
EndFunc   ;==>checkchatmode
Func HotkeysOn()
	HotKeySet($BlinkPoofKey, "BlinkPoof")
	HotKeySet($PoofMeeposKey, "Poof")
	HotKeySet($NumberofMeeposSetKey, "NumberOfMeeposSet")
	HotKeySet($NumberofMeeposCheckKey, "NumberOfMeeposCheck")
EndFunc   ;==>HotkeysOn
Func HotkeysOff()
	HotKeySet($BlinkPoofKey)
	HotKeySet($PoofMeeposKey)
	HotKeySet($NumberofMeeposSetKey)
	HotKeySet($NumberofMeeposCheckKey)
EndFunc   ;==>HotkeysOff
