return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        local fmt_stat = function()
            local stat = ''
            stat = stat .. 'spaces=' .. vim.opt_local.tabstop._value
            return stat
        end

        local navic_ok, navic = pcall(require, 'nvim-navic')
        local winbar_cfg = {}
        local inactive_winbar_cfg = {}

        if navic_ok then
            winbar_cfg = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    { "filename",         path = 1,                 color = { bg = "NONE" } },
                    { navic.get_location, cond = navic.is_available },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            }
            inactive_winbar_cfg = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    { "filename", path = 1, color = { bg = "NONE" } },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            }
        end

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = 'catppuccin',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", path = 3 } },
                lualine_x = { fmt_stat, "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = winbar_cfg,
            inactive_winbar = inactive_winbar_cfg,
        })
    end
}
