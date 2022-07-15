-- This block is for installing packer
local function check_dl_packer()
  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
    fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
    execute "packadd packer.nvim"
  end
end

check_dl_packer()

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Surround actions/objects
  use "tpope/vim-surround"
  -- Repeat plugin commands
  use "tpope/vim-repeat"
  -- For compilation commands
  use { "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } }
  -- Expanded text objects
  use "wellle/targets.vim"

  -- Easymotion reimplementation
  use {
    "phaazon/hop.nvim",
    as = "hop",
    config = function()
      require("hop").setup()
    end,
  }

  -- A more opinionated motion plugin
  use {
    "ggandor/lightspeed.nvim",
    requires = { "tpope/vim-repeat" },
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require "cfg.autopairs"
    end,
    -- Load after cmp to set up completion integration.
    -- NOTE: This might no longer be necessary
    after = "nvim-cmp",
  }

  -- Allows command line linters and formatters to interact like LSP clients
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    after = { "nvim-lspconfig" },
    config = function()
      require "cfg.null-ls"
    end,
  }

  -- Magit clone
  use {
    "TimUntersberger/neogit",
    -- lazy-load only when called
    cmd = "Neogit",
    config = function()
      require("neogit").setup()
    end,
  }

  -- Git gutter
  use {
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    event = "BufRead",
    config = function()
      require("gitsigns").setup {
        -- A value of 15 or greater should prioritize gitsigns over diagnostics
        -- (which are also underlined)
        sign_priority = 20,
        -- NOTE: this function will change in neovim 0.7
        on_attach = function(bufnr)
          -- local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            -- opts = opts or {}
            -- opts.buffer = bufnr
            -- vim.keymap.set(mode, l, r, opts)
            opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, l, r, opts)
          end
          -- Navigation
          map("n", "]g", "&diff ? ']g' : '<cmd>Gitsigns next_hunk<cr>'", { expr = true })
          map("n", "[g", "&diff ? '[g' : '<cmd>Gitsigns prev_hunk<cr>'", { expr = true })

          -- Actions
          -- note that there is also a toggle line blame
          map("n", "<leader>gb", '<cmd>lua require("gitsigns").blame_line{full=true}<cr>')
          map("n", "<leader>gd", "<cmd>Gitsigns diff_this<cr>")
          map("n", "<leader>gD", '<cmd>lua require("gitsigns").diff_this("~")<cr>')
          map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>")
          map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>")
          map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>")
          map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>")
          map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>")
          map(
            "v",
            "<leader>gr",
            '<cmd>lua require("gitsigns").reset_hunk({vim.fn.line("."), vim.gn.line("v")})<cr>'
          )
          map(
            "v",
            "<leader>gs",
            '<cmd>lua require("gitsigns").stage_hunk({vim.fn.line("."), vim.gn.line("v")})<cr>'
          )

          -- Text object
          map("o", "ih", ":<C-u>Gitsigns select_hunk<cr>")
          map("x", "ih", ":<C-u>Gitsigns select_hunk<cr>")
        end,
      }
    end,
  }

  -- Status line
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    after = "onedark.nvim",
    config = function()
      require "cfg.statusline"
    end,
  }

  -- This config is migrating from vimscript to lua
  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    -- NOTE: There are several more commands from this package but we really
    -- only use Toggle.
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" },
    config = function()
      require "cfg.explorer"
    end,
  }

  -- Telescope for quickly searching things
  use {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    -- load after Trouble so the keymapping to open results in trouble works.
    -- This leads to problems with the other telescope plugins, however.
    -- after = "trouble.nvim",
    config = function()
      require "cfg.telescope"
    end,
  }
  use {
    "nvim-telescope/telescope-project.nvim",
    requires = "telescope.nvim",
    config = function()
      require("telescope").load_extension "project"
    end,
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    requires = "telescope.nvim",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "telescope.nvim", "tami5/sqlite.lua", { "nvim-web-devicons", opt = true } },
    config = function()
      require("telescope").load_extension "frecency"
    end,
  }
  -- use telescope for `vim.ui.select`, so neovim core selections can fill telescope picker.
  use {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "cfg.treesitter"
    end,
  }
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = "nvim-treesitter",
  }
  use { "nvim-treesitter/nvim-treesitter-refactor", requires = "nvim-treesitter" }
  use { "p00f/nvim-ts-rainbow", requires = "nvim-treesitter" }

  -- LSP functionality
  use { "williamboman/nvim-lsp-installer", requires = "nvim-lspconfig" }
  use "nvim-lua/lsp-status.nvim"
  use {
    "neovim/nvim-lspconfig",
    -- These packages require some configuration in cfg.lsp
    after = { "nvim-cmp", "lsp_signature.nvim" },
    config = function()
      require "cfg.lsp"
    end,
  }

  -- Missing IDE-like features; see litee for more detail. There's a lot more to set up here.
  -- TODO: Try to lazy-load, waiting for an LSP buffer to be opened
  use {
    "ldelossa/litee.nvim",
    config = function()
      require("litee.lib").setup()
    end,
  }
  -- Browse callers and callees of the current function
  use {
    "ldelossa/litee-calltree.nvim",
    requires = "litee.nvim",
    config = function()
      require("litee.calltree").setup()
    end,
  }

  -- Show LSP call signature in completion window.
  -- Toggle with <C-s> (configured in cfg.lsp)
  use {
    "ray-x/lsp_signature.nvim",
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    -- NOTE: We can't lazy-load because the telescope configuration sets up
    -- integration w/ Trouble
    -- cmd = { "Trouble", "TroubleToggle", "TroubleClose", "TroubleRefresh" },
    config = function()
      require("trouble").setup()
    end,
  }

  -- Keybindings and help
  use {
    "folke/which-key.nvim",
    event = "BufWinEnter",
    config = function()
      require "cfg.which-key"
    end,
  }

  use {
    "anuvyklack/hydra.nvim",
    requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
    event = "BufWinEnter",
    config = function()
      require "cfg.hydra"
    end,
  }

  -- This is cute butthe cursor must be at exactly the right spot.
  -- Can take a while to trigger unless updatetime is reduced, but be warned
  -- that this has effects on crash-recovery.
  -- NOTE: With gitsigns integration, everywhere has a lightbulb. It doesn't add much.
  -- use {
  --   "kosayoda/nvim-lightbulb",
  --   config = function()
  --     vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
  --   end,
  -- }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
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
  }

  -- Add pre-defined snippets. Should this be a nvim-cmp requirement?
  use "rafamadriz/friendly-snippets"

  -- Debugging isn't really configured right now, although rust-tools may do
  -- some setup.
  use { "mfussenegger/nvim-dap", keys = { "<leader>d" } }

  -- Language-specific

  -- kitty terminal configuration syntax highlighting
  use { "fladson/vim-kitty", ft = "kitty" }

  -- This configures and sets up LSP using the rust-analyzer found in $PATH.
  -- Thus, we should not call `:LspInstall rust` to configure it as part of our
  -- LSP client setup.
  use {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      require("rust-tools").setup {
        server = {
          on_attach = require("cfg.lsp").on_attach,
        },
      }
    end,
    requires = {
      "nvim-lspconfig",
      { "popup.nvim", opt = true },
      { "plenary.nvim", opt = true },
      { "telescope.nvim", opt = true },
      { "nvim-dap", opt = true },
    },
  }

  -- org-mode emulation
  use {
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
  }

  -- theme
  use {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup {
        style = "darker",
        toggle_style_key = "<leader>ts",
        -- can use `toggle_style_list` to pick the styles that are toggled
      }
      require("onedark").load()
    end,
  }
end)
