" Python language configuration

" Don't add <C-u> as that will remove the range, but isort should work on a
" range.
nnoremap <buffer> <localleader>i :isort<cr>

" nnoremap <buffer> <localleader>lis :<C-u>CocCommand python.sortImports<cr>
" nnoremap <buffer> <localleader>lio :<C-u>CocCommand pyright.organizeImports<cr>
" nnoremap <buffer> <localleader>lvr :<C-u>CocCommand pyright.restartserver<cr>

