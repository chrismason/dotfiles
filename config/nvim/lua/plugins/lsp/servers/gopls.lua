local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
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

-- config.root_dir = function(fname)
-- 	-- see: https://github.com/neovim/nvim-lspconfig/issues/804
-- 	local mod_cache = vim.trim(vim.fn.system("go env GOMODCACHE"))
-- 	if fname:sub(1, #mod_cache) == mod_cache then
-- 		local clients = vim.lsp.get_active_clients({ name = "gopls" })
-- 		if #clients > 0 then
-- 			return clients[#clients].config.root_dir
-- 		end
-- 	end
-- 	return util.root_pattern("go.work")(fname) or util.root_pattern("go.mod", ".git")(fname)
-- end

lspconfig.gopls.setup(config)
