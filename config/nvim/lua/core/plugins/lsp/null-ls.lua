local null_ls = require 'null-ls'
local features = require 'core.plugins.lsp.features'
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {}

if features.prettier then
  table.insert(sources, formatting.prettier)
end

if features.eslint_d then
  table.insert(sources, diagnostics.eslint)
end

if features.rubocop then
  table.insert(sources, formatting.rubocop.with({ command = "bin/rubocop" }))
  table.insert(sources, diagnostics.rubocop.with({ command = "bin/rubocop" }))
end

if #sources ~= 0 then
  null_ls.setup({
    debug = false,
    sources = sources,
    on_attach = function(client)
      if client.server_capabilities.documentFormattingProvider then
        local id = vim.api.nvim_create_augroup("lsp_formatting", { clear = false })
        vim.api.nvim_clear_autocmds({ buffer = 0, group = id })
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = 0,
          group = id,
          callback = function()
            vim.lsp.buf.format({ sync = true })
          end,
        })
      end
    end
  })
end
