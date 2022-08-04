" starting with Neovim (Aug 2021), I no longer am using Pathogen and instead am switching
" to vim-plug (https://github.com/junegunn/vim-plug/wiki/tutorial). I installed this
" in /Users/tfeiler/.config/nvim/autoload
"
" then
" 1. call "Plug" commands as needed
" 2. call :PluginInstall to actually install the new ones. They go in:
" :echo stdpath('data') == /Users/tfeiler/.local/share/nvim
" 3. can call :PlugStatus to check on things.
"
" Note unlike with Pathogen you don't need to manually clone the repo for
" these things; the vim-plug plugin handles that for you. It will map partial
" URLs to Github ('tpope/vim-fugitive' -> 'https://github.com/tpope/vim-fugitive')
" or accept absolute URLs.
"
" On a new computer, just manually install vim-plug and then call PlugInstall
" and everything should get pulled in, rather than lots of manual cloning.
"
" To temporarily disable a plugin, just comment it out; or call Plug
" conditionally, etc.
"
" Note that if you can PlugClean and things are conditionally turned off, then
" they can potentially be uninstalled! vim-plug will give you an interface and
" let you pick and choose. If you screw up just make sure it's Plug'ed again
" and :PlugInstall to bring it back in.
"
" PlugUpdate to update plugins.

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
	" LSP-related items for making Vim like an IDE for Java, etc.
	Plug 'neovim/nvim-lspconfig'
	Plug 'mfussenegger/nvim-jdtls'
	Plug 'hrsh7th/nvim-compe'

	Plug 'tpope/vim-fugitive'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'jpalardy/vim-slime'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'altercation/vim-colors-solarized'
	Plug 'vim-scripts/taglist.vim'
	Plug 'tpope/vim-unimpaired'

	" do I still use these?
	Plug 'mileszs/ack.vim'
	Plug 'scrooloose/nerdtree'

	" for now, only run ALE when doing HAWC.
	if stridx(system("pwd"), "/Users/tfeiler/development/hawc_project/hawc") == 0
		Plug 'dense-analysis/ale'
	endif

	" July 2022 - try https://github.com/mfussenegger/nvim-dap for using jdb.
	" I was previously using nvim-jdtls; see  "Debugger" instrux at https://github.com/mfussenegger/nvim-jdtls
	" and I:
	"	1. cloned the "java-debug" project into ~/development/tools/java-debug
	" Plug 'mfussenegger/nvim-dap'
	" ABANDONED -- needs Java 17 - and I am going with my own tibs_jdb_vim bridge stuff!

	" if I'm in the litstream codebase I am using LSP instead of ctags,
	" etc.
call plug#end()
