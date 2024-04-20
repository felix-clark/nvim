local M = {}
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
        return "]g"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, {
      expr = true,
    })
    map("n", "[g", function()
      if vim.wo.diff then
        return "[g"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, {
      expr = true,
    })

    -- Actions
    -- These bindings are a backup in case the hydra fails, or in case it hasn't loaded yet
    map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk")
    map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk")
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
    -- NOTE: toggle blame and deleted are defined in which-key

    -- Text object
    map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<cr>", "Select hunk")
  end,
}
return M
