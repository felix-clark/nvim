" fish shell seems to slow things down
set shell=bash
" in lua this would be:
" vim.opt.shell = "bash"

" This seems to give a nicer palette; requires ISO-8613-3 terminal.
" Some plugins, like nvim-tree, require it, as does the colorscheme onedark.
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

" Since we have `yy`, make Y follow C and D convention.
" NOTE: This has been merged into neovim master so eventually this line can be
" removed. Check with `:h Y`.
nnoremap Y y$

" use 'jk' combination to quit insert mode
inoremap jk <Esc>
" something similar for terminal (?)
" tnoremap jk <C-\><C-n>
" This messes with fzf windows, although telescope seems fine so far
tnoremap <Esc> <C-\><C-n>

" start in terminal (insert-like) mode when opening a terminal window
autocmd TermOpen * startinsert

" Quick window motion with Alt+<direction>
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l

" disable accidentally pressing C-z to suspend
nnoremap <C-z> <Nop>

" snappier response time (default 1000ms)
" Make sure to not set notimeout
set timeoutlen=400
" Reduce the delay (from 4s) for the CursorHold event. Used in crash-recovery
" as well.
set updatetime=600

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
