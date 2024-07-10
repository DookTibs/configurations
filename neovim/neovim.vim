" in Vim when you hit CTRL-] to jump to the tag for the word under the cursor, and
" there are multiple matches, it pulls up a menu. In Neovim it seems to just jump to the first
" match. This is not great if you have like a abstract base class and multiple implementations
" and you want a specific one. So instead of calling "tag X" I map it to call "tselect X".
"
" Note that just calling "tag X" at Ex will also just jump to the first so I need to get 
" it in mind to remember to call "tselect" manually in those cases. but this at least fixes
" the quick shortcut so it works the way I remember.
function! TagSearch()
	echo "-----"
	echo "tfeiler custom TagSearch method - remember to use 'tselect' not 'tag' when entering manually..."
	echo "-----"
	let currWord = expand("<cword>")
	execute 'tselect ' currWord
endfunction
"map <C-]> :call TagSearch()<enter>

" 20240628 - this works even better
" https://superuser.com/questions/679160/how-to-jump-to-correct-method-definition-when-more-than-one-tags-match
" remap...
nnoremap <C-]> g<C-]>

" while we're at it, let's override :ta
" https://stackoverflow.com/questions/2605036/how-to-redefine-a-command-in-vim
":command -nargs=+ TIBSTAGFIX :tselect "<args>"
":cabbrev ta TIBSTAGFIX
":cabbrev tag TIBSTAGFIX

" another attempt - let's map this to "ta" and keep original "tag" command as-is
" (I like mine just fine, but we don't have any autocomplete on tag names with it...)
"
" This uses the tagJumper script I wrote; if tagJumper doesn't find an exact match, we
" fall back to standard behavior.
function! TibsTagJumper(tagName)
	" echo "tibstagjump: " . a:tagName
	let lineAndFile=system(["tagJumper.sh", a:tagName])
	if v:shell_error == 0
		" thanks https://stackoverflow.com/questions/26291758/how-to-manually-push-stack-entry-into-vim-tagstack
		" Store where we're jumping from.
		let preJumpPos = [bufnr()] + getcurpos()[1:]
		let preJumpItem = {'bufnr': preJumpPos[0], 'from': preJumpPos, 'tagname': expand('<cword>')}

		" now jump to the new location...
		" echo "lineAndFile is: " . lineAndFile
		let chunks = split(lineAndFile, ":::")
		let lineNum = chunks[0]
		let fileName = chunks[1]
		" echo "tag is in file '" . fileName . "' at line [" . lineNum . "]"
		
		" open the file...
		execute 'e ' . fileName

		" ...and jump to the line
		exe lineNum
		
		" Assuming jump was successful, write to tag stack.
		let winId = win_getid()
		let stack = gettagstack(winId)
		let stack['items'] = [preJumpItem]
		call settagstack(winId, stack, 't')
	else
		" ran into an error; just do default tag command...
		execute 'tag ' . a:tagName
	endif
endfunction

:command -nargs=+ TIBSTAGFIX :call TibsTagJumper("<args>")
:cabbrev ta TIBSTAGFIX
" :cabbrev tag TIBSTAGFIX
