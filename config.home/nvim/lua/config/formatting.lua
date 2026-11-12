local TIMEOUT_MS = 2000

local function get_client(bufnr, name)
  return vim.lsp.get_clients({ bufnr = bufnr, name = name })[1]
end

-- `:LspOxlintFixAll` uses client:exec_cmd(), which is async, so the edits land
-- after the write. request_sync() blocks in vim.wait(), which still processes
-- the server's `workspace/applyEdit` request, so fixes are applied before write.
local function oxlint_fix_all(bufnr)
  local client = get_client(bufnr, 'oxlint')
  if not client then return end

  local resp, err = client:request_sync('workspace/executeCommand', {
    command = 'oxc.fixAll',
    arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
  }, TIMEOUT_MS, bufnr)

  if not resp then
    vim.notify('oxlint fixAll: ' .. tostring(err), vim.log.levels.WARN)
  elseif resp.err then
    vim.notify('oxlint fixAll: ' .. resp.err.message, vim.log.levels.WARN)
  end
end

local function oxfmt_format(bufnr)
  if not get_client(bufnr, 'oxfmt') then return end

  vim.lsp.buf.format({
    bufnr = bufnr,
    async = false,
    timeout_ms = TIMEOUT_MS,
    filter = function(c) return c.name == 'oxfmt' end,
  })
end

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('oxc_on_save', { clear = true }),
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
  desc = 'oxlint fixAll + oxfmt on save',
  callback = function(args)
    local bufnr = args.buf
    if vim.bo[bufnr].buftype ~= '' or vim.b[bufnr].disable_oxc_on_save then return end

    -- Fix first, then format, so the formatter has the final say on layout.
    oxlint_fix_all(bufnr)
    oxfmt_format(bufnr)
  end,
})
