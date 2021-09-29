local npairs = require('nvim-autopairs')

npairs.setup({
  -- check treesitter
  check_ts = true,
  -- ts_config = {
    -- vim = {'string'},
    -- lua = {'string'}, -- it will not add a pair on that treesitter node
    -- ...
  -- },
  -- Additional treesitter configurations can be added here.
  -- local ts_conds = require('nvim-autopairs.ts-conds')
})

-- compe integration
-- nvim-autopairs documentation says to remove compe <CR> mapping
require('nvim-autopairs.completion.compe').setup({
  map_cr = true, -- map <CR> on insert mode
  map_complete = true, -- will auto-insert '(' after select function or menu item
  auto_select = false, -- auto-select first item
  map_char = {
    all = '(',
    tex = '{',
  },
})
