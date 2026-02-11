vim.api.nvim_set_hl(0, 'SnacksIndent', { link = 'LineNr' })
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      enabled = true,
      char = '│',
      only_scope = false,
      only_current = false,
      hl = 'Comment',
      priority = 1,
      scope = { enabled = false },
    },
  },
}
