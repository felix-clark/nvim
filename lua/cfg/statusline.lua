require("lualine").setup {
  -- options = { theme = "onedark" },
  -- options = { theme = "catppuccin" },
  -- auto seems to work fine for kanagawa:
  options = { theme = "auto" },
  sections = {
    lualine_b = { "branch", "diff" },
    lualine_c = {
      "filename",
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = { error = "", warn = "", info = "", hint = "" },
      },
    },
    lualine_x = {
      function()
        return require("lsp-progress").progress()
      end,
    },
    lualine_y = { "encoding", "fileformat", "filetype" },
    lualine_z = { "progress", "location" },
  },
  extensions = { "nvim-tree" },
}

-- refresh lualine
vim.api.nvim_create_augroup("lualine_augroup", {})
vim.api.nvim_create_autocmd("User LspProgressStatusUpdated", {
  group = "lualine_augroup",
  callback = require("lualine").refresh,
})
