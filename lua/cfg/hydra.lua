local hydra = require "hydra"
local gitsigns = require "gitsigns"

local githint = [[
_]_/_[_: goto next/prev hunk    _s_/_S_: stage hunk/buffer    _r_/_R_: reset hunk/buffer
  _u_: undo stage               _p_: preview              _b_/_B_: blame
  _c_: commit                 _d_/_D_: diff                   _l_: log
  _/_: show base file           _g_: Neogit                 _q_: exit
]]

hydra {
  hint = githint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      position = "bottom",
      border = "rounded",
    },
    on_enter = function()
      vim.bo.modifiable = false
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
  body = "<leader>g",
  heads = {
    { "[", gitsigns.prev_hunk, { nowait = true } },
    { "]", gitsigns.next_hunk, { nowait = true } },
    { "s", gitsigns.stage_hunk },
    { "u", gitsigns.undo_stage_hunk },
    { "S", gitsigns.stage_buffer },
    { "p", gitsigns.preview_hunk },
    { "r", gitsigns.reset_hunk },
    { "R", gitsigns.reset_buffer },
    { "b", gitsigns.blame_line },
    {
      "B",
      function()
        gitsigns.blame_line { full = true }
      end,
    },
    { "d", gitsigns.diffthis, { exit = true } },
    {
      "D",
      function()
        gitsigns.diffthis "~"
      end, {exit = true}
    },
    { "c", "<cmd>Neogit commit<cr>", { exit = true } },
    -- { "g", "<cmd>Neogit kind=split<cr>", { exit = true } },
    { "g", "<cmd>Neogit<cr>", { exit = true } },
    { "l", "<cmd>Neogit log<cr>", { exit = true } },
    { "/", gitsigns.show, { exit = true } },
    { "q", nil, { exit = true, nowait = true } },
    -- TODO: silent exits when other keys are pressed?
  },
}
