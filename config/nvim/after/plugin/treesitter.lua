local configs_ok, configs = pcall(require, 'nvim-treesitter.configs')

if not configs_ok then
  return
end

configs.setup({
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
    'c_sharp',
    'rust',
    'ruby',
    'toml',
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    -- enable = true,
    enable = false,
  },
  -- autotag = {
  --   enable = true,
  -- },
  context_commentstring = {
    enable = true,
  },
  -- refactor = {
  --   highlight_definitions = { enable = true },
  -- },
})
