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

" snappier response time (default 1000ms)
" Make sure to not set notimeout
set timeoutlen=500

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
" TODO: Should localleader be ','? If this is changed we must edit the
" which-key config as well.
let maplocalleader=' '
" additional keybindings go below:
" Comfortable access to window menu
" TODO: Consider mapping <C-j> to <C-w>j, for instance

" Run :PlugInstall and :PlugUpdate to install and update plugins.

call plug#begin()

" Fugitive can take a long time to load and is slow in general
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'liuchengxu/vim-which-key'
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

" which-key config
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<cr>
" If localleader is comma, then:
" nnoremap <silent> <localleader> :<c-u>WhichKey ','<cr>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<cr>
" We can use which-key on g-commands too. Presumably another dictionary can be
" registered as above if we want to edit and document these commands.
nnoremap <silent> g :<c-u>WhichKey 'g'<cr>
vnoremap <silent> g :<c-u>WhichKeyVisual 'g'<cr>
" We don't have anything bound to the 'z' prefix right now.
" nnoremap <silent> z :<c-u>WhichKey 'z'<cr>
" vnoremap <silent> z :<c-u>WhichKeyVisual 'z'<cr>
nnoremap <silent> ] :<c-u>WhichKey ']'<cr>
nnoremap <silent> [ :<c-u>WhichKey '['<cr>
vnoremap <silent> ] :<c-u>WhichKeyVisual ']'<cr>
vnoremap <silent> [ :<c-u>WhichKeyVisual '['<cr>
" This lets us not mask built-in combos like gj, although they will not be
" listed in the which-key menu (try :help g)
let g:which_key_fallback_to_native_key = 1
let g:which_key_map = {}
" This procedure defines keybindings as well as the which-key info.
" Complicated commands will need to be defined separately as usual, then the
" value in which_key_map set to a string.
" The format is recursive, so additional layers in the command tree can be
" added in the obvious way.
" Modified keys (e.g. <C-h>) don't seem to work naively in the command tree.
let g:which_key_map.w = {
  \ 'name'  : '+window',
  \ 'w'     : ['<C-w>w'    , 'other-window'],
  \ 'd'     : ['<C-w>c'    , 'delete-window'],
  \ 'o'     : ['<C-w>o'    , 'focus-window'],
  \ '-'     : ['<C-w>s'    , 'split-window-below'],
  \ '|'     : ['<C-w>v'    , 'split-window-right'],
  \ '2'     : ['<C-w>v'    , 'layout-double-columns'],
  \ 'h'     : ['<C-w>h'    , 'window-left'],
  \ 'j'     : ['<C-w>j'    , 'window-below'],
  \ 'l'     : ['<C-w>l'    , 'window-right'],
  \ 'k'     : ['<C-w>k'    , 'window-up'],
  \ 'H'     : ['<C-w>H'    , 'move-window-left'],
  \ 'J'     : ['<C-w>J'    , 'move-window-down'],
  \ 'K'     : ['<C-w>K'    , 'move-window-up'],
  \ 'L'     : ['<C-w>L'    , 'move-window-right'],
  \ '='     : ['<C-w>='    , 'balance-window'],
  \ 's'     : ['<C-w>s'    , 'split-window-below'],
  \ 'v'     : ['<C-w>v'    , 'split-window-below'],
  \ 'e'     : {
  \   'name' : '+expand',
  \   'h' : ['<C-w>5<'   , 'expand-window-left'],
  \   'j' : [':resize +5', 'expand-window-below'],
  \   'l' : ['<C-w>5>'   , 'expand-window-right'],
  \   'k' : [':resize -5', 'expand-window-up'],
  \   },
  \ '?'     : ['Windows'   , 'fzf-window'],
  \ }
let g:which_key_map.b = {
  \ 'name' : '+buffer',
  \ 'b' : ['Buffers'  , 'switch-buffer'],
  \ 'd' : ['bd'       , 'delete-buffer'],
  \ 'h' : ['bfirst'   , 'first-buffer'],
  \ 'j' : ['bnext'    , 'next-buffer'],
  \ 'k' : ['bprevious', 'previous-buffer'],
  \ 'l' : ['blast'    , 'last-buffer'],
  \ }
let g:which_key_map.f = {
  \ 'name' : '+file',
  \ 'c' : ['GFiles?', 'project-find-changed-file'],
  \ 'f' : ['Files' , 'find-file'],
  \ 'p' : ['GFiles', 'project-find-file'],
  \ 's' : ['update', 'save-file'],
  \ }
" TODO: Tags and BTags when using ctags? is there a coc alternative?
let g:which_key_map.s = {
  \ 'name' : '+search',
  \ ':' : ['Commands', 'search-commands'],
  \ 'b' : ['BLines', 'search-buffer'],
  \ 'c' : ['Commits', 'search-commits'],
  \ 'k' : ['Marks', 'search-marks'],
  \ 'm' : ['Maps', 'search-normal-mappings'],
  \ 'o' : ['Lines', 'search-open-buffers'],
  \ 'p' : ['Rg', 'search-project'],
  \ 's' : ['Snippets', 'search-snippets'],
  \ 't' : ['Tags', 'search-tags'],
  \ }
let g:which_key_map.c = {
  \ 'name' : '+comment',
  \ }
let g:which_key_map.t = {
  \ 'name' : '+toggle',
  \ 't' : ['NERDTreeToggleVCS', 'toggle-project-tree'],
  \ }
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gl :Git log<cr>
" consider <leader>g<S-p> :Git push<cr>
let g:which_key_map.g = {
  \ 'name' : '+git (TODO)',
  \ '[' : ['GitGutterPrevHunk', 'goto-previous-hunk'],
  \ ']' : ['GitGutterNextHunk', 'goto-next-hunk'],
  \ 'c' : 'commit',
  \ 'd' : ['GDiffsplit', 'diff-split'],
  \ 'g' : ['Git', 'fugitive-dispatch'],
  \ 'l' : 'log',
  \ 'p' : ['GitGutterPreviewHunk', 'preview-hunk'],
  \ 's' : ['GitGutterStageHunk', 'stage-hunk'],
  \ 'u' : ['GitGutterUndoHunk', 'undo-hunk'],
  \ }
" easymotion times out before which-key even triggers. But this label is
" useful for remembering.
let g:which_key_map['<space>'] = 'easymotion'

" NERDCommenter config
let g:NERDSpaceDelims = 1

" NERDTree config and keybinds
let NERDTreeIgnore = ['^__pycache__$', 'egg-info$']

" Turn off gitgutter default mappings in leiu of our git command tree
let g:gitgutter_map_keys = 0

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
