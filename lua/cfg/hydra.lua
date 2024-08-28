local hydra = require "hydra"
local gitsigns = require "gitsigns"
local neogit = require "neogit"

local githint = [[
_]_/_[_: goto next/prev hunk    _s_/_S_: stage hunk/buffer    _r_/_R_: reset hunk/buffer
  _u_: undo stage               _p_: preview              _b_/_B_: blame line/commit
  _c_: commit                 _d_/_D_: diff line/buffer       _l_: log
  _/_: show base file           _g_: Neogit                 _q_: exit
]]

hydra {
  name = "git",
  hint = githint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      position = "bottom",
      float_opts = {
        border = "rounded",
      },
    },
    on_enter = function()
      -- if not modifiable, reset cannot be done
      -- vim.bo.modifiable = false
      -- gitsigns.toggle_signs(true)
      gitsigns.toggle_linehl(true)
      gitsigns.toggle_deleted(true)
    end,
    on_exit = function()
      -- gitsigns.toggle_signs(false)
      gitsigns.toggle_linehl(false)
      gitsigns.toggle_deleted(false)
    end,
  },
  -- What about commiting a visual block? Perhaps that can be left in which-key
  mode = { "n", "x" },
  body = "<leader>G",
  heads = {
    { "[", gitsigns.prev_hunk, { nowait = true } },
    { "]", gitsigns.next_hunk, { nowait = true } },
    { "s", gitsigns.stage_hunk, { nowait = true } },
    { "u", gitsigns.undo_stage_hunk, { nowait = true } },
    { "S", gitsigns.stage_buffer, { nowait = true } },
    { "p", gitsigns.preview_hunk, { nowait = true } },
    { "r", gitsigns.reset_hunk, { nowait = true } },
    { "R", gitsigns.reset_buffer, { nowait = true } },
    { "b", gitsigns.blame_line, { nowait = true } },
    {
      "B",
      function()
        gitsigns.blame_line { full = true }
      end,
      { nowait = true },
    },
    { "d", gitsigns.diffthis, { exit = true } },
    {
      "D",
      function()
        gitsigns.diffthis "~"
      end,
      { exit = true },
    },
    {
      "c",
      function()
        neogit.open { "commit" }
      end,
      { exit_before = true, nowait = true },
    },
    -- { "g", function() neogit.open { kind = "split" } end, { exit = true } },
    { "g", neogit.open, { exit = true, nowait = true } },
    {
      "l",
      function()
        neogit.open { "log" }
      end,
      { exit_before = true, nowait = true },
    },
    { "/", gitsigns.show, { exit = true, nowait = true } },
    { "q", nil, { exit = true, nowait = true } },
    -- TODO: silent exits when other keys are pressed? Potentially use
    -- "foreign" option.
  },
}
