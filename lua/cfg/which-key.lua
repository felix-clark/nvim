local wk = require "which-key"

wk.add {
  {
    "<leader>b",
    group = "buffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end,
  },
  { "<leader>a", group = "ai" },
  { "<leader>d", group = "debug" },
  { "<leader>f", group = "file" },
  { "<leader>l", group = "lsp" },
  { "<leader>o", group = "open" },
  { "<leader>s", group = "search" },
  { "<leader>t", group = "toggle" },
  { "<leader>w", proxy = "<C-w>", group = "windows" },
  { "<leader>x", group = "trouble" },
  { "g", group = "goto" },
  { "]", group = "next" },
  { "[", group = "previous" },
  {
    -- branches with options in both normal and visual mode
    mode = { "n", "v" },
    { "<leader>c", group = "code" },
    { "<leader>g", group = "git" },
    -- { "<leader>m", group = "local" }, -- in old config this caused some clunky interactions; hasn't been tested in updated yet
    { "<leader>r", group = "refactor" },
  },
}
