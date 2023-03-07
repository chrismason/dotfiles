return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      current_line_blame = true,
      signs = {
        add = {
          text = "▍",
        },
        change = {
          text = "▍",
        },
        delete = {
          text = "",
        },
        topdelete = {
          text = "",
        },
        changedelete = {
          text = "▍",
        },
      },
    })
  end
}
