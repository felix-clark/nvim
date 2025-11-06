local M = {}

M.keys = {
  {
    "<leader>Tr",
    function()
      require("neotest").run.run()
    end,
    desc = "Run nearest test",
  },
  {
    "<leader>Tf",
    function()
      require("neotest").run.run(vim.fn.expand "%")
    end,
    desc = "Run tests in current file",
  },
  {
    "<leader>Td",
    function()
      require("neotest").run.run { strategy = "dap" }
    end,
    desc = "Debug nearest test",
  },
  {
    "<leader>Tq",
    function()
      require("neotest").run.stop()
    end,
    desc = "Stop nearest test",
  },
  {
    "<leader>Ts",
    function()
      require("neotest").summary.toggle()
    end,
    desc = "Toggle summary window",
  },
  {
    "<leader>Tt",
    function()
      require("neotest").output_panel.toggle()
    end,
    desc = "Toggle output window",
  },
}

return M
