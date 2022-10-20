local lualine_ok, lualine = pcall(require, 'lualine')

if not lualine_ok then
  return
end

lualine.setup {
  options = {
    theme = 'catppuccin',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
}
