local map = require('core.utils').map

local silent = { silent = true }

-- normal mode
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

map('n', 'Y', 'yg$')
map('n', '<leader>y', '"+y')
map('n', '<leader>Y', 'gg"+yG')
map('n', '<leader>d', '"_d')
map('n', '<C-f>', ':silent !tmux neww tmux-sessionizer<cr>')
map('n', '<leader>+', ':vertical resize +5<cr>')
map('n', '<leader>-', ':vertical resize -5<cr>')
map('n', '<leader>rp', ':resize 100<cr>')

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
