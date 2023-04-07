-- Highlight line numbers for diagnostics
vim.fn.sign_define("DiagnosticSignError", { numhl = "LspDiagnosticsLineNrError", text = "" })
vim.fn.sign_define("DiagnosticSignWarn", { numhl = "LspDiagnosticsLineNrWarning", text = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "" })

-- Configure diagnostics displaying
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    update_in_insert = false,
    underline = true,
    virtual_text = {
        spacing = 5,
        severity_limit = "Hint",
    },
})

-- Handle formatting in a smarter way
-- If the buffer has been edited before formatting has completed, do not try to
-- apply the changes
vim.lsp.handlers["textdocument/formatting"] = function(err, result, ctx, _)
    if err ~= nil or result == nil then
        return
    end

    -- If the buffer hasn't been modified before the formatting has finished,
    -- update the buffer
    if not vim.api.nvim_buf_get_option(ctx.bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, ctx.bufnr, "utf-8")
        vim.fn.winrestview(view)
        if ctx.bufnr == vim.api.nvim_get_current_buf() or not ctx.bufnr then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

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

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
    kinds[i] = icons[kind] or kind
end

local M = {}

local function on_attach(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    local function buf_map(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap = true, silent = true }
    buf_map("n", "<leader>gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
    buf_map("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    buf_map("n", "<leader>gi", '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
    buf_map("n", "<leader>gt", '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', opts)
    buf_map("n", "<leader>gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
    buf_map("n", "<leader>gn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

    -- diagnostics
    buf_map("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    buf_map("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    buf_map("n", "<leader>ge", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", })<cr>', opts)
    buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    buf_map("n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    buf_map("v", "<leader>ga", "<cmd>lua vim.lsp.buf.range_code_actions()<cr>", opts)
    buf_map("n", "<leader>gf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
    buf_map("n", "<C-K>", '<cmd>lua require("lsp_signature").signature()<cr>', opts)

    require("lsp_signature").on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "single",
        },
    }, bufnr)

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end

    if client.name == 'omnisharp' then
        local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
        for i, v in ipairs(tokenModifiers) do
            tokenModifiers[i] = v:gsub(' ', '_')
        end
        local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
        for i, v in ipairs(tokenTypes) do
            tokenTypes[i] = v:gsub(' ', '_')
        end
    end

    -- require("core.plugins.colorscheme").set_highlights()
    print("LSP attached")
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

M.defaults = function()
    return {
        capabilities = capabilities,
        flags = { debounce_text_changes = 150 },
        on_attach = on_attach,
    }
end

M.on_attach = on_attach

return M
