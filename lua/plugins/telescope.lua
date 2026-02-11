return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Undo tree
    { 'debugloop/telescope-undo.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case', -- or '--ignore-case'
        },
        sorting_strategy = 'ascending', -- results grow downward from the top
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            mirror = false,
            prompt_position = 'top', -- or "bottom"
            width = 0.8, -- relative width
            height = 0.8, -- relative height
            preview_width = 0.5, -- relative width of preview window
          },
        },
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          },
        },
      },
      pickers = {
        find_files = {
          theme = 'ivy',
          hidden = true,
        },

        live_grep = {},

        man_pages = {
          sections = { 'ALL' },
          theme = 'dropdown',
          preview = false,
        },

        help_tags = {},

        current_buffer_fuzzy_find = {
          theme = 'dropdown',
          preview = true,
        },
      },

      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
          require('telescope.themes').get_ivy(),
        },
        fzf = {},
        undo = {},
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'undo')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'

    -- Shortcut for opening main telescope menu
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })

    -- Shortcut for general file navigation
    vim.keymap.set('n', '<leader>sf', function()
      builtin.find_files {}
    end, { desc = '[S]earch [F]iles' })

    vim.keymap.set('n', '<leader>so', function()
      builtin.find_files {
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            local file = action_state.get_selected_entry()
            local cwd = vim.fn.getcwd() .. '/'
            vim.cmd 'stopinsert'
            vim.cmd('vsplit ' .. cwd .. file.value .. '()')
          end)
          return true
        end,
      }
    end, { desc = '[S]earch then [O]pen [F]ile in Split' })

    -- Shortcut for searching subdir by grep
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })

    vim.keymap.set('n', '<leader>q', builtin.quickfix, { desc = 'Open [Q]uickfix List' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files {
        cwd = vim.fn.stdpath 'config',
      }
    end, { desc = '[S]earch [N]eovim Files' })

    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

    -- Shortcut for browsing help pages
    vim.keymap.set('n', '<leader>sh', function()
      builtin.help_tags {
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            local selected = action_state.get_selected_entry()
            vim.cmd 'stopinsert'
            vim.cmd('vert help ' .. selected.value)
          end)
          return true
        end,
      }
    end, { desc = '[S]earch [H]elp' })

    -- Shortcut for browsing man pages
    vim.keymap.set('n', '<leader>sm', function()
      builtin.man_pages {
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            local selected = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            vim.cmd 'stopinsert'
            vim.cmd('vert Man ' .. selected.section .. ' ' .. selected.value)
          end)
          return true
        end,
      }
    end, { desc = '[S]earch [M]anual Pages' })

    vim.keymap.set('n', '<leader>sy', builtin.highlights, { desc = '[S]earch [H]ighlight Groups' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>s/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find {
        previewer = false,
        theme = 'dropdown',
      }
    end, { desc = '[/] Fuzzily search in current buffer' })
  end,
}
