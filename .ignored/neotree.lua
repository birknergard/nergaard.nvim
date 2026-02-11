-- Function to calculate width
local function get_neotree_width()
  local total_cols = vim.o.columns
  local scaled = math.floor(total_cols * 0.25)
  return math.min(math.max(scaled, 50), 100)
end

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
    window = {
      width = get_neotree_width(),
    },
    config = function()
      local width = get_neotree_width()
      vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle right<CR>', {
        desc = 'Open/focus file explorer',
      })

      -- Auto resize Neo-tree when Vim is resized
      vim.api.nvim_create_autocmd('VimResized', {
        callback = function()
          -- Update Neo-tree window width if it's open
          local view = require('neo-tree.sources.manager').get_state 'filesystem'
          if view and view.winid then
            vim.api.nvim_win_set_width(view.winid, width)
          end
        end,
      })
    end,
  },
}
