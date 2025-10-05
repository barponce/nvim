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
-- vim.keymap.set("n", "<leader>tn", theme_switcher.next_theme, { desc = "Next theme" })
-- vim.keymap.set("n", "<leader>tp", theme_switcher.prev_theme, { desc = "Previous theme" })
vim.keymap.set("n", "<leader>st", theme_switcher.pick_theme, { desc = "Select theme" })

-- Moving between windows
-- Removed to avoid conflict with Aerospace window focus (alt-shift-cmd-ctrl-h/j/k/l)
-- vim.keymap.set('n', '<D-C-A-S-h>', '<C-w>h', { desc = 'Move to left split' })
-- vim.keymap.set('n', '<D-C-A-S-l>', '<C-w>l', { desc = 'Move to right split' })

-- One-handed split navigation (Ctrl+h/j/k/l)
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })
