require('plugins.telescope')
require('plugins.lsp')
require('plugins.cmp')
require('plugins.autopairs')
require('plugins.lualine')

P = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, 'plenary') then
    RELOAD = require('plenary.reload').reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end
