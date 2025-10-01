-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
 end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require("vim-options")

-- Initialize theme switcher
local theme_switcher = require("theme-switcher")
theme_switcher.init()

-- Theme switching keymaps
vim.keymap.set('n', '<leader>tn', theme_switcher.next_theme, { desc = 'Next theme' })
vim.keymap.set('n', '<leader>tp', theme_switcher.prev_theme, { desc = 'Previous theme' })
vim.keymap.set('n', '<leader>ts', theme_switcher.pick_theme, { desc = 'Select theme' })

