local g = vim.g
local map = require('config.utils').map

g.mapleader = ' '

-- Quickfix
map('n', '<leader>ck', ':cexpr []<CR>', { noremap = true })
map('n', '<leader>cc', ':cclose <CR>', { noremap = true })
map('n', '<leader>co', ':copen <CR>', { noremap = true })
map('n', '<leader>cf', ':cfdo %s/', { noremap = true })

-- Editor
map('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
map('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })
map('x', '<leader>p', '"_dP', { noremap = true })
map('n', '<leader>y', '"+y', { noremap = true })
map('v', '<leader>y', '"+y', { noremap = true })
map('n', '<leader>Y', 'gg"+yG', { noremap = true })
map('n', '<leader>d', '"_d', { noremap = true })
map('v', '<leader>d', '"_d', { noremap = true })
map('i', '<C-c>', '<esc>', { noremap = true })
map('n', '<C-c>', ':noh<CR>', {noremap = true, silent = true, nowait = true})

require('config.core.navigation.mappings').init()