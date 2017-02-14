; scripts to make it nicer to use the wireless Mac keyboard in Windows

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; for testing - start, see:
; https://www.autohotkey.com/docs/commands/_InstallKeybdHook.htm
; https://www.autohotkey.com/docs/commands/KeyHistory.htm
; basically uncomment this, then open the running script (doubleclick the
; tray icon) and choose "View Keyboard History"
; #InstallKeybdHook

; see https://support.apple.com/en-us/HT202676
; default:
; MAC KEY  -->	WINDOWS EQUIV
; Command  -->	Windows
; Alt/Opt  -->	Alt
; Ctrl     -->	Ctrl
; fn	   -->	Nothing

; problem is these are laid out differently. On Mac Wireless kb left to right:
; [fn] [ctrl] [alt/opt] [command] [spacebar...]
; whereas on windows:
; [ctrl] [windows] [alt] [spacebar]...

LWin::Alt
Alt::LWin
; I'd love to map Mac KB fn to something, but AHK can't detect it...

F7::
IfWinExist, ahk_class iTunes
ControlSend, ahk_parent, ^{LEFT}  ; < previous
return

F8::
IfWinExist, ahk_class iTunes
ControlSend, ahk_parent, {SPACE}  ; play/pause toggle
return

F9::
IfWinExist, ahk_class iTunes
ControlSend, ahk_parent, ^{RIGHT}  ; > next
return

F10::SoundSet, +0, MASTER, MUTE
F11::SoundSet, -3
F12::SoundSet, +3
