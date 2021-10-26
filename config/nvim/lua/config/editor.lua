local cmd = vim.cmd
local opt = vim.opt
local indent = 2

cmd([[
  filetype plugin indent on
  autocmd BufWritePre * :%s/\s\+$//e
]])

cmd([[
  augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout=40})
  augroup END
]])

opt.syntax = 'enable'
opt.hidden = true
opt.encoding = 'utf-8'
opt.clipboard = 'unnamedplus'
opt.backspace = { 'eol', 'start', 'indent' }
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }

opt.autoindent = true
opt.smartindent = true

opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.expandtab = true

opt.wildmenu = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { '*/node_modules/*', '*/vendor/*' }

opt.number = true
opt.rnu = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.laststatus = 2
opt.wrap = false
opt.scrolloff = 18
opt.sidescrolloff = 3
opt.showmode = false
opt.lazyredraw = true
opt.mouse = 'a'
opt.incsearch = true

opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.shortmess = opt.shortmess + { c = true }

opt.updatetime = 50

opt.termguicolors = true