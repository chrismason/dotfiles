local lspconfig = require("lspconfig")
local cfg = require("core.plugins.lsp.defaults")
local config = cfg.defaults()
local features = require("core.plugins.lsp.features")

config.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = not features.prettier
	client.server_capabilities.documentRangeFormattingProvider = not features.prettier

	cfg.on_attach(client, bufnr)
end

lspconfig.tsserver.setup(config)
