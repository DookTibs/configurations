" I manage plugins using Pathogen. Install that following instructions at
" https://github.com/tpope/vim-pathogen.
"
" Once that's there, just drop pathogen compatible plugins into ~/.vim/bundle,
" and Pathogen will load them in automatically. To drop them in, you can do
" something like:
"		git clone git://github.com/christoomey/vim-tmux-navigator ~/.vim/bundle/vim-tmux-navigator
"		git clone git://github.com/vim-scripts/taglist.vim.git ~/.vim/bundle/taglist
"		git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline
"
" To temporarily disable a plugin, add it to the g:pathogen_disabled variable.
"
" PLUGINS I CURRENTLY USE
" taglist
" vim-tmux-navigator
" vim-slime
" vim-airline
" vim-colors-solarized
" vim-fugitive
"
" see http://www.openlogic.com/wazi/bid/262302/Three-tools-for-managing-Vim-plugins (has typos) for some more info

let g:pathogen_disabled = []

" for now, only run ALE when doing HAWC.
if stridx(system("pwd"), "/Users/tfeiler/development/hawc_project/hawc") != 0
	call add(g:pathogen_disabled, 'ale')
endif

" call add(g:pathogen_disabled, 'vim-airline')
call add(g:pathogen_disabled, 'supertab')
" call add(g:pathogen_disabled, 'vim-vebugger')
execute pathogen#infect()

