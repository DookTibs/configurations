if (1 == 1)
	" starting with Neovim (Aug 2021), I no longer am using Pathogen and instead am switching
	" to vim-plug (https://github.com/junegunn/vim-plug/wiki/tutorial). I installed this
	" in /Users/tfeiler/.config/nvim/autoload
	"
	" then
	" 1. call "Plug" commands as needed
	" 2. call :PlugInstall to actually install the new ones. They go in:
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
		Plug 'williamboman/mason.nvim'
		Plug 'williamboman/mason-lspconfig.nvim'
		Plug 'neovim/nvim-lspconfig'
		" Plug 'mfussenegger/nvim-jdtls'
		
		" NEW JUNE 2024 - KEEP OR NO? START
		" Completion
		" nvim-compe deprecated, replaced by nvim-cmp
		Plug 'hrsh7th/nvim-cmp'
		Plug 'hrsh7th/cmp-buffer'
		Plug 'hrsh7th/cmp-path'
		Plug 'hrsh7th/cmp-cmdline'
		Plug 'hrsh7th/cmp-nvim-lsp'
		
		" Snippets - works in tandem with Completion...
		Plug 'L3MON4D3/LuaSnip'
		Plug 'saadparwaiz1/cmp_luasnip'
		" there's also vsnip -- didn't try that
		Plug 'rafamadriz/friendly-snippets'
		" see https://github.com/rafamadriz/friendly-snippets/tree/main/snippets for lots of snippets
		" NEW JUNE 2024 - KEEP OR NO? END

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

		" 20240124 -- trying CoPilot
		" this one does...
		" Plug 'github/copilot.vim'
		" Plug 'hrsh7th/cmp-copilot'
		
		" 20240616 - new laptop and alternate CoPilot setup (integrating with cmp)
		" https://github.com/zbirenbaum/copilot.lua
		" https://tamerlan.dev/setting-up-copilot-in-neovim-with-sane-settings/
		Plug 'zbirenbaum/copilot.lua'
		Plug 'zbirenbaum/copilot-cmp'

		" Copilot Chat
		Plug 'nvim-lua/plenary.nvim' " needed for async lua or something?
		Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }

		" NONE OF THESE WORK RIGHT
		"Plug 'gptlang/CopilotChat.nvim'
		"Plug 'jellydn/CopilotChat.nvim'
		" Plug 'z0rzi/ai-chat.nvim'

		" for now, only run ALE when doing HAWC.
		if stridx(system("pwd"), "/Users/38593/development/hawc_project/hawc") == 0
			" https://black.readthedocs.io/en/stable/integrations/editors.html
			" Plug 'psf/black', { 'branch': 'stable' }
			"
			" https://github.com/averms/black-nvim
			" let g:python3_host_prog = "/Users/tfeiler/.virtualenvs/hawc2023/bin/python"
			" Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}
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

	" in /Users/38593/.config/nvim do:
	" ln -s ~/development/configurations/neovim/luaconfigs/ lua
	" And then you can drop files like 'foobar.lua' into ~/development/configurations/neovim/luaconfigs/ and then do "lua require('foobar')" to hook into it from VimScript. "lua require('foo.bar')" for nested in directories.
	"
	" I CHANGED FROM MOnaco13 to this POS. find a better one later.

	" run configurations defined in lua
	lua require('my_cmp')
	lua require('my_copilot')
	lua require('my_lsp')
else
	" June 2024 - experimenting with switching from vim-plug to packer
	"
	" abandoning for now -- vim-slime is throwing errors when opening
	" python files (https://github.com/jpalardy/vim-slime/issues/432).
	" maybe try again sometime; this was semi-working if you install Packer
	" by hand (https://github.com/wbthomason/packer.nvim)...like I could add
	" plugins and all, but I am only a few in and already hitting issues.
	"
	" Also was getting lots of dupes in nvim-cmp suggestion list. Maybe a
	" coincidence, but was definitely annoying
	"
	" My reason for trying Packer was to get lazyloading support, but giving
	" up for now.
	lua require('packer_plugins')
endif

" TESTING!!! why does vim-tmux-navigator work normally -- but not when following a sag shortcut?
" let g:tmux_navigator_no_mappings = 1

" function! SackNavDebugger(xxx)
	" echo "TIBSY '" .. a:xxx .. "'"
" endfunction

" this fails too...
" echo "MAPPING ISSUE!"
" let g:C_Ctrl_j = 'off'
" let g:C_Ctrl_k = 'off'
" let g:BASH_Ctrl_j = 'off'
" map <C-j> :<C-U>call SackNavDebugger("down")<cr>
" map <C-k> :<C-U>call SackNavDebugger("up")<cr>

" nnoremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>
" nnoremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>
" nnoremap <silent> <C-k> :<C-U>TmuxNavigateUp<cr>
" nnoremap <silent> <C-l> :<C-U>TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :<C-U>TmuxNavigatePrevious<cr>
