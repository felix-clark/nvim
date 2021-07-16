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

  -- Check this out sometime (e.g. build commands)
  -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  --" Surround actions/objects
  use 'tpope/vim-surround'
  --" Repeat plugin commands
  use 'tpope/vim-repeat'
  --" Could consider tcomment as an alternative
  use 'tpope/vim-commentary'
  --" Expanded text objects
  use 'wellle/targets.vim'

  -- Easymotion reimplementation
  use {'phaazon/hop.nvim',
    as = 'hop',
    config = function () require('hop').setup() end,
  }

  use {'windwp/nvim-autopairs',
    config = function () require('cfg.autopairs') end,
    -- Load after compe to set up completion integration
    after = 'nvim-compe',
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
    event = "BufRead",
    config = function () require('gitsigns').setup() end,
  }

  -- Status line
  use {'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function () require('cfg.lualine') end,
  }

  -- This config is in vimscript and sourced from init.vim
  use {'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
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
    run = ':TSUpdate',
    config = function () require('cfg.treesitter') end,
  }
  use {'nvim-treesitter/nvim-treesitter-textobjects',
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
    config = function () require('cfg.lsp') end,
  }

  use {'folke/trouble.nvim',
    requires = "kyazdani42/nvim-web-devicons",
    config = function () require('trouble').setup() end,
  }

  -- Keybindings and help
  use {'folke/which-key.nvim',
    event = "BufWinEnter",
    config = function () require('cfg.which-key') end,
  }

  -- TODO: Try re-enabling this. It might lead to slowdown.
  -- use {'kosayoda/nvim-lightbulb',
  --   config = function ()
  --     vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
  --   end
  -- }

  use {'hrsh7th/nvim-compe',
    requires = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
    },
    config = function () require('cfg.compe') end,
  }

  -- This isn't really configured right now
  use 'mfussenegger/nvim-dap'

  -- Language-specific
  use 'simrat39/rust-tools.nvim'
  use 'cespare/vim-toml'

  -- theme
  use 'navarasu/onedark.nvim'
end)
