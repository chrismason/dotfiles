local lspconfig = require("lspconfig")
local cfg = require("plugins.lsp.config")
local features = require("plugins.lsp.features")
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
    },
}

lspconfig.lua_ls.setup(config)
