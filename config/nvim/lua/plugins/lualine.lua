require('lualine').setup({
    options = {
        theme = 'moonfly',
        component_separators = { " ", " " },
        section_separators = { "", "" },
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = { "mode", "paste" },
        lualine_b = {
          { "branch", icon = "" },
          { "diff", color_added = "#8cc85f", color_modified = "#e3c78a", color_removed = "#ff5454" },
        },
        lualine_c = {
          { "diagnostics", sources = { "nvim_lsp" } },
          function()
            return "%="
          end,
          "filename", 
        },
        lualine_x = { "filetype" },
        lualine_y = {
          {
            "progress",
          },
        },
        lualine_z = {
          {
            "location",
            icon = "",
          },
        },
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
      extensions = {},
})
