local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>ca", function()
  vim.cmd.RustLsp "codeAction" -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr, desc = "code action (rust)" })
vim.keymap.set("n", "<localleader>d", function()
  vim.cmd.RustLsp "debuggables"
end, { silent = true, buffer = bufnr, desc = "Rust debuggables" })
vim.keymap.set("n", "<localleader>r", function()
  vim.cmd.RustLsp "runnables"
end, { silent = true, buffer = bufnr, desc = "Rust runnables" })
-- Consider overriding <leader>e
vim.keymap.set("n", "<localleader>e", function()
  vim.cmd.RustLsp "explainError"
end, { silent = true, buffer = bufnr, desc = "Explain error" })
