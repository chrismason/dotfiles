local lspconfig = require("lspconfig")
local cfg = require("core.plugins.lsp.defaults")
local config = cfg.defaults()

config.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  cfg.on_attach(client, bufnr)
end
config.cmd = { "gopls", "serve" }
config.settings = {
  gopls = {
    analyses = {
      unusedparams = true,
      shadow = true,
    },
    staticcheck = true,
  }
}

lspconfig.gopls.setup(config)
