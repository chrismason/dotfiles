local lspconfig = require("lspconfig")
local config = require("plugins.lsp.config").defaults()

lspconfig.terraformls.setup(config)
