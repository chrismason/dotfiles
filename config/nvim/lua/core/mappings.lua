local map = require('core.utils').map

local silent = { silent = true }

-- normal mode
map('n', 'Y', 'yg$')
map('n', '<leader>y', '"+y')
map('n', '<leader>Y', 'gg"+yG')
map('n', '<leader>d', '"_d')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')
map('n', 'x', '"_x')
map('n', 'X', '"_X')
map('v', 'x', '"_x')
map('v', 'X', '"_X')
map('v', 'p', '"_dP')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', '<C-f>', ':silent !tmux neww tmux-sessionizer<cr>')
map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<leader>+', ':vertical resize +5<cr>')
map('n', '<leader>-', ':vertical resize -5<cr>')
map('n', '<leader>rp', ':resize 100<cr>')
map('n', '<C-n>', '<cmd>cnext<cr>zz')
map('n', '<C-m>', '<cmd>cprev<cr>zz')
map('n', '<leader>m', '<cmd>lnext<cr>zz')
map('n', '<leader>,', '<cmd>lprev<cr>zz')

-- Navigate merge conflict markers
map('n', ']n', [[:call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'W')<cr>]], { silent = true })
map('n', '[n', [[:call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'bW')<cr>]], { silent = true })

map('n', '<C-c>', ':nohlsearch<cr>', silent)

map('n', '<C-e>', ':Ex<cr>')

-- insert mode
map('i', '<C-c>', '<esc>')

-- visual mode
map('v', '<', '<gv')
map('v', '>', '>gv')
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")
map('v', '<leader>d', '"_d')
map('v', '<leader>y', '"+y')

-- command mode
map('c', '<c-a>', '<home>')

-- other
map('x', '<leader>p', '"_dP')

-- terminal
map('t', '<esc>', '<c-\\><c-n><cr>')
