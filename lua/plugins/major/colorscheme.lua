return { -- Color Schemes
  'birknergard/neovim-ayu',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('ayu').setup {
      mirage = true, -- Optional: set to true to use the mirage theme variant
      overrides = {
        -- Transparent background settings
        Normal = { bg = 'none' },
        NormalNC = { bg = 'none' },
        EndOfBuffer = { bg = 'none' },
        SignColumn = { bg = 'none' },
        FidgetTitle = { bg = 'none' },
        FidgetTask = { bg = 'none' },

        -- Remove black line in split center
        VertSplit = { bg = 'none', fg = 'none' },

        -- Line number colors
        LineNr = { fg = '#FF5757', bg = 'none', italic = false, bold = false },
        CursorLineNr = { fg = '#FF598A', italic = false, bold = true },

        -- Changes highlighting color (visual mode)
        Visual = { bg = '#7A2B2B' },

        -- Configure BlinkCmp appearance
        BlinkCmpMenu = { bg = '#0F1419' },
        BlinkCmpMenuSelection = { bg = '#7A2B2B' },

        -- Yank highlight
        YankHighlight = {
          bg = '#f07178',
          fg = '#ffffff', -- text
          bold = true,
        },
        ['@lsp.type.method.java'] = { fg = '#F07178' },
      },
    }
    vim.cmd.colorscheme 'ayu-dark'
  end,
}
