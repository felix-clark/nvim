-- Need to set up orgmode TS parser first
require('orgmode').setup_ts_grammar()

-- NOTE: the "ensure_installed" line could be removed in lieu of manual installations.
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = {"org"}, -- Remove this to use TS highligher for some highlights (Experimental)
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = {"org"}, -- Required since TS highlighter doesn't support all syntax features (conceal)
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
  -- Use nvim-ts-rainbow for rainbow delimiters
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  },
  -- These are part of nvim-treesitter-textobjects
  -- TODO: There are many more text objects possible, check
  -- nvim-treesitter-textobjects documentation. The ones here are better
  -- versions of neovim's defaults.
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
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
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
      }
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
