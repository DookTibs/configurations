local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("my_lsp.mason")
-- require("my_lsp.handlers").setup()

-- tfeiler note --  "<Leader>" can be used in a mapping here but you'd first need to reset it like:
-- vim.g.mapleader = ';'
-- for some reason even though we set it in main.vim. e.g. something like:
--vim.keymap.set('n', '<Leader>w', function() vim.someLuaModule.someFunction() end, opts)

