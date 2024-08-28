local M = {}

M.neogit_keys = {
  {
    "<leader>gg",
    function()
      require("neogit").open()
    end,
    desc = "Neogit",
  },
  {
    "<leader>gc",
    function()
      require("neogit").open { "commit" }
    end,
    desc = "Commit",
  },
}

M.gitsigns_opts = {
  -- A value of 15 or greater should prioritize gitsigns over diagnostics
  -- (which are also underlined)
  sign_priority = 20,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, desc, opts)
      opts = opts or {}
      opts.buffer = bufnr
      opts.desc = desc
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]g", function()
      if vim.wo.diff then
        vim.cmd.normal { "]g", bang = true }
      else
        gs.nav_hunk "next"
      end
    end, "Next hunk")
    map("n", "[g", function()
      if vim.wo.diff then
        vim.cmd.normal { "[g", bang = true }
      else
        gs.nav_hunk "prev"
      end
    end, "Previous hunk")

    -- Actions
    map({ "n", "v" }, "<leader>gs", gs.stage_hunk, "Stage hunk")
    map({ "n", "v" }, "<leader>gr", gs.reset_hunk, "Reset hunk")
    map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
    map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage")
    map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
    map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
    map("n", "<leader>gb", function()
      gs.blame_line { full = true }
    end, "Blame line")
    map("n", "<leader>gd", gs.diffthis, "Diff line")
    map("n", "<leader>gD", function()
      gs.diffthis "~"
    end, "Diff buffer")
    -- defer to blame.nvim for this
    -- map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle git blame")
    map("n", "<leader>tg", gs.toggle_signs, "Toggle git signs")

    -- Text object
    map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<cr>", "Select hunk")
  end,
}
return M
