local wk = require("which-key")
-- Mappings starting with leader key
wk.register({
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
  },
  d = {
    name = "+debug",
  },
  f = {
    name = "+file",
    b = {"<cmd>Telescope file_browser<cr>", "File browser"},
    f = {"<cmd>Telescope find_files<cr>", "Find file"},
    n = {"<cmd>enew<cr>", "New file"},
    p = {"<cmd>Telescope git_files<cr>", "Open file in project"},
    r = {"<cmd>Telescope oldfiles<cr>", "Open recent file"},
    s = {"<cmd>update<cr>", "Save file"},
  },
  g = {
    name = "+git",
    ["["] = {"<cmd>GitGutterPrevHunk<cr>", "Go to previous hunk"},
    ["]"] = {"<cmd>GitGutterNextHunk<cr>", "Go to next hunk"},
    c = {"<cmd>Git commit<cr>", "Commit"},
    d = {"<cmd>Gdiffsplit<cr>", "Open split diff"},
    g = {"<cmd>Git<cr>", "Git launcher"},
    l = {"<cmd>Git log<cr>", "Git log"},
    p = {"<cmd>GitGutterPreviewHunk<cr>", "Preview hunk"},
    -- P = {"<cmd>Git push<cr>", "Push"},
    s = {"<cmd>GitGutterStageHunk<cr>", "Stage hunk"},
    S = {"<cmd>Gwrite<cr>", "Stage file"},
    u = {"<cmd>GitGutterUndoHunk<cr>", "Undo hunk"},
  },
  l = {
    name = "+lsp",
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
    t = {"<cmd>NvimTreeToggle<cr>", "Project tree"},
    p = "Toggle AutoPairs",
    -- TODO: Code style (from onedark) -- currently bound to <leader>cs
    -- TODO: line numbering
    -- TODO: Consider toggle for git-gitter, although there isn't harm in
    -- keeping it on
  },
  -- w = {
  --   name = "+window",
  --   -- "<C-w>", "+window"
  -- },
}, { prefix = "<leader>" })
