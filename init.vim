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
" This messes with fzf windows:
" tnoremap <Esc> <C-\><C-n>

" disable accidentally pressing C-z to suspend
nnoremap <C-z> <Nop>

" Recommended for coc
set hidden
set nobackup
set nowritebackup
set updatetime=300
set cmdheight=2
set shortmess+=c
" TODO: might want set signcolumn-[number|yes]

" nnoremap <space> <nop>
" Leader key should be set before plugins in case they use leader key mappings
" map the leader and localleader to space (default is '\')
let mapleader=' '
let maplocalleader=' '
" additional keybindings go below:
" Comfortable access to window menu
" TODO: Consider mapping <C-j> to <C-w>j, for instance
nnoremap <leader>w <C-w>
" one we use vim-which-key we can define it as such:
" There's more to do; see vim-which-key documentation for info.
" let g:which_key_map.w = { 'name' : '+window' }

""" List of plugins to consider:
" * vim-which-key
" * deoplete for completion (requires python3 support in neovim)
"     Should coc.vim be used instead?

" Run :PlugInstall and :PlugUpdate to install and update plugins.

call plug#begin()

" Fugitive can take a long time to load and is slow in general
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeToggleVCS'] }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Must come after nerdtree and before devicons
Plug 'Xuyuanp/nerdtree-git-plugin'
" This says it must be the last one. Requires a Nerd font.
Plug 'ryanoasis/vim-devicons'

call plug#end()

" airline style
let g:airline_theme = 'angr'
let g:airline_powerline_fonts = 1

" fzf shortcut(s)
" TODO: How to quit the window?
" General find file
nnoremap <leader>ff :Files<cr>
" Files in project
nnoremap <leader>fp :GFiles<cr>
" Search directory (?)
nnoremap <leader>sd :Rg<cr>
" switch buffers
nnoremap <leader>bb :Buffers<cr>
" TODO: tags :Tags, :BTags. Probably needs ctags.
" TODO: see more in fzf

" NERDCommenter config
let g:NERDSpaceDelims = 1

" NERDTree keybinds
nnoremap <leader>tt :NERDTreeToggleVCS<cr>

" Use nerd font icons for nerdtree-git
" This doesn't seem to work
" let g:NERDTreeGitStatusUseNerdFonts = 1

" CoC configuration (consider separate file)
" use <C-[jk]> instead of <C-[np]> to navigate completion window
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" Use `[e` and `]e` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)
" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
