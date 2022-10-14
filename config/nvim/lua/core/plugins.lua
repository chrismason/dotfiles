local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer itself
  use { 'wbthomason/packer.nvim', opt = true }

  -- colorscheme
  use({
    'catppuccin/nvim', as = 'catppuccin',
    config = function()
      require('core.plugins.colorscheme').set_theme()
      require('core.plugins.colorscheme').set_globalcolors()
    end,
  })

  use({
    'kyazdani42/nvim-web-devicons',
    -- after = 'catppuccin/nvim',
  })

  -- Fuzzy finding
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'core.plugins.telescope'
    end,
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',

      -- FZF sorter for Telescope
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  }

  use({
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'ray-x/lsp_signature.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require 'core.plugins.lsp'
    end,
  })

  use({
    'hrsh7th/nvim-cmp',
    config = function()
      require 'core.plugins.cmp'
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
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'windwp/nvim-ts-autotag',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/playground',
      'romgrk/nvim-treesitter-context'
    },
    run = ':TSUpdate',
    config = function()
      require 'core.plugins.treesitter'
    end,
  })

  use({
    'vim-test/vim-test',
    requires = {
      'tpope/vim-dispatch',
    },
    config = function()
      require 'core.plugins.vim-test'
    end,
  })

  use({
    'tpope/vim-fugitive',
    opt = true,
    cmd = 'Git',
  })

  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'core.plugins.lualine'
    end,
  })

  use({
    'theprimeagen/harpoon',
    config = function()
      require 'core.plugins.harpoon'
    end,
  })

  use({
    'mfussenegger/nvim-dap',
    requires = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'leoluz/nvim-dap-go'
    },
    config = function()
      require 'core.plugins.dap'
    end,
  })

  use({
    'gpanders/editorconfig.nvim'
  })

  if packer_bootstrap then
    require('packer').sync()
  end

end)
