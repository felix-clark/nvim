-- use 'jk' combination to quit insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
-- something similar for terminal (?)
-- This messes with fzf windows, although telescope seems fine so far
-- It makes using "Esc" in a lazygit terminal awkward. As long as we can leave
-- the window, perhaps we don't need to exit terminal mode often.
-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- try helix-inspired bindings
-- a more ergonomic 0 which overrides starting select mode ("get highlighted").
vim.keymap.set({ "n", "x", "o" }, "gh", "0", { desc = "Go to first character in line" })
-- a more ergonomic ^ which overrides "goto sleep". leap.nvim uses this to jump
-- across windows, but shouldn't override the existing keymap.
vim.keymap.set({ "n", "x", "o" }, "gs", "^", { desc = "Go to start of text in line" })
-- a more ergonomic $
vim.keymap.set({ "n", "x", "o" }, "gl", "<End>", { desc = "Go to end of line" })

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

vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

vim.keymap.set("n", "]x", "<cmd>cnext<cr>", { desc = "Next quickfix" })
vim.keymap.set("n", "[x", "<cmd>cprevious<cr>", { desc = "Previous quickfix" })

-- plugin-specific bindings, defined here for lazy loading.

-- refactoring.nvim
-- The space at the end of some mappings is intentional because those mappings
-- expect an additional argument (all of these mappings leave the user in
-- command mode to utilize the preview command feature).
-- There are lua API alternatives if we don't want this preview feature.
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
-- prompt for a refactor to apply when the remap is triggered
-- There is also a telescope picker option, but the benefit of that coupling is
-- not clear.
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
  require("refactoring").select_refactor()
end, { desc = "Select refactor" })
