return { -- Highlight, edit, and navigate code
  --{
  --  'romus204/tree-sitter-manager.nvim',
  --  dependencies = {}, -- tree-sitter CLI must be installed system-wide
  --  config = function()
  --    require('tree-sitter-manager').setup {
  --      -- Default Options
  --      ensure_installed = {
  --        'markdown',
  --        'rust',
  --        'typescript',
  --        'javascript',
  --        'c-sharp',
  --        'lua',
  --      }, -- list of parsers to install at the start of a neovim session
  --      border = 'rounded', -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
  --      auto_install = true, -- if enabled, install missing parsers when editing a new file
  --      highlight = true, -- treesitter highlighting is enabled by default
  --      -- languages = {}, -- override or add new parser sources
  --      -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
  --      -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
  --    }
  --  end,
  --},
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    opts = {
      ensure_installed = { 'rust' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --   If you are experiencing weird indenting issues, add the language to
        --   the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --      - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --      - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --      - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  -- {
  --   'nvim-treesitter/nvim-treesitter-context',
  -- },
}
