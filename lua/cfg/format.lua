local M = {}

-- NOTE: the conform.nvim wiki shows how to implement a global/buffer
-- distinction for autoformatting, but I haven't really needed this.
local enable_format_on_save = false
local get_fos_args = function()
  if enable_format_on_save then
    return { timeout_ms = 500, lsp_fallback = true }
  end
end

local toggle_format_on_save = function()
  enable_format_on_save = not enable_format_on_save
  if enable_format_on_save then
    print "Enabled format on save"
  else
    print "Disabled format on save"
  end
end

-- defining keys here helps with lazy-loading
M.keys = {
  -- format on-demand
  {
    "<leader>=",
    function()
      require("conform").format { async = true, lsp_fallback = true }
    end,
    mode = "n",
    desc = "Format buffer",
  },
  -- toggle format-on-save
  { "<leader>t=", toggle_format_on_save, mode = "n", "Toggle format-on-save" },
}
-- everything in opts is passed to conform's setup()
M.opts = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- now using ruff for python formatting, but sequential formatters can be done like so:
    -- python = { "isort", "black" },
    -- with a sublist, the first option will be tried and the remainder are fallbacks.
    javascript = { { "prettierd", "prettier" } },
  },
  -- formatter cli options can be added with the `formatters` key.
  format_on_save = get_fos_args,
}
return M
