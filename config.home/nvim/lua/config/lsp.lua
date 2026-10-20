vim.lsp.config('tsc', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {  'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx' },
  root_dir = vim.fs.dirname(vim.fs.find({'tsconfig.json', 'package.json'}, { upward = true })[1]),
})


vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('oxlint')
vim.lsp.enable('pyright')
vim.lsp.enable('tsc')
