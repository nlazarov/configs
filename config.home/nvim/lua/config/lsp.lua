local tscLoc = vim.env.HOME .. '/.local/share/pnpm/bin/tsc'
local tscExists = vim.fn.executable(tscLoc) == 1

if tscExists then
  vim.lsp.config('tsc', {
    cmd = { tscLoc, '--lsp', '--stdio' },
    filetypes = {  'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx' },
    root_dir = vim.fs.dirname(vim.fs.find({'tsconfig.json', 'package.json'}, { upward = true })[1]),
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })
else
  vim.notify('tsc not installed for the user with pnpm i -g typescipt', vim.log.levels.ERROR)
end

local function root_dir_finder(patterns)
  return function (bufnr, on_dir)
    local root = vim.fs.root(bufnr, patterns)
    if root then on_dir(root) end
  end
end

-- cmd is left to nvim-lspconfig, which prefers <root>/node_modules/.bin/oxlint
vim.lsp.config('oxlint', {
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_dir = root_dir_finder({
    '.oxlintrc.json',
    '.oxlintrc.jsonc',
    'oxlint.config.ts',
    'oxlint.config.mts',
  }),
})

vim.lsp.config('oxfmt', {
  root_dir = root_dir_finder({
    '.oxfmtrc.json',
    '.oxfmtrc.jsonc',
    'oxfmt.config.ts',
    'oxfmt.config.mts',
  }),
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
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.config('vimls', {
  cmd = { 'vim-language-server', '--stdio' },
  init_options = { isNeovim = true, isVim = false, diagnostics = true },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('oxfmt')
vim.lsp.enable('oxlint')
vim.lsp.enable('pyright')
vim.lsp.enable('tsc')
vim.lsp.enable('vimls')

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
