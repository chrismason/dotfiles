local lspconfig = require("lspconfig")
local cfg = require("plugins.lsp.config")
local config = cfg.defaults()

config.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    cfg.on_attach(client, bufnr)
end

config.settings = {
    Lua = {
        diagnostics = {
            globals = { "vim", "bit" },
        },
        hint = {
            enable = true
        }
    },
}

lspconfig.lua_ls.setup(config)
