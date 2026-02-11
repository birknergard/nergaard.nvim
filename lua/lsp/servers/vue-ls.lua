return {
  -- add filetypes for typescript, javascript and vue
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  init_options = {
    typescript = {
      tsdk = '',
    },
  },
  name = 'vue_ls',
  root_markers = { 'package.json' },
  config = {},
}
