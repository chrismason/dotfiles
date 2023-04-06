local lspconfig = require("lspconfig")
local cfg = require("plugins.lsp.config")
local config = cfg.defaults()

config.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    cfg.on_attach(client, bufnr)
end

config.cmd = { "dotnet", vim.fn.expand("$HOME/.local/omnisharp/OmniSharp.dll") }
config.enable_roslyn_analyzers = true
config.organize_imports_on_format = true
config.enable_import_completion = true
config.handlers = {
    ["textDocument/definition"] = require("omnisharp_extended").handler
}

lspconfig.omnisharp.setup(config)
