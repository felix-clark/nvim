require'telescope'.setup{
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
