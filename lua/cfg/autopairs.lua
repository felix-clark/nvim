local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
-- Additional treesitter configurations can be added here.
local ts_conds = require('nvim-autopairs.ts-conds')

npairs.setup({
  -- check treesitter
  check_ts = true,
  ts_config = {
    -- vim = {'string'},
    -- lua = {'string'}, -- it will not add a pair on that treesitter node
    rust = {},
  },
  -- After typing opening character, press the map key (<M-e> default) then a
  -- key like $ to indicate where to place the closing character
  fast_wrap = {
    -- The default mapping is <M-e>
    map = '<M-e>',
  },
})
npairs.add_rules({
  -- If immediately after a word character, assume it's a template expression
  Rule("<", ">", {"c", "cpp", "rust"})
    :with_pair(cond.before_regex_check("%w"))
    :with_pair(cond.not_after_text_check(">"))
  ,
  -- Some treesitter node might be a better specification
  -- Rule("<", ">", "rust"):with_pair(ts_conds.is_ts_node({"type_arguments", "bounded_type"})),
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

local M = {}
M.toggle_autopairs = function()
  local ok, autopairs = pcall(require, "nvim-autopairs")
  if ok then
    if autopairs.state.disabled then
      autopairs.enable()
      print("autopairs on")
    else
      autopairs.disable()
      print("autopairs off")
    end
  else
    print("autopairs not available")
  end
end
return M
