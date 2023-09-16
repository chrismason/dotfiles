require("mason-tool-installer").setup({
	ensure_installed = {
		{ "golangci-lint", version = "v1.51.2" },
		"goimports",
		"stylua",
		"luacheck",
		"protolint",
		"delve",
	},
})
