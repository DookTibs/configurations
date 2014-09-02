" I don't use any of this stuff anymore; just keeping it around for posterity's sake

"burn those lazy keyboard bridges
map [A :echo "use k to move up"
map [B :echo "use j to move down"
map [C :echo "use l to move right"
map [D :echo "use h to move left"

" not needed anymore, now I have tmux_navigator
" faster split switching
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l
" map <C-h> <C-w>h

" stuff moved from mswin.vim so we don't take all of it - start
" next two lines are commented out on OSX but uncommented on Windows
" behave mswin
" set backspace=indent,eol,start whichwrap+=<,>,[,]
" these are commented out everywhere
" map <C-V>		"+gP
" cmap <C-V>		<C-R>+
" stuff moved from mswin.vim so we don't take all of it - end

" is any of this needed when using cygwin vim?
" set shell=C:/cygwin/bin/bash
"set shellxquote=\"
" not needed...
" set shellcmdflag=--login\ -c

" OLD WAY OF DOING THINGS
" map \ :!ant -buildfile \eclipse-workspace\fairies\srctools\flash\build.xml tool_addBadgeCard

" map \ :!ant -buildfile \eclipse-workspace\fairies\src\flash\build.xml birds
" map \ :!ant -buildfile \eclipse-workspace\fairies\src\flash\build.xml shopPanel

" new way - need to kickoff cygwin in order to run the shell script that does the copying/ant/etc.
" map \ :!C:\cygwin\bin\sh.exe fairiesBuildHelper.sh shopping

" map ^ :call ToggleBlockCommentC()<enter>j

" if on windows might need this...
" set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" set splits (including the preview window) to open below/right
" set splitbelow
" set splitright

" make the preview window smaller
" set previewheight=2

" maps the spacebar to show the prototype for what your cursor is over in the preview window
" map <Space> <C-w>}

function StartWithTag(tagName)
	"silent execute "!sleep 1"
	let launchTagCmd = "ta " . a:tagName
	execute launchTagCmd
	set syntax=actionscript
endfunction

" See http://vim.wikia.com/wiki/VimTip103
" Useful for navigating through indentation as opposed to braces based
" languages, like Python or Coffeescript.
"
"
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction
" Moving back and forth between lines of same or lower indentation.
" nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
" nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
" nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
" nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
" vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
" vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
" vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
" vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
" onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
" onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
" onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
" onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>
" **************** INDENTATION BASED NAVIGATION: END ******************** 

function LaunchLuaInterpreterOnCurrentFile()
	" execute "!'C:/Program Files (x86)/Lua/5.1/lua.exe' C:/development/lua/foo.lua"
	" @% contains the filename of the file currently being edited
	execute "!'C:/Program Files (x86)/Lua/5.1/lua.exe' " . @%
endfunction

" a couple of example ways to trigger things

" map \ :call FIFO("ant compileBacon")<enter>

" if $TOM_OS == "osx"
	" map \ :execute "!cpUiBuildHelper.sh " . cpBuildHelper<enter>
" elseif $TOM_OS == "cygwin"
	" map \ :execute "!C:/cygwin/bin/sh.exe cpUiBuildHelper.sh " . cpBuildHelper
" endif

" map  :call ToggleBuildType()
" map \ :execute "!C:/cygwin/bin/sh.exe fairiesBuildHelper.sh " . buildHelper . " " . g:buildTypes[g:selectedBuildType]
" map \ :call LaunchLuaInterpreterOnCurrentFile()
" map  :!cat letrec.ss \| ./interpreter.exe
