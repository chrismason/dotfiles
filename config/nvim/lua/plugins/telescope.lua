return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        {
            "nvim-telescope/telescope-ui-select.nvim",
        }
    },
    cmd = "Telescope",
    config = function()
        local actions_ok, actions = pcall(require, 'telescope.actions')
        local telescope_ok, telescope = pcall(require, 'telescope')

        if not actions_ok or not telescope_ok then
            return
        end

        telescope.setup {
            defaults = {
                prompt_prefix = ' ❯ ',
                selection_caret = '❯ ',
                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        ['<c-j>'] = actions.move_selection_next,
                        ['<c-k>'] = actions.move_selection_previous,
                        ['<s-up>'] = actions.cycle_history_prev,
                        ['<s-down>'] = actions.cycle_history_next,
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
            },
            pickers = {
                oldfiles = {
                    sort_lastused = true,
                    cwd_only = true,
                },
                find_files = {
                    hidden = true,
                },
                live_grep = {
                    path_display = { 'shorten' },
                },
            },
        }

        telescope.load_extension('fzf')
        telescope.load_extension('ui-select')
    end,
    keys = {
        { "<leader>pf",  "<cmd>lua require'telescope.builtin'.find_files()<cr>" },
        { "<C-p>",       "<cmd>lua require'telescope.builtin'.git_files()<cr>" },
        { "<leader>ps",  "<cmd>lua require'telescope.builtin'.live_grep()<cr>" },
        { "<leader>pb",  "<cmd>lua require'telescope.builtin'.buffers()<cr>" },
        { "<leader>pgs", "<cmd>lua require'telescope.builtin'.git_status()<cr>" },
        { "<leader>fgc", "<cmd>lua require'telescope.builtin'.git_commits()<cr>" },
    }
}
