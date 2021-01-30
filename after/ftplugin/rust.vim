" Rust language configuration

nnoremap <buffer> <localleader>th :<C-u>CocCommand rust-analyzer.toggleInlayHints<cr>
nnoremap <buffer> <localleader>le :<C-u>CocCommand rust-analyzer.explainError<cr>
nnoremap <buffer> <localleader>lw :<C-u>CocCommand rust-analyzer.ssr<cr>
nnoremap <buffer> <localleader>lvr :<C-u>CocCommand rust-analyzer.reload<cr>
nnoremap <buffer> <localleader>lvs :<C-u>CocCommand rust-analyzer.analyzerStatus<cr>
nnoremap <buffer> <localleader>lvw :<C-u>CocCommand rust-analyzer.reloadWorkspace<cr>
nnoremap <buffer> <localleader>lvv :<C-u>CocCommand rust-analyzer.serverVersion<cr>
