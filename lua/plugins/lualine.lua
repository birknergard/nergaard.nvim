return {
  { -- Harpoon module for luanline
    'letieu/harpoon-lualine',
    dependencies = {
      {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      -- custom theme
      local colors = {
        black = '#0f1419',
        orange = '#ff8e42',
        beige = '#ffee99',
        white = '#e6e1cf',
        green = '#b8cc52',
        blue = '#36a3d9',
        red = '#f07178',
        gray = '#3e4b59',
      }

      local theme = {
        normal = {
          a = { fg = colors.blue, bg = 'none' },
          b = { fg = colors.blue, bg = 'none' },
          c = { fg = colors.white, bg = 'none' },
          x = { fg = colors.gray, bg = 'none' },
          z = { fg = colors.white, bg = 'none' },
        },
        insert = {
          a = { fg = colors.green, bg = 'none' },
          b = { fg = colors.green, bg = 'none' },
          c = { fg = colors.white, bg = 'none' },
          x = { fg = colors.gray, bg = 'none' },
          z = { fg = colors.white, bg = 'none' },
        },
        visual = {
          a = { fg = colors.beige, bg = 'none' },
          b = { fg = colors.beige, bg = 'none' },
          c = { fg = colors.white, bg = 'none' },
          x = { fg = colors.gray, bg = 'none' },
          z = { fg = colors.white, bg = 'none' },
        },
        replace = {
          a = { fg = colors.red, bg = 'none' },
          b = { fg = colors.red, bg = 'none' },
          c = { fg = colors.white, bg = 'none' },
          x = { fg = colors.gray, bg = 'none' },
          z = { fg = colors.white, bg = 'none' },
        },
        command = {
          a = { fg = colors.orange, bg = 'none' },
          b = { fg = colors.orange, bg = 'none' },
          c = { fg = colors.white, bg = 'none' },
          x = { fg = colors.gray, bg = 'none' },
          z = { fg = colors.white, bg = 'none' },
        },
        inactive = {
          a = { fg = colors.gray, bg = 'none' },
          b = { fg = colors.gray, bg = 'none' },
          c = { fg = colors.gray, bg = 'none' },
        },
      }

      local function get_harpoon_indicator(harpoon_entry)
        return harpoon_entry.value
      end

      -- Setup lualine with custom theme
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = theme,
          component_separators = { left = '', right = '-' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = { 'neo-tree', 'Outline', 'packer' },
            winbar = { 'neo-tree', 'Outline', 'packer' },
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = true,
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
          lualine_a = {
            {
              'mode',
              padding = { left = 0.5, right = 1 },
              fmt = function(str)
                return string.upper(str)
              end,
            },
          },
          lualine_b = {
            {
              'branch',
              icons_enabled = true,
              icon = '',
              padding = { left = 0.5, right = 0 },
              fmt = function(str)
                return str
              end,
            },
          },
          lualine_c = {
            {
              'harpoon2',
              indicators = { ' z ', ' x ', ' c ', ' v ', ' b ' },
              active_indicators = { '[z]', '[x]', '[c]', '[v]', '[b]' },
              color_active = { fg = colors.red },
              _separator = '',
              icon = '󱡅',
              icons_enabled = false,
              fmt = function(str)
                return str
              end,
            },
          },
          lualine_x = {
            { 'lsp_status', icons_enabled = false, color = { fg = colors.orange } },
          },
          lualine_y = { 'diagnostics' },
          lualine_z = {
            { 'location', padding = 0 },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },

        tabline = {
          lualine_a = {
            {
              'filename',
              padding = { left = 1, right = 0 },
              path = 1,
              color = { fg = colors.green },
              -- icon = '',
              symbols = {
                modified = '[edited]', -- Text to show when the file is modified.
                readonly = '[readonly]', -- Text to show when the file is non-modifiable or readonly.
                unnamed = '[empty]', -- Text to show for unnamed buffers.
                newfile = '[new file]', -- Text to show for newly created file before first write
              },
              fmt = function(str)
                return '  ' .. str
              end,
            },
          },

          lualine_b = {
            {
              'diff',
              color = { fg = colors.white },
              fmt = function(str)
                return str
              end,
            },
          },
          lualine_c = {},
          lualine_x = {
            { 'searchcount', color = { fg = colors.orange } },
          },
          lualine_y = {
            {
              'filetype',
              padding = 0,
              icons_enabled = true,
              icon = { align = 'right' },
              color = { fg = colors.white },
            },
          },
          lualine_z = {
            {
              'progress',
              color = { fg = colors.blue },
            },
          },
        },

        winbar = {},
        inactive_winbar = {},
        extensions = { 'oil', 'lazy', 'mason', 'quickfix' },
      }

      -- Override global highlights to ensure transparency works fir statusline
      vim.cmd [[
        hi StatusLine guibg=NONE ctermbg=NONE
        hi StatusLineNC guibg=NONE ctermbg=NONE
        hi TabLine guibg=NONE ctermbg=NONE
        hi TabLineSel guibg=NONE ctermbg=NONE
        hi TabLineFill guibg=NONE ctermbg=NONE
      ]]
    end,
  },
}
