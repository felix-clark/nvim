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
set foldlevelstart=99

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
" Git client. Fugitive can take a long time to load and is slow in general
Plug 'tpope/vim-fugitive'
" Surround actions/objects
Plug 'tpope/vim-surround'
" Repeat plugin commands
Plug 'tpope/vim-repeat'
" Could consider tcomment as an alternative
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'neovim/nvim-lspconfig'
" nvim-lspinstall allows use of :LspInstall; not really used right now
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
lua <<EOF
require'lualine'.setup{
  options = { theme = 'onedark' },
}
EOF

" fly mode for autopairs closes all open delims when the last one is typed
let g:AutoPairsFlyMode = 1
" Don't use the built-in; define our own keybinding for toggle
let g:AutoPairsShortcutToggle = '<leader>tp'

" turn on rainbow parentheses by default
let g:rainbow_active = 1

" Turn off gitgutter default mappings in lieu of our git command tree
let g:gitgutter_map_keys = 0

source $HOME/.config/nvim/which-key.lua

nnoremap ]h <cmd>GitGutterNextHunk<cr>
nnoremap [h <cmd>GitGutterPrevHunk<cr>
" TODO: shortcuts to open config file (local and global)

" TODO: Check :help dap.* for more options
nnoremap <silent> <leader>dd :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dv :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>di :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>do :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dg :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>dr :lua require'dap'.run_to_cursor()<CR>

""" Compe configuration
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

highlight link CompeDocumentation NormalFloat

source $HOME/.config/nvim/compe.lua
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

""" trouble configuration for listing errors
" TODO: Consider changing these default bindings (e.g. <leader>cx to toggle
" window)
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
""" end trouble configuration

""" Configure nvim-lightbulb
" Update the lightbulbs when there is a pause
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
""" end nvim-lightbulb configuration

""" nvim-tree configuration
source $HOME/.config/nvim/nvim-tree.vim
""" End nvim-tree configuration

" use <C-[jk]> instead of <C-[np]> to navigate completion window
" This was used for CoC but perhaps it would still be useful?
" inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
" inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

""" Language-specific configuration

" Filetype plugins are defined in (:echo $VIMRUNTIME) (e.g.
" /usr/share/nvim/runtime/ftplugin).
" To load additional configuration for a filetype, add {ft}.vim to
" ./after/ftplugin/{ft}.vim where {ft} is a filetype.

