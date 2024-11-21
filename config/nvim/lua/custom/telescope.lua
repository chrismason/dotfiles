local actions_ok, actions = pcall(require, "telescope.actions")

if not actions_ok then
  return
end

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<s-up>"] = actions.cycle_history_prev,
        ["<s-down>"] = actions.cycle_history_next,
      },
    },
  },
  extensions = {
    wrap_results = true,
    fzf = {},
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files)
vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set("n", "<leader>vh", builtin.help_tags)
vim.keymap.set("n", "<leader>pb", builtin.buffers)
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>ps", builtin.live_grep)
vim.keymap.set("n", "<leader>pws", function()
  local word = vim.fn.expand("<cword>")
  builtin.grep_string({ search = word })
end)
-- vim.keymap.set("n", "<leader>pgs", builtin.git_status)
-- vim.keymap.set("n", "<leader>pgc", builtin.git_commits)

