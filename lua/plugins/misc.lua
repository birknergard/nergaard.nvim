return {
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  { -- Keep relative line numbers from 1->5
    'mluders/comfy-line-numbers.nvim',
    opts = {},
  },
  { -- Extended webicons
    'nvim-tree/nvim-web-devicons',
    opts = {},
  },
  { -- Autocompletion for html tags
    'windwp/nvim-ts-autotag',
  },
  { -- Handles seamless navigation between tmux panes and neovim buffers
    'christoomey/vim-tmux-navigator',
    event = 'VeryLazy',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  { -- Fixes indentation sillyness
    'tpope/vim-sleuth',
  },
  { -- Utility tool for showing scope context on the end of scope line
    'code-biscuits/nvim-biscuits',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      toggle_keybind = '<leader>tb',
      cursor_line_only = true,
      show_on_start = true,
      default_config = {
        prefix_string = '? ',
      },
    },
  },
}
