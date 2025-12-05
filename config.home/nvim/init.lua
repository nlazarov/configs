-- With a map leader it's possible to do extra key combinations
-- like <leader>w saves the current file
vim.g.mapleader = " " -- Leader is the space key
vim.g.maplocalleader = "\\"

require("config/lazy")
require("config/telescope")

local vimrc = vim.fn.stdpath('config') .. '/legacy.vim'
vim.cmd.source(vimrc)

vim.api.nvim_create_user_command('Nconf', function ()
  vim.cmd.tabe(vim.fn.stdpath('config'))
end, {})
