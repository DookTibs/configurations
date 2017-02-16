" taken from http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

" **************** INDENTATION BASED NAVIGATION: START ********************

" function I (tjf) wrote to help navigate indentation-based languages like CoffeeScript,
" or even langauges where indentation isn't necessarily required but is
" usually observed; for instance if/else/endif with nice indentation in
" VimScript is a lot easier to navigate by using this function!
"
" I have this mapped to ^; next to % which I use for similar
" navigation in bracketed langs
"
" This runs either down or up, looking for something that is less indented
" than what we're currently looking at. Behavior for going up/down is a little
" different but gets pretty decent results.
"
" works pretty well although slightly strange behavior when faced with
" something like this in ~coffeescript:
"
" if ()
"	for ()
"	  while ()
"	    doSomething
"
" running IndentBouncer on either the "if" or "for" lines of this
" type of construct takes us to "doSomething"...but then running it a second
" time from there takes us back to "while". The "up" direction on a lang like
" CS can't suss out what the person editing actually wants. Maybe I could
" stuff a timed variable someplace, or maybe this is just a limitation of this
" type of language. The g:indent_bounce_breadcrumb stuff below is a simple
" workaround for this type of thing that makes repeated calls to this function
" a bit more 'stable'.
" 
"
let g:indent_bounce_breadcrumb = "-1,-1"
function! IndentBouncer(direction, timesThru)
	let lineNum = line('.')
	let startLineNum = lineNum
	let lastLineNum = line('$')
	let startIndent = indent(lineNum)

	let crumbSeparator = ","

	let stepVal = a:direction " 1 = down/forward, -1 = up/backward

	" special case - when going back up, see if the indent_bounce_breadcrumb
	" variable applies.
	if (stepVal == -1)
		let crumbs = split(g:indent_bounce_breadcrumb, crumbSeparator)

		if (crumbs[1] == startLineNum)
			exe crumbs[0]
			return
		endif
	endif

	while (lineNum > 0 && lineNum <= lastLineNum)
		let lineNum = lineNum + stepVal

		let lineContents = getline(lineNum)
		let indent = indent(lineNum)

		if (lineContents != "")
			if (stepVal == 1)
				if (indent <= startIndent)
					let destination = lineNum - 1
					
					" now back up a bit to find the first non-empty line
					while (destination >= startLineNum)
						let lineContents = getline(destination)

						if (lineContents != "")
							if (destination == startLineNum)
								" if destination is the same, it might
								" be more fruitful to look in other
								" direction...this gets us the %-style toggle
								if (a:timesThru == 0)
									call IndentBouncer(stepVal * -1, a:timesThru + 1)
									return
								endif
							else
								" go to that line! (and remember something about this bounce)
								let g:indent_bounce_breadcrumb = startLineNum . crumbSeparator . destination
								exe destination
								return
							endif
						endif
						let destination = destination + (stepVal * -1)
					endwhile
				endif
			else
				if (indent < startIndent)
					" go to that line!
					exe lineNum
					return
				endif
			endif
		endif
	endwhile
endfunction
" **************** INDENTATION BASED NAVIGATION: END ********************

" show the current tag prototype as an "echo". Doesn't support multiline
" prototypes but not bad! Follow up with <C-w>} to see tag prototype in
" preview window, or standard tag commands to jump to edit the file
function! ShowTagPrototype()
	let wordUnderCursor = expand("<cword>")
	let tagSearchResult = taglist(wordUnderCursor)

	for tsr in tagSearchResult
		let fileContents = readfile(tsr["filename"])

		let searchPattern = tsr["cmd"]
		let searchPattern = searchPattern[1:len(searchPattern)-2] " chop off first/last character

		let lineIdx = match(fileContents, searchPattern)
		
		if (lineIdx != -1)
			let lineContents = fileContents[lineIdx]

			let leadin = ""
			if (len(tagSearchResult) > 1)
				let leadin = "(1/" . len(tagSearchResult) . ") "
			endif

			" strip leading whitespace
			let formattedLineContents = substitute(lineContents, "^[ \t]*","","")

			" add leadin
			let formattedLineContents = leadin . formattedLineContents

			" let formattedLineContents = formattedLineContents . " (" . len(formattedLineContents) . " / " . winwidth(0) . ")"

			" make sure it doesn't overflow...
			if (len(formattedLineContents) > winwidth(0))
				let formattedLineContents = formattedLineContents[:winwidth(0)-4] . "..."
			endif
			echo formattedLineContents
		else
			echo "No match found for tag \"" . wordUnderCursor . "\". (cmd was \"" . tsr["cmd"] . "\"."
		endif

		break
	endfor
endfunction

" got two new ways of firing off commands from vim, to separate
" terminals/windows/panes. If in tmux, the SendFreshCommandToTMUX /
" SendKeysToTMUX stuff is very flexible and probably easiest; lets me send
" CTRL characters to kill processes, target any window/pane easily, etc.
"
" If I'm not in tmux (cygwin for instance) the second approach with named
" pipes is maybe easier, sending stuff to a FIFO. That also lets me do it with
" separate terminal windows if that is something that makes sense for a
" particular workflow.
"
"

" include an extra enter to get past the "Press ENTER to type command to continue" prompt
" map \ :call SendKeysToTMUX("assetPipe.2", "C-c \"clear\" Enter \"date\" Enter \"node app.js\" Enter")<enter><enter>
" map  :call SendFreshCommandToTMUX("assetPipe.2", "node app.js")<enter><enter>

" simple wrapper that cancels out previous cmd if any, clears screen, puts a
" datestamp up, and then calls SendKeysToTMUX

" takes optional second param to specify the tmux target; defaults to pane 1 of current window
function! SendFreshCommandToTMUX(cmdString, ...)
	let tmuxTarget="1"
	if a:0 > 0
		let tmuxTarget = a:1
	end

	" if (a:skipCancel > 0)
		" let updatedCmdString = "\"clear\" Enter \"" . a:cmdString . "\" Enter"
	" else
		" let updatedCmdString = "C-c \"clear\" Enter \"date\" Enter \"" . a:cmdString . "\" Enter"
	" end
	let updatedCmdString = "\"clear\" Enter \"" . a:cmdString . "\" Enter"

	echo "update [" . updatedCmdString . "]"
	call SendKeysToTMUX(tmuxTarget, updatedCmdString)
endfunction

" sends keys to some tmux window. Maybe look into vimux/tslime?
function! SendKeysToTMUX(target, cmdString)
	" let fullCmd = "!tmux send-keys -t " . a:target . " " . a:cmdString
	" echo "full cmd [" . fullCmd . "]"
	" silent execute fullCmd
	" redraw!
	
	let fullCmd = "tmux send-keys -t " . a:target . " " . a:cmdString
	call system(fullCmd)
	redraw!

endfunction

" examples
" :call FIFO("javac Foo.java") # sends compile cmd to fifo /tmp/vimCmds
" :call FIFO("java Foo", "B") # sends run cmd to fifo /tmp/vimCmdsB
" use in conjunction with listenForVimCommands.sh / http://blog.jb55.com/post/29072842980/sending-commands-from-vim-to-a-separate-tmux-pane
function! FIFO(cmd, ...)
	if a:0 > 0
		let pipeName = "/tmp/vimCmds" . a:1
	else
		let pipeName = "/tmp/vimCmds"
	end

	" echo "need to send [" . a:cmd . "] to [" . pipeName . "]"
	let fullCmd = "!echo \"clear ; echo \"STARTFIFOCMD\" ; date ; " . a:cmd . "\" > " . pipeName
	" echo "full cmd [" . fullCmd . "]"
	silent execute fullCmd
	redraw!
endfunction

function! ReloadFirefoxTab(pattern)
	" silent execute "!osascript /Users/tfeiler/development/appleScripts/firefoxReloader.scpt " . a:pattern
	silent execute "!/Users/tfeiler/development/shellScripts/firefoxReloader.scpt " . a:pattern
	redraw!
	echo "reloading Firefox tab with [" . a:pattern . "] url's..."
endfunction

function! CheckCommandServerStatus()
	echo "command server port is [" . g:remote_cmdserver_port . "]"
endfunction

function! ReloadChromeTab(pattern)
	if $TOM_OS == 'cygwin'
		call ReloadChromeTabWithAutoHotKey(a:pattern)
	else
		call ReloadChromeTabWithChromix(a:pattern)
	endif
endfunction
" map \ :call ReloadChromeTab("random.org")<enter>


function! ReloadChromeTabWithAutoHotKey(pattern)
	let scriptPath="/cygdrive/c/development/AHK\\ Scripts/chromeReloader.ahk"
	silent execute "!cygstart " . scriptPath . " " . a:pattern
	redraw!
endfunction

" wrapping it in a function means we can get it to run in the background sorta, and not screw up vim's display
" this requires Chromix installation and a running Chromix server
function! ReloadChromeTabWithChromix(pattern)
	" silent execute "!chromix with " . a:pattern . " reload"
	" silent execute "!chromix with " . a:pattern . " goto " . a:pattern
	
	" best compromise - loads, creates if necessary, and focuses. Some of the
	" other options work great if I only have a single page I'm looking at,
	" but if I'm viewing multiple pages (like a website and a testsuite say)
	" it's worth it to step through this extra hoop
	" silent execute "!chromix with " . a:pattern . " close ; chromix load " . a:pattern
	" silent execute "!chromix with " . a:pattern . " reload ; chromix with " . a:pattern . " focus"
	if g:remote_cmdserver_port == -1
		silent execute "!chromix load " . a:pattern . " ; chromix with " . a:pattern . " reload"
		let methodology="local chromix"
	else
		" attempt to run it via curl/simpleCommandServer
		exe "silent !curl -s localhost:" . g:remote_cmdserver_port . "/chromix/with/" . a:pattern . "/reload"
		let methodology="tunnelling over port " . g:remote_cmdserver_port
	endif

	redraw!
	echo "reloading Chrome tabs with [" . a:pattern . "] url's using " . methodology . "..."
endfunction

" see scripts/loanerPseudoServer.sh for example of how this is useful
function! SendNetcatCommand(server, port, command)
	silent execute "!echo '" . a:command . "' | nc " . a:server . " " . a:port
	redraw!
	echo "sent [" . a:command . "] over netcat to server [" . a:server . ":" . a:port . "]..."
endfunction

function! SendNodeTestCmd(url)
	silent execute "!curl " . a:url
	redraw!
	echo "hit [" . a:url . "]"
endfunction

function! ToggleBlockCommentC()
	call ToggleBlockComment("/*", "*/")
endfunction

function! ToggleBlockComment(startSequence, endSequence)
	let line = getline(".")

	let startIdx = stridx(line, a:startSequence)
	let endIdx = stridx(line, a:endSequence)

	" couldn't get regex approach to work here...
	"let probe = matchstr(line, a:startSequence . ".*" . a:endSequence)
	if (startIdx > -1 && endIdx > startIdx)
		let repl = substitute(line, escape(a:startSequence, a:startSequence), "", "")
		let repl = substitute(repl, escape(a:endSequence, a:endSequence), "", "")
	else
		let repl = substitute(line, "\\(.*\\)", a:startSequence . "\\1" . a:endSequence, "")
	endif

	call setline(".", repl)
endfunction

function! SetExpandTabForIndentedLanguages()
	let currentFileType=&filetype
	" echo "sample fxn! [" currentFileType "]/[" @% "]"
	set nosmartindent

	if currentFileType == "python" || currentFileType == "coffee"
		" echo "python/coffee/etc. - expandtab"
		set expandtab
	else
		let fullFilename=expand("%:p")
		" echo "full name [" fullFilename "]"

		if currentFileType == "php" && (stridx(fullFilename, "${MOODLE_WSG}") == 0 || stridx(fullFilename, "/Users/tfeiler/remotes/mitreClampHome") == 0 || stridx(fullFilename, "/home/tfeiler/moodles") == 0)
			" moodle coding standards call for spaces not tabs
			" echo "php in moodle - expandtab"
			set expandtab
			
			" new - trying out as per moodle suggestions
			set smartindent
		else
			" echo "ANYTHING ELSE - change it back"
			set noexpandtab
		endif
	endif
endfunction

" mapped to <C-P> for me usually; if paste mode was off, turns it on and enters insert mode. And,
" sets up an autocommand to call this function again when existing insert mode.
"
" when called with insert mode on, turns it back off.
"
" Nice - now when I have stuff to paste in like sql or html or what have you I
" can just do
" ctrl-P			command-V	esc
" (PasteToggler)	(paste)		(exit insert mode)
" TODO - make this insert a blank line below
function! PasteToggler()
	let inPasteMode = &paste
	set paste!
	if inPasteMode == 0
		" startinsert
		" insert a blank line below and sstart pasting
		normal o

		augroup paste_callback
			"clear the group
			autocmd!

			" when we leave insert mode, call this function again and we'll toggle paste back off
			autocmd InsertLeave <buffer> call PasteToggler()
		augroup END
	else
		augroup paste_callback
			autocmd!
		augroup END
	endif
endfunction

" see http://vim.wikia.com/wiki/PHP_online_help for the idea; K is mapped to this function instead of default use of keywordprg
function! EnhancedKeywordLookup()
	let wordUnderCursor = expand("<cword>")
	let ft = &filetype

	if g:remote_cmdserver_port == -1
		" just run the command
		exe "silent !~/development/shellScripts/vim/keyword/keywordLookup.js " . ft . " " . wordUnderCursor . " | less"
	else
		" attempt to run it via curl/simpleCommandServer
		exe "silent !curl -s localhost:" . g:remote_cmdserver_port . "/vk/" . ft . "/" . wordUnderCursor . " | less"
	endif
	redraw!

endfunction

" usually extension is enough to tell us what the filetype is, but sometimes
" it's not. For instance I often name shell scripts with .sh extension but use
" Node.js, so I want JavaScript filetype.
function! DetectScriptFiletype()
	let firstLineOfFile = getline(1)

	if firstLineOfFile =~# '^#!/usr/local/bin/node\>'
		set filetype=javascript
	endif
endfunction

function! IndentSurroundingBlock()
	" step 1 - let's find the enclosing curly brace and jump the cursor back
	" to it. We need to either echo the val or store it in variable or vim
	" complains?
	let bracketPos = searchpair('{', '', '}', 'bW')

	" step 2 - do "=" (which indents) to "%" (the matching curly brace)
	normal =%

	" note you can keep hitting this command and it will just move up out 
	" of nested brackets as you go. So like first it will do inside and if
	" block, then inside the loop it's in, then inside the function that's in,
	" etc.
endfunction

function! CellmateUpload()
	let currFilename = @%
	let workingDir = system("pwd")
	let workingDir = substitute(workingDir, "\n", "", "")
	let fullPath = workingDir . "/" . currFilename
	
	" cellmate source is available on my DookTibs github
	" you'll need google SDK installed; I have a python virtualenv "google_uploader" that will do this,
	" do 'workon google_uploader' to enable it in the tmux window that is running this...
	let cmd = "python ~/development/acc/cellmate/cellmate.py -f " . fullPath . " -o upload"
	" execute "!" . cmd
	call SendFreshCommandToTMUX(cmd)
endfunction

function! ToggleLocationWindow()
	call ToggleWindow("variables.current_syntax", "qf", "lopen", "lclose")
endfunction

function! ToggleWindow(targetField, targetVal, openCmd, closeCmd)
	let targetChunks=split(a:targetField, "\\.")

	" do it this way and buffers is a list of Dictionaries with various items listed...
	" let buffers = map(filter(copy(getbufinfo()), 'v:val.listed'), 'v:val')
	
	" do it this way
	let buffers = map(filter(copy(getbufinfo()), 'v:val.listed'), 'v:val')

	let windowIsOpen = 0

	let idx = 0
	for b in buffers
		let idx += 1
		" echo "buffer [" . idx . "], [" . a:targetField . "]:"
		" echo b
		let val = b
		for chunk in targetChunks
			let val = val[chunk]
		endfor
		" echo val
		if (val == a:targetVal)
			let windowIsOpen = 1
		endif
	endfor

	if (windowIsOpen == 1)
		exe a:closeCmd
	else
		try
			exe a:openCmd
		catch
			echo "Unable to open window using '" . a:openCmd . "'"
		endtry
	endif

endfunction
