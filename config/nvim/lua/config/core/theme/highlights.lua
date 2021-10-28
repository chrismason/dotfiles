local colors = require('config.core.theme.colors')
local highlight = require('config.utils').highlight
local M = {}

function M.init()
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

  highlight('LspDiagnosticsError', 'None', colors.error)
  highlight('LspDiagnosticsWarn', 'None', colors.warn)
  highlight('LspDiagnosticsInfo', 'None', colors.info)
  highlight('LspDiagnosticsHint', 'None', colors.hint)

  highlight('LspSignatureActiveParameter', 'None', colors.orange)

  highlight('TelescopeSelectionCaret', 'None', colors.selection_caret)

  highlight('CmpItemAbbrDeprecated', 'None', colors.warn)

  vim.cmd([[
    highlight clear NormalFloat
    highlight link NormalFloat Normal
  ]])
end

return M