" vimdiff didn't work on OSX for me; I had to do:
" sudo ln -s /usr/bin/diff /usr/share/vim/vim73diff
" to get it working right

" this is ok, but only one file with a given name can be backed up at a time.
" i guess leave it this way for now.
" set backupdir=/cygdrive/c/Users/tfeiler/vimBackups/,.
set backupdir=~/vimBackups/,.

" this changes swap directory (double slash at end ensures unique filenames so
" you can edit multiple files from different dirs with same filename
" set directory=~/vimBackups//,.

" this vimrc is used by cygwin vim.
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim

set nu
set ai
highlight Normal guibg=Black guifg=White
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set incsearch
set hlsearch
syntax on
" filetype on
filetype plugin indent on

" set working directory to whatever we just opened, interesting...
set autochdir

" map plus to toggle buffers
map + :e #

map ^ :call IndentBouncer(1, 0)<enter>
map <Space> :call ShowTagPrototype()<enter>

" colorschemes live in /usr/share/vim/vim73/colors/
" others that are ok: torte, delek, darkblue, slate, zellner
" also have some in ~/.vim/bundle like vim-colors-solarized (along with other plugins)
" colorscheme torteTibs
" colorscheme torte
colorscheme solarized " see https://github.com/altercation/vim-colors-solarized / http://ethanschoonover.com/solarized
" colorscheme torte
if g:colors_name == "solarized"
	" syntax enable
	set background=dark
endif

" airline
" always show the status line
set laststatus=2
" enable 256 colors - not strictly an airline thing, but that's where I came across it
set t_Co=256
let g:airline_powerline_fonts=1
let g:airline_theme='kolor'

" slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" CTAGS STUFF START
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
" CTAGS STUFF END

" use "gx" to open urls in browser

" when editing php, make shift-K run this command that looks stuff up from php docs!
au FileType php set keywordprg=~/development/shellScripts/vim/php_doc.sh

" rainbow parentheses
" " au VimEnter * RainbowParenthesesActivate
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
" map ) :RainbowParenthesesToggle<enter>

" clojure
" au BufRead,BufNewFile *.clj xmap \ <Plug>SlimeRegionSend
" au BufRead,BufNewFile *.clj nmap \ <Plug>SlimeParagraphSend

" remember folds when I exit/re-enter
" au BufWinLeave ?* mkview
" au BufWinEnter ?* silent loadview

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

" whenever I open a python/coffee/etc file, set tabs to expand
" au FileType python set expandtab
au FileType * call SetExpandTabForIndentedLanguages()
" au FileType * call UpdateReasonPackageSwitcher()

let currentDir=system("pwd")
" echo "Current Dir is:" currentDir

" sometimes cydgrive doesnt appear in path which screws things up...
if currentDir[0:2] == "/c/"
	let currentDir="/cygdrive" . currentDir
endif

" disables persistent undo; I think I prefer the old way
set noundofile
