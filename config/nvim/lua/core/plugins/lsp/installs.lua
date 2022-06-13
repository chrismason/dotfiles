local default_config = require 'core.plugins.lsp.defaults'
local lsp_installer = require 'nvim-lsp-installer'

lsp_installer.settings {
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    },
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
  }
}

local default_servers = {
  "gopls",
  "yamlls",
  "bashls",
  "yamlls",
  "tsserver",
}

for _, name in pairs(default_servers) do
  local found, server = lsp_installer.get_server(name)
  if found then
    if not server:is_installed() then
      print("Installing LSP server: " .. name)
      server:install()
    end
  end
end

lsp_installer.on_server_ready(function(server)
  local defaults = default_config.defaults()

  local server_opts = {
    ["gopls"] = require 'core.plugins.lsp.installs.gopls',
    ["yamlls"] = require 'core.plugins.lsp.installs.yamlls',
    ["tsserver"] = require 'core.plugins.lsp.installs.tsserver',
  }

  local opts = server_opts[server.name] and server_opts[server.name]() or defaults

  -- if server.name == 'gopls' then
  --   local config = require 'core.plugins.lsp.go'
  --   opts = vim.tbl_deep_extend('force', opts, config)
  -- end

  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end)
