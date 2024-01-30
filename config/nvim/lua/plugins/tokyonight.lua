return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			style = "night",
			on_highlights = function(hl, c)
				hl.DiagnosticUnnecessary = {
					fg = c.comment,
				}
				hl.CursorLineNr = {
					fg = c.orange,
				}
				hl.LineNr = {
					fg = c.blue,
				}
			end,
		})
		vim.cmd("colorscheme tokyonight")
	end,
}
