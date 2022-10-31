local rt_ok, rt = pcall(require, "rust-tools")
-- local lspconfig = require("lspconfig")
local cfg = require("core.plugins.lsp.defaults")
-- local config = require("core.plugins.lsp.defaults").defaults()

if not rt_ok then
    return
end

rt.setup({
    server = {
        on_attach = cfg.on_attach,
    }
})

-- lspconfig.rust_analyzer.setup(config)
