local opt = vim.opt

opt.inccommand = "split"
opt.smartcase = true
opt.ignorecase = true

opt.number = true
opt.relativenumber = true

opt.splitbelow = true
opt.splitright = true

opt.grepprg = "rg --ignore-case --vimgrep"
opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"

opt.signcolumn = "yes:2"
opt.shada = { "'10", "<0", "s10", "h" }

opt.clipboard = { "unnamed", "unnamedplus" }

opt.formatoptions:remove "o"

opt.scrolloff = 10
opt.sidescrolloff = 8

opt.updatetime = 100

opt.clipboard = { "unnamed", "unnamedplus" }

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

if vim.env.CODESPACES then
	vim.g.clipboard = {
		name = "rdm",
		copy = {
			["+"] = { "rdm", "copy" },
			["*"] = { "rdm", "copy" },
		},
		paste = {
			["+"] = { "rdm", "paste" },
			["*"] = { "rdm", "paste" },
		},
	}
end