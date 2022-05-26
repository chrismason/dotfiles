-- Highlight line numbers for diagnostics
vim.fn.sign_define('DiagnosticSignError', { numhl = 'LspDiagnosticsLineNrError', text = '' })
vim.fn.sign_define('DiagnosticSignWarn', { numhl = 'LspDiagnosticsLineNrWarning', text = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = '' })

-- Configure diagnostics displaying
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})

-- Handle formatting in a smarter way
-- If the buffer has been edited before formatting has completed, do not try to
-- apply the changes
vim.lsp.handlers['textdocument/formatting'] = function(err, result, ctx, _)
  if err ~= nil or result == nil then
    return
  end

  -- If the buffer hasn't been modified before the formatting has finished,
  -- update the buffer
  if not vim.api.nvim_buf_get_option(ctx.bufnr, 'modified') then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, ctx.bufnr, 'utf-8')
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

local M = {}

local function on_attach(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  local function buf_map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  buf_map('n', '<leader>gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
  buf_map('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_map('n', '<leader>gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
  buf_map('n', '<leader>gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', opts)
  buf_map('n', '<leader>gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
  buf_map('n', '<leader>gn', '<cmd>lua vim.lsp.buf.rename.float()<cr>', opts)

  -- diagnostics
  buf_map('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  buf_map('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  buf_map('n', 'ge', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", })<cr>', opts)
  buf_map('n', '<leader>ge', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<cr>', opts)
  buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  buf_map('n', '<leader>ga', '<cmd>lua require("telescope.builtin").lsp_code_actions()<cr>', opts)
  buf_map('v', '<leader>ga', '<cmd>lua require("telescope.builtin").lsp_range_code_actions()<cr>', opts)
  buf_map('n', '<leader>gf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
  buf_map('n', '<C-K>', '<cmd>lua require("lsp_signature").signature()<cr>', opts)

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[augroup LspFormatting]]
    vim.cmd [[autocmd! * <buffer>]]
    vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    vim.cmd [[augroup END]]
  end

  require('lsp_signature').on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = 'single',
    },
  }, bufnr)

  require('core.plugins.colorscheme').set_highlights()
  print('LSP attached')
end

-- M.flags = {
--   debounce_text_changes = 150,
-- }

-- M.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

M.defaults = function()
  return {
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    on_attach = on_attach,
  }
end

M.on_attach = on_attach

return M
