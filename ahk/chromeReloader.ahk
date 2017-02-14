; First attempt at getting a programmatic way of reloading a Chrome tab.
; This currently works - and loops through tabs. But if there are multiple
; Chrome windows, it only looks at the most recent one.
;
; could use Windows+<numeric position on taskbar> or someting like VistaSwitcher to loop
; through multiple windows, and watch the firstUrl of each and the first window id
; I supposed. Let's live with this solution for awhile first and see if that
; seems necessary.

; how to use from the command line
; cygstart chromeReloader.ahk <patternOfTabToReload>

; My Vim is configured, when running in Cygwin, to call this script
; when running the VimScript ReloadChromeTab function

ReloadCurrentTab()
{
	; reload the tab
	ControlSend,,{Ctrl Down}r{Ctrl Up},ahk_class Chrome_WidgetWin_1
}

GetCurrentTabUrl()
{
	ControlSend,,{Ctrl Down}lc{Ctrl Up},ahk_class Chrome_WidgetWin_1
	return clipboard
}

reloadPattern = %1%
re := "i)" . reloadPattern

FileDelete, C:\development\ahk.log
; FileAppend, pattern was %re%`n, C:\development\ahk.log

; get current window id - if I'm using it, this is likely the terminal
WinGet, ActiveId, ID, A

; switch to chrome
WinActivate,ahk_class Chrome_WidgetWin_1

; get the current tab url
firstUrl := GetCurrentTabUrl()
; FileAppend, first url new way is %firstUrl%`n, C:\development\ahk.log

; compare it to a regular expression
isMatch := RegExMatch(firstUrl, re)
; FileAppend, "match yields: [%isMatch%]"`n, C:\development\ahk.log

if (isMatch >= 1) {
	; FileAppend, "%firstUrl% matches %re%...%isMatch%...RELOAD!"`n, C:\development\ahk.log
	ReloadCurrentTab()
} else {
	; FileAppend, "%firstUrl% does NOT match %re%...%isMatch%"`n, C:\development\ahk.log

	sanity := 0
	Loop {
		ControlSend,,{Ctrl Down}{Tab}{Ctrl Up},ahk_class Chrome_WidgetWin_1
		tabUrl := GetCurrentTabUrl()

		if (tabUrl = firstUrl) {
			; we've looped
			break
		} else if (RegExMatch(tabUrl, re) >= 1) {
			; we've got a match
			ReloadCurrentTab()
			break
		} else {
			; keep trying
		}

		if (sanity >= 15) {
			break
		}
	}
}

; switch back to previous window
WinActivate, ahk_id %ActiveId%
