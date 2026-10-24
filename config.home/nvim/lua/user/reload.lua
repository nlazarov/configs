-- lua/user/reload.lua
local M = {}

function M.reload()
  -- Unload all your custom modules (adjust the pattern to match your namespace)
  for name, _ in pairs(package.loaded) do
    if name:match("^user%.") then
      package.loaded[name] = nil
    end
  end

  -- Also unload lspconfigs/plugins if you want those refreshed
  for name, _ in pairs(package.loaded) do
    if name:match("^plugins%.") or name:match("^lsp%.") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

return M
