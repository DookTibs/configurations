-- NOTE - not in use, this was an experiment
print("packer plugins script")

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer itself (but we manually isntalled it first time out
	use 'wbthomason/packer.nvim'

	use 'jpalardy/vim-slime'
	use 'christoomey/vim-tmux-navigator'

	-- completion
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'

	-- Snippets - works in tandem with Completion...
	-- (there's also vsnip -- didn't try that)
	-- (see https://github.com/rafamadriz/friendly-snippets/tree/main/snippets for lots of snippets)
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'
end)

