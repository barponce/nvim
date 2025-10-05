return {
   'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
          options = {
              theme = 'auto',
              component_separators = { left = '|', right = '|'},
              section_separators = { left = '', right = ''},
              globalstatus = true, -- Single statusline for all windows
          },
          sections = {
              lualine_a = {'mode'},
              lualine_b = {'branch', 'diff', 'diagnostics'},
              lualine_c = {
                  {
                      'filename',
                      path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                      symbols = {
                          modified = ' [+]',
                          readonly = ' []',
                          unnamed = '[No Name]',
                      }
                  }
              },
              lualine_x = {'encoding', 'fileformat', 'filetype'},
              lualine_y = {'progress'},
              lualine_z = {'location'}
          },
          inactive_sections = {
              lualine_a = {},
              lualine_b = {},
              lualine_c = {'filename'},
              lualine_x = {'location'},
              lualine_y = {},
              lualine_z = {}
          },
      })
    end
}
