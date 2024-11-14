local set = vim.keymap.set
local k = vim.keycode

set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

-- Toggle hlsearch if it's on, otherwise just do "enter"
set("n", "<CR>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.v.hlsearch == 1 then
    vim.cmd.nohl()
    return ""
  else
    return k "<CR>"
  end
end, { expr = true })

set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-=>", "<C-W>+")
set("n", "<M-->", "<C-W>-")

set("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
end)

set('n', 'Y', 'yg$')
set('n', '<leader>y', '"+y')
set('n', '<leader>Y', 'gg"+yG')
set('n', '<leader>d', '"_d')
set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')
set('n', 'J', 'mzJ`z')
set('n', 'x', '"_x')
set('n', 'X', '"_X')
set('v', 'x', '"_x')
set('v', 'X', '"_X')
set('v', 'p', '"_dP')
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')

set('i', '<C-c>', '<esc>')

set('v', '<', '<gv')
set('v', '>', '>gv')
set('v', 'J', ":m '>+1<CR>gv=gv")
set('v', 'K', ":m '<-2<CR>gv=gv")
set('v', '<leader>d', '"_d')
set('v', '<leader>y', '"+y')