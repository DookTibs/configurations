--[[
  Use the :Mason command to install lsp's etc. manually, and then use this file to configure things.

  To install new langauge server, try something like:
	1. :Mason, search for the one you want, "i" to install, etc.
	2. configure it to launch at certain times with certain configs. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for samples.

 I had to edit ~/.local/share/nvim/mason/bin/jdtls and add something like:
	 declare -x JAVA_HOME=/Users/38593/.jenv/versions/22
 before the call to jdtls (as my system java is old [11] due to litstream being old!)
--]]

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mlc_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlc_ok then
  return
end

local lc_ok, lspconfig = pcall(require, "lspconfig")
if not lc_ok then
  return
end

mason.setup()


local currentDir=vim.fn.getcwd()

-- Lua string find, first position is 1, not 0?!!?!?
-- if (vim.fn.stridx(currentDir, "/Users/38593/development/icf_dragon/src/main/java") == 0) then
local java_lsp_needed = ""
local python_lsp_needed = ""

if (string.find(currentDir, "/Users/38593/development/icf_dragon/src/main/java") == 1) then
	java_lsp_needed = "litstream"
elseif (string.find(currentDir, "/Users/38593/development/lfc") == 1) then
	python_lsp_needed = "LFC"
elseif (string.find(currentDir, "/Users/38593/development/hawc_project/hawc") == 1) then
	python_lsp_needed = "HAWC"
end

if (java_lsp_needed ~= "") then
	print("Launching jdtls for " .. java_lsp_needed .. " development...(~/dev/cfgs/nvim/luaconfigs/my_lsp/mason.lua)")
	lspconfig.jdtls.setup{}
elseif (python_lsp_needed ~= "") then
	print("Launching python-lsp-server for " .. python_lsp_needed .. " development...(~/dev/cfgs/nvim/luaconfigs/my_lsp/mason.lua)")
	lspconfig.pylsp.setup{}
end

if (java_lsp_needed ~= "" or python_lsp_needed ~= "") then
	local opts = { noremap = true, silent = true }
	local term_opts = { silent = true }

	-- keymap("gd", <cmd>lua vim.lsp.buf.definition()<CR>
	vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

	vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

	vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
end
