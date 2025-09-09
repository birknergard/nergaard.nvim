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
  { -- For seamless tmux/nvim split navigation
    'christoomey/vim-tmux-navigator',
  },
  { -- Fixes indentation sillyness
    'tpope/vim-sleuth',
  },
}
