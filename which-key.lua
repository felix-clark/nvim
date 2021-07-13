local wk = require("which-key")

-- These are common to both normal and visual mode
local hop = {
    name = "+hop",
    ["/"] = {"<cmd>lua require'hop'.hint_patterns()<cr>", "Patterns"},
    c = {"<cmd>lua require'hop'.hint_char1()<cr>", "Characters"},
    j = {"<cmd>HopLineStartAC<cr>", "Lines down"},
    k = {"<cmd>HopLineStartBC<cr>", "Lines up"},
    s = {"<cmd>lua require'hop'.hint_char2()<cr>", "Bigrams"},
    -- This will search all words; could split between forward and backwards
    -- with HopWord[AC|BC]
    w = {"<cmd>lua require'hop'.hint_words()<cr>", "Words"},
  }

-- Mappings starting with leader key
wk.register({
  ["<space>"] = hop,
  b = {
    name = "+buffer",
    b = {"<cmd>Telescope buffers<cr>", "Switch buffer"},
    d = {"<cmd>bd<cr>"       , "delete-buffer"},
    h = {"<cmd>bfirst<cr>"   , "first-buffer"},
    j = {"<cmd>bnext<cr>"    , "next-buffer"},
    k = {"<cmd>bprevious<cr>", "previous-buffer"},
    l = {"<cmd>blast<cr>"    , "last-buffer"},
  },
  c = {
    name = "+code",
    a = "Code action",
    d = {"<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document diagnostics"},
    l = {"<cmd>TroubleToggle loclist<cr>", "Location list"},
    q = {"<cmd>TroubleToggle quickfix<cr>", "Quickfix list"},
    r = "Rename (treesitter-refactor)",
    w = {"<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace diagnostics"},
    x = {"<cmd>TroubleToggle<cr>", "Show error list"},
  },
  d = {
    name = "+debug",
    -- TODO: Check :help dap.* for more options. These descriptions could be
    -- improved with experience using them.
    d = {"<cmd>lua require'dap'.repl.open()<CR>", "Open debug terminal"},
    c = {"<cmd>lua require'dap'.continue()<CR>", "Continue"},
    v = {"<cmd>lua require'dap'.step_over()<CR>", "Step over"},
    i = {"<cmd>lua require'dap'.step_into()<CR>", "Step into"},
    o = {"<cmd>lua require'dap'.step_out()<CR>", "Step out"},
    b = {"<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint"},
    B = {"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Conditional breakpoint"},
    g = {"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "Log point"},
    l = {"<cmd>lua require'dap'.run_last()<CR>", "Run last"},
    r = {"<cmd>lua require'dap'.run_to_cursor()<CR>", "Run to cursor"},
  },
  f = {
    name = "+file",
    b = {"<cmd>Telescope file_browser<cr>", "File browser"},
    f = {"<cmd>Telescope find_files<cr>", "Find file"},
    g = {"<cmd>find $HOME/.config/nvim/init.vim<cr>", "Open neovim config"},
    n = {"<cmd>enew<cr>", "New file"},
    p = {"<cmd>Telescope git_files<cr>", "Open file in project"},
    r = {"<cmd>Telescope oldfiles<cr>", "Open recent file"},
    s = {"<cmd>update<cr>", "Save file"},
  },
  g = {
    name = "+git",
    ["["] = {"<cmd>lua require'gitsigns.actions'.prev_hunk()<cr>", "Go to previous hunk"},
    ["]"] = {"<cmd>lua require'gitsigns.actions'.next_hunk()<cr>", "Go to next hunk"},
    b = {"<cmd>lua require'gitsigns.actions'.blame_line(true)<cr>", "Blame line"},
    c = {"<cmd>Neogit commit<cr>", "Commit"},
    -- g = {"<cmd>Neogit kind=split<cr>", "Git launcher"},
    g = {"<cmd>Neogit<cr>", "Git launcher"},
    l = {"<cmd>Neogit log<cr>", "Git log"},
    p = {"<cmd>lua require'gitsigns.actions'.preview_hunk()<cr>", "Preview hunk"},
    r = {"<cmd>lua require'gitsigns.actions'.reset_hunk()<cr>", "Revert hunk"},
    R = {"<cmd>lua require'gitsigns.actions'.reset_buffer()<cr>", "Revert buffer"},
    s = {"<cmd>lua require'gitsigns.actions'.stage_hunk()<cr>", "Stage hunk"},
    u = {"<cmd>lua require'gitsigns.actions'.undo_stage_hunk()<cr>", "Undo stage hunk"},
  },
  l = {
    name = "+lsp",
    r = "Rename (LSP)",
    w = "+workspace",
    ["="] = "Format",
  },
  p = {
    name = "+project",
    f = {"<cmd>Telescope git_files<cr>", "Open file in project"},
    p = {"<cmd>lua require'telescope'.extensions.project.project{}<cr>", "Pick project"},
  },
  -- See telescope's documentation for other pickers
  s = {
    name = "+search",
    [":"] = {"<cmd>Telescope commands<cr>", "commands"},
    b = {"<cmd>Telescope current_buffer_fuzzy_find<cr>", "buffer"},
    c = {"<cmd>Telescope git_commits<cr>", "git commits"},
    h = {"<cmd>Telescope help_tags<cr>", "help tags"},
    k = {"<cmd>Telescope marks<cr>", "marks"},
    m = {"<cmd>Telescope keymaps<cr>", "keymaps"},
    p = {"<cmd>Telescope live_grep<cr>", "project"},
    s = {"<cmd>Telescope treesitter<cr>", "treesitter"},
    t = {"<cmd>Telescope tags<cr>", "tags"},
  },
  t = {
    name = "+toggle",
    l = {"<cmd>set relativenumber!<cr>", "Switch line number style"},
    t = {"<cmd>NvimTreeToggle<cr>", "Project tree"},
    s = {"<cmd>lua require('onedark').toggle()<cr>", "Toggle color scheme"}
    -- TODO: Consider toggle for git-gitter, although there isn't harm in
    -- keeping it on
  },
  w = {
    name = "+window",
    w     = {"<C-w>w"    , "Switch to next window"},
    W     = {"<C-w>W"    , "Switch to previous window"},
    c     = {"<C-w>c"    , "Close window"},
    q     = {"<C-w>q"    , "Quit window"},
    o     = {"<C-w>o"    , "Focus current window"},
    ["-"] = {"<C-w>-"    , "Decrease height"},
    ["+"] = {"<C-w>+"    , "Increase height"},
    ["|"] = {"<C-w>|"    , "Max out the width"},
    ["<"] = {"<C-w><lt>" , "Decrease width"},
    [">"] = {"<C-w><gt>" , "Increase width"},
    h     = {"<C-w>h"    , "Go to left window"},
    j     = {"<C-w>j"    , "Go to down window"},
    l     = {"<C-w>l"    , "Go to right window"},
    k     = {"<C-w>k"    , "Go to up window"},
    t     = {"<C-w>t"    , "Go to top-left window"},
    b     = {"<C-w>b"    , "Go to bottom-right window"},
    p     = {"<C-w>p"    , "Go to previous window"},
    P     = {"<C-w>P"    , "Go to preview window"},
    H     = {"<C-w>H"    , "Move window left"},
    J     = {"<C-w>J"    , "Move window down"},
    K     = {"<C-w>K"    , "Move window up"},
    L     = {"<C-w>L"    , "Move window right"},
    ["="] = {"<C-w>="    , "Equally high and wide"},
    s     = {"<C-w>s"    , "Split window horizontally"},
    v     = {"<C-w>v"    , "Split window vertically"},
    x     = {"<C-w>x"    , "Swap window with next"},
    r     = {"<C-w>r"    , "Rotate windows down/right"},
    R     = {"<C-w>r"    , "Rotate windows up/left"},
    T     = {"<C-w>T"    , "Break out into new tab"},
  },
}, { prefix = "<leader>" })
wk.register({
  -- from treesitter-refactor: goto definition w/ lsp fallback
  d = "Go to definition",
  -- overwrites "Goto global declaration"
  D = {"<cmd>TroubleToggle lsp_definitions<cr>", "List definitions"},
  R = {"<cmd>TroubleToggle lsp_references<cr>", "List references"},
}, { prefix = "g" })

-- visual mode bindings
wk.register({
  ["<space>"] = hop,
  g = {
    name = "+git",
    r = {"<cmd>lua require'gitsigns'.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<cr>", "Revert selection"},
    s = {"<cmd>lua require'gitsigns'.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<cr>", "Stage selection"},
  },
}, { mode = 'v', prefix = "<leader>" })
