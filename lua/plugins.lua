-- This block is for installing packer
local function check_dl_packer()
  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
  end
end

check_dl_packer()

return require('packer').startup(function (use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Surround actions/objects
  use 'tpope/vim-surround'
  -- Repeat plugin commands
  use 'tpope/vim-repeat'
  -- Could consider tcomment as an alternative
  use 'tpope/vim-commentary'
  -- For compilation commands
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
  -- Expanded text objects
  use 'wellle/targets.vim'

  -- Easymotion reimplementation
  use {'phaazon/hop.nvim',
    as = 'hop',
    config = function () require('hop').setup() end,
  }

  use {'windwp/nvim-autopairs',
    config = function () require('cfg.autopairs') end,
    -- Load after cmp to set up completion integration.
    -- NOTE: This might no longer be necessary
    after = 'nvim-cmp',
  }

  use {'mhartington/formatter.nvim',
    config = function () require('cfg.formatter') end,
  }

  -- Magit clone
  use {'TimUntersberger/neogit',
    -- lazy-load only when called
    cmd = 'Neogit',
    config = function () require('neogit').setup() end,
  }

  -- Git gutter
  use {'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufRead',
    config = function () require('gitsigns').setup() end,
  }

  -- Status line
  use {'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    after = 'onedark.nvim',
    config = function () require('cfg.lualine') end,
  }

  -- This config is in vimscript and sourced from init.vim
  use {'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function () require('cfg.explorer') end,
  }

  -- Telescope for quickly searching things
  use {'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function () require('cfg.telescope') end,
  }
  use {'nvim-telescope/telescope-project.nvim',
    requires = 'telescope.nvim',
    config = function () require('telescope').load_extension('project') end,
  }
  use {'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    requires = 'telescope.nvim',
    config = function () require('telescope').load_extension('fzf') end,
  }
  -- TODO: consider other extension from nvim-telescope, frecency.

  use {'nvim-treesitter/nvim-treesitter',
    branch = '0.5-compat',
    run = ':TSUpdate',
    config = function () require('cfg.treesitter') end,
  }
  use {'nvim-treesitter/nvim-treesitter-textobjects',
    branch = '0.5-compat',
    requires = 'nvim-treesitter',
  }
  use {'nvim-treesitter/nvim-treesitter-refactor',
    requires = 'nvim-treesitter',
  }
  use {'p00f/nvim-ts-rainbow',
    requires = 'nvim-treesitter',
  }

  -- LSP functionality
  use {'kabouzeid/nvim-lspinstall',
    requires = 'nvim-lspconfig'
  }
  use 'nvim-lua/lsp-status.nvim'
  use {'neovim/nvim-lspconfig',
    after = 'nvim-cmp',
    config = function () require('cfg.lsp').setup_servers() end,
  }

  use {'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function () require('trouble').setup() end,
  }

  -- Keybindings and help
  use {'folke/which-key.nvim',
    event = 'BufWinEnter',
    config = function () require('cfg.which-key') end,
  }

  -- TODO: Try re-enabling this. It might lead to slowdown.
  -- use {'kosayoda/nvim-lightbulb',
  --   config = function ()
  --     vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
  --   end
  -- }

  use {'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
    -- Don't lazy-load since we configure LSP based on completion capabilities.
    -- event = 'InsertEnter *',
    config = function () require('cfg.complete') end,
  }

  -- This isn't really configured right now, although rust-tools may do some
  -- setup.
  use 'mfussenegger/nvim-dap'

  -- Language-specific
  use {
    'stsewd/isort.nvim',
    ft = 'python',
    run = ':UpdateRemotePlugins',
    -- use lowercase isort
    config = function () vim.g.isort_command = 'isort' end,
  }
  -- This configures and sets up LSP using the rust-analyzer found in $PATH.
  -- Thus, we should not call `:LspInstall rust` to configure it as part of our
  -- LSP client setup.
  use {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    config = function () require('rust-tools').setup({
      server = {
        on_attach = require('cfg.lsp').on_attach,
      },
    }) end,
    requires = {
      'nvim-lspconfig',
      {'popup.nvim', opt = true},
      {'plenary.nvim', opt = true},
      {'telescope.nvim', opt = true},
      {'nvim-dap', opt = true},
    },
  }

  -- theme
  use {
    'navarasu/onedark.nvim',
    config = function ()
      -- Change the default style before calling setup(), e.g.:
      -- vim.g.onedark_style = 'darker'
      require('onedark').setup()
    end,
  }
end)
