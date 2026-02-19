return {
  --{ -- Useful status updates for LSP.
  --  'j-hui/fidget.nvim',
  --  opts = {
  --    notification = {
  --      window = {
  --        winblend = 0,    -- transparency (0 = opaque)
  --        border = 'none', -- 'single', 'double', 'none', etc.
  --      },
  --    },
  --  },
  --},
  { -- Mason for managing (most) lsp servers
    'mason-org/mason.nvim',
    opts = {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
      },
    },
  },
  { -- Allows extra capabilities provided by blink.cmp
    'saghen/blink.cmp',
    build = 'cargo build --release',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      signature = { enabled = true },
      fuzzy = { implementation = 'lua' },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
        },
        menu = {
          enabled = true,
          min_width = 15,
          max_height = 30,
          border = nil, -- Defaults to `vim.o.winborder` on nvim 0.11+
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
          -- Keep the cursor X lines away from the top/bottom of the window
          scrolloff = 2,
          -- Note that the gutter will be disabled when border ~= 'none'
          scrollbar = false,
          -- Which directions to show the window,
          -- falling back to the next direction when there's not enough space
          direction_priority = { 's', 'n' },
          -- Can accept a function if you need more control
          -- direction_priority = function()
          --   if condition then return { 'n', 's' } end
          --   return { 's', 'n' }
          -- end,

          -- Whether to automatically show the window when new completion items are available
          auto_show = true,

          -- Screen coordinates of the command line
          cmdline_position = function()
            if vim.g.ui_cmdline_pos ~= nil then
              local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
              return { pos[1] - 1, pos[2] }
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
          end,
        },
      },
    },
  },

  -- Load JDTLS plugin, because java
  'mfussenegger/nvim-jdtls',

  { -- Roslyn lsp for C# development
    'seblyng/roslyn.nvim',
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
}
