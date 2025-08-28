return {
  cmd = { 'sourcekit-lsp' },
  filetypes = { 'swift', 'objc', 'objcpp', 'c', 'cpp' },
  root_dir = function(fname)
    return require('lspconfig.util').root_pattern('Package.swift', '.git', 'BuildServer.json')(fname) or vim.loop.cwd()
  end,
}
