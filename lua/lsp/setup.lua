local on_attach = function() end

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = {
    severity = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.HINT,
    },
  },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = false,
  -- {
  -- source = 'if_many',
  -- spacing = 2,
  -- format = function(diagnostic)
  --   local diagnostic_message = {
  --     [vim.diagnostic.severity.ERROR] = diagnostic.message,
  --     [vim.diagnostic.severity.WARN] = diagnostic.message,
  --     [vim.diagnostic.severity.INFO] = diagnostic.message,
  --     [vim.diagnostic.severity.HINT] = diagnostic.message,
  --   }
  --   return diagnostic_message[diagnostic.severity]
  -- end,
}

-- local lfs = require 'lfs'
local server_config_path = 'lsp.servers'
local capabilities = require('blink.cmp').get_lsp_capabilities()

local servers = (function()
  local lua_suffix = '.lua'
  local servers = {}

  local config_path = vim.fn.stdpath 'config'
  local i = 1
  for file in vim.fs.dir(config_path .. '/lua/lsp/servers', {}) do
    if file:sub(-#lua_suffix) == lua_suffix then
      local filename = file:sub(1, #file - #lua_suffix)
      servers[i] = filename
    end
    i = i + 1
  end

  return servers
end)()

for _, server in ipairs(servers) do
  local config = require(server_config_path .. '.' .. server)
  config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
  vim.lsp.config[server] = config

  -- LSP SPECIFIC KEYMAPS
  vim.keymap.set('n', '<leader>i', function()
    vim.lsp.buf.hover(config)
  end, { desc = 'LSP: Hover info' })
end

vim.lsp.enable(servers)
