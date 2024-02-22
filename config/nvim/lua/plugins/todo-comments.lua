return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = "VimEnter",
	opts = {
		highlight = {
			pattern = [[.*<(KEYWORDS)\s*[:@]\s*]], -- vim regex
		},
		search = {
			-- Matches with "TODO: something" and "TODO @PL something"
			pattern = [[\b(KEYWORDS)\s*[:@]\b]], -- ripgrep regex
		},
	},
	keys = {
		{
			"<leader>xt",
			"<CMD>TodoTrouble<CR>",
			desc = "Open todos in Trouble",
			noremap = true,
			silent = true,
		},
	},
}
