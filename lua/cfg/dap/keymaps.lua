local dap = require "dap"
local dapui = require "dapui"
-- see :h dap-widgets for more to do with these, although much is covered by
-- dap-ui.
local widgets = require "dap.ui.widgets"

local function nmap(lhs, rhs, desc)
  local opts = { silent = true, desc = desc }
  vim.keymap.set("n", lhs, rhs, opts)
end

local M = {}
function M.setup()
  nmap("<leader>dR", dap.run_to_cursor, "Run to Cursor")
  nmap("<leader>dE", function()
    dapui.eval(vim.fn.input "[Expression] > ")
  end, "Evaluate Input")
  nmap("<leader>dC", function()
    dap.set_breakpoint(vim.fn.input "[Condition] > ")
  end, "Conditional Breakpoint")
  nmap("<leader>dU", dapui.toggle, "Toggle UI")
  nmap("<leader>db", dap.step_back, "Step Back")
  nmap("<leader>dc", dap.continue, "Continue")
  nmap("<leader>dd", dap.disconnect, "Disconnect")
  nmap("<leader>de", dapui.eval, "Evaluate")
  nmap("<leader>dg", dap.session, "Get Session")
  nmap("<leader>dh", widgets.hover, "Hover Variables")
  nmap("<leader>di", dap.step_into, "Step Into")
  nmap("<leader>do", dap.step_over, "Step Over")
  nmap("<leader>dp", dap.pause, "Pause")
  nmap("<leader>dq", dap.close, "Quit")
  nmap("<leader>dr", dap.repl.toggle, "Toggle Repl")
  nmap("<leader>ds", dap.continue, "Start")
  nmap("<leader>dt", dap.toggle_breakpoint, "Toggle Breakpoint")
  nmap("<leader>dx", dap.terminate, "Terminate")
  nmap("<leader>du", dap.step_out, "Step Out")

  -- evalutes the highlighted expression
  vim.keymap.set("v", "<leader>e", dapui.eval, { silent = true, desc = "Evaluate" })
end

return M
