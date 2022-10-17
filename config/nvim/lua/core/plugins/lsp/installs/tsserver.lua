local M = {}

local config = require 'core.plugins.lsp.defaults'
local features = require 'core.plugins.lsp.features'

local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = not features.prettier
  client.server_capabilities.documentRangeFormattingProvider = not features.prettier

  config.on_attach(client, bufnr)
end

M.on_attach = on_attach

return M
