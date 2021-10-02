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
-- Don't complete single-quotes within a type argument e.g. <'a>
npairs.get_rule("'")[2]:with_pair(ts_conds.is_not_ts_node({"type_arguments", "bounded_type"}))

-- cmp integration
-- nvim-autopairs documentation says to remove cmp <CR> mapping
require('nvim-autopairs.completion.cmp').setup({
  map_cr = true, -- map <CR> on insert mode
  map_complete = true, -- will auto-insert '(' ('map_char') after select function or method item
  auto_select = true, -- automatically select the first item
  insert = false, -- use insert confirm behavior instead of replace
  map_char = {
    all = '(',
    tex = '{',
  },
})
