" this belongs in ~/.config/nvim/init.vim

source ~/development/configurations/neovim/neovim.vim
source ~/development/configurations/neovim/plugins.vim
source ~/development/configurations/neovim/functions.vim
source ~/development/configurations/neovim/main.vim

" source ~/development/configurations/neovim/ctags.vim
source ~/development/configurations/neovim/lsp.vim

source ~/development/configurations/neovim/icf.vim


" let's add a way to run current buffer through JSON format

" 'sh'/'shell' doesn't exist in Neovim and I want something like it...
if exists('$TMUX')
	" just open a tmux split, easier
	" cnoreabbrev sh silent exec "!tmux split-window -v"
	" cnoreabbrev shell silent exec "!tmux split-window -v"
	command Shell silent exec "!tmux split-window -v"
else
	" REMEMBER -- when in Neovim's built-in terminal, gotta use
	" CTRL-\ CTRL-n to get into normal mode on the buffer (clunky).
	" I start right in insert mode so that you can type a shell command
	" immediately, and then send a dummy carriage return when the shell
	" exits so that it closes instantly.

	" cnoreabbrev sh split term://bash
	" cnoreabbrev shell split term://bash
	" autocmd BufWinEnter,WinEnter term://* startinsert
	" autocmd TermClose term://* call nvim_input('<CR>')
endif

