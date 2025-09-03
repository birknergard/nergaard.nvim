return {
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  { -- Extended webicons
    'nvim-tree/nvim-web-devicons',
    opts = {},
  },
  { -- For tmux pane navigation
    'christoomey/vim-tmux-navigator',
  },
  { -- Fixes indentation sillyness
    'tpope/vim-sleuth',
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Simple and easy statusline.
      --[[
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
      ]]

      -- ... and there is more!
      --   Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
