return {
  'birknergard/neovim-ayu',
  priority = 1000, -- Lazy load late
  config = function()
    local custom_colors = {
      yellow = '#E5B351',
      red = '#F07178',
      redb = '#ff8074',
      magenta = '#D1A4FF',
      gray = '#53555e',
    }
    require('ayu').setup {
      mirage = false, -- Optional: set to true to use the mirage theme variant
      overrides = {
        -- Transparent background settings
        Normal = { fg = '#bfbdb6', bg = 'none' },
        NormalFloat = { fg = '#bfbdb6', bg = 'none' },
        Pmenu = { bg = 'none' },
        FloatBorder = { bg = 'none' },
        NormalNC = { bg = 'none' },
        EndOfBuffer = { bg = 'none' },
        SignColumn = { bg = 'none' },
        FidgetTitle = { bg = 'none' },
        FidgetTask = { bg = 'none' },
        BlinkCmpMenu = { bg = 'none' },
        TelescopeTitle = { fg = custom_colors.red },
        TelescopeBorder = { fg = custom_colors.gray },
        TelescopePromptBorder = { fg = custom_colors.gray },
        TelescopeSelection = { fg = '#ffffff', bg = custom_colors.redb },
        -- Line number colors
        LineNr = { fg = '#53555e', bg = 'none', italic = false, bold = false },
        BiscuitColor = { bg = "none", fg = "#53555e" },
        -- Changes highlighting color (visual mode)
        Visual = { bg = '#7A2B2B' },

        -- Configure BlinkCmp appearance
        BlinkCmpMenuSelection = { bg = '#7A2B2B' },

        -- Yank highlight
        YankHighlightColor = {
          bg = '#ff8074',
          fg = '#ffffff', -- text
          bold = true,
        },
        ['@lsp.type.method.java'] = { fg = '#F07178' },
        ['@function.declaration'] = { fg = '#FF8721' },

        TreesitterContext = {
          fg = '#ff8074',
          bg = '#10151d',
        },
      },
      ui = {
        icons = vim.g.have_nerd_font and {},
      },
    }
  end,
}
