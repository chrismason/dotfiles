local rt_ok, rt = pcall(require, "rust-tools")
local cfg = require("plugins.lsp.config")

if not rt_ok then
    return
end

rt.setup({
    server = {
        on_attach = cfg.on_attach,
        tools = {
            inlay_hints = {
                auto = false,
            }
        },
        settings = {
                ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                    allFeature = true,
                },
                inlayHints = {
                    lifetimeElisionHints = {
                        enable = "always",
                        useParameterNames = true,
                    },
                    reborrowHints = "always",
                },
            },
        },
    }
})
