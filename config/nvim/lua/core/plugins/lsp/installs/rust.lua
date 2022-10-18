local lspconfig = require("lspconfig")
local config = require("core.plugins.lsp.defaults").defaults()

lspconfig.rust_analyzer.setup(config)
