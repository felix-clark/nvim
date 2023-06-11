local M = {}

function M.setup(_)
  -- Need to point to a python executable that has debugpy installed. Mason
  -- should provide one.
  local debugpy_bin_dir = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/"
  local python_path = debugpy_bin_dir .. "python"
  if vim.fn.executable(python_path) ~= 1 then
    print "Could not find python executable in mason's debugpy install."
    python_path = "python"
  end

  require("dap-python").setup(python_path)
end

return M
