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
; !e::Run C:\Users\38593\eclipse\neon\eclipse\eclipse.exe

; alt-b launches Chrome (browser)
!b::Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

; note that this is NOT really well written for multi-monitors. Could definitely use
; some improvment there, particularly if resolution is different between them.
; I mainly use this function on the main monitor so it works ok for now but
; not ready for distribution. (basically we see if X == 0, and it is not zero even if 
; window is on the left edge of non-main monitors). Could fix by:
;	* knowing the left-edge x-pos of each monitor, instead of assuming 0 (easier)
;	* seeing current monitor dimensions and deciding of middle of active window
;	  is on the left half or the right half (better)
BumpWindowInPlace(key)
{
	; MsgBox, bump %key%
	ChangeAmt := 40
	LeftEdge := 0
	TopEdge := 0
	WinGetPos X, Y, Width, Height, A
	; MsgBox, height is %Height%

	NewX := X
	NewWidth := Width

	NewY := Y
	NewHeight := Height

	if (X == LeftEdge) {
		; we're on the left edge of the screen
		if (key == "left") {
			; maintain x pos, decrease width
			NewWidth := Width - ChangeAmt
		} else if (key == "right") {
			; maintain x pos, increase width
			NewWidth := Width + ChangeAmt
		}
	} else {
		; we're not on the left edge of the screen
		if (key == "left") {
			; increase width and decrease x pos to hold right edge
			NewX := X - ChangeAmt
			NewWidth := Width + ChangeAmt
		} else if (key == "right") {
			; decrease width and increase x pos to hold right edge
			NewX := X + ChangeAmt
			NewWidth := Width - ChangeAmt
		}
	}

	if (Y == TopEdge) {
		; we're on the top edge of the screen
		if (key == "up") {
			; maintain y pos, decrease height
			NewHeight := Height - ChangeAmt
		} else if (key == "down") {
			if (Height == 1040) {
				; special case - we are vertically maximized.
				NewY := Y + ChangeAmt
				NewHeight := Height - ChangeAmt
			} else {
				; maintain y pos, increase height
				NewHeight := Height + ChangeAmt
			}
		}
	} else {
		; we're not on the top edge of the screen
		if (key == "up") {
			; increase height and decrease y pos to hold bottom edge
			NewY := Y - ChangeAmt
			NewHeight := Height + ChangeAmt
		} else if (key == "down") {
			; decrease height and increase y pos to hold bottom edge
			NewY := Y + ChangeAmt
			NewHeight := Height - ChangeAmt
		}
	}
	WinMove, A, , NewX, NewY, NewWidth, NewHeight
}

; Win+Alt+Arrows resize windows
#!Left::BumpWindowInPlace("left")
#!Right::BumpWindowInPlace("right")
#!Up::BumpWindowInPlace("up")
#!Down::BumpWindowInPlace("down")
