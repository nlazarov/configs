vim.lsp.config('tsc', {
  cmd = { vim.env.HOME..'/.local/share/mise/installs/node/lts/bin/tsc', '--lsp', '--stdio' },
  filetypes = {  'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx' },
  root_dir = vim.fs.dirname(vim.fs.find({'tsconfig.json', 'package.json'}, { upward = true })[1]),
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
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

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
  loclist = {
    open = true,
    severity = { min = vim.diagnostic.severity.WARN },
  },
})
