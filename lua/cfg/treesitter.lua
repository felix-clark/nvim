local parsers = {
  "bash",
  "c",
  "cpp",
  "css",
  "dockerfile",
  "fish",
  "go",
  "haskell",
  "html",
  "javascript",
  -- NOTE: there's also json5
  "json",
  "lua",
  "make",
  "python",
  "query",
  "r",
  "rust",
  "scss",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

-- The latex parser has known installation issues on some systems (missing
-- pre-built binary, cross-compilation failures, etc.). Include it only if
-- already installed (so updates still work) or if a C compiler is available
-- to build it from source.
local latex_installed = vim.uv.fs_stat(
  vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser/latex.so"
) ~= nil
local can_build_latex = vim.fn.executable("tree-sitter") == 1
  and (
    vim.fn.executable("cc") == 1
    or vim.fn.executable("gcc") == 1
    or vim.fn.executable("clang") == 1
  )
if latex_installed or can_build_latex then
  table.insert(parsers, "latex")
end

-- NOTE: the "ensure_installed" line could be removed in lieu of manual installations.
require("nvim-treesitter.configs").setup {
  ensure_installed = parsers,
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- This option will auto-install upon opening new filetypes. It is contingent
  -- on the treesitter CLI, which is installed via Mason.
  auto_install = true,
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<s-cr>",
      scope_incremental = "<s-cr>",
      node_incremental = "<tab>",
      node_decremental = "<s-tab>",
    },
  },
  indent = {
    -- This changes indentexpr; it's unclear to me if it does more than that.
    enable = true,
  },
  -- Integration with nvim-autopairs
  autopairs = { enable = true },
  -- This configuration if for the extension plugin nvim-treesitter-textobjects.
  -- There are many more text objects possible, check
  -- nvim-treesitter-textobjects documentation.
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      -- NOTE: on "inner" vs. "outer": typically one of these is supported by
      -- more parsers, and that's the one chosen for movement. See
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
      -- for full list.
      goto_next_start = {
        -- ]m overrides vim's defaults but ]f feels a little more ergonomic and
        -- in vim-unimpaired (from where these bindings derive inspiration)
        -- it's used to go to the next file, which is redundant.
        -- ["]m"] = "@function.outer",
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]a"] = "@parameter.inner",
        ["]o"] = "@comment.outer",
        ["]b"] = "@block.outer",
        -- No "paragraph" text object; "block" is different.
        -- ["]p"] = "@block.outer",
      },
      goto_next_end = {
        -- ["]M"] = "@function.outer",
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]A"] = "@parameter.inner",
        ["]O"] = "@comment.outer",
        ["]B"] = "@block.outer",
      },
      goto_previous_start = {
        -- ["[m"] = "@function.outer",
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[a"] = "@parameter.inner",
        ["[o"] = "@comment.outer",
        ["[b"] = "@block.outer",
      },
      goto_previous_end = {
        -- ["[M"] = "@function.outer",
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[A"] = "@parameter.inner",
        ["[O"] = "@comment.outer",
        ["[B"] = "@block.outer",
      },
    },
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
  },
}
