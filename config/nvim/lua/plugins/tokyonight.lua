return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			style = "night",
			transparent = true,
			styles = {
				sidebars = "dark",
				floats = "dark",
			},
			on_colors = function(colors)
				colors.bg_sidebar = "#011826"
			end,
			on_highlights = function(hl, c)
				local prompt = "#0B2534"
				local bgColor = "#011826"
				hl.ToggleTerm = {
					bg = bgColor,
				}
				hl.TelescopeNormal = {
					bg = bgColor,
					fg = c.fg_dark,
				}
				hl.TelescopeBorder = {
					bg = bgColor,
					fg = bgColor,
				}
				hl.TelescopePromptNormal = {
					bg = prompt,
				}
				hl.TelescopePromptBorder = {
					bg = prompt,
					fg = prompt,
				}
				hl.TelescopePromptTitle = {
					bg = prompt,
					fg = "#1aFFFF",
				}
				hl.TelescopePreviewTitle = {
					fg = "#1aFFFF",
				}
				hl.TelescopeResultsTitle = {
					fg = "#1aFFFF",
				}
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
