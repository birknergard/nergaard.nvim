return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    local ayu = require 'lualine.themes.ayu'

    -- Save original colors of section a for all modes
    for mode_name, mode in pairs(ayu) do
      if mode.a then
        local original_bg = mode.a.bg
        mode.a.fg = original_bg -- use bg color as fg
        mode.a.bg = 'none' -- transparent background
      end
    end

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

    -- Setup lualine with custom theme
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = ayu,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'neo-tree', 'Outline', 'packer' },
          winbar = { 'neo-tree', 'Outline', 'packer' },
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16, -- ~60fps
          events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
          },
        },
      },
      sections = {
        lualine_a = { 'mode', 'branch' },
        lualine_b = { 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }

    -- Override global highlights to ensure transparency works fir statusline
    vim.cmd [[
        hi StatusLine guibg=NONE ctermbg=NONE
        hi StatusLineNC guibg=NONE ctermbg=NONE
      ]]
  end,
}
