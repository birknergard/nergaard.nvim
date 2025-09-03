return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    -- Keybinding to toggle Colorizer for the current buffer
    vim.keymap.set('n', '<leader>ct', ':ColorizerToggle<CR>', { desc = 'Toggle Colorizer' })
    vim.keymap.set('n', '<leader>cr', ':ColorizerReloadAllBuffers<CR>', { desc = 'Update Colorizer colors' })
  end,
}
