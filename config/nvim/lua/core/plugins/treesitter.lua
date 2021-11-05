require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'typescript',
    'javascript',
    'tsx',
    'html',
    'css',
    'bash',
    'lua',
    'json',
    'scss',
    'go',
    'yaml',
    'c_sharp'
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
  },
})
