vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank {
      higroup = 'YankHighlightColor',
      timeout = 150,
      on_visual = true,
    }
  end,
})

require('nvim-ts-autotag').setup {
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true,
  },
}

-- Disable relative line numbers when in insert mode
local augroup = vim.api.nvim_create_augroup('numbertoggle', {})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  pattern = '*',
  group = augroup,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  pattern = '*',
  group = augroup,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
      -- Workaround for https://github.com/neovim/neovim/issues/32068
      if not vim.tbl_contains({ '@', '-' }, vim.v.event.cmdtype) then
        vim.cmd 'redraw'
      end
    end
  end,
})
