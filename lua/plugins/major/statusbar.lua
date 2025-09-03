return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    local ayu = require 'lualine.themes.ayu'

    -- Save default Ayu background (used in a/z)
    local default_bg = ayu.normal.a.bg
    local default_fg = ayu.normal.a.fg

    -- Make all sections except 'a' and 'z' transparent in active modes
    for _, mode in pairs(ayu) do
      for _, section in ipairs { 'b', 'c', 'x', 'y' } do
        if mode[section] then
          mode[section].bg = 'none'
        end
      end
    end

    -- Transparent inactive windows (all sections)
    ayu.inactive.a.bg = 'none'
    ayu.inactive.b.bg = 'none'
    ayu.inactive.c.bg = 'none'

    -- Optional: dim inactive fg
    ayu.inactive.a.fg = '#666666'
    ayu.inactive.b.fg = '#666666'
    ayu.inactive.c.fg = '#666666'

    -- Restore 'z' background to default (in case your theme has changed it)
    for _, mode in pairs(ayu) do
      if mode.z then
        mode.z.bg = default_bg
        mode.z.fg = default_fg
      end
    end

    -- Setup lualine with custom theme
    require('lualine').setup {
      options = {
        theme = ayu,
      },
    }

    -- Override global highlights to ensure transparency works
    vim.cmd [[
        hi StatusLine guibg=NONE ctermbg=NONE
        hi StatusLineNC guibg=NONE ctermbg=NONE
      ]]
  end,
}
