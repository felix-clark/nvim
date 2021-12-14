local null_ls = require("null-ls")
null_ls.setup({
	sources = {
    -- lua
    null_ls.builtins.formatting.stylua,

		-- Python
    -- null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.flake8,
    -- pylint uses a lot of memory/CPU and is largely redundant with pylsp
		-- null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.diagnostics.mypy,

		-- web
		null_ls.builtins.formatting.prettier,
	},
})
