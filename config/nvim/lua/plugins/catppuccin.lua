vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("Catppuccin", { clear = true }),
  pattern = "catppuccin.lua",
  command = "source <afile> | CatppuccinCompile"
})

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavor = "mocha",
      styles = {
        comments = { 'italic' },
        functions = { 'italic', 'bold' },
        keywords = { 'bold' },
      },
      integrations = {
        treesitter = true,
        treesitter_context = true,
        cmp = true,
        telescope = true,
        harpoon = true,
        mason = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
          },
        },
        dap = {
          enabled = true,
          enable_ui = true,
        },
        gitsigns = true,
      }
    })

    vim.cmd('color catppuccin')
  end
}
