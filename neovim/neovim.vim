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
map <C-]> :call TagSearch()<enter>
