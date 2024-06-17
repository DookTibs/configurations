" use "comma" as the leader command for debugging commands.

" ok for users to change
let g:tibsdebug_leader=','
let g:tibsdebug_jdb_port=9005
let g:tibsdebug_bridge_port=4949
let g:tibsdebug_tmuxtarget_jdb='1'
let g:tibsdebug_tmuxtarget_bridge=':dragonTomcat.2'
let g:tibsdebug_srcpaths = [
	\"/some/fake/path/",
	\"/Users/38593/development/icf_dragon/src/main/java/",
	\"/some/other/fake/path/"
\]


" internal values only
let g:tibsdebug_debugger_running=0


" requires rlwrap (installable via homebrew) as we use that to ensure history/arrows work
" when working in jdb

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
"		- talk to debugger to get current signs? Right now if either editor or debugger exits, we have to redo all breakpoints, etc.
"		- can we read/watch the current tmux buffer (so we could jump to lines as debugger progresses?)
"		- and if so, can Vim be controller from tmux (ie can tmux call a Vim function) w/o clientserver mode working? async Vim?
"		- how to get command running in current window -- can we know if debugger is running already when start/stop?

" define a sign to use when placing a breakpoint
sign define tibsDebugSign text=!!

" hardcoded for Dragon right now...
function! GetClassFromContext(fullPath)
	" echo "working on [" . a:fullPath . "]"
	let className = substitute(a:fullPath, "/Users/38593/development/icf_dragon/src/main/java/", "", "")
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
		exe ":sign place " . ctx.line . " line=" . ctx.line . " name=tibsDebugSign file=" . expand("%:p")
		" now send a 'add breakpoint' command to jdb
		let jdbCmd = "stop at " . className . ":" . ctx.line

		" when flow returns successfully, we'll add a sign
	endtry

	call SendKeysToTMUX(g:tibsdebug_tmuxtarget_jdb, "\"" . jdbCmd . "\" Enter")
endfunction

function! AddBreakpointAtLineOfCurrentFile(lineNum)
	let ctx = GetCurrentContext()
	let className = GetClassFromContext(ctx.fullPath)
"
	exe ":sign place " . a:lineNum . " line=" . a:lineNum . " name=tibsDebugSign file=" . expand("%:p")
	redraw!
endfunction

function! RunJdbCmdOnCurrentWord(cmd)
	let wordUnderCursor = expand("<cword>")
	" let jdbCmd = "print " . wordUnderCursor
	let jdbCmd = a:cmd . " " . wordUnderCursor
	call SendKeysToTMUX(g:tibsdebug_tmuxtarget_jdb, "\"" . jdbCmd . "\" Enter")
endfunction

function! SimpleJdbCmd(cmd)
	" call SendKeysToTMUX(g:tibsdebug_tmuxtarget_jdb, "\"" . a:cmd . "\" Enter")
	call SendKeysToTMUX(g:tibsdebug_tmuxtarget_jdb, a:cmd . " Enter")
endfunction

function! StartOrStopDebugger()
	if g:tibsdebug_debugger_running == 0
		call SendFreshCommandToTMUX("rlwrap jdb -connect com.sun.jdi.SocketAttach:port=" . g:tibsdebug_jdb_port . ",hostname=localhost -sourcepath /Users/38593/development/icf_dragon/src/main/java/ \| tee $DRAGON_HOME/unsynced/jdb_output/jdb.log", g:tibsdebug_tmuxtarget_jdb)
		call SendFreshCommandToTMUX("python /Users/38593/development/shellScripts/jdb_vim_bridge.py $DRAGON_HOME/unsynced/jdb_output/jdb.log " . g:tibsdebug_bridge_port, g:tibsdebug_tmuxtarget_bridge)
		echo "debugger/bridge launched..."
		sleep 1
		call OpenConnectionToJdbBridgeServer()
		echo "Vim connected to bridge; proceed!"
		let g:tibsdebug_debugger_running=1
	else
		call CloseConnectionToJdbBridgeServer()
		call SendKeysToTMUX(g:tibsdebug_tmuxtarget_jdb, "quit Enter")
		call SendKeysToTMUX(g:tibsdebug_tmuxtarget_bridge, " Enter")
		let g:tibsdebug_debugger_running=0
	endif
endfunction

" tmux send-keys -t "2" ":call HelloFromShell('asdf')^M"
function! HelloFromShell(...)
	if a:0 > 0
		echo "hello " . a:1 . "!!!"
	else
		echo "hello!"
	endif
endfunction


hi TibsDebugLineMarker cterm=NONE ctermbg=DarkYellow
" based on my ToggleCustomLineHighlight general function
" clears all other marks
" if setMarkOnCurrentLine == 1, add a new mark; if 0 then just clears all
function! SetDebugLineMarker(setMarkOnCurrentLine)
	let currentMatches = getmatches()

	let linePattern = '\%' . line('.') . 'l'
	for m in currentMatches
		if has_key(m, 'group') && m['group'] == "TibsDebugLineMarker"
			call matchdelete(m['id'])
			" if has_key(m, 'pattern') && m['pattern'] == linePattern
				" call matchdelete(m['id'])
				" return
			" endif
		endif
	endfor
	
	if a:setMarkOnCurrentLine
		call matchadd('TibsDebugLineMarker', linePattern)
		silent execute "normal z."
	endif
endfunction

function! OnDataReceivedFromJdbBridge(...)
	" echo "ondata firing (" . a:0 . ") a=(" . a:1 . "), b=(" . "a:2" . "), c=(" . a:3 . ")"
	let rawJson = a:2[0]
	" echo "OnDataReal: " . rawJson

	let startTime = strftime("%X")

	let parsedData = json_decode(rawJson).parsed_data

	let debugMsg = ""
	if ("raw" == parsedData.type)
		let debugMsg = "Raw data: [" . join(parsedData.data, ",") . "]"
	elseif ("breakpoint_added" == parsedData.type)
		let bp = parsedData.breakpoint
		let debugMsg = "added breakpoint at " . bp.class . ":" . bp.line
		" call AddBreakpointAtLineOfCurrentFile(bp.line)
	elseif ("breakpoint_removed" == parsedData.type)
		let bp = parsedData.breakpoint
		let debugMsg = "removed breakpoint at " . bp.class . ":" . bp.line
	elseif ("execution_paused" == parsedData.type)
		let chunk = parsedData.possiblePartialFilePath
		let subtype = parsedData.subtype
		let lineNum = parsedData.lineNumber
		let debugMsg = "execution paused at " . rawJson
		
		let fullPath = LookForFile(chunk)

		if fullPath == ""
			" echo "Could not find destination for " . rawJson
			call SetDebugLineMarker(0)		" clear current marker
		else
			echo subtype . ": " . parsedData.function . ":" . lineNum
			call DisplayBufferForFile(fullPath, lineNum)
		endif

	elseif ("breakpoint_list" == parsedData.type)
		let debugMsg = "list of breakpoints..."
	else
		let debugMsg = "Unknown type: " . rawJson
	endif

	let endTime = strftime("%X")
	" echo "[" . startTime . "]->[" . endTime . "] got data " . strpart(rawJson, 0, 25) . " ....."
	" echo "[" . startTime . "]->[" . endTime . "] " . debugMsg
	
	" note to self - echo'ing sometimes fires after a lengthy delay. Not sure why.
endfunction

function! ToggleJdbBridgeConnection()
	if exists("g:tibsdebug_channel_id")
		call CloseConnectionToJdbBridgeServer()
	else
		call OpenConnectionToJdbBridgeServer()
	endif
endfunction

function! OpenConnectionToJdbBridgeServer()
	" let g:channel = ch_open('localhost:4949')
	
	" NeoVim
	let g:tibsdebug_channel_id = sockconnect('tcp', 'localhost:' . g:tibsdebug_bridge_port, { "on_data": "OnDataReceivedFromJdbBridge" })
endfunction

function! CloseConnectionToJdbBridgeServer()
	call chanclose(g:tibsdebug_channel_id)
	unlet g:tibsdebug_channel_id
endfunction

" search all defined srcpaths looking for a partial path. Return complete path if found,
"    or empty string if not.
function! LookForFile(filePath)
	for srcpath in g:tibsdebug_srcpaths
		let complete_path = srcpath . a:filePath
		if filereadable(complete_path)
			" echo complete_path . " is readable!"
			return complete_path
		endif
	endfor
	" echo filePath . " could not be found..."
	return ""
endfunction

function! DisplayBufferForFile(filePath, lineNum)
	call SetDebugLineMarker(0)		" clear current marker; we might switch windows...

	if !filereadable(a:filePath)
		" echo "Cannot jump to " . a:filePath . ":" . a:lineNum
		return
	endif

	let current_bufnr = bufnr("%")

	let target_bufnr = -1
	for buffer in getbufinfo()
		" echo "comparing '" . buffer.name . "' to '" . a:filePath . "'"
		if buffer.name == a:filePath
			" echo "HIT!"
			if buffer.hidden == 1
				" file is open but currently hidden
				let target_bufnr = buffer.bufnr
			else
				if buffer.bufnr != current_bufnr
					" file is open and visible; just switch to it
					silent execute bufwinnr(buffer.bufnr) 'wincmd w'
				else
					" already in this file; no need to switch
				endif

				" jump to line and highlight
				silent execute "normal " . a:lineNum . "G"
				call SetDebugLineMarker(1)
				return
			endif
		endif
	endfor

	for buffer in getbufinfo()
		if buffer.bufnr == current_bufnr
			if buffer.changed
				" show it in a split; currently active window has changes
				" echo "show '" . a:filePath . "' at line '" . a:lineNum . "'; but curr buffer (" . buffer.name . ") is changed!"
				if target_bufnr == -1
					" file isn't currently opened; open it in a split
					silent execute "split +" . a:lineNum . " " . a:filePath
				else
					" bugger is open just hidden...
					silent execute "sbuffer +" . a:lineNum . " " . target_bufnr
				endif
				call SetDebugLineMarker(1)
			else
				" currently active window is not touched; just jump along
				" echo "show '" . a:filePath . "' at line '" . a:lineNum . "'; ok right now!"
				silent execute "edit +" . a:lineNum . " " . a:filePath
				call SetDebugLineMarker(1)
			endif
			" break
		endif
	endfor

	" winnr()
endfunction



" exe 'nnoremap ' . g:tibsdebug_leader . 'D' . ' :call SendFreshCommandToTMUX("rlwrap jdb -connect com.sun.jdi.SocketAttach:port=9005,hostname=localhost -sourcepath /Users/38593/development/icf_dragon/src/main/java/ \| tee $DRAGON_HOME/unsynced/jdb_output/jdb.log", g:tibsdebug_tmuxtarget_jdb)<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'D' . ' :call StartOrStopDebugger()<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'b' . ' :call ToggleBreakpoint()<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'B' . ' :call SimpleJdbCmd("clear")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'p' . ' :call RunJdbCmdOnCurrentWord("print")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'd' . ' :call RunJdbCmdOnCurrentWord("dump")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'l' . ' :call SimpleJdbCmd("locals")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'L' . ' :call SimpleJdbCmd("list")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 's' . ' :call SimpleJdbCmd("step")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'n' . ' :call SimpleJdbCmd("next")<enter>'
exe 'nnoremap ' . g:tibsdebug_leader . 'c' . ' :call SimpleJdbCmd("cont")<enter>'
" exe 'nnoremap ' . g:tibsdebug_leader . 'q' . ' :call SimpleJdbCmd("quit")<enter>'

" map <BS> :source ~/development/configurations/vim/vebugger.vim<enter>


" temp for debugging only!!!
" map _ :call SetDebugLineMarker(1)<enter>
" map <BS> :call ToggleJdbBridgeConnection()<enter>
" map <BS> :call LookForFile("com/icfi/dragon/web/gateway/ApiGateway.java")<enter>
" map <BS> :call DisplayBufferForFile("/Users/38593/development/icf_dragon/src/main/java/com/icfi/dragon/web/gateway/ApiGateway.java", 1209)<enter>
