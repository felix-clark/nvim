local null_ls = require("null-ls")
null_ls.config({
	sources = {
    -- lua
    null_ls.builtins.formatting.stylua,

		-- Python
    -- null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.pylint,

		-- web
		null_ls.builtins.formatting.prettier,
	},
})
require("lspconfig")["null-ls"].setup({
  -- setup keybindings
  on_attach = require("cfg.lsp").on_attach,
})