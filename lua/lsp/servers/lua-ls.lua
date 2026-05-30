return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { 'luarc.json', 'luarc.jsonc', '.luarc.json' }, '.git' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = { vim.api.nvim_get_runtime_file('', true), '/usr/share/hypr/stubs' }, -- index Neovim runtime
        checkThirdParty = false, -- optional, avoids prompts
      },
      telemetry = { enable = false },
    },
  },
}
