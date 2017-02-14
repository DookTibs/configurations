; AHK script for working at ICF
; #InstallKeybdHook
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Capslock::Esc

; alt-c launches a Cygwin console terminal
!c::Run C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -

; alt-e launches Eclipse
!e::Run C:\Users\38593\eclipse\neon\eclipse\eclipse.exe

; alt-b launches Chrome (browser)
!b::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"


