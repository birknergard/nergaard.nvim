return {
  cmd = { 'pylyzer', '--server' },
  cmd_env = {
    ERG_PATH = '/home/runner/.erg',
  },
  filetypes = { 'python' },
  root_markers = { 'setup.py', 'tox.ini', 'requirements.txt', 'Pipfile', 'pyproject.toml', '.git' },
  settings = {
    python = {
      checkOnType = false,
      diagnostics = true,
      inlayHints = true,
      smartCompletion = true,
    },
  },
}
