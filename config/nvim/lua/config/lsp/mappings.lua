local map = require('config.utils').map

-- Mappings.
local opts = { noremap = true, silent = true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
map('n', '<leader>gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
map('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
map('n', '<leader>gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
map('n', '<leader>gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', opts)
map('n', '<leader>gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
map('n', '<leader>gn', '<cmd>lua require("cosmic.core.theme.ui").rename()<cr>', opts)

-- diagnostics
map('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
map('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
map('n', 'ge', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", })<cr>', opts)
map('n', '<leader>ge', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<cr>', opts)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
map('n', '<leader>ga', '<cmd>lua require("telescope.builtin").lsp_code_actions()<cr>', opts)
map('v', '<leader>ga', '<cmd>lua require("telescope.builtin").lsp_range_code_actions()<cr>', opts)
map('n', '<leader>gf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
map('n', '<C-K>', '<cmd>lua require("lsp_signature").signature()<cr>', opts)

-- lsp workspace
map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)