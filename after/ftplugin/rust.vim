" Rust language configuration

" Set the dispatch command for rust to make the debug build
" The Dispatch command can also be used to run generic commands, like
" `:Dispatch cargo build --release`
autocmd FileType rust let b:dispatch = 'cargo build'

" add command to run all tests
nnoremap <buffer> <localleader>t :<C-u>Dispatch cargo test --all<cr>

" nnoremap <buffer> <localleader>th :<C-u>CocCommand rust-analyzer.toggleInlayHints<cr>
" nnoremap <buffer> <localleader>le :<C-u>CocCommand rust-analyzer.explainError<cr>
" nnoremap <buffer> <localleader>lw :<C-u>CocCommand rust-analyzer.ssr<cr>
" nnoremap <buffer> <localleader>lvr :<C-u>CocCommand rust-analyzer.reload<cr>
" nnoremap <buffer> <localleader>lvs :<C-u>CocCommand rust-analyzer.analyzerStatus<cr>
" nnoremap <buffer> <localleader>lvw :<C-u>CocCommand rust-analyzer.reloadWorkspace<cr>
" nnoremap <buffer> <localleader>lvv :<C-u>CocCommand rust-analyzer.serverVersion<cr>
