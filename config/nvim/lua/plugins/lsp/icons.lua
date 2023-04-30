local icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Field = "",
    TypeParameter = "",
}

local M = {}

function M.setup_lsp_icons()
    local kinds = vim.lsp.protocol.CompletionItemKind
    for i, kind in ipairs(kinds) do
        kinds[i] = icons[kind] or kind
    end
end

function M.set_sign_icons(opts)
    opts = opts or {}

    local sign = function(args)
        if opts[args.name] == nil then
            return
        end

        vim.fn.sign_define(args.hl, {
            texthl = args.hl,
            text = opts[args.name],
            numhl = "",
        })
    end

    sign({ name = "error", hl = "DiagnosticSignError" })
    sign({ name = "warn", hl = "DiagnosticSignWarn" })
    sign({ name = "hint", hl = "DiagnosticSignHint" })
    sign({ name = "info", hl = "DiagnosticSignInfo" })
end

return M
