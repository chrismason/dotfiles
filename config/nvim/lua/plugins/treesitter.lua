return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        local configs = require('nvim-treesitter.configs')

        configs.setup({
            ensure_installed = {
                'typescript',
                'javascript',
                'tsx',
                'html',
                'css',
                'bash',
                'lua',
                'json',
                'scss',
                'go',
                'yaml',
                'c_sharp',
                'rust',
                'ruby',
                'toml',
                'terraform',
            },
            highlight = {
                enable = true,
                use_languagetree = true,
                additional_vim_regex_highlighting = true,
            },
            indent = {
                enable = false,
            },
            context_commentstring = {
                enable = true,
            },
        })
    end
}
