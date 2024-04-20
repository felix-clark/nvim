local M = {}

local function format(opts)
  -- always show first and second label
  return {
    { opts.match.label1, "FlashMatch" },
    { opts.match.label2, "FlashLabel" },
  }
end

local function action(match, state)
  state:hide()
  require("flash").jump {
    search = { max_length = 0 },
    highlight = { matches = false },
    label = { format = format },
    matcher = function(win)
      -- limit matches to the current label
      return vim.tbl_filter(function(m)
        return m.label == match.label and m.win == win
      end, state.results)
    end,
    labeler = function(matches)
      for _, m in ipairs(matches) do
        m.label = m.label2 -- use the second label
      end
    end,
  }
end

local function labeler(matches, state)
  local labels = state:labels()
  for m, match in ipairs(matches) do
    match.label1 = labels[math.floor((m - 1) / #labels) + 1]
    match.label2 = labels[(m - 1) % #labels + 1]
    match.label = match.label1
  end
end

-- This recipe was extracted from Flash's readme.
local two_char_word_hop = function()
  require("flash").jump {
    search = { mode = "search" },
    label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
    pattern = [[\<]],
    action = action,
    labeler = labeler,
  }
end

M.keys = {
  {
    "s",
    mode = { "n", "x", "o" },
    two_char_word_hop,
    desc = "Two-character hop",
  },
  {
    "g/",
    mode = { "n", "x", "o" },
    -- NOTE: wrapping in functions like this is required for the lazy loading
    function()
      -- default options: exact mode, multi window, all directions, with a backdrop
      require("flash").jump()
    end,
    desc = "Jump to pattern",
  },
  {
    "S",
    mode = { "n", "x", "o" },
    function()
      -- used so select a treesitter node with visual mode. this can be
      -- quicker and more direct than treesitter-select (mapped to <cr> w/
      -- <tab>/<S-tab>).
      require("flash").treesitter()
    end,
    desc = "Select treesitter node",
  },
  {
    "r",
    mode = "o",
    function()
      -- allows some complicated operations, like yanking a textobject
      -- elsewhere then returning to the current position (yr + <s chars> +
      -- <textobject>).
      require("flash").remote()
    end,
    desc = "Remote Flash",
  },
}

return M
