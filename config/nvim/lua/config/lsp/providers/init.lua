local default_config = require('config.lsp.providers.defaults')
local lsp_installer = require('nvim-lsp-installer')

lsp_installer.settings({
  ui = {
    keymaps = {
      -- Keymap to expand a server in the UI
      toggle_server_expand = 'i',
      -- Keymap to install a server
      install_server = '<CR>',
      -- Keymap to reinstall/update a server
      update_server = 'u',
      -- Keymap to uninstall a server
      uninstall_server = 'x',
    },
  },
})

lsp_installer.on_server_ready(function(server)
  local opts = default_config

  if server.name == 'gopls' then
    local config = require('config.lsp.providers.gopls')
    opts = vim.tbl_deep_extend('force', opts, config)
  end

  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end)