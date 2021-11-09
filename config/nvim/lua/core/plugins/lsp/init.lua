local default_config = require 'core.plugins.lsp.defaults'
local lsp_installer = require 'nvim-lsp-installer'

-- Highlight line numbers for diagnostics
vim.fn.sign_define('DiagnosticSignError', { numhl = 'LspDiagnosticsLineNrError', text = '' })
vim.fn.sign_define('DiagnosticSignWarn', { numhl = 'LspDiagnosticsLineNrWarning', text = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = '' })

lsp_installer.settings {
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    },
    keymaps = {
      -- Keymap to expand a server in the UI
      toggle_server_expand = 'i',
      -- Keymap to install a server
      install_server = '<CR>',
      -- Keymap to reinstall/update a server
      update_server = 'u',
      -- Keymap to uninstall a server
      uninstall_server = 'x',
    },
  }
}

-- Configure diagnostics displaying
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})

-- Handle formatting in a smarter way
-- If the buffer has been edited before formatting has completed, do not try to
-- apply the changes
vim.lsp.handlers['textDocument/formatting'] = function(err, result, ctx, _)
  if err ~= nil or result == nil then
    return
  end

  -- If the buffer hasn't been modified before the formatting has finished,
  -- update the buffer
  if not vim.api.nvim_buf_get_option(ctx.bufnr, 'modified') then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, ctx.bufnr)
    vim.fn.winrestview(view)
    if ctx.bufnr == vim.api.nvim_get_current_buf() or not ctx.bufnr then
      vim.api.nvim_command 'noautocmd :update'
    end
  end
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

local icons = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Field = '',
  TypeParameter = '',
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
  kinds[i] = icons[kind] or kind
end

vim.lsp.buf.rename = {
  float = function()
    local curr_name = vim.fn.expand '<cword>'
    local tshl = require('nvim-treesitter-playground.hl-info').get_treesitter_hl()
    if tshl and #tshl > 0 then
      local ind = tshl[#tshl]:match '^.*()%*%*.*%*%*'
      tshl = tshl[#tshl]:sub(ind + 2, -3)
    end

    local win = require('plenary.popup').create(curr_name, {
      title = 'New Name',
      style = 'minimal',
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      relative = 'cursor',
      borderhighlight = 'FloatBorder',
      titlehighlight = 'Title',
      highlight = tshl,
      focusable = true,
      width = 25,
      height = 1,
      line = 'cursor+2',
      col = 'cursor-1',
    })

    local map_opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(0, 'i', '<Esc>', '<cmd>stopinsert | q!<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<Esc>', '<cmd>stopinsert | q!<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(
      0,
      'i',
      '<CR>',
      "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('" .. curr_name .. ',' .. win .. "')<CR>",
      map_opts
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      '<CR>',
      "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('" .. curr_name .. ',' .. win .. "')<CR>",
      map_opts
    )
  end,
  apply = function(curr, win)
    local newName = vim.trim(vim.api.nvim_get_current_line())
    vim.api.nvim_win_close(win, true)
    if #newName > 0 and newName ~= curr then
      local params = vim.lsp.util.make_position_params()
      params.newName = newName
      vim.lsp.buf_request(0, 'textDocument/rename', params)
    end
  end,
}

lsp_installer.on_server_ready(function(server)
  local opts = default_config

  if server.name == 'gopls' then
    local config = require 'core.plugins.lsp.go'
    opts = vim.tbl_deep_extend('force', opts, config)
  end

  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end)