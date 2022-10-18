local lspconfig = require("lspconfig")
local config = require("core.plugins.lsp.defaults")
local features = require("core.plugins.lsp.features")

config.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = not features.prettier
  client.server_capabilities.documentRangeFormattingProvider = not features.prettier

  config.on_attach(client, bufnr)
end

lspconfig.tsserver.setup(config)
