return { -- Plugin for handling surrounding
  'kylechui/nvim-surround',
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  event = 'VeryLazy', -- Load the plugin very late to avoid startup impact
  config = function()
    require('nvim-surround').setup {
      -- Optional: Customize keymaps or other settings here
    }
  end,
}
