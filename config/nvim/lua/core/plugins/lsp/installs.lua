local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")

if not mason_ok or not mason_lsp_ok then
	return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lsp.setup({
	ensure_installed = { "bashls", "gopls", "jsonls", "sumneko_lua", "tsserver", "yamlls" },
	-- automatic_installation = true,
})

require("core.plugins.lsp.installs.bash")
require("core.plugins.lsp.installs.gopls")
require("core.plugins.lsp.installs.jsonls")
require("core.plugins.lsp.installs.rust")
require("core.plugins.lsp.installs.solargraph")
require("core.plugins.lsp.installs.sorbet")
require("core.plugins.lsp.installs.sumneko_lua")
require("core.plugins.lsp.installs.tsserver")
require("core.plugins.lsp.installs.yamlls")
