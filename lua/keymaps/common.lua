-- Opens terminal in directory of current buffer
vim.keymap.set('n', '<leader>T', function()
  vim.cmd 'split'
  vim.cmd ':cd %:p:h | terminal'
end, { desc = 'Open terminal in current dir' })

-- Yank to system clipboard

-- Overwriting text in sends deleted text to void register
vim.keymap.set('x', 'p', [["_dP]], { noremap = true, silent = true })

-- TODO: Toggle signcolumn
vim.keymap.set('n', '<leader>cs', function()
  print 'Toggling signcolumn'
end, { desc = 'Hide/show sign column' })

-- Easier saving
--vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { noremap = true, desc = 'Save current buffer' })
--vim.keymap.set('n', '<leader>W', '<cmd>wa<CR>', { noremap = true, desc = 'Save all open buffers' })

-- Yank to system cliboard
vim.keymap.set('n', '<leader>y', '"+y', { noremap = true })

-- Yank to system cliboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true })

-- Paste from system clipboard
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true })

-- Paste from system clipboard
vim.keymap.set('v', '<leader>p', '"+p', { noremap = true })

-- Create splits
vim.keymap.set('n', '<leader>Sv', '<cmd>vsplit<CR>', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>Sh', '<cmd>split<CR>', { desc = 'Split horizontally' })

-- Centers screen on new position with C-d, C-u
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- rebind exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float()
end, { desc = 'Toggle floating error message' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinding to toggle Colorizer for the current buffer
vim.keymap.set('n', '<leader>ct', ':ColorizerToggle<CR>', { desc = 'Toggle Colorizer' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>-', function()
  local oil = require 'oil'
  oil.toggle_float()
end, { desc = 'Open oil in parent directory of current file' })
