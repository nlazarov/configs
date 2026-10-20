vim.lsp.enable('tsc')
vim.lsp.config('tsc', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  root_dir = vim.fs.dirname(vim.fs.find({'tsconfig.json', 'package.json'}, { upward = true })[1]),
})

vim.lsp.enable('pyright')
