return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      delay = 500, -- delay before which-key popup appears (ms)
    })

    -- Optional: Register group names for better organization
    wk.add({
      { "<leader>f", group = "Find/Format" },
      { "<leader>g", group = "Git" },
      { "<leader>c", group = "Code" },
      { "<leader>r", group = "Rename" },
      { "<leader>s", group = "Select" },
      { "<leader>x", group = "Xcodebuild" },
      { "<leader>d", group = "Debug" },
      { "<leader>t", group = "Theme" },
    })
  end,
}
