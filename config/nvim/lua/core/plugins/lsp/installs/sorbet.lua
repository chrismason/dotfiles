local features = require("core.plugins.lsp.features")

if not features.sorbet then
  return
end

local lspconfig = require("lspconfig")
local cfg = require("core.plugins.lsp.defaults")
local config = cfg.defaults()

config.cmd = { "bin/srb", "tc", "--lsp" }

lspconfig.sorbet.setup(config)
