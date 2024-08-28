-- Quick window motion with Alt+<direction>
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-l>", "<C-w>l")
vim.keymap.set("t", "<M-h>", "<cmd>wincmd h<cr>")
vim.keymap.set("t", "<M-j>", "<cmd>wincmd j<cr>")
vim.keymap.set("t", "<M-k>", "<cmd>wincmd k<cr>")
vim.keymap.set("t", "<M-l>", "<cmd>wincmd l<cr>")

-- buffer navigation
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bh", "<cmd>bfirst<cr>", { desc = "First buffer" })
vim.keymap.set("n", "<leader>bj", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bk", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bl", "<cmd>blast<cr>", { desc = "Last buffer" })
vim.keymap.set("n", "<leader>bt", "<cmd>b term://<cr>", { desc = "Switch to terminal buffer" })

-- alternative file handling
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
vim.keymap.set("n", "<leader>fs", "<cmd>update<cr>", { desc = "Save file" })

-- toggle line number style
vim.keymap.set(
  "n",
  "<leader>tl",
  "<cmd>set relativenumber!<cr>",
  { desc = "Switch line number style" }
)

-- 
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

vim.keymap.set("n", "]c", "<cmd>cnext<cr>", { desc = "Next quickfix" })
vim.keymap.set("n", "[c", "<cmd>cprevious<cr>", { desc = "Previous quickfix" })
