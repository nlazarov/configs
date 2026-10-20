local group = vim.api.nvim_create_augroup('tsx_oxc_format', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = group,
  pattern = '*.tsx',
  desc = 'oxlint --fix + oxfmt on save',
  callback = function(args)
    local file = args.file

    -- skip unnamed buffers and non-file buffers (terminals, quickfix, ...)
    if file == '' or vim.bo[args.buf].buftype ~= '' then return end

    -- this cmd is exposed from the nvim-lspconfig plugin
    -- it requires that the oxlint lsp is enabled
    vim.cmd('LspOxlintFixAll')

    local root = vim.fs.root(file, { 'oxlint.importsort.mts', 'oxlint.config.mts', 'package.json' })
      or vim.fn.fnamemodify(file, ':h')

    local fmt = vim.system({ 'oxfmt', file }, { cwd = root }):wait()
    if fmt.code ~= 0 then
      vim.notify('oxfmt: ' .. (fmt.stderr or ''), vim.log.levels.ERROR)
      return
    end
  end,
})
