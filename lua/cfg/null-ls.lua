local null_ls = require "null-ls"
null_ls.setup {
  sources = {
    -- gitsigns integration
    null_ls.builtins.code_actions.gitsigns,

    -- lua
    null_ls.builtins.formatting.stylua,

    -- Python
    -- NOTE: The main ones here can all be included in the pylsp installation
    -- with mason:
    -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/server_configurations/pylsp/README.md
    -- null_ls.builtins.formatting.autopep8,
    -- null_ls.builtins.formatting.black,
    -- null_ls.builtins.formatting.isort,
    -- null_ls.builtins.diagnostics.flake8,
    -- pylint uses a lot of memory/CPU and is largely redundant with pylsp
    -- null_ls.builtins.diagnostics.pylint,
    -- null_ls.builtins.diagnostics.mypy,

    -- web
    null_ls.builtins.formatting.prettier,
  },
  on_attach = require("cfg.lsp").on_attach,
}
