local copilot_status_ok, copilot = pcall(require, "copilot")
if not copilot_status_ok then
  return
end

local cpcmp_status_ok, cpcmp = pcall(require, "copilot_cmp")
if not cpcmp_status_ok then
  return
end

local cpchat_status_ok, cpchat = pcall(require, "CopilotChat")
-- allow proceed even if chat disabled; we'll check before calling setup

cpcmp.setup()


copilot.setup({
  panel = {
    enabled = false,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = false,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
})

if cpchat_status_ok then
	cpchat.setup({
	  debug = false, -- Enable debugging
	  -- See Configuration section for rest
	})
end
