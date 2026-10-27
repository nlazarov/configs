-- With a map leader it's possible to do extra key combinations
-- like <leader>w saves the current file
vim.g.mapleader = " " -- Leader is the space key
vim.g.maplocalleader = ","

require("config.formatting")
require("config.lazy")
require("config.lsp")
require("config.telescope")

local vimrc = vim.fn.stdpath('config') .. '/legacy.vim'
vim.cmd.source(vimrc)

vim.keymap.set('n', '<localleader>a', ':call feedkeys("\\<C-a>", "x")<CR>', {
  desc = "Simulate <C-a> without messing up tmux",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<localleader>z", function()
  require("user.reload").reload()
end, { desc = "Reload config" })

vim.keymap.set('n', '<c-w><', ':tabmove -1<CR>', { desc = "Move tab left", noremap = true, silent = true })
vim.keymap.set('n', '<c-w>>', ':tabmove +1<CR>', { desc = "Move tab left", noremap = true, silent = true })

vim.api.nvim_create_user_command('Nconf', function ()
  vim.cmd.tabe(vim.fn.stdpath('config'))
end, {})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx' },
  callback = function()
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show hover information", noremap = true, silent = true })
    vim.keymap.set('n', '<leader>tt', ":Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Search workspace symbols", noremap = true, silent = true })
    vim.keymap.set('n', '<leader>td', ":Telescope lsp_document_symbols<CR>", { desc = "Search document symbols", noremap = true, silent = true })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'octo',
  callback = function()
    vim.keymap.set("i", "@", "@<C-x><C-o>", { silent = true, buffer = true })
    vim.keymap.set("i", "#", "#<C-x><C-o>", { silent = true, buffer = true })
  end,
})
