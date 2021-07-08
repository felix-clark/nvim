require'lualine'.setup{
  options = { theme = 'onedark' },
  sections = {
    lualine_b = {'branch', 'diff'},
    lualine_c = {
      'filename',
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        sections = {'error', 'warn', 'info', 'hint'},
        symbols = {error='', warn='', info='', hint=''},
      },
    },
    lualine_x = {},
    lualine_y = {'encoding', 'fileformat', 'filetype'},
    lualine_z = {'progress', 'location'},
  },
  extensions = { 'fugitive', 'nvim-tree' },
}
