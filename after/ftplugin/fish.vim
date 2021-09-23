" Setup autodetection of fish shell script files.
" This should be unnecessary in nvim-treesitter for neovim 0.6.
" https://github.com/nvim-treesitter/nvim-treesitter/pull/1635

autocmd BufRead,BufNewFile *.fish setfiletype fish

