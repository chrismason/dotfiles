local lspconfig = require("lspconfig")
local cfg = require("core.plugins.lsp.defaults")
local config = cfg.defaults()
local features = require("core.plugins.lsp.features")

config.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = not features.golangci_lint
	client.server_capabilities.documentRangeFormattingProvider = not features.golangci_lint

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
	},
}

lspconfig.gopls.setup(config)
