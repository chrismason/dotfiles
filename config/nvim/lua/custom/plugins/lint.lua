return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	cond = function()
		return false
	end,
	config = function()
		local lint = require("lint")

		local luacheck = lint.linters.luacheck
		luacheck.args = {
			"--globals",
			"vim",
		}

		lint.linters_by_ft = {
			go = { "golangcilint" },
			lua = { "luacheck" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}