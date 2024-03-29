return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"ray-x/lsp_signature.nvim",
			"simrat39/rust-tools.nvim",
			"Hoffs/omnisharp-extended-lsp.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
			},
		},
		config = function()
			require("plugins.lsp.config")
			require("plugins.lsp.mason-lspconfig")
			require("plugins.lsp.tools")
		end,
	},
	{
		"SmiteshP/nvim-navic",
		config = function()
			require("plugins.lsp.navic")
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("plugins.lsp.inlayhints")
		end,
	},
}
