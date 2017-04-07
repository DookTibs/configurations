" use "comma" as the leader command for debugging commands.

"let g:vebugger_leader=','
" let g:vebugger_use_tags=1
"let g:vebugger_view_source_cmd='edit'

" map d to something
"exe 'nnoremap ' . g:vebugger_leader . 'd' . ' :call LaunchDragonDebugger()<enter>'

"function! LaunchDragonDebugger()
	"call vebugger#jdb#start('', {'srcpath': 'C:/Users/38593/workspace/icf_dragon/src/main/java/', 'args':['-connect', 'com.sun.jdi.SocketAttach:port=9005,hostname=localhost']})
"endfunction

" attempting to write some simple functions to let me use portions of jdb easily from a Vim/tmux session.
" official Vim debugger plugins don't seem to work quite right, Eclim can't use Eclipse's debugger, etc.
" as usual, I blame cygwin - I think any of these methods would work fine on MacOS.
"
" Right now this is by no means ready for primetime, and I just use Eclipse when I need to debug. But my hope is to 
" get this to a point where it's usable. And along the way I'll learn a little more about some parts of Vim I haven't
" touched before, and get to hack together some neat stuff. Maybe with netcat! :-)
"
" What works so far:
"	* can add/remove breakpoints with visual indicators in source
"	* can print value of word under cursor
"	* basic control flow with next/cont commands
"
" todo - remove Dragon dependencies
"		- highlight the whole line where breakpoint is set
"		- don't assume tmux pane 1 for where the debugger lives
"		- talk to debugger to get current signs? Right now if either editor or debugger exits, we have to redo all breakpoints, etc.
"		- can we read/watch the current tmux buffer (so we could jump to lines as debugger progresses?)
"		- and if so, can Vim be controller from tmux (ie can tmux call a Vim function) w/o clientserver mode working? async Vim?

let g:tibsdebug_leader=','

" define a sign to use when placing a breakpoint
sign define tibsDebug text=!!

" hardcoded for Dragon right now...
function! GetClassFromContext(fullPath)
	" echo "working on [" . a:fullPath . "]"
	let className = substitute(a:fullPath, "/cygdrive/c/Users/38593/workspace/icf_dragon/src/main/java/", "", "")
	let className = substitute(className, ".java", "", "")
	let className = substitute(className, "/", ".", "g")
	return className
endfunction

function! ToggleBreakpoint()
	let ctx = GetCurrentContext()
	let className = GetClassFromContext(ctx.fullPath)

	let jdbCmd = ""
	try
		sign unplace
		" now send a 'remove breakpoint' command to jdb
		let jdbCmd = "clear " . className . ":" . ctx.line
	catch
		" exe ":sign place " . ctx.line . " line=" . ctx.line . " name=tibsDebug file=" . expand("%:p")
		" now send a 'add breakpoint' command to jdb
		let jdbCmd = "stop at " . className . ":" . ctx.line

		" when flow returns successfully, we'll add a sign
	endtry

	call SendKeysToTMUX("1", "\"" . jdbCmd . "\" Enter")
endfunction

function! AddBreakpointAtLineOfCurrentFile(lineNum)
	let ctx = GetCurrentContext()
	let className = GetClassFromContext(ctx.fullPath)

	exe ":sign place " . a:lineNum . " line=" . a:lineNum . " name=tibsDebug file=" . expand("%:p")
	redraw!
endfunction

function! PrintVariable()
	let wordUnderCursor = expand("<cword>")
	let jdbCmd = "print " . wordUnderCursor
	call SendKeysToTMUX("1", "\"" . jdbCmd . "\" Enter")
endfunction

function! SimpleJdbCmd(cmd)
	call SendKeysToTMUX("1", "\"" . a:cmd . "\" Enter")
endfunction

exe 'nnoremap ' . g:tibsdebug_leader . 'b' . ' :call ToggleBreakpoint()<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'B' . ' :call SimpleJdbCmd("clear")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'p' . ' :call PrintVariable()<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'n' . ' :call SimpleJdbCmd("next")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'c' . ' :call SimpleJdbCmd("cont")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'q' . ' :call SimpleJdbCmd("quit")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'd' . ' :call SendFreshCommandToTMUX("jdb -connect com.sun.jdi.SocketAttach:port=9005,hostname=localhost -sourcepath C:/Users/38593/workspace/icf_dragon/src/main/java/")<enter>'

" map <BS> :source ~/development/configurations/vim/vebugger.vim<enter>
