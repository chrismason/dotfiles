local fn = vim.fn
local cmd = vim.cmd

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
    },

    -- Fuzzy find
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-ui-select.nvim",

            -- FZF sorter for Telescope
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
    },

    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "ray-x/lsp_signature.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            "simrat39/rust-tools.nvim",
        },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "windwp/nvim-autopairs",
            "onsails/lspkind-nvim",
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
    },

    {
        "vim-test/vim-test",
        dependencies = {
            "tpope/vim-dispatch",
        },
    },


    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
    },

    "tpope/vim-fugitive",
    "nvim-lualine/lualine.nvim",
    "theprimeagen/harpoon",
    "gpanders/editorconfig.nvim",
    'lewis6991/gitsigns.nvim',
})
