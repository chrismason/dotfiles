local default_config = require 'core.plugins.lsp.defaults'
local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_ok, mason_lsp = pcall(require, 'mason-lspconfig')

if not mason_ok or not mason_lsp_ok then
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
  }
})

mason_lsp.setup {
  ensure_installed = { "bashls", "gopls", "jsonls", "sumneko_lua", "rust_analyzer",
    "tsserver", "yamlls" },
  automatic_installation = true
}

local lspconfig = require('lspconfig')

local defaults = default_config.defaults()
local capabilities = defaults.capabilities
local on_attach = defaults.on_attach
local flags = defaults.flags

mason_lsp.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      flags = flags,
      on_attach = on_attach,
    }
  end,
  ["jsonls"] = function()
    lspconfig.jsonls.setup {
      capabilities = capabilities,
      flags = flags,
      on_attach = on_attach,
      settings = require('core.plugins.lsp.installs.jsonls').settings
    }
  end,
  ["gopls"] = function()
    lspconfig.gopls.setup {
      capabilities = capabilities,
      flags = flags,
      on_attach = on_attach,
      cmd = require('core.plugins.lsp.installs.gopls').cmd,
      settings = require('core.plugins.lsp.installs.gopls').settings
    }
  end,
  ["tsserver"] = function()
    lspconfig.tsserver.setup {
      capabilities = capabilities,
      flags = flags,
      on_attach = require('core.plugins.lsp.installs.tsserver').on_attach,
    }
  end,
  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup {
      capabilities = capabilities,
      flags = flags,
      on_attach = on_attach,
      settings = require('core.plugins.lsp.installs.sumneko_lua').settings
    }
  end,
  ["yamlls"] = function()
    lspconfig.yamlls.setup {
      capabilities = capabilities,
      flags = flags,
      on_attach = on_attach,
      settings = require('core.plugins.lsp.installs.yamlls').settings
    }
  end
})
