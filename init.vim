" This seems to give a nicer palette; requires ISO-8613-3 terminal.
" Some plugins, like nvim-tree, require it.
set termguicolors

" give the terminal window an appropriate title with the name of the open file
set title

" Insert spaces instead of tab, using a default width of 2.
" Use `:set noexpandtab` to temporarily disable.
set expandtab
set tabstop=2
set shiftwidth=2

" Line wrap between words to avoid breaking them up
set linebreak

" Set absolute and relative line numbers both on (current line gives absolute).
" See the vim-numbertoggle plugin for a better way of toggling between options
set number
set relativenumber

" Keep all folds open to start
" set foldlevelstart=99

" Complete the longest common string and show the list of potential matches
" when using <TAB>
set wildmode=longest,list

" show matching brackets 
set showmatch

" use 'jk' combination to quit insert mode
inoremap jk <Esc>
" something similar for terminal (?)
" tnoremap jk <C-\><C-n>
" This messes with fzf windows:
" tnoremap <Esc> <C-\><C-n>

" disable accidentally pressing C-z to suspend
nnoremap <C-z> <Nop>

" snappier response time (default 1000ms)
" Make sure to not set notimeout
set timeoutlen=400

" Leader key should be set before plugins in case they use leader key mappings
" map the leader and localleader to space (default is '\')
let mapleader=' '
let maplocalleader=' '

" Run :PlugInstall and :PlugUpdate to install and update plugins.

call plug#begin()

Plug 'navarasu/onedark.nvim'
" Surround actions/objects
Plug 'tpope/vim-surround'
" Repeat plugin commands
Plug 'tpope/vim-repeat'
" Could consider tcomment as an alternative
Plug 'tpope/vim-commentary'
" Easymotion reimplementation
Plug 'phaazon/hop.nvim'
Plug 'windwp/nvim-autopairs'
" Magit clone
Plug 'TimUntersberger/neogit'
" Git gutter
Plug 'lewis6991/gitsigns.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim' " required for other plugins
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" TODO: consider other extension from nvim-telescope, frecency.
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'p00f/nvim-ts-rainbow'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'folke/trouble.nvim'
Plug 'folke/which-key.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'mfussenegger/nvim-dap'
Plug 'simrat39/rust-tools.nvim'
Plug 'cespare/vim-toml'

call plug#end()

" let g:onedark_style = 'darker'
colorscheme onedark

" lualine configuration
source $HOME/.config/nvim/lualine.lua

lua <<EOF
require('hop').setup()
EOF

" gitsigns configuration
" TODO: Disable default keybindings, replacing text objects
lua <<EOF
require('gitsigns').setup()
EOF

lua <<EOF
require('neogit').setup()
EOF

" Most keymappings are defined here
source $HOME/.config/nvim/which-key.lua

source $HOME/.config/nvim/autopairs.lua

source $HOME/.config/nvim/telescope.lua

""" Compe configuration
source $HOME/.config/nvim/compe.lua

inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" Compe documentation says this is needed for nvim-autopairs, but it's not
" clear it makes a difference given the autopairs config doing a re-mapping:
" inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

highlight link CompeDocumentation NormalFloat
""" End compe configuration

""" Treesitter configuration
source $HOME/.config/nvim/treesitter.lua
" Define folds based on treesitter objects
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
""" End treesitter configuration

""" nvim-lspconfig configuration
""" (and possibly nvim-lspinstall in the future)
source $HOME/.config/nvim/lspconfig.lua
""" End nvim-lspconfig configuration

""" Configure nvim-lightbulb
" Update the lightbulbs when there is a pause
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
""" end nvim-lightbulb configuration

""" nvim-tree configuration
source $HOME/.config/nvim/nvim-tree.vim
""" End nvim-tree configuration

" use <C-[jk]> instead of <C-[np]> to navigate completion window
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

""" Language-specific configuration

" Filetype plugins are defined in (:echo $VIMRUNTIME) (e.g.
" /usr/share/nvim/runtime/ftplugin).
" To load additional configuration for a filetype, add {ft}.vim to
" ./after/ftplugin/{ft}.vim where {ft} is a filetype.
