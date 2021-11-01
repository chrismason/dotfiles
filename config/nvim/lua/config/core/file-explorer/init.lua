local map = require('config.utils').map

-- Mappings.
local opts = { noremap = true, silent = true }

map('n', '<C-e>', ':Ex<CR>', opts)
