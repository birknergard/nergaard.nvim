return {
  { -- Java LSP setup
    'mfussenegger/nvim-jdtls',
  },
  { -- TS/JS LSP setup
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
}
