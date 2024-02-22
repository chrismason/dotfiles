return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = "VimEnter",
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
