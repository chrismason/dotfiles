local map = require('config.utils').map
local M = {}

function M.init()
  -- Telescope
  map('n', '<leader>pf', "<cmd>:Telescope find_files<CR>", { noremap = true })
  map('n', '<C-p>', ":Telescope git_files<CR>", { noremap = true })
  map('n', '<leader>pb', ":Telescope buffers<CR>", { noremap = true })
  map('n', '<leader>ps', ":Telescope live_grep<CR>", { noremap = true })
  map('n', '<leader>pgc', ':Telescope git_commits<CR>', { noremap = true })
  map('n', '<leader>pgs', ':Telescope git_status<CR>', { noremap = true })
    
  -- Window movement
  map('n', '<c-h>', '<c-w>h')
  map('n', '<c-j>', '<c-w>j')
  map('n', '<c-k>', '<c-w>k')
  map('n', '<c-l>', '<c-w>l')
end

function M.mappings()
  local actions = require('telescope.actions')
  local normal = {
    n = {
      ['Q'] = actions.smart_add_to_qflist + actions.open_qflist,
      ['q'] = actions.smart_send_to_qflist + actions.open_qflist,
      ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
      ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
      ['v'] = actions.file_vsplit,
      ['s'] = actions.file_split,
      ['<cr>'] = actions.file_edit,
    },
  }

  return normal
end

return M