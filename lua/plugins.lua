local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {

  -- Repeat plugin commands
  "tpope/vim-repeat",
  -- For compilation commands
  {
    "tpope/vim-dispatch",
    lazy = true,
    cmd = { "Dispatch", "Make", "Focus", "Start" },
  },
  -- Expanded text objects
  "wellle/targets.vim",
  -- More practical definition of "word"
  {
    "chaoren/vim-wordmotion",
    config = function()
      -- these are recommended to restore standard vim behavior to preserve
      -- whitespace between words:
      -- vim.api.nvim_set_keymap("n", "cw", "ce")
      -- vim.api.nvim_set_keymap("n", "cW", "cE")
    end,
  },
  -- Surround actions/objects, extension of tpope's vim-surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },

  -- theme
  {
    "rebelot/kanagawa.nvim",
    config = function()
      -- No need to call setup if the defaults are satisfactory
      -- require("kanagawa").setup {}
      vim.cmd "colorscheme kanagawa"
    end,
  },

  -- A more opinionated motion plugin
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  -- improved f/F/t/T motions that extend leap.nvim for single-character jumps
  {
    "ggandor/flit.nvim",
    dependencies = { "leap.nvim" },
    config = function()
      require("flit").setup {
        -- default is only in visual mode
        labeled_modes = "nv",
      }
    end,
  },
  -- NOTE: there is a leap-ast plugin as well but it is very incomplete

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require "cfg.autopairs"
    end,
    -- Load after cmp to set up completion integration.
    -- NOTE: This might no longer be necessary
    dependencies = { "nvim-cmp" },
  },

  -- ensure devicons are installed. If this isn't made explicit some dependents
  -- don't find it (e.g. trouble), although lazy.nvim may help this situation
  "kyazdani42/nvim-web-devicons",

  -- Allows command line linters and formatters to interact like LSP clients
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require "cfg.null-ls"
    end,
  },

  -- Magit clone
  {
    "TimUntersberger/neogit",
    -- lazy-load only when called
    cmd = "Neogit",
    config = function()
      require("neogit").setup()
    end,
  },

  -- Git gutter
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- Lazy-loading can easily cause problems, particularly with the git hydra
    -- event = "BufRead",
    config = function()
      require("gitsigns").setup {
        -- A value of 15 or greater should prioritize gitsigns over diagnostics
        -- (which are also underlined)
        sign_priority = 20,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
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
          map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>")
          map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>")
          map("n", "<leader>gS", gs.stage_buffer)
          map("n", "<leader>gu", gs.undo_stage_hunk)
          map("n", "<leader>gR", gs.reset_buffer)
          map("n", "<leader>gp", gs.preview_hunk)
          map("n", "<leader>gb", function()
            gs.blame_line { full = true }
          end)
          map("n", "<leader>gd", gs.diffthis)
          map("n", "<leader>gD", function()
            gs.diffthis "~"
          end)
          -- NOTE: toggle blame and deleted are defined in which-key

          -- Text object
          map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<cr>")
        end,
      }
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    config = function()
      require "cfg.statusline"
    end,
  },

  -- This config is migrating from vimscript to lua
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    -- NOTE: There are several more commands from this package but we really
    -- only use Toggle.
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" },
    config = function()
      require "cfg.explorer"
    end,
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
    -- build = "make",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
  { "HiPhish/nvim-ts-rainbow2", dependencies = { "nvim-treesitter" } },

  -- easy toggle terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
  },

  -- better development of neovim lua configuration
  -- must be setup before lspconfig is, but after loading it.
  {
    "folke/neodev.nvim",
  },

  -- Mason for easy install of 3rd-party dependencies
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "nvim-lspconfig" },
  },
  -- LSP functionality
  "nvim-lua/lsp-status.nvim",
  {
    "neovim/nvim-lspconfig",
    -- These packages require some configuration in cfg.lsp
    dependencies = { "nvim-cmp", "lsp_signature.nvim", "mason-lspconfig.nvim", "neodev.nvim" },
    config = function()
      require "cfg.lsp"
    end,
  },

  -- Missing IDE-like features; see litee for more detail. There's a lot more to set up here.
  -- TODO: Try to lazy-load, waiting for an LSP buffer to be opened
  {
    "ldelossa/litee.nvim",
    config = function()
      require("litee.lib").setup()
    end,
  },
  -- Browse callers and callees of the current function
  {
    "ldelossa/litee-calltree.nvim",
    dependencies = { "litee.nvim" },
    config = function()
      require("litee.calltree").setup()
    end,
  },
  -- litee-symboltree for tree-based symbol navigation
  {
    "ldelossa/litee-symboltree.nvim",
    dependencies = { "litee.nvim" },
    config = function()
      require("litee.symboltree").setup()
    end,
  },

  -- Show LSP call signature in completion window.
  -- Toggle with <C-s> (configured in cfg/lsp.lua)
  "ray-x/lsp_signature.nvim",

  {
    "folke/trouble.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    -- NOTE: We can't lazy-load because the telescope configuration sets up
    -- integration w/ Trouble
    -- cmd = { "Trouble", "TroubleToggle", "TroubleClose", "TroubleRefresh" },
    config = function()
      require("trouble").setup()
    end,
  },

  -- Keybindings and help
  {
    "folke/which-key.nvim",
    event = "BufWinEnter",
    config = function()
      require "cfg.which-key"
    end,
  },

  {
    "anuvyklack/hydra.nvim",
    dependencies = { "anuvyklack/keymap-layer.nvim", "gitsigns.nvim" }, -- needed only for pink hydras
    event = "BufWinEnter",
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
    -- Don't lazy-load since we configure LSP based on completion capabilities.
    -- event = 'InsertEnter *',
    config = function()
      require "cfg.complete"
    end,
  },

  -- Add pre-defined snippets. Should this be a nvim-cmp requirement?
  "rafamadriz/friendly-snippets",

  -- Debugging with DAP
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = "BufReadPre",
    dependencies = {
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
    config = function()
      require("mason-nvim-dap").setup {
        ensure_installed = { "codelldb", "python" },
      }
    end,
  },

  -- Language-specific

  -- kitty terminal configuration syntax highlighting
  { "fladson/vim-kitty", ft = "kitty" },

  -- This configures and sets up LSP using the rust-analyzer found in $PATH.
  -- Thus, we may not need to `:LspInstall rust` to configure it as part of our
  -- LSP client setup.
  {
    "simrat39/rust-tools.nvim",
    -- mason-lspconfig *should* handle the file type
    -- ft = "rust",
    dependencies = {
      "nvim-lspconfig",
      "popup.nvim",
      "plenary.nvim",
      "telescope.nvim",
      "nvim-dap",
    },
  },

  -- org-mode emulation
  {
    "nvim-orgmode/orgmode",
    -- Lazy-loading is not recommended. This package loads quickly and needs to be used before setting up treesitter.
    -- ft = { "org" },
    config = function()
      require("orgmode").setup {
        -- note: there are more
        org_agenda_files = { "~/org/todo.org", "~/org/felix-agenda.org" },
        org_default_notes_file = "~/org/notes.org",
      }
    end,
  },
}
