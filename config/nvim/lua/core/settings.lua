local opt = vim.opt

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.hidden = true

opt.ignorecase = true
opt.smartcase = true
opt.grepprg = "rg --ignore-case --vimgrep"
opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"

opt.path = "**"
opt.wildmenu = true
-- Ignore some folders and files with find
opt.wildignore = {
	"**/node_modules/**",
	"**/.git/**",
}
opt.wildmode = { "longest", "list", "full" }

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:2"
opt.lazyredraw = true
opt.mouse = ""
opt.incsearch = true
opt.cursorline = true
opt.backspace = { "indent", "eol", "start" }
opt.showmode = false

opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess = opt.shortmess + { c = true }

opt.scrolloff = 10
opt.sidescrolloff = 8

opt.updatetime = 100

opt.clipboard = { "unnamed", "unnamedplus" }
opt.isfname:append("@-@")

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
