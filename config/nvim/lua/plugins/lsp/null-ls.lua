local null_ls = require("null-ls")
local features = require("plugins.lsp.features")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
    code_actions.gitsigns,
    diagnostics.luacheck,
    formatting.goimports,
}

if features.prettier then
    table.insert(sources, formatting.prettier)
end

if features.eslint then
    table.insert(sources, diagnostics.eslint)
end

if features.rubocop then
    table.insert(sources, formatting.rubocop)
    table.insert(sources, diagnostics.rubocop)
end

if features.golangci_lint then
    table.insert(sources, diagnostics.golangci_lint.with({
        timeout = -1
    }))
end

if features.stylua then
    table.insert(sources, diagnostics.stylua)
end

if features.tsc then
    table.insert(sources, diagnostics.tsc)
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
        end,
    })
end
