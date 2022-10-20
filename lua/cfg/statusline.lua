require("lualine").setup {
  -- options = { theme = "onedark" },
  -- options = { theme = "catppuccin" },
  -- auto seems to work fine:
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
        return require("lsp-status").status()
      end,
    },
    lualine_y = { "encoding", "fileformat", "filetype" },
    lualine_z = { "progress", "location" },
  },
  extensions = { "nvim-tree" },
}
