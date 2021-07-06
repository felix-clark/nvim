" See https://github.com/Optixal/neovim-init.vim for more ideas

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

" " Recommended for coc
" set hidden
" set nobackup
" set nowritebackup
" set updatetime=300
" set cmdheight=2
" set shortmess+=c
" " TODO: might want set signcolumn-[number|yes]

" Enable compe
set completeopt=menuone,noselect

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

Plug 'navarasu/onedark.nvim'
" Fugitive can take a long time to load and is slow in general
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" Repeat plugin commands
Plug 'tpope/vim-repeat'
" Could consider tcomment as an alternative
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'liuchengxu/vim-which-key'
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeToggleVCS'] }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
if has("python3")
  " Debugging with vimspector. Requires python for neovim.
  " NOTE: consider nvim-dap for neovim 0.5
  Plug 'puremourning/vimspector'
endif
Plug 'cespare/vim-toml'
" Must come after nerdtree and before devicons
Plug 'Xuyuanp/nerdtree-git-plugin'
" This says it must be the last one. Requires a Nerd font.
Plug 'ryanoasis/vim-devicons'

call plug#end()

" let g:onedark_style = 'darker'
colorscheme onedark

" airline style
let g:airline_theme = 'angr'
let g:airline_powerline_fonts = 1

" Use fly mode for autopairs to close all open delims when the last one is
" typed
" let g:AutoPairsFlyMode = 1
" Don't use the built-in; define our own keybinding for toggle
let g:AutoPairsShortcutToggle = '<leader>tp'

" turn on rainbow parentheses by default
let g:rainbow_active = 1

" NERDTree config and keybinds
let NERDTreeIgnore = ['^__pycache__$', 'egg-info$']

" Turn off gitgutter default mappings in leiu of our git command tree
let g:gitgutter_map_keys = 0

" Use nerd font icons for nerdtree-git
" This doesn't seem to work
" let g:NERDTreeGitStatusUseNerdFonts = 1

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
  \ }
nnoremap <leader>bb <cmd>Telescope buffers<cr>
let g:which_key_map.b = {
  \ 'name' : '+buffer',
  \ 'b' : 'switch-buffer',
  \ 'd' : ['bd'       , 'delete-buffer'],
  \ 'h' : ['bfirst'   , 'first-buffer'],
  \ 'j' : ['bnext'    , 'next-buffer'],
  \ 'k' : ['bprevious', 'previous-buffer'],
  \ 'l' : ['blast'    , 'last-buffer'],
  \ }
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fp <cmd>Telescope git_files<cr>
let g:which_key_map.f = {
  \ 'name' : '+file',
  \ 'b' : 'browser',
  \ 'f' : 'find',
  \ 'p' : 'project',
  \ 's' : ['update', 'save'],
  \ }
" See telescope's documentation for other pickers
nnoremap <leader>s: <cmd>Telescope commands<cr>
nnoremap <leader>sb <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>sc <cmd>Telescope git_commits<cr>
nnoremap <leader>sh <cmd>Telescope help_tags<cr>
nnoremap <leader>sk <cmd>Telescope marks<cr>
nnoremap <leader>sm <cmd>Telescope keymaps<cr>
nnoremap <leader>sp <cmd>Telescope live_grep<cr>
nnoremap <leader>ss <cmd>Telescope treesitter<cr>
nnoremap <leader>st <cmd>Telescope tags<cr>
" nnoremap <leader>st <cmd>Telescope current_buffer_tags<cr>
let g:which_key_map.s = {
  \ 'name' : '+search',
  \ ':' : 'commands',
  \ 'b' : 'buffer',
  \ 'c' : 'commits',
  \ 'h' : 'help-tags',
  \ 'k' : 'marks',
  \ 'm' : 'keymaps',
  \ 'p' : 'project',
  \ 's' : 'treesitter',
  \ 't' : 'tags',
  \ }
let g:which_key_map.t = {
  \ 'name' : '+toggle',
  \ 't' : ['NERDTreeToggleVCS', 'toggle-project-tree'],
  \ 'p' : 'autopair',
  \ }
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>g<S-s> :Gwrite<cr>
" nnoremap <leader>g<S-p> :Git push<cr>
let g:which_key_map.g = {
  \ 'name' : '+git',
  \ '[' : ['GitGutterPrevHunk', 'goto-previous-hunk'],
  \ ']' : ['GitGutterNextHunk', 'goto-next-hunk'],
  \ 'c' : 'commit',
  \ 'd' : ['Gdiffsplit', 'git-diff-split'],
  \ 'g' : ['Git', 'fugitive-summary'],
  \ 'l' : 'log',
  \ 'p' : ['GitGutterPreviewHunk', 'preview-hunk'],
  \ 's' : ['GitGutterStageHunk', 'stage-hunk'],
  \ 'S' : 'stage-file',
  \ 'u' : ['GitGutterUndoHunk', 'undo-hunk'],
  \ }
" easymotion times out before which-key triggers. But this label is
" useful for remembering.
let g:which_key_map['<space>'] = 'easymotion'
let g:which_key_map.c = {
  \ 'name' : '+code ("TODO")',
  \ 'a' : 'code-action',
  \ 's' : 'toggle-style',
  \ }
let g:which_key_map.l = {
  \ 'name' : '+language',
  \ 'r' : 'rename',
  \ 'q' : 'set-loclist',
  \ '=' : 'format-buffer',
  \ }
" TODO: shortcuts to open config file (local and global)

" TODO: Should limit these to only when debugger active?
" NOTE: run-to-cursor creates a breakpoint at a line and runs until it's
" reached. This may be the most common use case.
" S-j at least is commonly used to join line
" nnoremap <S-k> :call vimspector#StepOut()
" nnoremap <S-l> :call vimspector#StepInto()
" nnoremap <S-j> :call vimspector#StepOver()
let g:which_key_map.d = {
  \ 'name': '+debug',
  \ 'a': ['vimspector#Launch()', 'launch-debugger'],
  \ 'r': ['vimspector#Reset()', 'reset'],
  \ 'R': ['vimspector#Restart()', 'restart'],
  \ 'c': ['vimspector#Continue()', 'continue'],
  \ 'd': ['vimspector#RunToCursor()', 'run-to-cursor'],
  \ 'b': {
  \   'name': '+breakpoint',
  \   'b': ['vimspector#ToggleBreakpoint', 'toggle-breakpoint'],
  \   'c': ['vimspector#ToggleConditionalBreakpoint', 'toggle-conditional-breakpoint'],
  \   'D': ['vimspector#ClearBreakpoints', 'clear-breakpoints'],
  \ },
  \ }
" Global debug configurations can be placed here. Some instances might want
" specific ones, in which case this could be changed out of the nvim config
" repo.
" The configurations can go in <vimspector_base_dir>/configurations/linux/_all/vim-debug-configuration.json 
" (although the JSON filename does not matter)
let g:vimspector_base_dir = expand('$HOME/.config/nvim/vimspector')
let g:vimspector_install_gadgets = ['debugpy', 'CodeLLDB']

" Compe configuration
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
" let g:compe.min_length = 1
let g:compe.min_length = 2
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
" let g:compe.source.emoji = v:true
" NOTE: This one can be slow
" let g:compe.source.treesitter = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

highlight link CompeDocumentation NormalFloat
" TODO: Snippet support ? (see compe readme)
" End compe configuration

" Treesitter configuration
" NOTE: the "ensure_installed" line could be removed in lieu of manual installations.
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}
EOF
" Define folds based on treesitter objects
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" End treesitter configuration

" nvim-lspconfig configuration
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>l=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "vimls", "pylsp", "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF


" use <C-[jk]> instead of <C-[np]> to navigate completion window
" This was used for CoC but perhaps it would still be useful?
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

""" Language-specific configuration

" Filetype plugins are defined in (:echo $VIMRUNTIME) (e.g.
" /usr/share/nvim/runtime/ftplugin).
" To load additional configuration for a filetype, add {ft}.vim to
" ./after/ftplugin/{ft}.vim where {ft} is a filetype.

