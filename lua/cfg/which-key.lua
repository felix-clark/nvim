local wk = require "which-key"

wk.add {
  {
    "<leader>b",
    group = "buffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end,
  },
  { "<leader>c", group = "code" },
  { "<leader>d", group = "debug" },
  { "<leader>f", group = "file" },
  { "<leader>g", group = "git" },
  { "<leader>l", group = "lsp" },
  -- { "<leader>m", group = "local" }, -- in old config this caused some clunky interactions; hasn't been tested in updated yet
  { "<leader>o", group = "open" },
  { "<leader>r", group = "refactor" },
  { "<leader>s", group = "search" },
  { "<leader>t", group = "toggle" },
  { "<leader>w", proxy = "<C-w>", group = "windows" },
  { "g", group = "goto" },
  { "]", group = "next" },
  { "[", group = "previous" },
}
