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

map <leader><Space> :call ShowTagPrototype()<enter>

let tlist_actionscript_settings = 'actionscript;c:classes;k:consts;p:properties;F:public methods;f:private methods;z:protected methods;g:getters;s:setters;v:variables'
let tlist_coffee_settings = 'coffee;c:classes;s:static methods;f:function;v:variable'
let Tlist_Auto_Open=0
let Tlist_Sort_Type='name'
let Tlist_Exit_OnlyWindow=1
if &diff
	" if diffing (especially with git), leaving this as 1 causes some errors
	" in generating tags
	let Tlist_Process_File_Always=0
else
	let Tlist_Process_File_Always=1
endif
map TT :TlistToggle<enter>
" nota bene - if taglist isn't working right (TlistToggle is empty for instance) then check to see if you are using
" windows ctags and cygwin vim, etc. Path can screw it up. If so edit taglist.vim and replace command like:
"             let ctags_cmd = ctags_cmd . ' "' . a:filename . '"'
" with:
"			  let ctags_cmd = ctags_cmd . ' `cygpath -m "' . a:filename . '"`'
"

" not ctags exactly, but let's map TL to show listing of matching tags
map TL g]
