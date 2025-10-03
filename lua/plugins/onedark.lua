return {
  "navarasu/onedark.nvim",
  name = "onedark",
  config = function()
    require("onedark").setup({
      style = "dark", -- dark, darker, cool, deep, warm, warmer, light
    })
  end,
}
