return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", gs.next_hunk, { desc = "Next hunk" })
        map("n", "[c", gs.prev_hunk, { desc = "Previous hunk" })

        -- Blame
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "Git blame line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
      end,
    })
  end,
}
