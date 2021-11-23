local g = vim.g

g.mapleader = ' '
vim.cmd('filetype plugin indent on')

require 'core.settings'
require 'core.plugins'
require 'core.mappings'
