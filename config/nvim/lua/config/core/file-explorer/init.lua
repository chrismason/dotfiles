local map = require('config.utils').map

-- Mappings.
local opts = { noremap = true, silent = true }

map('n', '<leader>pv', ':Ex<CR>', opts)