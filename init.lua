-- Set <space> as the leader key
-- See `:help mapleader`
--   NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--   For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Update numbers dynamically when moving the cursor
vim.api.nvim_create_autocmd('CursorMoved', {
   pattern = '*',
   callback = function()
      vim.opt.relativenumber = true
      vim.opt.number = true
   end,
})

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--   Schedule the setting after `UiEnter` because it can increase startup-time.
--   Remove this option if you want your OS clipboard to remain independent.
--   See `:help 'clipboard'`
vim.schedule(function()
   vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = false

-- Indent settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--   See `:help 'list'`
--   and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 3

--   See `:help vim.keymap.set()`
-- Clear highlights on search when pressing <Esc> in normal mode
--   See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Disable netrw
vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = false

-- Useful Keymaps
vim.keymap.set('n', '<leader>e', '<cmd>Neotree focus current<CR>', { desc = 'Open explorer' })
vim.keymap.set('n', '<leader>t', '<cmd>te<CR>i', { desc = 'Open terminal in current buffer' })
vim.keymap.set('n', '<leader>T', '<cmd>split | terminal<CR>i', { desc = 'Open terminal in new split' })
vim.keymap.set('n', '<leader>O', '<cmd>vsplit<CR><cmd>split | terminal<CR><C-w><C-h>',
   { desc = 'Create simple workspace' })
vim.keymap.set('n', '<leader>R', function()
   local from = vim.fn.input 'Replace pattern: '
   local to = vim.fn.input 'With: '
   vim.cmd(string.format('%%s/%s/%s/g', from, to))
end, { noremap = true, silent = true, desc = 'Replace all occurences of pattern' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--   Use CTRL+<hjkl> to switch between windows
--
--   See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--   See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--   Try it with `yap` in normal mode
--   See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
   desc = 'Highlight when yanking (copying) text',
   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
   callback = function()
      vim.hl.on_yank()
   end,
})

-- LSP (Lua)
vim.lsp.config['lua-ls'] = {
   cmd = { 'lua-language-server' },
   root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
   filetypes = { 'lua' },

   settings = {
      Lua = {
         diagnostics = {
            globals = { 'vim' }
         },

         runtime = {
            version = 'LuaJIT',
         }
      }
   }
}
vim.lsp.enable('lua-ls')

-- LSP (Java)
vim.lsp.config['jdtls'] = {
   cmd = { "jdtls", "-configuration", "/home/runner/.cache/jdtls/config", "-data", "/home/runner/.cache/jdtls/workspace" },
   filetypes = { 'java' },
   root_markers = { ".git", "build.gradle", "build.gradle.kts", "build.xml", "pom.xml", "settings.gradle", "settings.gradle.kts" },
   handlers = {},
   settings = {},
}
vim.lsp.enable('jdtls')

-- [[ Install `lazy.nvim` plugin manager ]]
--      See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
   local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
   if vim.v.shell_error ~= 0 then
      error('Error cloning lazy.nvim:\n' .. out)
   end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--   To check the current status of your plugins, run
--      :Lazy
--
--   You can press `?` in this menu for help. Use `:q` to close the window
--
--   To update plugins you can run
--      :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
      'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

      { -- Downloads mason
         "mason-org/mason.nvim",
         opts = {}
      },

      { -- Adds git related signs to the gutter, as well as utilities for managing changes
         'lewis6991/gitsigns.nvim',
         opts = {
            signs = {
               add = { text = '+' },
               change = { text = '~' },
               delete = { text = '_' },
               topdelete = { text = '‾' },
               changedelete = { text = '~' },
            },
         },
      },

      -- Java LSP setup
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-jdtls',

      {                      -- Useful plugin to show you pending keybinds.
         'folke/which-key.nvim',
         event = 'VimEnter', -- Sets the loading event to 'VimEnter'
         opts = {
            -- delay between pressing a key and opening which-key (milliseconds)
            -- this setting is independent of vim.opt.timeoutlen
            delay = 0,
            icons = {
               -- set icon mappings to true if you have a Nerd Font
               mappings = vim.g.have_nerd_font,
               -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
               -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
               keys = vim.g.have_nerd_font and {} or {
                  Up = '<Up> ',
                  Down = '<Down> ',
                  Left = '<Left> ',
                  Right = '<Right> ',
                  C = '<C-…> ',
                  M = '<M-…> ',
                  D = '<D-…> ',
                  S = '<S-…> ',
                  CR = '<CR> ',
                  Esc = '<Esc> ',
                  ScrollWheelDown = '<ScrollWheelDown> ',
                  ScrollWheelUp = '<ScrollWheelUp> ',
                  NL = '<NL> ',
                  BS = '<BS> ',
                  Space = '<Space> ',
                  Tab = '<Tab> ',
                  F1 = '<F1>',
                  F2 = '<F2>',
                  F3 = '<F3>',
                  F4 = '<F4>',
                  F5 = '<F5>',
                  F6 = '<F6>',
                  F7 = '<F7>',
                  F8 = '<F8>',
                  F9 = '<F9>',
                  F10 = '<F10>',
                  F11 = '<F11>',
                  F12 = '<F12>',
               },
            },

            -- Document existing key chains
            spec = {
               { '<leader>c', group = '[C]ode',     mode = { 'n', 'x' } },
               { '<leader>d', group = '[D]ocument' },
               { '<leader>r', group = '[R]ename' },
               { '<leader>s', group = '[S]earch' },
               { '<leader>w', group = '[W]orkspace' },
               { '<leader>t', group = '[T]oggle' },
               { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
            },
         },
      },

      -- NOTE: Plugins can specify dependencies.
      --
      -- The dependencies are proper plugin specifications as well - anything
      -- you do for a plugin at the top level, you can do for a dependency.
      --
      -- Use the `dependencies` key to specify the dependencies of a particular plugin

      { -- Autoformat
         'stevearc/conform.nvim',
         event = { 'BufWritePre' },
         cmd = { 'ConformInfo' },
         keys = {
            {
               '<leader>f',
               function()
                  require('conform').format { async = true, lsp_format = 'fallback' }
               end,
               mode = '',
               desc = '[F]ormat buffer',
            },
         },
         opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
               -- Disable "format_on_save lsp_fallback" for languages that don't
               -- have a well standardized coding style. You can add additional
               -- languages here or re-enable it for the disabled ones.
               local disable_filetypes = { c = true, cpp = true }
               local lsp_format_opt
               if disable_filetypes[vim.bo[bufnr].filetype] then
                  lsp_format_opt = 'never'
               else
                  lsp_format_opt = 'fallback'
               end
               return {
                  timeout_ms = 500,
                  lsp_format = lsp_format_opt,
               }
            end,
            formatters_by_ft = {
               -- NOTE: Add formatters here
               lua = { 'stylua' },
               python = { 'isort' },
               javascript = { 'prettierd' },
            },
         },
      },

      -- Color Scheme
      {
         'Shatur/neovim-ayu',
         priority = 1000, -- Make sure to load this before all the other start plugins.
         init = function()
            -- Load the colorscheme here.
            -- Transparent background

            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme 'ayu-dark'

            -- Transparent background
            vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', blend = 10 })
            vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none', blend = 10 })
            vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none', blend = 10 })
            vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none', blend = 10 })

            -- Line number colors
            vim.api.nvim_set_hl(0, 'LineNr', { fg = '#FF5757', bg = 'none', italic = true })
            vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FFA98A', italic = true, bold = true })

            -- Changes highlighting color (visual mode)
            vim.api.nvim_set_hl(0, 'Visual', { bg = '#7a2b2b' })
         end,
      },

      -- Highlight todo, notes, etc in comments
      { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

      { -- Collection of various small independent plugins/modules
         'echasnovski/mini.nvim',
         config = function()
            -- Simple and easy statusline.
            --   You could remove this setup call if you don't like it,
            --   and try some other statusline plugin
            local statusline = require 'mini.statusline'
            -- set use_icons to true if you have a Nerd Font
            statusline.setup { use_icons = vim.g.have_nerd_font }

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we set the section for
            -- cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
               return '%2l:%-2v'
            end

            -- ... and there is more!
            --   Check out: https://github.com/echasnovski/mini.nvim
         end,
      },
      { -- Highlight, edit, and navigate code
         'nvim-treesitter/nvim-treesitter',
         build = ':TSUpdate',
         main = 'nvim-treesitter.configs', -- Sets main module to use for opts
         -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
         opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'java', },
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


      -- require 'kickstart.plugins.debug',
      --require 'kickstart.plugins.indent_line',
      require 'kickstart.plugins.lint',
      require 'kickstart.plugins.autopairs',
      require 'kickstart.plugins.neo-tree',
      -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

      --   Custom plugins
      { import = 'custom.plugins' },
   },
   {
      ui = {
         -- If you are using a Nerd Font: set icons to an empty table which will use the
         -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
         icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
         },
      },

      -- Open in Neotree if initialized in current directory (rather than file)
      vim.api.nvim_create_autocmd("VimEnter", {
         callback = function()
            local arg = vim.fn.argv(0)
            if arg == '.' then
               vim.cmd('Neotree focus current')
            end
         end
      })
   })
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=3 sts=3 sw=3 et
