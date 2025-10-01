return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				require("none-ls.formatting.eslint_d"),
				null_ls.builtins.formatting.prettier,
			},
		})

		vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, {})
	end,
}
