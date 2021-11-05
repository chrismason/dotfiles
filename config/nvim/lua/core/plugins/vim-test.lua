local map = require('config.utils').map
local g = vim.g

local function setup_mappings()
  map('n', '<leader>tn', ":TestNearest<CR>", { noremap = true, silent = true })
  map('n', '<leader>tf', ":TestFile<CR>", { noremap = true, silent = true })
  map('n', '<leader>ts', ':TestSuite<CR>', { noremap = true, silent = true })
  map('n', '<leader>tl', ':TestLast<CR>', { noremap = true, silent = true })
end

g['test#strategy'] = 'neovim'
g['test#csharp#runner'] = 'dotnettest'
g['test#go#runner'] = 'gotest'

setup_mappings()