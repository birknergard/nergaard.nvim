return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'add file to harpoon list' })

    vim.keymap.set('n', '<leader>st', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'open harpoon quick menu' })

    -- Map harpoon index 1 to 9
    -- TODO: Get mark name in preview instead of index
    local list = harpoon:list()
    -- List of lower row
    local keymaps = { 'z', 'x', 'c', 'v', 'b' }
    for i = 1, #keymaps do
      vim.keymap.set('n', '<leader>' .. keymaps[i], function()
        harpoon:list():select(i)
      end, { desc = 'saved buffer {' .. i .. '}' })
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>j', function()
      harpoon:list():next()
    end, { desc = 'go to next harpoon buffer' })

    vim.keymap.set('n', '<leader>k', function()
      harpoon:list():prev()
    end, { desc = 'go to previous harpoon buffer' })
  end,
  opts = {},
}
