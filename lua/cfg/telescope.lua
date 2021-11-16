local actions = require "telescope.actions"
local trouble = require "trouble.providers.telescope"

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        -- exit telescope with a single press of escape
        ["<esc>"] = actions.close,
        -- use C-h for help. Default is <C-/> or ? for i or n mode.
        ["<C-h>"] = "which_key",
        ["<C-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<C-t>"] = trouble.open_with_trouble,
      },
    },
  },
  -- Some pickers are better suited to a different style, for instance:
  -- "dropdown": A smaller centered panel
  -- "cursor": A smaller window located near the cursor
  -- "ivy": A separate frame a la the emacs package
  pickers = {
    lsp_code_actions = { theme = "cursor" },
    lsp_range_code_actions = { theme = "cursor" },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case", -- or "ignore_case", "respect_case"
    },
  },
}
