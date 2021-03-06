local config = require 'core.plugins.lsp.defaults'.defaults()

return function()
  config.cmd = { "gopls", "serve" }
  config.settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    }
  }

  return config
end
