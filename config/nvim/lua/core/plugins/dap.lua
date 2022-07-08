local dap = require('dap')
local dapui = require('dapui')
local daptext = require('nvim-dap-virtual-text')
local map = require('core.utils').map

daptext.setup()
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open(1)
end

dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.after.event_exited["dapui_config"] = function()
  dapui.close()
end

require('core.plugins.debuggers.go')

map('n', '<F5>', function()
  dap.continue()
end)
map('n', '<S-F5>', function()
  dap.close()
  dapui.close()
end)
map('n', '<F9>', function()
  dap.toggle_breakpoint()
end)
map('n', '<S-F9>', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint Condition: '))
end)
map('n', '<F10>', function()
  step_over()
end)
map('n', '<F11>', function()
  step_into()
end)
map('n', '<F12>', function()
  step_out()
end)
