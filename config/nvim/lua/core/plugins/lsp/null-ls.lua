local null_ls = require("null-ls")
local features = require("core.plugins.lsp.features")
local utils = require("core.utils")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

utils.mason_ensure_tools({
  { name = "goimports", version = "latest" },
  { name = "golangci_lint", version = "v1.49.0" },
  { name = "luacheck" },
  { name = "stylua" },
})

local sources = {
  diagnostics.golangci_lint.with({ command = utils.mason_get_path("golangci-lint") }),
  diagnostics.luacheck.with({ command = utils.mason_get_path("luacheck") }),
  diagnostics.tsc,
  formatting.goimports.with({ command = utils.mason_get_path("goimports") }),
  formatting.stylua.with({ command = utils.mason_get_path("stylua") }),
}

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
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentFormattingProvider then
        local id = vim.api.nvim_create_augroup("lsp_formatting", { clear = false })
        vim.api.nvim_clear_autocmds({ buffer = 0, group = id })
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          group = id,
          callback = function()
            vim.lsp.buf.format({ sync = true, bufnr = bufnr })
          end,
        })
      end
    end
  })
end
