local M = {}

local config = require 'core.plugins.lsp.defaults'
local features = require 'core.plugins.lsp.features'

local on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = not features.prettier
  client.resolved_capabilities.document_range_formatting = not features.prettier

  config.on_attach(client, bufnr)
end

M.on_attach = on_attach

return M
