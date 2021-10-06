local actions = require('telescope.actions')
require'telescope'.setup{
  defaults = {
    mappings = {
      i = {
        -- exit telescope with a single press of escape
        ["<esc>"] = actions.close,
        -- use C-h for help. Default is <C-/> or ? for i or n mode.
        ["<C-h>"] = "which_key",
      },
    },
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
require'telescope'.load_extension('project')
-- This must be loaded after the telescope setup.
require'telescope'.load_extension('fzf')
