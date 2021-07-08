require'lualine'.setup{
  options = { theme = 'onedark' },
  sections = {
    lualine_b = {'branch', 'diff'},
    lualine_x = {
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        sections = {'error', 'warn', 'info', 'hint'},
        -- TODO: Figure out why some icons are not correctly displayed in
        -- nerdfont and replace these with appropriate icons
        symbols = {error='E', warn='W', info='I', hint='H'},
      } 
    },
    lualine_y = {'encoding', 'fileformat', 'filetype'},
    lualine_z = {'progress', 'location'},
  },
  extensions = { 'fugitive' },
}
