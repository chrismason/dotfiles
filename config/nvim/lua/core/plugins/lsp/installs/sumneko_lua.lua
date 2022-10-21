local lspconfig = require("lspconfig")
local cfg = require("core.plugins.lsp.defaults")
local config = cfg.defaults()

config.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    cfg.on_attach(client, bufnr)
end

config.settings = {
    Lua = {
        diagnostics = {
            globals = { "vim", "bit", "packer_plugins" },
        },
    },
}

lspconfig.sumneko_lua.setup(config)
