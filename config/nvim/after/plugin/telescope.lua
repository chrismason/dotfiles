local actions = require 'telescope.actions'
local map = require ('core.utils').map

map('n', '<leader>pf', [[<cmd>lua require'telescope.builtin'.find_files()<cr>]])
map('n', '<C-p>', [[<cmd>lua require'telescope.builtin'.git_files()<cr>]])
map('n', '<leader>ps', [[<cmd>lua require'telescope.builtin'.live_grep()<cr>]])
map('n', '<leader>pb', [[<cmd>lua require'telescope.builtin'.buffers()<cr>]])
map('n', '<leader>pgs', [[<cmd>lua require'telescope.builtin'.git_status()<cr>]])
map('n', '<leader>fgc', [[<cmd>lua require'telescope.builtin'.git_commits()<cr>]])

require('telescope').setup {
  defaults = {
    prompt_prefix = ' ❯ ',
    selection_caret = '❯ ',
    mappings = {
      i = {
        ['<esc>'] = actions.close,

        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,

        ['<s-up>'] = actions.cycle_history_prev,
        ['<s-down>'] = actions.cycle_history_next,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
  pickers = {
    oldfiles = {
      sort_lastused = true,
      cwd_only = true,
    },
    find_files = {
      hidden = true,
    },
    live_grep = {
      path_display = { 'shorten' },
    },
  },
}

require('telescope').load_extension 'fzf'