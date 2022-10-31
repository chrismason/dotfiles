local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer.nvim
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer itself
    use({ "wbthomason/packer.nvim", opt = true })

    -- colorscheme
    use({
        "catppuccin/nvim",
        as = "catppuccin",
    })

    use({
        "kyazdani42/nvim-web-devicons",
        -- after = 'catppuccin/nvim',
    })

    -- Fuzzy finding
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-ui-select.nvim",

            -- FZF sorter for Telescope
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
    })

    use({
        "williamboman/mason.nvim",
        requires = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "ray-x/lsp_signature.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            "simrat39/rust-tools.nvim",
        },
    })

    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "windwp/nvim-autopairs",
            "onsails/lspkind-nvim",
        },
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter-context",
    })

    use({
        "vim-test/vim-test",
        requires = {
            "tpope/vim-dispatch",
        },
    })

    use({
        "tpope/vim-fugitive",
        opt = true,
        cmd = "Git",
    })

    use({
        "nvim-lualine/lualine.nvim",
    })

    use({
        "theprimeagen/harpoon",
    })

    use({
        "mfussenegger/nvim-dap",
        requires = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
    })

    use({
        "gpanders/editorconfig.nvim",
    })

    use {
        'lewis6991/gitsigns.nvim',
    }
end)
