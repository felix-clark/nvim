return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--query-driver=/usr/bin/clang++,/usr/bin/g++",
  },
}
