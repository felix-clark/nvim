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

return require("packer").startup({ function(use)
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
    "ggandor/leap.nvim",
    requires = { "tpope/vim-repeat" },
    config = function()
      require("leap").add_default_mappings()
    end,
  }
  -- improved f/F/t/T motions; however note that ';,' navigation (as in vim) is
  -- not yet integrated; instead the f/F/t/T key is repeated.
  use {
    "ggandor/flit.nvim",
    requires = { "leap.nvim" },
    config = function()
      require("flit").setup{
        -- default is only in visual mode
        labeled_modes = "nv"
      }
    end
  }
  -- NOTE: there is a leap-ast plugin as well but it is very incomplete

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

  -- ensure devicons are installed. If this isn't made explicit some dependents
  -- don't find it (e.g. trouble)
  use "kyazdani42/nvim-web-devicons"

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
            if vim.wo.diff then return "]g" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true })
          map("n", "[g", function()
            if vim.wo.diff then return "[g" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true })

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
  -- I don't really use project management and it has a slow-ish startup time.
  -- use {
  --   "nvim-telescope/telescope-project.nvim",
  --   requires = "telescope.nvim",
  --   config = function()
  --     require("telescope").load_extension "project"
  --   end,
  -- }
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
    -- lazy-load when we open the file tree. waiting until <leader>fr doesn't work properly.
    keys = { "<leader>f" },
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
  use { "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    requires = { "mason.nvim", "nvim-lspconfig" },
    after = { "mason.nvim" },
  }
  use "nvim-lua/lsp-status.nvim"
  use {
    "neovim/nvim-lspconfig",
    -- These packages require some configuration in cfg.lsp
    after = { "nvim-cmp", "lsp_signature.nvim", "mason-lspconfig.nvim" },
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
  -- litee-symboltree for tree-based symbol navigation
  use {
    "ldelossa/litee-symboltree.nvim",
    requires = "litee.nvim",
    after = "litee.nvim",
    config = function()
      require("litee.symboltree").setup()
    end,
  }

  -- Show LSP call signature in completion window.
  -- Toggle with <C-s> (configured in cfg/lsp.lua)
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
    after = "gitsigns.nvim",
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
  -- Thus, we may not need to `:LspInstall rust` to configure it as part of our
  -- LSP client setup.
  use {
    "simrat39/rust-tools.nvim",
    -- mason-lspconfig *should* handle the file type
    -- ft = "rust",
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
end,
  config = {
    profile = {
      enable = true,
      -- amount of time in ms a plugin must be over
      threshold = 1,
    },
  },
})
