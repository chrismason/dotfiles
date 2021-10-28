local map = require('config.utils').map
local M = {}

function M.init()
  map('n', '<leader>tn', ":TestNearest<CR>", { noremap = true, silent = true })
  map('n', '<leader>tf', ":TestFile<CR>", { noremap = true, silent = true })
  map('n', '<leader>ts', ':TestSuite<CR>', { noremap = true, silent = true })
  map('n', '<leader>tl', ':TestLast<CR>', { noremap = true, silent = true })
end

return M