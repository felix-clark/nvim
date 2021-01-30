" Python language configuration

nnoremap <buffer> <localleader>lis :<C-u>CocCommand python.sortImports<cr>
nnoremap <buffer> <localleader>lio :<C-u>CocCommand pyright.organizeImports<cr>
nnoremap <buffer> <localleader>lvr :<C-u>CocCommand pyright.restartserver<cr>
