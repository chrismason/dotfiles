local M = {}

function M.on_attach(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  local function buf_map( ... )
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

M.flags = {
  debounce_text_changes = 150,
}

M.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
