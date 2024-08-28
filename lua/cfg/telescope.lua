local builtin = require "telescope.builtin"

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        -- exit telescope with a single press of escape
        ["<esc>"] = require("telescope.actions").close,
        -- use C-h for help. Default is <C-/> or ? for i or n mode.
        ["<C-h>"] = "which_key",
        ["<C-t>"] = require("trouble.sources.telescope").open,
      },
      n = {
        ["<C-t>"] = require("trouble.sources.telescope").open,
      },
    },
  },
  -- Some pickers are better suited to a different style, for instance:
  -- "dropdown": A smaller centered panel
  -- "cursor": A smaller window located near the cursor
  -- "ivy": A separate frame a la the emacs package
  pickers = {
    buffers = {
      -- sort buffers by recency for easy switching back-and-forth
      ignore_current_buffer = true,
      sort_mru = true,
    },
    lsp_code_actions = { theme = "cursor" },
    lsp_range_code_actions = { theme = "cursor" },
  },
}

-- Set up keybindings for some general pickers
local function tele_map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

tele_map("n", "<leader>bb", builtin.buffers, "Switch buffer")
tele_map("n", "<leader>s:", builtin.commands, "commands")
tele_map("n", "<leader>sb", builtin.current_buffer_fuzzy_find, "buffer")
tele_map("n", "<leader>sc", builtin.git_commits, "git commits")
tele_map("n", "<leader>sd", function()
  builtin.diagnostics { bufnr = 0 }
end, "buffer diagnostics")
tele_map("n", "<leader>sD", builtin.diagnostics, "workspace diagnostics")
tele_map("n", "<leader>sh", builtin.help_tags, "help tags")
tele_map("n", "<leader>sk", builtin.marks, "marks")
tele_map("n", "<leader>sm", builtin.keymaps, "keymaps")
tele_map("n", "<leader>sp", builtin.live_grep, "project")
tele_map("n", "<leader>ss", builtin.treesitter, "treesitter")
tele_map("n", "<leader>st", builtin.tags, "tags")
tele_map("n", "<leader>s*", builtin.grep_string, "find this word")
tele_map("n", "<leader>s?", builtin.help_tags, "help")
tele_map("n", "<leader>ff", builtin.find_files, "find file")
tele_map("n", "<leader>fg", builtin.git_files, "find file in repo")
-- NOTE: perhaps this is redundant with frecency (mapped to "<leader>fr" in
-- lazy)
tele_map("n", "<leader>fp", builtin.oldfiles, "find previously opened file")
