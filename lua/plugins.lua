return {
  -- theme should be loaded first
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- No need to call setup if the defaults are satisfactory
      -- require("kanagawa").setup {}
      vim.cmd "colorscheme kanagawa"
    end,
  },

  -- Repeat plugin commands
  "tpope/vim-repeat",
  -- For compilation commands
  {
    "tpope/vim-dispatch",
    lazy = true,
    cmd = { "Dispatch", "Make", "Focus", "Start" },
    keys = { { "<leader>cc", "<cmd>Dispatch<cr>", desc = "Compile" } },
  },
  -- Expanded text objects
  "wellle/targets.vim",
  -- More practical definition of "word"
  {
    "chaoren/vim-wordmotion",
    config = function()
      -- these are recommended to restore standard vim behavior to preserve
      -- whitespace between words, but do I even use these?
      -- vim.api.nvim_set_keymap("n", "cw", "ce")
      -- vim.api.nvim_set_keymap("n", "cW", "cE")
    end,
  },
  -- Surround actions/objects, extension of tpope's vim-surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },

  -- improved search, f/F/t/T, treesitter motions, remote actions
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = require("cfg.motion").keys,
    config = true,
  },

  {
    "numToStr/Comment.nvim",
    config = true,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- Load after cmp to set up completion integration.
    -- dependencies = { "nvim-cmp" },
    config = function()
      require "cfg.autopairs"
    end,
  },

  -- ensure devicons are installed. If this isn't made explicit some dependents
  -- don't find it (e.g. trouble), although lazy.nvim may help this situation
  { "nvim-tree/nvim-web-devicons" },

  -- Tie standalone linters into vim.diagnostic.
  {
    "mfussenegger/nvim-lint",
    config = function()
      require "cfg.lint"
    end,
  },
  -- Async formatting for non-LSP sources (with fallback)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = require("cfg.format").keys,
    opts = require("cfg.format").opts,
  },

  -- Magit clone
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = require("cfg.git").neogit_keys,
    config = true,
  },
  -- Git gutter
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- lazy loading gitsigns can cause occasional errors
    -- event = "BufRead",
    opts = require("cfg.git").gitsigns_opts,
  },
  -- Blame history more in-depth than seems available in neogit/gitgutter.
  {
    "FabijanZulj/blame.nvim",
    keys = { { "<leader>tb", "<cmd>BlameToggle window<cr>", desc = "Toggle git blame" } },
    config = true,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons", "linrongbin16/lsp-progress.nvim" },
    config = function()
      require "cfg.statusline"
    end,
  },

  -- This config is migrating from vimscript to lua
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- NOTE: There are several more commands from this package; these are meant
    -- to cover the ones that are called first.
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile", "NvimTreeOpen" },
    config = function()
      require "cfg.explorer"
    end,
    keys = {
      { "<leader>ot", "<cmd>NvimTreeOpen<cr>", desc = "Project tree" },
    },
  },

  -- Telescope for quickly searching things
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require "cfg.telescope"
    end,
  },
  -- I don't really use project management and it has a slow-ish startup time.
  -- use {
  --   "nvim-telescope/telescope-project.nvim",
  --   dependencies = {"telescope.nvim"},
  --   config = function()
  --     require("telescope").load_extension "project"
  --   end,
  -- }
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = { "telescope.nvim" },
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = { "telescope.nvim", "tami5/sqlite.lua", "nvim-web-devicons" },
    keys = { { "<leader>fr", "<cmd>Telescope frecency<cr>", desc = "Open recent file" } },
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },
  -- use telescope for `vim.ui.select`, so neovim core selections can fill telescope picker.
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "telescope.nvim" },
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "cfg.treesitter"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter" },
  },
  { "nvim-treesitter/nvim-treesitter-refactor", dependencies = { "nvim-treesitter" } },

  -- More powerful refactoring using treesitter
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "Refactor",
    config = true,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter" },
    submodules = false,
    main = "rainbow-delimiters.setup",
  },

  -- easy toggle terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- This plugin loads pretty quickly so there's no need to lazify it
    -- (which would complicate the setup significantly).
    config = function()
      require("toggleterm").setup {
        size = function(term)
          if term.direction == "horizontal" then
            return 18
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
      }
      require "cfg.terminal"
    end,
  },

  -- Configure LuaLS
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

  -- Mason for easy install of 3rd-party dependencies
  {
    "williamboman/mason.nvim",
    config = true,
  },
  -- auto-install tools that aren't LSP or DAP
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = { "tree-sitter-cli", "stylua", "mypy" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "nvim-lspconfig" },
  },
  {
    "linrongbin16/lsp-progress.nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    -- These packages require some configuration in cfg.lsp
    dependencies = { "nvim-cmp", "lsp_signature.nvim", "mason-lspconfig.nvim" },
    config = function()
      require "cfg.lsp"
    end,
  },

  -- Missing IDE-like features; see litee for more detail. There's a lot more to set up here.
  -- TODO: Try to lazy-load, waiting for an LSP buffer to be opened
  {
    "ldelossa/litee.nvim",
    config = true,
    main = "litee.lib",
  },
  -- Browse callers and callees of the current function
  {
    "ldelossa/litee-calltree.nvim",
    dependencies = { "litee.nvim" },
    config = true,
    main = "litee.calltree",
  },
  -- litee-symboltree for tree-based symbol navigation
  {
    "ldelossa/litee-symboltree.nvim",
    dependencies = { "litee.nvim" },
    config = true,
    main = "litee.symboltree",
  },

  -- Show LSP call signature in completion window.
  -- Toggle with <C-s> (configured in cfg/lsp.lua)
  "ray-x/lsp_signature.nvim",

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    config = true,
    keys = require("cfg.trouble").keys,
  },

  -- Keybindings and help
  {
    "folke/which-key.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require "cfg.which-key"
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show { global = false }
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "nvimtools/hydra.nvim",
    config = function()
      require "cfg.hydra"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-path",
      -- Consider vim commandline completion
      -- "hrsh7th/cmp-cmdline",
      -- For neovim lua API completion
      "hrsh7th/cmp-nvim-lua",
    },
    event = "InsertEnter *",
    config = function()
      require "cfg.complete"
    end,
  },

  -- Debugging with DAP
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    -- NOTE: This could probably be refactored to be lazier by defining
    -- keybingings that require("dap") as needed, but it would take some
    -- refactoring.
    event = "BufReadPre",
    dependencies = {
      "nvim-neotest/nvim-nio",
      -- UI dependencies
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
      -- language-specific dependencies
      "jbyuki/one-small-step-for-vimkind",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      require("cfg.dap").setup()
    end,
  },
  -- integrate nvim-dap w/ mason
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = { "codelldb", "python" },
    },
  },

  -- Language-specific (filetype plugins are often lazy-loaded by default, and
  -- regardless it seems to be generally un-recommended to lazy-load these)

  -- kitty terminal configuration syntax highlighting
  { "fladson/vim-kitty", ft = "kitty" },

  -- extended LSP and debugging features for rust
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended to pin the version explicitly
    lazy = false, -- readme says it's already lazy
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              -- NOTE: sometimes features are mutually exclusive, which can
              -- lock up check/clippy, so --all-features shouldn't be enabled
              -- by default.
              -- allFeatures = true,
              allTargets = true,
            },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
    end,
  },

  -- Cargo.toml crate version features
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },

  -- LaTeX (lazy-loaded by default)
  {
    "lervag/vimtex",
    -- Some configuration is suggested but it doesn't appear very necessary.
    -- Commands are mapped to local-leader (<space>m).
  },

  -- org-mode emulation
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    opts = {
      -- note: there are more
      org_agenda_files = { "~/org/todo.org", "~/org/felix-agenda.org" },
      org_default_notes_file = "~/org/notes.org",
    },
  },
}
