return {
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { -- Useful status updates for LSP.
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = {
              winblend = 0, -- transparency (0 = opaque)
              border = 'none', -- 'single', 'double', 'none', etc.
            },
          },
        },
      },
      { -- Neovim autocomplete and annotations
        'folke/lazydev.nvim',
        opts = {},
      },
      { -- Allows extra capabilities provided by blink.cmp
        'saghen/blink.cmp',
        build = 'cargo build --release',
        dependencies = 'rafamadriz/friendly-snippets',
        version = 'v0.*',
        opts = {
          keymap = { preset = 'default' },
          appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
          },
          signature = { enabled = true },
          fuzzy = { implementation = 'prefer_rust_with_warning' },
          completion = {
            documentation = {
              auto_show = true,
              auto_show_delay_ms = 300,
            },
            menu = {
              enabled = true,
              min_width = 15,
              max_height = 10,
              border = nil, -- Defaults to `vim.o.winborder` on nvim 0.11+
              winblend = 0,
              winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
              -- Keep the cursor X lines away from the top/bottom of the window
              scrolloff = 2,
              -- Note that the gutter will be disabled when border ~= 'none'
              scrollbar = true,
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
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Load servers
      local servers = {
        eslint = require 'plugins.major.lsp.servers.eslint',
        pyright = require 'plugins.major.lsp.servers.pyright',
        vue_ls = require 'plugins.major.lsp.servers.vue-ls',
        tailwindcss = require 'plugins.major.lsp.servers.tailwindcss',
        html = require 'plugins.major.lsp.servers.html',
        lua_ls = require 'plugins.major.lsp.servers.lua-ls',
        --sourcekit = require 'plugins.major.lsp.servers.sourcekit',
        clang = require 'plugins.major.lsp.servers.clang',
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- for Lua code
        'prettierd', -- for Typescript/javascript
        'google-java-format', -- for Java
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- Already checked
        automatic_enable = true,
        automatic_install = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- Manually set up sourcekit
      require('lspconfig').sourcekit.setup {
        cmd = { 'sourcekit-lsp' },
        filetypes = { 'swift' },
        root_dir = function(fname)
          return require('lspconfig').util.root_pattern('Package.swift', '.git', 'BuildServer.json')(fname) or vim.loop.cwd()
        end,
        capabilities = capabilities,
      }
    end,
  },

  -- Installing of extra plugins
  require 'plugins.major.lsp.extra',
}
