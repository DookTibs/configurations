" TODO - check out https://sookocheff.com/post/vim/neovim-java-ide/ and see if we can make this cleaner...



" NOW following instrux at https://neovim.io/doc/user/lsp.html#lsp-extension-example

" this should live in shellScripts
if stridx(currentDir, "/Users/38593/development/icf_dragon/src/main/java") == 0
	" STARTS IT EVERY TIME which is kinda costly -- could I launch myself and just attach? For now just only run it while working on icf_dragon java stuff
	" lua require('lspconfig').jdtls.setup{ cmd = { '/Users/tfeiler/development/tools/eclipse.jdt.ls/launchme.sh' } }

	"lua require('lspconfig').jdtls.setup{ cmd = { '/Users/38593/development/shellScripts/launchEclipseJdtLanguageServer.sh' } }
	
	echo "Launching jdtls..."
	lua require('lspconfig').jdtls.setup{ cmd = { 'jdtls' } }
endif

" DISABLED -- python language server experiments.
" mkvirtualpyenv py_lsp_tests
" pip install python-lsp-server
" pip install python-lsp-server[all]
"
if "testing" == "testingx"
	echo "Launching pylsp..."
	lua require('lspconfig').pylsp.setup{ cmd = { 'pylsp' } }
endif

" these all from chrisatmachine.com/Neovim/27-native-lsp/
if "foo" == "foo"
	nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
	" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> <C-s> <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
	nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

	lua vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
endif
" nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>

" need this so we can find the compe-config lua module when requiring it; put it in ...../development/configurations/neovim/customRuntimePath/lua/compe-config/init.luq
" set runtimepath+=/Users/tfeiler/development/configurations/neovim/customRuntimePath
" lua require("compe-config")
" commented out b/c instead I'm just gonna configure it inline in VimScript; the Lua example didn't work!

" set completeopt="menuone,noselect"

" LUA DEBUGGING:
" vim.api.nvim_echo({{'AUTOCOMPLETE SET TO:'}, {foo}}, true, {})

if "usingcompe" == "nope"
	let g:compe = {}
	let g:compe.enabled = v:true
	let g:compe.autocomplete = v:false
	let g:compe.debug = v:false
	let g:compe.min_length = 1
	let g:compe.preselect = 'enable'
	let g:compe.throttle_time = 80
	let g:compe.source_timeout = 200
	let g:compe.resolve_timeout = 800
	let g:compe.incomplete_delay = 400
	let g:compe.max_abbr_width = 100
	let g:compe.max_kind_width = 100
	let g:compe.max_menu_width = 100
	let g:compe.documentation = v:true

	let g:compe.source = {}
	let g:compe.source.path = v:true
	let g:compe.source.buffer = v:true
	" let g:compe.source.calc = v:true
	let g:compe.source.nvim_lsp = v:true
	let g:compe.source.nvim_lua = v:true
	" let g:compe.source.vsnip = v:true
	" let g:compe.source.ultisnips = v:true
	" let g:compe.source.luasnip = v:true
	" let g:compe.source.emoji = v:true

	" CTRL-slash will launch the autocomplete window
	inoremap <silent><expr> <C-\> compe#complete()
	inoremap <silent><expr> <CR> compe#confirm('<CR>')
endif
