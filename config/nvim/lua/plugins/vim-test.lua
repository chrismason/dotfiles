return {
  "vim-test/vim-test",
  dependencies = {
    "tpope/vim-dispatch",
  },
  config = function()
    local map = require('core.utils').map
    local g = vim.g

    g['test#strategy'] = 'neovim'
    g['test#csharp#runner'] = 'dotnettest'
    g['test#go#runner'] = 'gotest'

    map('n', '<leader>tn', ":TestNearest<CR>", { noremap = true, silent = true })
    map('n', '<leader>tf', ":TestFile<CR>", { noremap = true, silent = true })
    map('n', '<leader>ts', ':TestSuite<CR>', { noremap = true, silent = true })
    map('n', '<leader>tl', ':TestLast<CR>', { noremap = true, silent = true })
  end
}
