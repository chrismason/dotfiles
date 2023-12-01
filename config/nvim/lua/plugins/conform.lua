return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufNewFile" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			go = { "gofmt", "goimports" },
			lua = { "stylua" },
			ruby = { "rubocop" },
			rust = { "rustfmt" },
			terraform = { "terraform_fmt" },
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		formatters = {
			rustfmt = {
				command = "rustfmt",
				prepend_args = { "--edition=2021" },
			},
		},
	},
}
