" Rust language configuration

" Set the dispatch command for rust to make the debug build
" The Dispatch command can also be used to run generic commands, like
" `:Dispatch cargo build --release`
" Does this need to be set outside of the ft config?
autocmd FileType rust let b:dispatch = 'cargo build'

nnoremap <buffer> <localleader>l :<C-u>Dispatch cargo clippy --all-targets<cr>

compiler cargo
