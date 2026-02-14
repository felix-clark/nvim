local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<localleader>s", "<cmd>ClangdSwitchSourceHeader<cr>", { silent = true, buffer = bufnr, desc = "Switch source/header" })
vim.keymap.set("n", "<localleader>a", "<cmd>ClangdAST<cr>", { silent = true, buffer = bufnr, desc = "View AST" })
vim.keymap.set("n", "<localleader>t", "<cmd>ClangdTypeHierarchy<cr>", { silent = true, buffer = bufnr, desc = "Type hierarchy" })
vim.keymap.set("n", "<localleader>i", "<cmd>ClangdSymbolInfo<cr>", { silent = true, buffer = bufnr, desc = "Symbol info" })
vim.keymap.set("n", "<localleader>M", "<cmd>ClangdMemoryUsage<cr>", { silent = true, buffer = bufnr, desc = "Memory usage" })
