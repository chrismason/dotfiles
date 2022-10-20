local map = require('core.utils').map

map('n', '<leader>a', [[<cmd>lua require'harpoon.mark'.add_file()<cr>]])
map('n', '<leader>e', [[<cmd>lua require'harpoon.ui'.toggle_quick_menu()<cr>]])
map('n', '<leader>tc', [[<cmd>lua require'harpoon.cmd-ui'.toggle_quick_menu()<cr>]])

map('n', '<leader>h', [[<cmd>lua require'harpoon.ui'.nav_file(1)<cr>]])
map('n', '<leader>j', [[<cmd>lua require'harpoon.ui'.nav_file(2)<cr>]])
map('n', '<leader>k', [[<cmd>lua require'harpoon.ui'.nav_file(3)<cr>]])
map('n', '<leader>l', [[<cmd>lua require'harpoon.ui'.nav_file(4)<cr>]])

map('n', '<leader>th', [[<cmd>lua require'harpoon.term'.gotoTerminal(1)<cr>]])
map('n', '<leader>tj', [[<cmd>lua require'harpoon.term'.gotoTerminal(2)<cr>]])
-- map('n', '<leader>sh', [[<cmd>lua require'harpoon.term'.sendCommand(1, 1)<cr>]])
-- map('n', '<leader>sj', [[<cmd>lua require'harpoon.term'.sendCommand(1, 2)<cr>]])
