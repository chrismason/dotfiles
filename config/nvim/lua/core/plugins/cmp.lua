local cmp = require('cmp')
local autopairs = require 'nvim-autopairs'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local luasnip = require('luasnip')

vim.cmd([[
  autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
]])

autopairs.setup {
  check_ts = true,
  enable_moveright = true,
  disable_filetype = { 'TelescopePrompt', 'vim' },
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
  documentation = {
    border = 'single',
    winhighlight = 'FloatBorder:FloatBorder,Normal:Normal',
  },
  experimental = {
    ghost_text = true,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'luasnip' },
    { name = 'path' },
  }),
  formatting = {
    format = require('lspkind').cmp_format({
      with_text = true,
      menu = {
        buffer = '[buf]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[VimApi]',
        path = '[path]',
        luasnip = '[snip]',
      },
    }),
  },
})

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())