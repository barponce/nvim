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
  },
  {
    name = "kanagawa-wave",
    colorscheme = "kanagawa-wave",
    background = "dark"
  },
  {
    name = "kanagawa-dragon",
    colorscheme = "kanagawa-dragon",
    background = "dark"
  },
  {
    name = "kanagawa-lotus",
    colorscheme = "kanagawa-lotus",
    background = "light"
  },
  {
    name = "everforest-dark-hard",
    colorscheme = "everforest",
    background = "dark",
    setup = function()
      vim.g.everforest_background = 'hard'
    end
  },
  {
    name = "everforest-dark-medium",
    colorscheme = "everforest",
    background = "dark",
    setup = function()
      vim.g.everforest_background = 'medium'
    end
  },
  {
    name = "everforest-dark-soft",
    colorscheme = "everforest",
    background = "dark",
    setup = function()
      vim.g.everforest_background = 'soft'
    end
  },
  {
    name = "everforest-light-hard",
    colorscheme = "everforest",
    background = "light",
    setup = function()
      vim.g.everforest_background = 'hard'
    end
  },
  {
    name = "everforest-light-medium",
    colorscheme = "everforest",
    background = "light",
    setup = function()
      vim.g.everforest_background = 'medium'
    end
  },
  {
    name = "everforest-light-soft",
    colorscheme = "everforest",
    background = "light",
    setup = function()
      vim.g.everforest_background = 'soft'
    end
  },
  {
    name = "rose-pine",
    colorscheme = "rose-pine",
    background = "dark"
  },
  {
    name = "rose-pine-moon",
    colorscheme = "rose-pine-moon",
    background = "dark"
  },
  {
    name = "rose-pine-dawn",
    colorscheme = "rose-pine-dawn",
    background = "light"
  },
  {
    name = "catppuccin-latte",
    colorscheme = "catppuccin-latte",
    background = "light"
  },
  {
    name = "catppuccin-frappe",
    colorscheme = "catppuccin-frappe",
    background = "dark"
  },
  {
    name = "catppuccin-macchiato",
    colorscheme = "catppuccin-macchiato",
    background = "dark"
  },
  {
    name = "catppuccin-mocha",
    colorscheme = "catppuccin-mocha",
    background = "dark"
  },
  {
    name = "onedark-dark",
    colorscheme = "onedark",
    background = "dark",
    setup = function()
      require("onedark").setup({ style = "dark" })
    end
  },
  {
    name = "onedark-darker",
    colorscheme = "onedark",
    background = "dark",
    setup = function()
      require("onedark").setup({ style = "darker" })
    end
  },
  {
    name = "onedark-cool",
    colorscheme = "onedark",
    background = "dark",
    setup = function()
      require("onedark").setup({ style = "cool" })
    end
  },
  {
    name = "onedark-deep",
    colorscheme = "onedark",
    background = "dark",
    setup = function()
      require("onedark").setup({ style = "deep" })
    end
  },
  {
    name = "onedark-warm",
    colorscheme = "onedark",
    background = "dark",
    setup = function()
      require("onedark").setup({ style = "warm" })
    end
  },
  {
    name = "onedark-warmer",
    colorscheme = "onedark",
    background = "dark",
    setup = function()
      require("onedark").setup({ style = "warmer" })
    end
  },
  {
    name = "onedark-light",
    colorscheme = "onedark",
    background = "light",
    setup = function()
      require("onedark").setup({ style = "light" })
    end
  }
}

-- Current theme index (starts with kanagawa-wave)
M.current_theme_index = 4

-- Set default theme (gruvbox)
M.set_theme = function(theme)
  -- Run setup function if it exists (for themes with variants)
  if theme.setup then
    theme.setup()
  end

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

  -- Store original theme to restore if cancelled
  local original_theme_index = M.current_theme_index

  -- Use Telescope for live preview
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({
    layout_strategy = "vertical",
    layout_config = {
      width = 0.4,
      height = 0.5,
      preview_cutoff = 0,
    },
  }, {
    prompt_title = "Select Theme",
    finder = finders.new_table({
      results = M.themes,
      entry_maker = function(theme)
        return {
          value = theme,
          display = theme.name,
          ordinal = theme.name,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      -- Preview theme on selection change
      local function preview_theme()
        local selection = action_state.get_selected_entry()
        if selection then
          M.set_theme(selection.value)
        end
      end

      -- Preview on cursor move
      map("i", "<Down>", function()
        actions.move_selection_next(prompt_bufnr)
        preview_theme()
      end)
      map("i", "<Up>", function()
        actions.move_selection_previous(prompt_bufnr)
        preview_theme()
      end)
      map("i", "<C-n>", function()
        actions.move_selection_next(prompt_bufnr)
        preview_theme()
      end)
      map("i", "<C-p>", function()
        actions.move_selection_previous(prompt_bufnr)
        preview_theme()
      end)
      map("n", "j", function()
        actions.move_selection_next(prompt_bufnr)
        preview_theme()
      end)
      map("n", "k", function()
        actions.move_selection_previous(prompt_bufnr)
        preview_theme()
      end)

      -- On select, keep the theme
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          for i, theme in ipairs(M.themes) do
            if theme.name == selection.value.name then
              M.current_theme_index = i
              M.set_theme(theme)
              break
            end
          end
        end
      end)

      -- On cancel, restore original theme
      map("i", "<Esc>", function()
        actions.close(prompt_bufnr)
        M.set_theme(M.themes[original_theme_index])
      end)
      map("n", "q", function()
        actions.close(prompt_bufnr)
        M.set_theme(M.themes[original_theme_index])
      end)

      return true
    end,
  }):find()
end

-- Initialize with default theme
M.init = function()
  M.set_theme(M.themes[M.current_theme_index])
end

return M
