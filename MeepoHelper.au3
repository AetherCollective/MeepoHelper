#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=meepo.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Opt("SendKeyDownDelay", 5)
Opt("SendKeyDelay", 5)
ProcessSetPriority("MeepoHelper.exe", 5)
ProcessSetPriority("AutoIt3.exe", 5)
ProcessSetPriority("AutoIt3_x64.exe", 5)
ProcessSetPriority("dota2.exe",3)
FileChangeDir(@ScriptDir)
If Not FileExists("MeepoHelper.ini") Then Setup()
Global $NoM = 1, $numberofruns, $NoMt
Global $poofQuickCastKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "PoofQuickCastKey", "w")
Global $BlinkQuickCastKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "BlinkQuickCastKey", "x")
Global $VeilOfDiscordQuickCastKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "VeilOfDiscordQuickCastKey", "c")
Global $ControlGroupTabKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "ControlGroupTabKey", "q")
Global $selectallunitskey = IniRead("MeepoHelper.ini", "Dota2Bindings", "SelectAllUnitsKey", "{Numpad0}")
Global $SelectAllOtherUnitsKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "SelectAllOtherUnitsKey", "{Numpad7}")
Global $SelectHeroKey = IniRead("MeepoHelper.ini", "Dota2Bindings", "SelectHeroKey", "{f1}")
Global $blinkPoofKey = IniRead("MeepoHelper.ini", "MeepoHelper", "BlinkPoofKey", "5")
Global $PoofAllKey = IniRead("MeepoHelper.ini", "MeepoHelper", "PoofAllkey", "6")
Global $NumberofMeeposSetKey = IniRead("MeepoHelper.ini", "MeepoHelper", "NumberofMeeposSetAndCheckKey", "9")
Global $NumberofMeeposCheckKey = IniRead("MeepoHelper.ini", "MeepoHelper", "NumberofMeeposCheckKey", "0")
Global $ChatKey = IniRead("MeepoHelper.ini", "MeepoHelper", "ChatKey", "!{f11}")
Global $safety = IniRead("MeepoHelper.ini", "MeepoHelper", "Safety", True) ;Safety allows blinkpoof to become more reliable. In order to do this, user input is disabled for roughtly 300ms during the blinkpoof.
Global $auto
HotKeySet($blinkPoofKey, "BlinkPoof")
HotKeySet($PoofAllKey, "PoofAll")
HotKeySet($NumberofMeeposSetKey, "NumberOfMeeposSet")
HotKeySet($NumberofMeeposCheckKey, "NumberOfMeeposCheck")
HotKeySet($ChatKey, "chaton")
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
	FileWriteLine("MeepoHelper.ini", "BlinkPoofKey			=5")
	FileWriteLine("MeepoHelper.ini", "PoofAllKey			=6")
	FileWriteLine("MeepoHelper.ini", "NumberofMeeposSetAndCheckKey	=9")
	FileWriteLine("MeepoHelper.ini", "NumberofMeeposCheckKey		=0")
	FileWriteLine("MeepoHelper.ini", "ChatKey				=!{f11}")
	FileWriteLine("MeepoHelper.ini", "[Dota2Bindings]")
	FileWriteLine("MeepoHelper.ini", "SelectHeroKey			={f1}")
	FileWriteLine("MeepoHelper.ini", "SelectAllOtherUnitsKey		=f")
	FileWriteLine("MeepoHelper.ini", "SelectAllUnitsKey		={Numpad0}")
	FileWriteLine("MeepoHelper.ini", "ControlGroupTabKey		=`")
	FileWriteLine("MeepoHelper.ini", "BlinkQuickCastKey		=x")
	FileWriteLine("MeepoHelper.ini", "VeilOfDiscordQuickCastKey	=c")
	FileWriteLine("MeepoHelper.ini", "PoofQuickCastKey		=2")
	FileWriteLine("MeepoHelper.ini", " ")
	FileWriteLine("MeepoHelper.ini", "[Notes]")
	FileWriteLine("MeepoHelper.ini", 'Instructions="Read Readme.txt"')
	FileWriteLine("MeepoHelper.ini", 'Notes="Do not use Multiple Keys as a keybind(with the exception of Chatkey)"')
	FileWriteLine("MeepoHelper.ini", 'Buttons="All buttons can be found here https://www.autoitscript.com/autoit3/docs/functions/Send.htm "')
	MsgBox(0, "MeepoHelper", "Default Settings Loaded at MeepoHelper.ini. Please Configure your keybinds on the next pages.")
	InputBox("MeepoHelper", "Go to the link below to see what keybinds you can use. DO NOT USE multiple keys as keybind (such as alt+f4, or !{f4}). Also, never reuse a keybind that is already bound to this script or Dota unless specified.", "https://www.autoitscript.com/autoit3/docs/functions/Send.htm")
	Global $blinkPoofKey = IniRead("MeepoHelper.ini", "MeepoHelper", "BlinkPoofKey", InputBox("MeepoHelper Keybind Config", "Please Set the Keybind for EasyBlinkPoof."))
	IniWrite("MeepoHelper.ini", "MeepoHelper", "PoofAllkey", InputBox("MeepoHelper Keybind Config", "Please Set the Keybind for BlinkPoofAll."))
	IniWrite("MeepoHelper.ini", "MeepoHelper", "NumberofMeeposSetAndCheckKey", InputBox("MeepoHelper Keybind Config", "Please Set the Keybind for Setting the number of meepos to be used during EasyBlinkPoof. (Great for leaving a meepo to poof to at base, tho you will have to manually unselect him after the poof)"))
	IniWrite("MeepoHelper.ini", "MeepoHelper", "NumberofMeeposCheckKey", InputBox("MeepoHelper Keybind Config", "Please Set the Keybind for Checking the number of meepos to be used during EasyBlinkPoof."))
	IniWrite("MeepoHelper.ini", "MeepoHelper", "ChatKey", InputBox("MeepoHelper Keybind Config", "Please Set the Keybind to toggle the script's pause funtion. You will need to press this everytime you need to press a key and dont want the script to perform the keybound action while trying to chat. This is also the only keybind that supports multiple keys as a keybind"))
	MsgBox(0, "Meepohelper Keybind Config", "From this point forward, you will need to match your keybinds to what is set in Dota 2.")
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "SelectHeroKey", InputBox("MeepoHelper Keybind Config", "What is Select Hero currently bound to?"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "SelectAllOtherUnitsKey", InputBox("MeepoHelper Keybind Config", "What is Select All Other Units currently bound to?"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "SelectAllUnitsKey", InputBox("MeepoHelper Keybind Config", "What is Select All Units currently bound to?"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "ControlGroupTabKey", InputBox("MeepoHelper Keybind Config", "What is Control Group Tab currently bound to?"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "BlinkQuickCastKey", InputBox("MeepoHelper Keybind Config", "What is Blink QuickCast currently bound to? (Must be QuickCast)(Determine what key you always put blink on and set it to this key.)"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "VeilOfDiscordQuickCastKey", InputBox("MeepoHelper Keybind Config", "What is Veil of Discord QuickCast currently bound to? (Must be QuickCast)(Determine what key you always put Veil of Discord on and set it to this key.)(Must be set, If you dont use veils, then put agh sceptor in this slot)"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "PoofQuickCastKey", InputBox("MeepoHelper Keybind Config", "What is Poof QuickCast currently bound to? (Must be QuickCast)"))
	IniWrite("MeepoHelper.ini", "Dota2Bindings", "PoofQuickCastKey", True)
	FileClose($iHandle)
	MsgBox(0, "MeepoHelper Keybind Config", "Settings Saved. Please Relaunch MeepoHelper.exe")
	Exit

EndFunc   ;==>Setup
Func BlinkPoof()
	If $NoM = 1 Then standby()
	If $safety = True Then BlockInput(1)
	Send("{esc}")
	Send($SelectAllOtherUnitsKey)
	While $numberofruns < $NoM - 1
		Sleep(15)
		Send($poofQuickCastKey)
		Sleep(15)
		Send($ControlGroupTabKey)
		$numberofruns = $numberofruns + 1
	WEnd
	Global $numberofruns = 0
	Send($SelectHeroKey)
	If $safety = True Then BlockInput(0)
	Sleep(1000)
	If $safety = True Then BlockInput(1)
	Send($BlinkQuickCastKey)
	Sleep(50)
	Send($VeilOfDiscordQuickCastKey)
	Sleep(300)
	If $safety = True Then BlockInput(0)
	Send($selectallunitskey)
EndFunc   ;==>BlinkPoof
Func StopNet()
	standby()
EndFunc   ;==>StopNet
Func NumberOfMeeposSet()
	Global $NoMt = $NoM + 1
	Global $NoM = $NoMt
	If $NoM = 6 Then $NoM = 1
	NumberOfMeeposCheck()
EndFunc   ;==>NumberOfMeeposSet
Func NumberOfMeeposCheck()
	Global $numberofruns = 0
	For $i = 1 To $NoM
		Beep($i * 100 + 400, 50)
	Next
	standby()
EndFunc   ;==>NumberOfMeeposCheck
Func checkchatmode()
	If PixelSearch(@DesktopWidth * 0.3557291666666667, @DesktopHeight * 0.7157407407407407, @DesktopWidth * 0.3567708333333333, @DesktopHeight * 0.7175925925925926, 0xFFFFFF, 3) = "0" Then
		$auto = 1
		chatoff()
	Else
		$auto = 1
		Chaton()
	EndIf
EndFunc   ;==>checkchatmode
Func Chaton()
	HotKeySet($blinkPoofKey)
	HotKeySet($PoofAllKey)
	HotKeySet($NumberofMeeposSetKey)
	HotKeySet($NumberofMeeposCheckKey)
	HotKeySet($ChatKey, "chatoff")
	If Not $auto = 1 Then ToolTip("Paused", @DesktopWidth * .5, @DesktopHeight * .5)
	If Not $auto = 1 Then Sleep(1000)
	If Not $auto = 1 Then ToolTip("")
	$auto = 0
	Return
EndFunc   ;==>Chaton
Func chatoff()
	HotKeySet($blinkPoofKey, "BlinkPoof")
	HotKeySet($PoofAllKey, "PoofAll")
	HotKeySet($NumberofMeeposSetKey, "NumberOfMeeposSet")
	HotKeySet($NumberofMeeposCheckKey, "NumberOfMeeposCheck")
	HotKeySet($ChatKey, "Chaton")
	If Not $auto = 1 Then ToolTip("Resumed", @DesktopWidth * .5, @DesktopHeight * .5)
	If Not $auto = 1 Then Sleep(1000)
	If Not $auto = 1 Then ToolTip("")
	$auto = 0
	Return
EndFunc   ;==>chatoff
Func PoofAll()
	Send($selectallunitskey)
	Send($poofQuickCastKey)
	Send($ControlGroupTabKey)
	Send($poofQuickCastKey)
	Send($ControlGroupTabKey)
	Send($poofQuickCastKey)
	Send($ControlGroupTabKey)
	Send($poofQuickCastKey)
	Send($ControlGroupTabKey)
	Send($poofQuickCastKey)
	Send($ControlGroupTabKey)
	Send($SelectHeroKey)
	Send($selectallunitskey)
EndFunc   ;==>PoofAll
