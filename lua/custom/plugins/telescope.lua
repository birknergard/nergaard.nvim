return {
   {
      'nvim-telescope/telescope.nvim', tag = '0.1.8', branch = '0.1.x',
      dependencies = {
         'nvim-lua/plenary.nvim', 
         {
         'nvim-telescope/telescope-fzf-native.nvim', 
         build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' 
         }
      },
      config = function()
         -- Find files in current dir (./)
         vim.keymap.set('n', '<space>fd', require('telescope.builtin').find_files)

         -- Find files in neovim config
         vim.keymap.set('n', '<space>en', function()
            require('telescope.builtin').find_files {
               cwd = vim.fn.stdpath("config") 
            }
         end)

      end
   }
}
