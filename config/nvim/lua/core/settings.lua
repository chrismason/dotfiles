local opt = vim.opt

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.hidden = true

opt.ignorecase = true
opt.smartcase = true
opt.grepprg = 'rg --ignore-case --vimgrep'
opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'

opt.path = '**'
opt.wildmenu = true
-- Ignore some folders and files with find
opt.wildignore = {
  '**/node_modules/**',
  '**/.git/**',
}

opt.rnu = true
opt.signcolumn = 'yes:2'
opt.lazyredraw = true
opt.mouse = 'a'
opt.incsearch = true
opt.cursorline = true
opt.backspace = { 'indent', 'eol', 'start' }
opt.showmode = false

opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.shortmess = opt.shortmess + { c = true }

opt.scrolloff = 10
opt.sidescrolloff = 8

opt.updatetime = 100

opt.clipboard = { 'unnamed', 'unnamedplus' }

vim.cmd([[
  filetype plugin indent on
  autocmd BufWritePre * :%s/\s\+$//e
]])

vim.cmd([[
  augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout=40})
  augroup END
]])