local M = {}

M.keys = {
  {
    "<leader>Tr",
    require("neotest").run.run(),
    desc = "Run nearest test",
  },
  {
    "<leader>Tf",
    require("neotest").run.run(vim.fn.expand "%"),
    desc = "Run tests in current file",
  },
  {
    "<leader>Td",
    require("neotest").run.run { strategy = "dap" },
    desc = "Debug nearest test",
  },
  {
    "<leader>Tq",
    require("neotest").run.stop(),
    desc = "Stop nearest test",
  },
  {
    "<leader>Ts",
    require("neotest").summary.toggle(),
    desc = "Toggle summary window",
  },
}

return M
