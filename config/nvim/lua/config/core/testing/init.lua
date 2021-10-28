require('config.core.testing.mappings').init()
local g = vim.g

g['test#strategy'] = 'neovim'
g['test#csharp#runner'] = 'dotnettest'