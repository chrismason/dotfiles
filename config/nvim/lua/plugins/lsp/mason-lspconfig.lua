local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

mason_lsp.setup({
  ensure_installed = { "bashls", "gopls", "jsonls", "lua_ls", "tsserver", "yamlls" },
  -- automatic_installation = true,
})

require("plugins.lsp.servers.bash")
require("plugins.lsp.servers.gopls")
require("plugins.lsp.servers.jsonls")
require("plugins.lsp.servers.rust")
require("plugins.lsp.servers.solargraph")
require("plugins.lsp.servers.sorbet")
require("plugins.lsp.servers.sumneko_lua")
require("plugins.lsp.servers.tsserver")
require("plugins.lsp.servers.yamlls")
