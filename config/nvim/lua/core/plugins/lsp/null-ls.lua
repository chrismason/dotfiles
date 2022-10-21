local null_ls_ok, null_ls = pcall(require, "null-ls")
local features = require("core.plugins.lsp.features")

if not null_ls_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
    code_actions.gitsigns,
	diagnostics.luacheck,
	diagnostics.tsc,
	formatting.goimports,
	formatting.stylua,
}

if features.prettier then
	table.insert(sources, formatting.prettier)
end

if features.eslint_d then
	table.insert(sources, diagnostics.eslint)
end

if features.rubocop then
	table.insert(sources, formatting.rubocop.with({ command = "bin/rubocop" }))
	table.insert(sources, diagnostics.rubocop.with({ command = "bin/rubocop" }))
end

if features.golangci_lint then
	table.insert(sources, diagnostics.golangci_lint)
end

if #sources ~= 0 then
	null_ls.setup({
		debug = false,
		sources = sources,
		on_attach = function(client, bufnr)
			if client.server_capabilities.documentFormattingProvider then
				local id = vim.api.nvim_create_augroup("lsp_formatting", { clear = false })
				vim.api.nvim_clear_autocmds({ buffer = 0, group = id })
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					group = id,
					callback = function()
						vim.lsp.buf.format({ sync = true, bufnr = bufnr })
					end,
				})
			end
		end,
	})
end
