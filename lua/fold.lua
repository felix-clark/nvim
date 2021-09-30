vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
-- vim.o.fillchars = "fold:\\"
-- don't fill the fold lines with a character
vim.o.fillchars = "fold: "
-- consider reducing to 3
vim.o.foldnestmax = 4
-- 1 seems to be the default anyway
vim.o.foldminlines = 1
