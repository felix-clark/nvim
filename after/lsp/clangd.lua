-- Build --query-driver from compilers that actually exist on this system,
-- so the config is portable across machines with different toolchains.
local function query_driver_arg()
  local candidates = {
    "/usr/bin/clang++",
    "/usr/bin/clang",
    "/usr/bin/g++",
    "/usr/bin/gcc",
    "/usr/local/bin/clang++",
    "/usr/local/bin/clang",
    "/usr/local/bin/g++",
    "/usr/local/bin/gcc",
  }
  local found = vim.tbl_filter(function(p)
    return vim.fn.executable(p) == 1
  end, candidates)
  if #found == 0 then
    return nil
  end
  return "--query-driver=" .. table.concat(found, ",")
end

local cmd = {
  "clangd",
  "--background-index",
  "--clang-tidy",
  "--header-insertion=iwyu",
  "--completion-style=detailed",
}
local driver_arg = query_driver_arg()
if driver_arg then
  table.insert(cmd, driver_arg)
end

return { cmd = cmd }
