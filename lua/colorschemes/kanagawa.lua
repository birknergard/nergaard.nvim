return {
  'rebelot/kanagawa.nvim',
  opts = {
    compile = false, -- enable compiling the colorscheme
    undercurl = false, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = { -- add/modify theme and palette colors
      palette = {},
      theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
      return {
        Normal = { bg = 'none' },
        NormalFloat = { bg = 'none' },
        Pmenu = { bg = 'none' },
        FloatBorder = { bg = 'none' },
        NormalNC = { bg = 'none' },
        EndOfBuffer = { bg = 'none' },
        SignColumn = { bg = 'none' },
        FidgetTitle = { bg = 'none' },
        FidgetTask = { bg = 'none' },
        TelescopeTitle = { bg = 'none' },
        TelescopeBorder = { bg = 'none' },
        TelescopePromptBorder = { bg = 'none' },
        BlinkCmpMenu = { bg = 'none' },
        BlinkCmpMenuBorder = { bg = 'none' },
        LineNr = { fg = '#53555e', bg = 'none', italic = false, bold = false },
        YankHighlightColor = {
          bg = '#ff8074',
          fg = '#ffffff', -- text
          bold = true,
        },
      }
    end,
    theme = 'wave', -- Load "wave" theme
    background = { -- map the value of 'background' option to a theme
      dark = 'wave', -- try "dragon" !
      light = 'lotus',
    },
  },
}
