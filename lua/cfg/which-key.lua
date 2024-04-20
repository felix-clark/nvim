local wk = require "which-key"

-- Mappings starting with leader key
wk.register({
  b = {
    name = "+buffer",
    b = { "<cmd>Telescope buffers<cr>", "Switch buffer" },
    d = { "<cmd>bd<cr>", "delete-buffer" },
    h = { "<cmd>bfirst<cr>", "first-buffer" },
    j = { "<cmd>bnext<cr>", "next-buffer" },
    k = { "<cmd>bprevious<cr>", "previous-buffer" },
    l = { "<cmd>blast<cr>", "last-buffer" },
    t = { "<cmd>b term://<cr>", "terminal" },
  },
  c = {
    name = "+code",
    a = "Code action",
    -- use vim-dispatch to spin up a build command
    c = { "<cmd>Dispatch<cr>", "Compile" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
    D = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics" },
    l = { "<cmd>TroubleToggle loclist<cr>", "Location list" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix list" },
    r = "Rename (treesitter-refactor)",
    x = { "<cmd>TroubleToggle<cr>", "Show error list" },
  },
  f = {
    name = "+file",
    f = { "<cmd>Telescope find_files<cr>", "Find file" },
    g = { "<cmd>find $HOME/.config/nvim/init.vim<cr>", "Open neovim config" },
    n = { "<cmd>enew<cr>", "New file" },
    p = { "<cmd>Telescope git_files<cr>", "Open file in project" },
    s = { "<cmd>update<cr>", "Save file" },
  },
  g = {
    name = "+git",
    -- A hydra is defined for git
  },
  l = {
    name = "+lsp",
  },
  -- specifying this here causes some clunky interactions
  -- m = { "<localleader>", "+local" },
  o = {
    name = "+open",
    -- This variant opens the terminal based on the vim shell. Probably
    -- redundant with +term.
    -- t = { string.format("<cmd>vsplit term://%s<cr>", vim.o.shell), "terminal" },
    -- TODO: Consider a variant for interactive language prompt based on
    -- filetype, e.g. ":term python" for a python REPL. This would probably
    -- require setting a buffer-local variable in each after/ftplugin source.
    s = {
      name = "horizontal",
      f = { "<cmd>split term://fish<cr>", "fish" },
      -- TODO: Consider falling back to htop then top
      p = { "<cmd>split term://ytop -m<cr>", "ytop" },
      t = { "<cmd>split +term<cr>", "terminal" },
    },
    v = {
      name = "vertical",
      f = { "<cmd>vsplit term://fish<cr>", "fish" },
      p = { "<cmd>vsplit term://ytop<cr>", "ytop" },
      t = { "<cmd>vsplit +term<cr>", "terminal" },
    },
    c = { "<cmd>:CTOpen<cr>", "call tree" },
    p = { "<cmd>split term://ytop -m<cr>", "ytop" },
    t = { "<cmd>ToggleTerm<cr>", "terminal" },
  },
  -- Keymaps defined in telescope's config
  s = {
    name = "+search",
  },
  t = {
    name = "+toggle",
    l = { "<cmd>set relativenumber!<cr>", "Switch line number style" },
    p = { "<cmd>lua require('cfg.autopairs').toggle_autopairs()<cr>", "Toggle autopairs" },
    t = { "<cmd>NvimTreeToggle<cr>", "Project tree" },
    -- s = { "<cmd>lua require('onedark').toggle()<cr>", "Toggle color scheme" },
    b = { "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>", "Toggle git blame" },
    g = { "<cmd>lua require('gitsigns').toggle_signs()<cr>", "Toggle git signs" },
  },
  w = {
    name = "+window",
    w = { "<C-w>w", "Switch to next window" },
    W = { "<C-w>W", "Switch to previous window" },
    c = { "<C-w>c", "Close window" },
    q = { "<C-w>q", "Quit window" },
    o = { "<C-w>o", "Focus current window" },
    ["-"] = { "<C-w>-", "Decrease height" },
    ["+"] = { "<C-w>+", "Increase height" },
    ["|"] = { "<C-w>|", "Max out the width" },
    ["<lt>"] = { "<C-w><lt>", "Decrease width" },
    [">"] = { "<C-w>>", "Increase width" },
    h = { "<C-w>h", "Go to left window" },
    j = { "<C-w>j", "Go to down window" },
    l = { "<C-w>l", "Go to right window" },
    k = { "<C-w>k", "Go to up window" },
    t = { "<C-w>t", "Go to top-left window" },
    b = { "<C-w>b", "Go to bottom-right window" },
    p = { "<C-w>p", "Go to previous window" },
    P = { "<C-w>P", "Go to preview window" },
    H = { "<C-w>H", "Move window left" },
    J = { "<C-w>J", "Move window down" },
    K = { "<C-w>K", "Move window up" },
    L = { "<C-w>L", "Move window right" },
    ["="] = { "<C-w>=", "Equally high and wide" },
    s = { "<C-w>s", "Split window horizontally" },
    v = { "<C-w>v", "Split window vertically" },
    x = { "<C-w>x", "Swap window with next" },
    r = { "<C-w>r", "Rotate windows down/right" },
    R = { "<C-w>r", "Rotate windows up/left" },
    T = { "<C-w>T", "Break out into new tab" },
  },
  ["/"] = { ":nohlsearch<cr>", "Clear search highlight" },
}, {
  prefix = "<leader>",
})
wk.register({
  -- from treesitter-refactor: goto definition w/ lsp fallback
  d = "Go to definition",
  -- overwrites "Goto global declaration"
  D = { "<cmd>TroubleToggle lsp_definitions<cr>", "List definitions" },
  R = { "<cmd>TroubleToggle lsp_references<cr>", "List references" },
}, {
  prefix = "g",
})
-- extra gotos
wk.register({
  c = { ":cnext<cr>", "Next quickfix" },
  f = "Next function start [TS]",
  F = "Next function end [TS]",
  ["]"] = "Next class start [TS]",
  ["["] = "Next class end [TS]",
  a = "Next parameter start [TS]",
  A = "Next parameter end [TS]",
  o = "Next comment start [TS]",
  O = "Next comment end [TS]",
  b = "Next block start [TS]",
  B = "Next block end [TS]",
}, { mode = "n", prefix = "]" })
wk.register({
  c = { ":cprevious<cr>", "Previous quickfix" },
  f = "Previous function start [TS]",
  F = "Previous function end [TS]",
  ["["] = "Previous class start [TS]",
  ["]"] = "Previous class end [TS]",
  a = "Previous parameter start [TS]",
  A = "Previous parameter end [TS]",
  o = "Previous comment start [TS]",
  O = "Previous comment end [TS]",
  b = "Previous block start [TS]",
  B = "Previous block end [TS]",
}, { mode = "n", prefix = "[" })
