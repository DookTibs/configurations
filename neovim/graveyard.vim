" this is stuff that I don't think I currently use for one reason or another.




" can't remember what this was for...
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

" rainbow parentheses
" " au VimEnter * RainbowParenthesesActivate
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
" map ) :RainbowParenthesesToggle<enter>

" syntax setup
au BufRead,BufNewFile *.as set filetype=actionscript
au BufRead,BufNewFile *.jsfl set filetype=javascript
au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.clj set filetype=clojure
au BufRead,BufNewFile *.coffee set filetype=coffee
au BufRead,BufNewFile Cakefile set filetype=coffee
" unnecessary: on windows and osx gvim (there just drop the syntax file in the right dir and it will autoload),
" but needed on cygwin vim (which looks in a different syntax directory, /usr/share/vim/vim73/syntax)
" au! Syntax actionscript source /cygdrive/c/Vim/vim73/syntax/actionscript.vim
