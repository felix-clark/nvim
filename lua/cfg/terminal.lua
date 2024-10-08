vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "terminal" })

local Terminal = require("toggleterm.terminal").Terminal

-- Possible executables to use for monitoring, in order of priority
local top_execs = { "btm", "ytop", "htop", "top" }
for _, top_exec in pairs(top_execs) do
  if vim.fn.executable(top_exec) == 1 then
    local top_term = Terminal:new { cmd = top_exec, direction = "vertical" }
    vim.keymap.set("n", "<leader>op", function()
      top_term:toggle()
    end, { desc = "top" })
    break
  end
end

local lg_term =
  Terminal:new { cmd = "lazygit", display_name = "lazygit", direction = "float", hidden = true }
vim.keymap.set("n", "<leader>gg", function()
  lg_term:toggle()
end, { desc = "lazygit" })
