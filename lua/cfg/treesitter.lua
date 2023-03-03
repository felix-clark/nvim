-- Need to set up orgmode TS parser first
require("orgmode").setup_ts_grammar()

-- NOTE: the "ensure_installed" line could be removed in lieu of manual installations.
require("nvim-treesitter.configs").setup {
  ensure_installed = {
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
    "latex",
    "lua",
    "make",
    "org",
    "python",
    "r",
    "rust",
    "scss",
    "toml",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = {
    enable = true,
    disable = { "org" }, -- Remove this to use TS highligher for some highlights (Experimental)
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<cr>",
      scope_incremental = "<cr>",
      node_incremental = "<tab>",
      node_decremental = "<s-tab>",
    },
  },
  -- This is experimental and seems to do poorly at times, particularly in python.
  -- Perhaps in the future it should be re-enabled.
  indent = {
    enable = false,
  },
  -- Integration with nvim-autopairs
  autopairs = { enable = true },
  -- Use nvim-ts-rainbow2 for rainbow delimiters.
  rainbow = {
    enable = true,
    max_file_lines = 2048,
    -- try to speed things up by only highlighting the current sub-tree.
    -- default is global.
    strategy = require "ts-rainbow.strategy.local",
  },
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
        -- ]c is used by default for git naviation; we have it set to quickfix navigation.
        -- So ]] is used for class naviation.
        ["]]"] = "@class.outer",
        ["]a"] = "@parameter.inner",
        ["]o"] = "@comment.outer",
        ["]b"] = "@block.outer",
        -- No "paragraph" text object; "block" is different.
        -- ["]p"] = "@block.outer",
      },
      goto_next_end = {
        -- ["]M"] = "@function.outer",
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]A"] = "@parameter.inner",
        ["]O"] = "@comment.outer",
        ["]B"] = "@block.outer",
      },
      goto_previous_start = {
        -- ["[m"] = "@function.outer",
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[a"] = "@parameter.inner",
        ["[o"] = "@comment.outer",
        ["[b"] = "@block.outer",
      },
      goto_previous_end = {
        -- ["[M"] = "@function.outer",
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
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
  -- These are part of nvim-treesitter-refactor
  refactor = {
    highlight_definitions = { enable = true },
    -- This option feels heavy-handed and makes folds less obvious
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "<leader>cr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition_lsp_fallback = "gd",
        list_definitions = "<leader>lD",
        list_definitions_toc = "<leader>lO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
}
