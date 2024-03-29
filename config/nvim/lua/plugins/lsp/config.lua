vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

local icons = require("plugins.lsp.icons")
icons.setup_lsp_icons()
icons.set_sign_icons({
	error = "✘",
	warn = "▲",
	hint = "⚑",
	info = "»",
})

local M = {}

local function on_attach(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
	vim.keymap.set("n", "gi", '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
	vim.keymap.set("n", "gt", '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', opts)
	vim.keymap.set("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
	vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

	-- diagnostics
	vim.keymap.set("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
	vim.keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
	vim.keymap.set("n", "<leader>ge", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", })<cr>', opts)
	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	vim.keymap.set("n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	vim.keymap.set("v", "<leader>ga", "<cmd>lua vim.lsp.buf.range_code_actions()<cr>", opts)
	vim.keymap.set("n", "<leader>gf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
	vim.keymap.set("n", "<C-K>", '<cmd>lua require("lsp_signature").signature()<cr>', opts)

	require("lsp_signature").on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "single",
		},
	}, bufnr)

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end

	if client.server_capabilities.documentHighlightProvider then
		local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			group = group,
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			buffer = bufnr,
			group = group,
			callback = function()
				vim.lsp.buf.clear_references()
			end,
		})
	end

	if client.name == "omnisharp" then
		local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
		for i, v in ipairs(tokenModifiers) do
			tokenModifiers[i] = v:gsub(" ", "_")
		end
		local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
		for i, v in ipairs(tokenTypes) do
			tokenTypes[i] = v:gsub(" ", "_")
		end
	end
end

require("fidget").setup({
	text = {
		spinner = "moon",
	},
	align = {
		bottom = true,
	},
	window = {
		relative = "editor",
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

M.defaults = function()
	return {
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
		on_attach = on_attach,
	}
end

M.on_attach = on_attach

return M
