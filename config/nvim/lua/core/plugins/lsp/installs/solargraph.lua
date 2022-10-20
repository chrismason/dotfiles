local features = require("core.plugins.lsp.features")

if not features.solargraph then
  return
end

local lspconfig = require("lspconfig")
local cfg = require("core.plugins.lsp.defaults")
local config = cfg.defaults()

config.settings = { solargraph = { diagnostics = not features.rubocop } }
config.cmd = { "bin/solargraph", "stdio" }
config.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = features.rubocop
  client.server_capabilities.documentRangeFormattingProvider = features.rubocop

  cfg.on_attach(client, bufnr)
end

lspconfig.solargraph.setup(config)
