-- Set leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enables nerd font
vim.g.have_nerd_font = true
vim.o.termguicolors = true
vim.o.numberwidth = 4
vim.opt.showmode = false

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true

-- Sets system clipboard
vim.opt.clipboard = 'unnamed'

-- Mouse
vim.opt.mouse = 'a'

-- Indent settings
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable break indent
vim.opt.breakindent = false

-- Keep signcolumn on by default
vim.opt.signcolumn = 'no'

-- Decrease update time
vim.opt.updatetime = 50

-- Manage mapped sequence wait time
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.winborder = 'rounded'

-- Sets how neovim will display certain whitespace characters in the editor.
--   See `:help 'list'`
--   and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '->', trail = '·', nbsp = '␣' }
vim.opt.fillchars:append { eob = ' ' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Disable netrw
vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = false

-- Set up remote fetching of plugins with LazyVim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Lazy, plugin manager
require('lazy').setup {
  -- Major plugins
  require 'lsp.plugins',
  require 'plugins.which_key',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  -- require 'plugins.lazydev',
  require 'plugins.telescope',
  require 'plugins.autoformat',
  require 'plugins.oil',
  require 'plugins.harpoon',

  -- Minor plugins
  require 'plugins.autopairs',
  require 'plugins.surround',
  require 'plugins.snacks',
  require 'plugins.colorizer',
  require 'plugins.misc',
  -- require 'plugins.lint',

  -- Load color scheme last
  require 'colorschemes.ayu',
  --require 'colorschemes.catppuccin',
}

-- Load LSP
require 'lsp.setup'

vim.cmd 'colorscheme ayu-dark'

require 'keymaps.common'
require 'autocmds.common'

-- For Neovim 0.5+ (WinSeparator overrides VertSplit)
vim.cmd [[highlight WinSeparator guifg=#0e1018 guibg=NONE]]

-- Set lualine backgrounds to transparent AFTER theme has been loaded
vim.cmd [[
  hi StatusLine guibg=NONE ctermbg=NONE
  hi StatusLineNC guibg=NONE ctermbg=NONE
  hi TabLine guibg=NONE ctermbg=NONE
  hi TabLineSel guibg=NONE ctermbg=NONE
  hi TabLineFill guibg=NONE ctermbg=NONE
]]

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
