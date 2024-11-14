return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("nightfox").setup({
			options = {
				styles = {
					comments = "italic",
					keywords = "italic",
				},
			},
		})
		vim.cmd("colorscheme nightfox")
	end,
}