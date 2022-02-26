" Rust language configuration

" Set the dispatch command for rust to make the debug build
" The Dispatch command can also be used to run generic commands, like
" `:Dispatch cargo build --release`
autocmd FileType rust let b:dispatch = 'cargo build'

nnoremap <buffer> <localleader>d :<C-u>RustDebuggables<cr>
nnoremap <buffer> <localleader>r :<C-u>RustRun<cr>
nnoremap <buffer> <localleader>t :<C-u>RustRunnables<cr>
nnoremap <buffer> <localleader>l :<C-u>Dispatch cargo clippy --all-targets<cr>
