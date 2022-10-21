local lspconfig = require("lspconfig")
local config = require("core.plugins.lsp.defaults").defaults()
local schemastore_ok, schemastore = pcall(require, "schemastore")

local schemas
if not schemastore_ok then
    schemas = {
        {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json"
        },
        {
            fileMatch = { "tsconfig*.json" },
            url = "https://json.schemastore.org/tsconfig.json"
        },
        {
            fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
            url = "https://json.schemastore.org/prettierrc.json"
        },
        {
            fileMatch = { ".eslintrc", ".eslintrc.json" },
            url = "https://json.schemastore.org/eslintrc.json"
        },
    }
else
    schemas = schemastore.json.schemas()
end

config.settings = {
    json = {
        schemas = schemas
    }
}

lspconfig.jsonls.setup(config)
