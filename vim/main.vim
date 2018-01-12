" vimdiff didn't work on OSX for me; I had to do:
" sudo ln -s /usr/bin/diff /usr/share/vim/vim73diff
" to get it working right

" this is ok, but only one file with a given name can be backed up at a time.
" i guess leave it this way for now.
" set backupdir=/cygdrive/c/Users/tfeiler/vimBackups/,.
set backupdir=~/vimBackups/,.

let mapleader=";"

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
" relocated to the increasingly poorly named SetExpandTabForIndentedLanguages
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
" set noexpandtab
set incsearch
set hlsearch
" au FileType text echo "textwidth set to 0; run ':set tw=78' to revert to default for this file"
syntax on
filetype on

" I don't like this type of behavior as much...makes auto-indent not-so-hot
" when doing stuff like editing javascript/css embedded in another page. (of
" course, if I wanted to enforce that type of separation, adding this back in
" would be good incentive!)
" filetype plugin indent on

" set working directory to whatever we just opened, interesting...
set autochdir

" map plus to toggle buffers
map + :e #

map ^ :call IndentBouncer(1, 0)<enter>
map <Space> :call ShowTagPrototype()<enter>

" by default # does reverse search of current word (like * but opposite direction)
" I don't use that all that much so instead let's map it to toggle line numbers
" map # :set nu!<enter>
map # :call ToggleLineNumDisplay()<enter>

" colorschemes live in /usr/share/vim/vim73/colors/
" others that are ok: torte, delek, darkblue, slate, zellner
" also have some in ~/.vim/bundle like vim-colors-solarized (along with other plugins)
" colorscheme torteTibs
" colorscheme torte
" colorscheme solarized " see https://github.com/altercation/vim-colors-solarized / http://ethanschoonover.com/solarized
" colorscheme torte

" new way - decide on solarized/torte on the fly. have to use "execute" to
" build up the command dynamically
let appropriateColorScheme = system("selectAppropriateVimColorScheme.sh")
execute 'colorscheme' appropriateColorScheme


" if g:colors_name == "solarized"
	" syntax enable
	" set background=dark
" endif


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
let g:slime_dont_ask_default = 1

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

" not ctags, but let's map TL to show listing of matching tags
map TL g]

" use "gx" to open urls in browser

" when editing php, make shift-K run this command that looks stuff up from php docs!
map K :call EnhancedKeywordLookup()<enter>
" au FileType php set keywordprg=~/development/shellScripts/vim/keyword/shortcuts/sc_php.sh
" au FileType javascript set keywordprg=~/development/shellScripts/vim/keyword/shortcuts/sc_javascript.sh

" rainbow parentheses
" " au VimEnter * RainbowParenthesesActivate
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
" map ) :RainbowParenthesesToggle<enter>

" map CTRL-P to toggle paste mode. Interesting - once in cmd mode, can use
" C-P/C-N to look at prev/next command history in vim
map <C-P> :call PasteToggler()<enter>

map <C-I> :call IndentSurroundingBlock()<enter>

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

au FileType * set tw=0

au BufNewFile,BufRead * call DetectScriptFiletype()

let currentDir=system("pwd")
" echo "Current Dir is:" currentDir

" sometimes cydgrive doesnt appear in path which screws things up...
if currentDir[0:2] == "/c/"
	let currentDir="/cygdrive" . currentDir
endif

" disables persistent undo; I think I prefer the old way
set noundofile

" interesting - I used this to unravel a weird phising email - takes a capture
" from a substitute command and appends it onto the A buffer, then jumps
" around some windows. Couple of neat tricks I had never seen before
" map \ :s-ccc += '\(.*\)'-\=setreg('A', submatch(1))-n<enter>j4bma*mb:'ad<enter>'b 

let hostName=system('hostname')
if stridx(hostName, ".acs.carleton.edu") != -1
	let g:remote_cmdserver_port = -1
	" hardcoding this for summer2015 as I will usually be remote and wanting
	" to tunnel like this. NOTE - ALSO RESTORE EnhancedKeywordLookup
	" function!!!!
	" let g:remote_cmdserver_port = 2997
else
	let g:remote_cmdserver_port=2499
endif

let g:tibs_search_basedir="."
" ack related
" make ack.vim use ag as it's command
let g:ackprg = 'ag --vimgrep'
" supposedly these will make Ack work without jumping to the first file in the list. Doesn't work for me though...
" cnoreabbrev Ack Ack!
" nnoremap <Leader>a :Ack!<Space>

" :DragonSearch "foobar" will search the entire Dragon codebase using the ack.vim plugin
" :DragonSearch by itself will search using the word under the cursor
" command! -bang -nargs=* -complete=file DragonSearch           call ack#Ack('grep<bang>', (<q-args> == "" ? expand("<cword>") : <q-args>) . ' /cygdrive/c/Users/38593/workspace/icf_dragon/' )
command! -bang -nargs=* -complete=file TibsSearch           call ack#Ack('grep<bang>', (<q-args> == "" ? expand("<cword>") : <q-args>) . ' ' . g:tibs_search_basedir )
" we intentionally don't add a <enter> here - this lets us add a search term if we want, or just hit enter manually
" to search for the current word.
map // :TibsSearch! 

map zz :call FoldBlock()<enter>

" code for easy line highlights. underscore will highlight line as cursor moves
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white
map _ :set cursorline!<enter>

" and dash will let me add custom highlights (useful if I am jumping around and interested in 
" particular areas, or want to mark temp debug code, etc.)
hi TempLineMarker cterm=NONE ctermbg=green ctermfg=darkred
map - :call ToggleCustomLineHighlight()<enter>

map <F5> :redraw!<enter>

" with non-zero values, vim will start scrolling as you approach the top/bottom of the visible portion of the file
set scrolloff=0
