-- nvim-tree highly recommends disabling netrw at the beginning of
-- configuration, due to race conditions at nvim startup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- fish shell seems to slow things down
vim.opt.shell = "bash"

-- This seems to give a nicer palette; requires ISO-8613-3 terminal.
-- Some plugins, like nvim-tree, require it, as does the colorscheme onedark.
-- vim.opt.termcolors = true

-- give the terminal window an appropriate title with the name of the open file
vim.opt.title = true

-- Insert spaces instead of tab, using a default width of 2.
-- Use `:set noexpandtab` to temporarily disable.
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Line wrap between words to avoid breaking them up
vim.opt.linebreak = true

-- Set absolute and relative line numbers both on (current line gives absolute).
-- See the vim-numbertoggle plugin for a better way of toggling between options
vim.opt.number = true
vim.opt.relativenumber = true

-- Show exactly 1 column. Gitsigns will take priority over diagnostics with
-- other settings.
vim.opt.signcolumn = "yes:1"

-- Complete the longest common string and show the list of potential matches
-- when using <TAB>
vim.opt.wildmode = "longest,list"

-- show matching brackets
vim.opt.showmatch = true

-- use 'jk' combination to quit insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
-- something similar for terminal (?)
-- This messes with fzf windows, although telescope seems fine so far
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.cmd [[
augroup term
  " Remove existing autocommands in this group (in case this file gets sourced
  " twice)
  autocmd!
  " start in terminal (insert-like) mode when opening a terminal window
  " Note that the term://* stipulation prevents insert mode in Neogit
  autocmd TermOpen,TermEnter term://* startinsert
  " disable line numbers in terminal
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
]]

-- snappier response time (default 1000ms)
-- Make sure to not set notimeout
vim.opt.timeoutlen = 400
-- Reduce the delay (from 4s) for the CursorHold event. Used in crash-recovery
-- as well.
vim.opt.updatetime = 600

-- Leader key should be set before plugins in case they use leader key mappings
-- map the leader to space (default is '\')
vim.g.mapleader = " "
-- Use <SPC>m for local leader, although this is seldom used right now.
vim.g.maplocalleader = " m"

-- Quick window motion with Alt+<direction>
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-l>", "<C-w>l")
vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<M-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<M-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n><C-w>l")

-- bootstrap lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(require "plugins")

-- custom folding; must be loaded after treesitter
require "fold"
