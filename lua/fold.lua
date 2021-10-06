vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

function _G.my_fold_text ()
  -- NOTE: If tabs are in the foldline, they may be rendered as single-width.
  -- This is the vim:
  -- vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ...  (' . (v:foldend - v:foldstart + 1) . ' lines [' . (v:foldlevel) . '])']]
  -- Something like this would replace them, although it's choking on repeat()
  -- local first_line = vim.fn.substitute(
  --   vim.fn.getline(vim.v.foldstart),
  --   '\\t',
  --   vim.fn.repeat('\\ ', vim.v.tabstop),
  --   'g')
  local first_line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local filler = ' ... '
  if (string.sub(vim.fn.trim(first_line), -1) == '{') then
    local last_line = vim.fn.trim(vim.fn.getline(vim.v.foldend))
    local last_char = string.sub(last_line, -1)
    if (last_char == '}') then
      filler = filler .. last_char .. ' '
    elseif string.sub(last_line, -2) == '};' then
      filler = filler .. '}; '
    end
  end
  local count_str = ' (' .. line_count .. ' lines)'
  -- NOTE: Could indicate the fold level with something like this:
  -- local level_str = ' [' .. vim.v.foldlevel .. ']'
  -- local level_str = ' ' .. vim.v.folddashes
  -- TODO: Try to include the closing bracket after the dots if the final char
  -- of the last line is one
  return first_line .. filler .. count_str
end

vim.o.foldtext = 'v:lua.my_fold_text()'
vim.o.foldcolumn = 'auto:3'
-- don't fill the fold lines with a character, use space
vim.o.fillchars = 'fold: '
-- maximum nesting depth
vim.o.foldnestmax = 3
-- 1 seems to be the default anyway
vim.o.foldminlines = 1
-- Starting fold level: 0 for all folds closed, 99 for no folds closed.
vim.o.foldlevelstart=1

