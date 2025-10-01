local M = {}

-- Available themes with their background settings
M.themes = {
  {
    name = "solarized-light",
    colorscheme = "solarized",
    background = "light"
  },
  {
    name = "solarized-dark",
    colorscheme = "solarized",
    background = "dark"
  },
  {
    name = "gruvbox",
    colorscheme = "gruvbox",
    background = "dark"
  }
}

-- Current theme index (starts with solarized-light)
M.current_theme_index = 3

-- Set default theme (gruvbox)
M.set_theme = function(theme)
  vim.o.background = theme.background
  vim.cmd.colorscheme(theme.colorscheme)

  -- Reapply diagnostic highlights after colorscheme loads
  vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { bg = '#3f2d3d', fg = '#f38ba8' })
  vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { bg = '#3d3830', fg = '#f9e2af' })
  vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { bg = '#2d3640', fg = '#89dceb' })
  vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { bg = '#2d3640', fg = '#89b4fa' })

  print("Theme set to: " .. theme.name)
end

-- Cycle to next theme
M.next_theme = function()
  M.current_theme_index = M.current_theme_index + 1
  if M.current_theme_index > #M.themes then
    M.current_theme_index = 1
  end
  M.set_theme(M.themes[M.current_theme_index])
end

-- Cycle to previous theme
M.prev_theme = function()
  M.current_theme_index = M.current_theme_index - 1
  if M.current_theme_index < 1 then
    M.current_theme_index = #M.themes
  end
  M.set_theme(M.themes[M.current_theme_index])
end

-- Show theme picker using vim.ui.select
M.pick_theme = function()
  local theme_names = {}
  for i, theme in ipairs(M.themes) do
    theme_names[i] = theme.name
  end

  vim.ui.select(theme_names, {
    prompt = "Select theme:",
    format_item = function(item)
      return item
    end,
  }, function(choice, idx)
    if choice then
      M.current_theme_index = idx
      M.set_theme(M.themes[idx])
    end
  end)
end

-- Initialize with default theme
M.init = function()
  M.set_theme(M.themes[M.current_theme_index])
end

return M
