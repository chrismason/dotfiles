local present, config_packer = pcall(require, 'config.packer')

if not present then
  return false
end

local packer = config_packer.packer
local use = packer.use

return packer.startup(function ()
  use('wbthomason/packer.nvim')

  use({
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient')
    end,
  })

  use({
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'night'
      vim.g.tokyonight_sidebars = { 'qf', 'packer' }
      vim.cmd('color tokyonight')
    end,
  })

  use({
    'kyazdani42/nvim-web-devicons',
    after = 'tokyonight.nvim',
  })

  use({
    'NTBBloodbath/galaxyline.nvim',
    branch = 'main',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('config.core.statusline')
    end,
    after = 'nvim-web-devicons',
  })

  use({
    'williamboman/nvim-lsp-installer',
    requires = {
      'neovim/nvim-lspconfig',
      'ray-x/lsp_signature.nvim',
    },
    config = function()
      require('config.lsp')
    end,
  })

  use({
    'hrsh7th/nvim-cmp',
    config = function()
      require('config.lsp.autocomplete')
    end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'windwp/nvim-autopairs',
      'onsails/lspkind-nvim',
    },
  })

  use({
    'tpope/vim-fugitive',
    opt = true,
    cmd = 'Git',
  })

  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
      },
    },
    config = function()
      require('config.core.navigation')
    end,
    event = 'BufRead',
  })

  use({
    'rmagatti/auto-session',
    event = 'VimEnter',
    config = function()
      require('auto-session').setup({
        pre_save_cmds = { 'cclose' },
      })
    end,
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'windwp/nvim-ts-autotag',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    run = ':TSUpdate',
    config = function()
      require('config.core.treesitter')
    end,
  })

  
  use({
    'vim-test/vim-test',
    requires = {
      'tpope/vim-dispatch',
    },
  })

  if config_packer.first_install then
    packer.sync()
  end
end)