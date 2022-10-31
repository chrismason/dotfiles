local rt_ok, rt = pcall(require, "rust-tools")
local cfg = require("core.plugins.lsp.defaults")

if not rt_ok then
    return
end

rt.setup({
    server = {
        on_attach = cfg.on_attach,
    }
})
