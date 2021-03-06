local highlight = require('core.utils').highlight
local themeColors = require('tokyonight.colors').setup()

local colors = {
  white = themeColors.fg_dark,
  bg = themeColors.bg,
  bg_highlight = themeColors.bg_highlight,
  blue = themeColors.blue,
  purple = themeColors.magenta,
  orange = themeColors.orange,
  trace = themeColors.orange,
  hint = themeColors.teal,
  red = themeColors.red,
  diffAdd = themeColors.git.add,
  diffModified = themeColors.git.change,
  diffDeleted = themeColors.git.delete,
  info = themeColors.green2,
  error = themeColors.magenta2,
  warn = themeColors.orange,
  floatBorder = themeColors.border_highlight,
  selection_caret = themeColors.purple,
  lineNumbers = themeColors.teal,
}

local M = {}

function M.set_theme()
  vim.g.tokyonight_style = 'night'
  vim.g.tokyonight_sidebars = { 'qf', 'packer' }
  vim.cmd('color tokyonight')
end

function M.set_globalcolors()
  highlight('LineNr', 'None', colors.lineNumbers)
end

function M.set_highlights()
  highlight('DiagnosticVirtualTextError', 'None', colors.error)
  highlight('DiagnosticVirtualTextWarn', 'None', colors.warn)
  highlight('DiagnosticVirtualTextInfo', 'None', colors.info)
  highlight('DiagnosticVirtualTextHint', 'None', colors.hint)

  highlight('DiagnosticError', 'None', colors.error)
  highlight('DiagnosticWarn', 'None', colors.warn)
  highlight('DiagnosticInfo', 'None', colors.info)
  highlight('DiagnosticHint', 'None', colors.hint)

  highlight('Error', 'None', colors.error)
  highlight('ErrorMsg', 'None', colors.error)
  highlight('WarningMsg', 'None', colors.warn)

  highlight('DiagnosticError', 'None', colors.error)
  highlight('DiagnosticWarn', 'None', colors.warn)
  highlight('DiagnosticInfo', 'None', colors.info)
  highlight('DiagnosticHint', 'None', colors.hint)

  highlight('LspSignatureActiveParameter', 'None', colors.orange)

  highlight('TelescopeSelectionCaret', 'None', colors.selection_caret)

  highlight('CmpItemAbbrDeprecated', 'None', colors.warn)

  highlight('NotifyINFOBorder', nil, colors.hint)
  highlight('NotifyINFOTitle', nil, colors.hint)
  highlight('NotifyINFOIcon', nil, colors.hint)
  highlight('NotifyWARNBorder', nil, colors.warn)
  highlight('NotifyWARNTitle', nil, colors.warn)
  highlight('NotifyWARNIcon', nil, colors.warn)
  highlight('NotifyERRORBorder', nil, colors.error)
  highlight('NotifyERRORTitle', nil, colors.error)
  highlight('NotifyERRORIcon', nil, colors.error)
  highlight('NotifyTRACEBorder', nil, colors.trace)
  highlight('NotifyTRACETitle', nil, colors.trace)
  highlight('NotifyTRACEIcon', nil, colors.trace)
end

return M
