" See https://github.com/Optixal/neovim-init.vim for more ideas

" from https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/colors/codedark.vim
colorscheme codedark

" This seems to give a nicer palette; requires ISO-8613-3 terminal.
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

" disable accidentally pressing C-z to suspend
nnoremap <C-z> <Nop>

" nnoremap <space> <nop>
" Leader key should be set before plugins in case they use leader key mappings
" map the leader and localleader to space (default is '\')
let mapleader=' '
let maplocalleader=' '
" additional keybindings go below:
" Comfortable access to window menu
nnoremap <leader>w <C-w>
" one we use vim-which-key we can define it as such:
" There's more to do; see vim-which-key documentation for info.
" let g:which_key_map.w = { 'name' : '+window' }

""" List of plugins to consider:
" * fzf
" * vim-which-key
" * nerdtree-git-plugin
" * airline
" * deoplete for completion (requires python3 support in neovim)

" Run :PlugInstall and :PlugUpdate to install and update plugins.

call plug#begin()

Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeToggleVCS'] }

call plug#end()

" NERDCommenter config
let g:NERDSpaceDelims = 1

nnoremap <leader>tt :NERDTreeToggleVCS<cr>
