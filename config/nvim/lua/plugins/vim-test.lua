return {
    "vim-test/vim-test",
    dependencies = {
        "tpope/vim-dispatch",
    },
    config = function()
        local g = vim.g

        g['test#strategy'] = 'neovim'
        g['test#csharp#runner'] = 'dotnettest'
        g['test#go#runner'] = 'gotest'
    end,
    keys = {
        { "<leader>tn", "<cmd>TestNearest<CR>", { remap = false, silent = true } },
        { "<leader>tf", "<cmd>TestFile<CR>",    { remap = false, silent = true } },
        { "<leader>ts", "<cmd>TestSuite<CR>",   { remap = false, silent = true } },
        { "<leader>tl", "<cmd>TestLast<CR>",    { remap = false, silent = true } },
    }
}
