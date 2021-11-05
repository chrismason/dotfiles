local M = {}

function M.map(modes, lhs, rhs, opts) 
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

function M.highlight(group, bg, fg, gui)
  if gui ~= nil and gui ~= '' then
    vim.api.nvim_command(string.format('hi %s guibg=%s guifg=%s gui=%s', group, bg, fg, gui))
  else
    vim.api.nvim_command(string.format('hi %s guibg=%s guifg=%s', group, bg, fg))
  end
end

return M