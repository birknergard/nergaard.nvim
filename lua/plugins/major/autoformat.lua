return { -- Autoformat
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
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      xml = { 'prettierd' },
      java = { 'google_java_format' },
      cpp = { 'clang_format' },
      c = { 'clang_format' },
    },
    formatters = {
      google_java_format = {
        command = 'google-java-format',
        args = { '-' },
        stdin = true,
      },
      clangd_format = {
        command = 'clang_format',
        args = { '--assume-filename', 'temp.cpp' },
        stdin = true,
      },
    },
  },
}
