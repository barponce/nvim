return {
  'maxmx03/solarized.nvim',
  name = "solarized-maxmx03",
  lazy = false,
  priority = 1000,
  ---@type solarized.config
  opts = {},
  config = function(_, opts)
    vim.o.termguicolors = true
    require('solarized').setup(opts)
  end,
}
