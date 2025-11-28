-- With a map leader it's possible to do extra key combinations
-- like <leader>w saves the current file
vim.g.mapleader = " " -- Leader is the space key
vim.g.maplocalleader = "\\"

require("config/lazy")

local vimrc = vim.fn.stdpath('config') .. '/legacy.vim'
vim.cmd.source(vimrc)
