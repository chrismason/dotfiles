local lspconfig = require("lspconfig")
local cfg = require("plugins.lsp.config")
local config = cfg.defaults()

config.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = true
	client.server_capabilities.documentRangeFormattingProvider = true

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
		hints = {
			assignVariableTypes = true,
			compositeLiteralFields = true,
			constantValues = true,
			functionTypeParameters = true,
			parameterNames = true,
			rangeVariableTypes = true,
		},
	},
}

lspconfig.gopls.setup(config)
