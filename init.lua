-- Set leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enables nerd font
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.opt.mouse = 'a'
vim.o.numberwidth = 4

-- Indent settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable break indent
vim.opt.breakindent = false

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--   See `:help 'list'`
--   and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '-> ', trail = '·', nbsp = '␣' }
vim.opt.fillchars:append { eob = ' ' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 3

--   See `:help vim.keymap.set()`
-- Clear highlights on search when pressing <Esc> in normal mode
--   See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Disable netrw
vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = false

-- Useful Keymaps
vim.keymap.set('n', '<leader>e', '<cmd>Neotree focus current<CR>', { desc = 'Open N[e]otree' })

-- Opens terminal in directory of current buffer
vim.keymap.set('n', '<leader>T', function()
  vim.cmd 'split'
  vim.cmd ':cd %:p:h | terminal'
end, { desc = 'Open explorer' })

-- Search and replace for whole file
vim.keymap.set('n', '<leader>Ra', function()
  local from = vim.fn.input 'Replace pattern: '
  local to = vim.fn.input 'With: '
  vim.cmd(string.format('%%s/%s/%s/g', from, to))
end, { noremap = true, silent = true, desc = 'Replace all occurences of pattern' })

-- Search and replace below cursor
vim.keymap.set('n', '<leader>Rj', function()
  local cursorPos = vim.fn.line '.'
  local from = vim.fn.input 'Replace pattern: '
  local to = vim.fn.input 'With: '
  vim.cmd(string.format('%d,%ds/%s/%s/g', cursorPos, vim.fn.line '$', from, to))
end, { noremap = true, silent = true, desc = 'Replace all occurences of pattern below cursor' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--[[ Disables arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
]]

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>lf', function()
  vim.diagnostic.open_float()
end, { desc = 'Toggle floating error message' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank {
      higroup = 'YankHighlightColor',
      timeout = 150,
      on_visual = true,
    }
  end,
})

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
require('lazy').setup({
  -- Major plugins
  require 'plugins.major.which_key',
  require 'plugins.major.lsp.plugins',
  require 'plugins.major.lsp.setup',
  require 'plugins.major.colorscheme',
  require 'plugins.major.statusbar',
  require 'plugins.major.treesitter',
  require 'plugins.major.autoformat',
  require 'plugins.major.xcodebuild',

  -- Minor plugins
  require 'plugins.minor.lint',
  require 'plugins.minor.autopairs',
  require 'plugins.minor.neo-tree',
  require 'plugins.minor.gitsigns',
  -- require 'kickstart.plugins.debug',
  -- require 'plugins.minor.indent_line',
  require 'plugins.minor.surround',
  require 'plugins.minor.snacks',
  require 'plugins.minor.colorizer',
  require 'plugins.minor.misc',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },

  -- Open in Neotree if initialized in current directory (rather than file)
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      local arg = vim.fn.argv()
      if #arg == 1 then
        local path = arg[1]
        if vim.fn.isdirectory(path) == 1 then
          vim.cmd('Neotree focus current filesystem dir=' .. path)
        end
      end
    end,
  }),
})
--[[ Transparent background 
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', blend = 10 })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none', blend = 10 })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none', blend = 10 })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none', blend = 10 })
vim.api.nvim_set_hl(0, 'FidgetTitle', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FidgetTask', { bg = 'none' })

-- Remove black line in split center
vim.api.nvim_set_hl(0, 'VertSplit', { bg = 'none', fg = 'none' })
vim.opt.fillchars:append { vert = ' ' }

-- Yank highlight text
vim.api.nvim_set_hl(0, 'YankHighlightColor', {
  bg = '#f07178',
  fg = '#ffffff', -- text
  bold = true,
})

-- Line number colors
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#FF5757', bg = 'none', italic = false, bold = false })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FF598A', italic = false, bold = true })

-- Changes highlighting color (visual mode)
vim.api.nvim_set_hl(0, 'Visual', { bg = '#7A2B2B' })

-- Configure blink.cmd appearance
vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = '#0F1419' })
vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { bg = '#7A2B2B' })

-- Yank highlight text
vim.api.nvim_set_hl(0, 'YankHighlightColor', {
  bg = '#f07178',
  fg = '#ffffff', -- text
  bold = true,
}) ]]

-- Manually set fillchars and blend if needed (these are not part of ayu's overrides)
vim.opt.fillchars:append { vert = ' ' }

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
