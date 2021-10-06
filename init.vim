" fish shell seems to slow things down
set shell=bash
" in lua this would be:
" vim.opt.shell = "bash"

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
" map the leader to space (default is '\')
let mapleader=' '
" Use <SPC>m for local leader, although this is seldom used right now.
let maplocalleader=' m'

""" nvim-tree configuration is in vimscript.
" It configures global options that should be set before calling setup().
source $HOME/.config/nvim/nvim-tree.vim
""" End nvim-tree configuration

" Run :PackerSync to clean, install, and update plugins.
" Run :PackerCompile following changes to plugin configuration.
lua <<EOF
require('plugins')
require('fold')
EOF
