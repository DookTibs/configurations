" see for cscope:
" http://cscope.sourceforge.net/large_projects.html
" http://cscope.sourceforge.net/cscope_vim_tutorial.html
"
" see for GNU global:
" https://www.gnu.org/software/global/globaldoc_toc.html#Vim-editor
" http://linux.byexamples.com/archives/538/gnu-global-the-programmers-friend/


let style="B"

if (style == "A")
	source ~/development/configurations/vim/gtags.vim
	map <C-]> :Gtags<CR><CR>
	map <C-\> :Gtags -r<CR><CR>
	" map <F10> :cclose<CR>
	" map <F11> :cp<CR>
	" map <F12> :cn<CR>
elseif (style == "B")
	" script me to create GTAGS:
	" go to /cygdrive/c/Users/38593/workspace/icf_dragon/src/main/java and:
	"		find "$PWD"/ -name '*.java' > gtags.files
	" (possibly filter out the ones that just define the interface?)
	" (replace /cygdrive/c/ with c:/ since we are using windows compiled version of gtags)
	"		gtags -f gtags.files
	
	source ~/development/configurations/vim/cscope_maps.vim
	if stridx(currentDir, "/cygdrive/c/Users/38593/workspace/icf_dragon/src/main/java") == 0
		set cscopeprg=gtags-cscope
		set nocsverb
		cs add /cygdrive/c/Users/38593/workspace/icf_dragon/src/main/java/GTAGS
		set csverb

		au BufEnter * call ReloadCscopeDatabase("/cygdrive/c/Users/38593/workspace/icf_dragon/src/main/java")


		" earlier failed tests	
		" set cscoperelative
		" cs add /cygdrive/c/Users/38593/workspace/icf_dragon/src/main/java/GTAGS /cygdrive/c/Users/38593/workspace/icf_dragon/src/main/java/
	endif
else
	" disabled...
endif
