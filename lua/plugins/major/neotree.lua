return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons', -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
      -- Neotree keymaps
      vim.keymap.set('n', '<leader>ee', '<cmd>Neotree toggle right filesystem<CR>', { desc = 'Open file explorer' })
      vim.keymap.set('n', '<leader>eb', '<cmd>Neotree toggle right buffers<CR>', { desc = 'Open buffer explorer' })
      vim.keymap.set('n', '<leader>eg', '<cmd>Neotree toggle right git_status<CR>', { desc = 'Open git_status view' })
    end,
  },
}
